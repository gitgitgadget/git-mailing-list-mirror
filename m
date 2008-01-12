From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: [PATCH] Add committer and author names to top of COMMIT_EDITMSG.
Date: Fri, 11 Jan 2008 20:33:23 -0500
Message-ID: <9b3e2dc20801111733o477b3aadv6ee76d3aafade54a@mail.gmail.com>
References: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
	 <7v3at42avd.fsf@gitster.siamese.dyndns.org>
	 <9b3e2dc20801111609t3103af1frc23519cab43ae8be@mail.gmail.com>
	 <7vbq7r28qo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 02:33:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDVFu-0001aA-LN
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 02:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763157AbYALBd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 20:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762656AbYALBdZ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 20:33:25 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:40412 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763571AbYALBdY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 20:33:24 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1107222rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 17:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZkSXJ8HH+OUtpEPH+44p7i712m7fTiM5B1K/LyG5514=;
        b=u1n8HgB0FBElBs4Fy8Ktj+M7Km/LSwsF30dCia5XIFG7zqsaEKHZJjWxBYlmVekNmxhuc0esmgJ2sMNXbTXnQ5ak+LDeYp8jQDWgFTYDQzilNsP1k9tAeIkEy0bMqMHJZtj+5bXP4g3r4C1YoyrsByofVdBDbroyOxTJQ7kkaPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HpspfkmhNtlozsSfbKaVV3ELde2NEwq5Tsr/1LIjS53m2hPSz9xkZ8n/mdf/qIOQhsk3C3PoqCVnOidqhN00ivOpcva2sVABMRj4U7S26Q/+yrvsiE4cSGdwPUoANMbXk1WdPWnCdNopjkZ9Jq01qEjVpD1CfXJrGSx67Zo5CTI=
Received: by 10.141.123.4 with SMTP id a4mr2429136rvn.172.1200101603050;
        Fri, 11 Jan 2008 17:33:23 -0800 (PST)
Received: by 10.140.188.1 with HTTP; Fri, 11 Jan 2008 17:33:23 -0800 (PST)
In-Reply-To: <7vbq7r28qo.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70245>

>  * If AUTHOR_NAME+EMAIL is different from AUTHOR_NAME+EMAIL that
>    I would normally get for myself, or

I thought of this, however if the purpose of this is to handle a case
where you do a commit from a new and unconfigured user account, "that
I would normally get for myself" is undefined, since this information
is (rightfully) not propagated by git-clone.  This is why I made it
unconditional, (or perhaps something you could could turn off, but
would by default be on), but I figured there would be objections since
I admit it's not always useful information.

>  * If AUTHOR_NAME+EMAIL contains garbage identifier commonly
>    found when misconfigured (e.g. ".(none)" at the end of
>    e-mail),

That's more interesting to me.  I just checked my logs and I do see
that in at least one case, this .(none) was not appended.  The
computer in question was configured (not by me) with a domain of
".local", so the commit has <machinename>.local as part of the email
address.  However I would imagine this might solve most cases.

I still don't understand why git generates a default email address
instead of just giving an error message; do people actually use this
scenario?  In my experience an email address must always be explicitly
given, but perhaps some people work on the machines that also receive
their mail.  I rarely do "real" work on an actual server, but I guess
some people do.  I think they must be in the minority though..

On the other hand, now that I've been thinking about it I think my
idea of simply configuring a hook in my personal central git is
probably an easier and all-round better solution to my problem.  I
understand that git relies on system accounts for security, but
there's no reason I can't configure a particular repo to issue a
warning when it receives incoming commits from an unknown user/email.


Steve
