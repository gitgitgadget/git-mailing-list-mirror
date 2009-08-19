From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Continue git clone after interruption
Date: Wed, 19 Aug 2009 10:12:56 +0530
Message-ID: <2e24e5b90908182142n16201ed4ua41408878664e353@mail.gmail.com>
References: <1250509342.2885.13.camel@cf-48>
	 <alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302>
	 <vpqskfphe2k.fsf@bauges.imag.fr> <1250578735.2885.40.camel@cf-48>
	 <alpine.LFD.2.00.0908181246470.6044@xanadu.home>
	 <m3fxbpneqe.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Tomasz Kontusz <roverorna@gmail.com>,
	git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 06:43:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdd0r-00018F-Gq
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 06:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbZHSEm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2009 00:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbZHSEm4
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 00:42:56 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:62631 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbZHSEm4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Aug 2009 00:42:56 -0400
Received: by ywh3 with SMTP id 3so5915429ywh.22
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 21:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UlUqPH+vsqvkseczcEaEfXRaDcNqy0OBSFT9t/+84Bc=;
        b=brnbkpqieg89kkfLu4IHY4nZhNhYmQIQUycHfnWQkRrQUioRPVgcWfBhQMX3fwwjSX
         Frvt4NnUXZOIREqFkkwYziE7VliqHfh9UotmumEMhYTJYlNuKnZUbvb15qQ9C7wWEc4o
         0eUIrt62Tk412Mnz9N9nn3NJeRVj59DGFj3bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cosqBKPW7c7OOpRj7xMBrMldfNQ0tuZKycHAqN5Z2Zvv6iVSqIQbomv/9sakGbioos
         wlfLzS8TwFZAS1XQjitD7NWQk8v7pzkL3WdquksIZS80jF5Hmz1oktVYdGS4PpRX3KmT
         kjMuv7dgFIJd5ejW3C1Lz4k96BL+ea0jXSW9Y=
Received: by 10.231.14.67 with SMTP id f3mr3680653iba.36.1250656976943; Tue, 
	18 Aug 2009 21:42:56 -0700 (PDT)
In-Reply-To: <m3fxbpneqe.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126504>

On Wed, Aug 19, 2009 at 12:15 AM, Jakub Narebski<jnareb@gmail.com> wrot=
e:
> There is another way which we can go to implement resumable clone.
> Let's git first try to clone whole repository (single pack; BTW what
> happens if this pack is larger than file size limit for given
> filesystem?). =A0If it fails, client ask first for first half of of
> repository (half as in bisect, but it is server that has to calculate
> it). =A0If it downloads, it will ask server for the rest of repositor=
y.
> If it fails, it would reduce size in half again, and ask about 1/4 of
> repository in packfile first.

How about an extension where the user can *ask* for a clone of a
particular HEAD to be sent to him as a git bundle?  Or particular
revisions (say once a week) were kept as a single file git-bundle,
made available over HTTP -- easily restartable with byte-range -- and
anyone who has bandwidth problems first gets that, then changes the
origin remote URL and does a "pull" to get uptodate?

I've done this manually a few times when sneakernet bandwidth was
better than the normal kind, heh, but it seems to me the lowest impact
solution.

Yes you'd need some extra space on the server, but you keep only one
bundle, and maybe replace it every week by cron.  Should work fine
right now, as is, with a wee bit of manual work by the user, and a
quick cron entry on the server
