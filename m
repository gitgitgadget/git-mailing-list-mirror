From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] Documentation/urls: Rewrite to accomodate
 <transport>::<address>
Date: Sat, 17 Apr 2010 21:59:41 -0500
Message-ID: <20100418025940.GA2249@progeny.tock>
References: <1271552047-sup-9523@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 05:00:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Kju-0002iw-Ep
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 05:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab0DRC7r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Apr 2010 22:59:47 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:44154 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756819Ab0DRC7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 22:59:46 -0400
Received: by ywh32 with SMTP id 32so2071028ywh.33
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 19:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VcG5u0USIPEd2soJiHRi9S49/vMaHVwfkCkcQF7pqns=;
        b=ZwD7zKnFw/13yvZpBAiZvsh13huPU1tDRXZPKo2elqwifvKLun3f+IQ9M7RD8WPr8C
         8aOZG5i9rGSAKZCIKkH92adT0cMEDFZ8r3kWLdAfTah1OsLjiveANyyfBJXV4zR0N21C
         +XBD9I9wkTzywnG6kbeR54tiflWmVsrTytDQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RmfWL8v9TufVZzgtdLKJXIzZzgdIAEQjNhR7o6CQgzDUvsmNaoPyIsCZCk4AbBVk7v
         TZYdvAc3QRs4SV9UNhPa9melquJj3ToR0clzED/7tdaQV5Iz9meaiUaoCf9hXcj5jO4W
         EZFCmCSTyn5Yf6BpY/lpVuz41ThZJBamzssbc=
Received: by 10.100.24.17 with SMTP id 17mr8141904anx.53.1271559585121;
        Sat, 17 Apr 2010 19:59:45 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm3416635iwn.13.2010.04.17.19.59.44
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 19:59:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1271552047-sup-9523@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145205>

Ramkumar Ramachandra wrote:

> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -1,44 +1,52 @@
>  GIT URLS[[URLS]]
>  ----------------
> =20
> -One of the following notations can be used
> -to name the remote repository:
> +In general, URLs contain information about the transport protocol, t=
he
> +address of the remote server, and the path to the repository.

Nice.

> +Depending on the transport protocol, some of this information may be
> +absent.
> +
> +Git natively supports ssh, git, rsync, http, https, ftp, and ftps
> +protocols.

Hmm: if it is not built in to the git binary, is it right to call the
support native?  I don=E2=80=99t mean to say HTTP support is a second-c=
lass
citizen (with http-backend on the server side, it isn=E2=80=99t any mor=
e), but
it is possible that remote-http is not installed on a system.  Also, it
is a good example to introduce remote helpers with.

Not a criticism of this patch, just something to think about.

> The following syntaxes may be used with them:
> =20
> -- rsync://host.xz/path/to/repo.git/
> -- http://host.xz{startsb}:port{endsb}/path/to/repo.git/
> -- https://host.xz{startsb}:port{endsb}/path/to/repo.git/
> -- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
> -- git://host.xz{startsb}:port{endsb}/~user/path/to/repo.git/
>  - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/re=
po.git/
> -- ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
> -- ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/
> -- ssh://{startsb}user@{endsb}host.xz/~/path/to/repo.git
> +- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
> +- rsync://host.xz/path/to/repo.git/
> +- http{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.=
git/
> +- ftp{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.g=
it/

Tiny nitpick: I would mention http before rsync.

[...]
>  - /path/to/repo.git/
>  - file:///path/to/repo.git/
> =20
>  ifndef::git-clone[]
> -They are mostly equivalent, except when cloning.  See
> -linkgit:git-clone[1] for details.
> +These two syntaxes are mostly equivalent, except when cloning, when
> +the former implies --local option. See linkgit:git-clone[1] for
> +details.
>  endif::git-clone[]
> =20
> -ifdef::git-clone[]
> -They are equivalent, except the former implies --local option.
> -endif::git-clone[]

What happened to this passage in git-clone.1?

> +When git doesn't know how to handle a certain transport protocol, it
> +attempts to use the 'remote-<transport>' remote helper, if one
> +exists. To explicitly request a remote helper, the following syntax
> +may be used:
> +
> +- <transport>::<address>
> =20
> +where <address> may be a path, a server and path, or an arbitrary
> +URL-like string recognized by the specific remote helper being
> +invoked. See linkgit:git-remote-helpers[1] for details.

Except for the removal of the ifdef::git-clone[] section,

  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
Jonathan
