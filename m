From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import docs: LT is valid in email, GT is not
Date: Sat, 24 Apr 2010 11:12:36 -0500
Message-ID: <20100424161236.GB14690@progeny.tock>
References: <1272069944-20626-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 18:12:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5hy8-00052x-J9
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 18:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679Ab0DXQMG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 12:12:06 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:48203 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab0DXQME (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 12:12:04 -0400
Received: by qyk9 with SMTP id 9so14832587qyk.1
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WRQQ/mcc9R1sqKZ5N6UBWJZ4nJxwuUwhANyCV+7WDEg=;
        b=BHMhbLQSKZTgR+ojf34crd+LNHoighEZkazLE+zf6e+JvNgrRIOv2sGsnIXxeeWJNh
         e1w8JckqjJ0LeIa5Pv/zYP1wgM9Kakl3qSv0FR+X7L4RtrXQWFYgoKLaUKmbkCdHKpbc
         yGWiH5x93ZerfEbrBmUeG8wLdyEUx7t9fbTKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZNM6pzeU69IcKNLy70DUasZ5vq+QtIlkQ4DViSvPPyeoTi1qUI1MBGQUffKsyi/cJK
         u5qrOEP3/wz0otNjGAkwekH/0bvX0x2SsJGmTqSxbSQgy+NitZ4wbwERqRE3cT6yFz8u
         MhgAvkQHWMX3+mpw1U1x9Ox1Dwgv/KPpngvKo=
Received: by 10.229.232.198 with SMTP id jv6mr1943117qcb.11.1272125520739;
        Sat, 24 Apr 2010 09:12:00 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1591516iwn.13.2010.04.24.09.12.00
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 09:12:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1272069944-20626-1-git-send-email-lodatom@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145686>

Hi Mark,

Mark Lodato wrote:

> +++ b/Documentation/git-fast-import.txt
> @@ -394,7 +394,7 @@ Here `<name>` is the person's display name (for e=
xample
>  and greater-than (\x3e) symbols.  These are required to delimit
>  the email address from the other fields in the line.  Note that
>  `<name>` is free-form and may contain any sequence of bytes, except
> -`LT` and `LF`.  It is typically UTF-8 encoded.
> +`GT` and `LF`.  It is typically UTF-8 encoded.

	Here <name> is the person=E2=80=99s display name (for example
	=E2=80=9CCom M Itter=E2=80=9D)

So the original text is correct --- a <name> cannot contain LT because
a less-than sign marks the boundary between a name and email address.

Maybe you were wondering what characters are valid in an e-mail address=
?
The comments in fast-import.c and code in ident.c are consistent about
this: the forbidden characters are <, >, and LF, though no one seems to
check (see also my other reply).  A patch to explain this (including a
reference to git-commit-tree(1), I guess) might be useful.

git won=E2=80=99t understand an email with embedded > or LF.  I=E2=80=99=
m not sure a <
would cause problems, but I don=E2=80=99t mind that it is disallowed.

Hope that helps,
Jonathan
