From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] Simplified the invocation of command action in submodule
Date: Thu, 10 Jan 2008 09:05:20 +0600
Message-ID: <7bfdc29a0801091905k1ef9285em170b26a332a30535@mail.gmail.com>
References: <1199851140-31853-1-git-send-email-imyousuf@gmail.com>
	 <47848CDD.7050806@viscovery.net>
	 <7bfdc29a0801090151k22d3cd5aqedb0d4860868d4d9@mail.gmail.com>
	 <8c5c35580801090224l1e30df6cw5d3fefe99c0cdd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org,
	gitster@pobox.com
To: "Lars Hjemli" <lh@elementstorage.no>
X-From: git-owner@vger.kernel.org Thu Jan 10 04:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCnjr-0003BB-VE
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 04:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395AbYAJDFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 22:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755019AbYAJDFX
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 22:05:23 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:25863 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbYAJDFW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 22:05:22 -0500
Received: by fg-out-1718.google.com with SMTP id e21so504243fga.17
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 19:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZOk/20DB8vQhjkW9hw3c1Cf8V1tRjK005DDhg6B8/xM=;
        b=R+MjfX6B/fxe0srCyEaWKkr96kDoq46BxhgXlahrbYwCRp+G6Ll60QiTdr0T8Dkj94CMRP5lEJ/JGiQfeH2/wRPce/wfBmzCDtGvQ8ZTXnGl+b0sFKTTb4MiH5emCfpjdZp3kHf8BKm58nhONeh0GWi7PVnz+FX5Am/8HbauQ28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H7We9KIBQ4WvyYN8jv8jOCIqa/U/vskMwD/g15Ny+fltQyf3aXzKlhRKEOQJmnrilj5KLrtigHoV7redB37TH93FVSP3NM9LUJ7A5uB5moqSmtEJGe73Ot3CYSyHwHdHPDs+AZkKTYOxQslddPzw0eMf+Unoz/NhL0aNKybFAGk=
Received: by 10.78.149.15 with SMTP id w15mr1650336hud.72.1199934320493;
        Wed, 09 Jan 2008 19:05:20 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Wed, 9 Jan 2008 19:05:20 -0800 (PST)
In-Reply-To: <8c5c35580801090224l1e30df6cw5d3fefe99c0cdd7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70035>

On Jan 9, 2008 4:24 PM, Lars Hjemli <lh@elementstorage.no> wrote:
> On Jan 9, 2008 10:51 AM, Imran M Yousuf <imyousuf@gmail.com> wrote:
> > On Jan 9, 2008 2:59 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> > >
> > > - Previously, passing --cached to add, init, or update was an error, now
> > > it is not.
> >
> > The usage statement and this behaviour is rather contradicting. The
> > usage says that --cached can be used with all commands; so I am not
> > sure whether using --cached with add should be an error or not. IMHO,
> > if the previous implementation was right than the USAGE has to be
> > changed, and if the previous implementation was incorrect, than if the
> > default command is set to status than current implementation is right.
> >
> > I would like to get comment on this until I fix the patch and resend it.
>
> --cached only makes sense for the status subcommand, so the
> usage/manpage probably should have looked like this (except for the
> whitespace mangling...):
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index cffc6d4..331e806 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -10,7 +10,10 @@ SYNOPSIS
>  --------
>  [verse]
>  'git-submodule' [--quiet] [-b branch] add <repository> [<path>]
> -'git-submodule' [--quiet] [--cached] [status|init|update] [--] [<path>...]
> +'git-submodule' [--quiet] [--cached] [status] [--] [<path>...]
> +'git-submodule' [--quiet] init [--] [<path>...]
> +'git-submodule' [--quiet] update [--] [<path>...]
> +
>

This change makes a lot sense. Thus I will make sure that it is used
in this manner :). Thanks a lot for clarifying it Lars. I wanted to
know what is the purpose of '--'? If it is simply meant to be a
separator than fine; else I would be grateful if you would please
explain its purpose, so that I do not again implement wrongly :).

>
>  COMMANDS
> --
> 1.5.3.7.1141.g4eb39
>


-- 
Imran M Yousuf
