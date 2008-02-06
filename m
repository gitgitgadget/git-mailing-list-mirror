From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [PATCH] Make git prune remove temporary packs that look like write failures
Date: Wed, 6 Feb 2008 18:59:15 +0000
Message-ID: <e1dab3980802061059m5bf9c291s892da586248e229c@mail.gmail.com>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>
	 <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
	 <47A9E4F9.8050100@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"David Steven Tweed" <d.s.tweed@reading.ac.uk>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:00:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMpVB-00084B-00
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 20:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbYBFS7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 13:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754360AbYBFS7U
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 13:59:20 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:14217 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbYBFS7T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 13:59:19 -0500
Received: by ti-out-0910.google.com with SMTP id 28so298885tif.23
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 10:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nVSzYhIKLxIXzhUPuq6diD+5cST9NqfSg3i8R4seVGM=;
        b=gC/RSUuowZ3wHskdjjaQJ3OcEQD9/rr2Bk7zwBhercZWtHvMOsAzgLhAHy8p37HwPW9zniXz3JzmL35Lhv8UqHn6sJloVnNqTKl12qKuLD33QPk+kjHN4RBN5HWPm8loogM/PhRYVRE3RVK1NWwt42SN7EJeHbAnxTEoTt/EiQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a61RzejAK1WtmiUV0xThylPPkM6pIc0843G0chMouXzGe8tOxKeCPjR+J7pSVbsbd0S16raHnDB3A6NKBbx3XXM0xRjTljh3NAZ6/L1lw87aZFxeRXnAlhHD0r12ELcFAB7oG/GbLWzN55BFAXoyDHK4YU1HcwJ+1GvLKNA/qN4=
Received: by 10.150.191.10 with SMTP id o10mr4353888ybf.59.1202324355272;
        Wed, 06 Feb 2008 10:59:15 -0800 (PST)
Received: by 10.150.149.2 with HTTP; Wed, 6 Feb 2008 10:59:15 -0800 (PST)
In-Reply-To: <47A9E4F9.8050100@nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72825>

On Feb 6, 2008 4:48 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> I also suggest taking a look at the functions in builtin-prune-packed.c to see
> how similar functions are implemented there.
>
> Use strlcpy instead of sprintf.
> Use prefixcmp instead of strncmp.
> Use same messages as prune_dir() for show_only path and unlink failure.
> You could also check the opendir call and print a suitable message on failure.

All the other path creation in builtin-prune.c is using sprintf; is
doing 3 strlcpy's much better? (I backed off from using snprintf when
the other element in the if that tested it vanished; I probably ought
to put that back.) I'll use prefixcmp and check the opendir call
(although if get_object_directory() doesn't return something sensible
presumably bigger problems are in the mix.)

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
