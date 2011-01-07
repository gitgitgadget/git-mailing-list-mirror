From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit: suggest --amend --reset-author to fix commiter
 identity
Date: Fri, 7 Jan 2011 11:13:29 -0600
Message-ID: <20110107171329.GA16571@burratino>
References: <1294409671-5479-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jan 07 18:13:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbFsw-0002FR-P0
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 18:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab1AGRNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 12:13:47 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38495 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707Ab1AGRNq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 12:13:46 -0500
Received: by qwa26 with SMTP id 26so18004062qwa.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 09:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=n0YeOEO9YRTCMIKRyS6MittpDB9Q6gIqsI3mpOKgr60=;
        b=B8RHO4hNpPmeAAnhiW4aIguhRSj3l4uY6+/ZxeiIrGHrFghDSEouk4mD9fmO5mzOkh
         c8lP3M3QmNJro3Ekcb5VXM9Ktyq3Uc3M4hHKywbSKnAj5tnwN9wy4Ol0zvPYZgCHC8lt
         GgBzWESIYs2s+gUF2t0uhI77vVg8DqGyC0ZTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GqR9co9a/qz1SiUvu0fmnG6c6DC52QvCxFkgqN2tLYXIz7gcoxLQlUufpyPaGDg3+P
         fwLk7lYuHhBp5YkvAd3piV0Pu424qlREEIfTrpukzUMrflhuQWhrFbZ1RIBRhMIFaMfQ
         akK3/B8DW6Rb5KCgCCG/WNdN3hhDyYo4Hoed0=
Received: by 10.229.81.11 with SMTP id v11mr2160973qck.152.1294420425927;
        Fri, 07 Jan 2011 09:13:45 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id g32sm15261659qck.10.2011.01.07.09.13.42
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 09:13:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294409671-5479-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164721>

Matthieu Moy wrote:

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -47,7 +47,11 @@ static const char implicit_ident_advice[] =
>  "\n"
>  "If the identity used for this commit is wrong, you can fix it with:\n"
>  "\n"
> -"    git commit --amend --author='Your Name <you@example.com>'\n";
> +"    git commit --amend --author='Your Name <you@example.com>'\n"
> +"\n"
> +"or\n"
> +"\n"
> +"    git commit --amend --reset-author\n";
>

This message gets used when the author was set from gecos because
not available in the configuration.  Do you perhaps mean:

	If the identity used for this commit is wrong, you can fix it with:

	    git commit --amend --author='Your Name <you@example.com>'
	    git commit --amend --author='Your Name <you@example.com>'

	or

	    cat <<EOF >>~/.gitconfig
	    [user]
	      name = Your Name
	      email = you@example.com
	    EOF
	    git commit --amend --reset-author

?
