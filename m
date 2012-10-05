From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 5/6] gitignore: do not do basename match with patterns
 that have '**'
Date: Fri, 05 Oct 2012 09:01:19 +0200
Message-ID: <506E85BF.8010302@viscovery.net>
References: <7v626q3hen.fsf@alter.siamese.dyndns.org> <1349336392-1772-1-git-send-email-pclouds@gmail.com> <1349336392-1772-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 09:01:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK1uj-0002Ul-7t
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 09:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011Ab2JEHBZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 03:01:25 -0400
Received: from so.liwest.at ([212.33.55.24]:30972 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738Ab2JEHBY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2012 03:01:24 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TK1uR-0004zk-Kz; Fri, 05 Oct 2012 09:01:19 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 58A5F1660F;
	Fri,  5 Oct 2012 09:01:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <1349336392-1772-6-git-send-email-pclouds@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207078>

Am 10/4/2012 9:39, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> - - If the pattern does not contain a slash '/', git treats it as
> -   a shell glob pattern and checks for a match against the
> -   pathname relative to the location of the `.gitignore` file
> -   (relative to the toplevel of the work tree if not from a
> -   `.gitignore` file).
> + - If the pattern does not contain a slash '/' nor '**', git
> +   treats it as a shell glob pattern and checks for a match
> +   against the pathname relative to the location of the
> +   `.gitignore` file (relative to the toplevel of the work tree
> +   if not from a `.gitignore` file).

> +test_expect_success '"**" with no slashes test' '
> +	echo "a**f foo=3Dbar" >.gitattributes &&
> +	cat <<\EOF >expect &&
> +f: foo: unspecified
> +a/f: foo: bar
> +a/b/f: foo: bar
> +a/b/c/f: foo: bar
> +EOF

Should the above .gitattributes match nested paths, such as b/a/c/f?

I think it should, because the user can easily say "/a**f" that nested
paths should not be matched.

But if it does not match, as your documentation update implies, which
options does the user have to match nested paths? Only to add more
patterns for each nested directory, such as "b/a**f".

-- Hannes
