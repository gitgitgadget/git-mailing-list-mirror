From: Eric Kidd <git@randomhacks.net>
Subject: Re: [PATCHv3] filter-branch: Add more error-handling
Date: Wed, 11 Feb 2009 16:00:18 -0500
Message-ID: <431341160902111300r1a1c3a22n3c098a7d824a3fca@mail.gmail.com>
References: <7vhc30eqy7.fsf@gitster.siamese.dyndns.org>
	 <1234382600-7801-1-git-send-email-git@randomhacks.net>
	 <alpine.DEB.1.00.0902112145400.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 22:01:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXMDL-0002EX-HD
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 22:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757779AbZBKVAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 16:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757765AbZBKVAV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 16:00:21 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:47026 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757760AbZBKVAU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 16:00:20 -0500
Received: by yx-out-2324.google.com with SMTP id 8so207413yxm.1
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 13:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=3XBDMKDtAzqQN4cdLSAmnnJF/tMykYuCipM0yOvEUHg=;
        b=clqbclqXTRL/08nLGE40WM2ge/MdCO/CAGsEVzflepyLCACNYVhkLMTc7HR/ZBQP15
         +r3teLSct7So0foVpc5JcPhVplOx4YRhR9FETSAK7Q8a5rI6ecJYH+SQmg0ahP0GIh5n
         vYtIF5hMZv2N8I8h+OKidJaOtfJYBwDlvMwBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=D5kF2u2xQb9TIZA6OmGDfin4Eq6Jx9j4XuP20hm+4HxNrEoh09hTJxcYtqcplv85hh
         tyxrvEZptUxOSbZdaXjzv/ITXbiHsFp99vxbUm0JRpnTixrE+t6RYqKp8oyxnbXSYh1z
         FkHldJTdROde9C4HICurB6/hS715zVQQOibEs=
Received: by 10.150.156.9 with SMTP id d9mr258130ybe.50.1234386018891; Wed, 11 
	Feb 2009 13:00:18 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902112145400.10279@pacific.mpi-cbg.de>
X-Google-Sender-Auth: e6382ea61238be8b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109527>

On Wed, Feb 11, 2009 at 3:48 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I haven't checked, but is "$tempdir" not the working directory?  If so,
> this would lead to funny interaction with --tree-filter.  Rather, I'd
> write the file into "$GIT_DIR".  Likewise the other files.

The working directory actually lives one level down:

 tempdir=.git-rewrite
 workdir="$tempdir/t"

At the end of the script, git-filter-branch cleans up all of its
temporary files by deleting $tempdir. There's actually a fair bit of
stuff in there already, and none of it interferes with --tree-filter.

> That's not how it is supposed to be used.  Rather,
>
>        test_expect_success $LABEL '
>                test_must_fail git filter-branc $OPTIONS
>        '

Will fix. Thank you.

I really appreciate all this feedback from the git team. Thank you for
taking the time to help me get this right!

Cheers,
Eric
