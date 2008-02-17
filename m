From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Sun, 17 Feb 2008 14:09:48 -0800
Message-ID: <ee77f5c20802171409k2dee2c87v8d84eba111c3d506@mail.gmail.com>
References: <871w7bz1ly.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Jim Meyering" <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sun Feb 17 23:10:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQriM-0002RA-CZ
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 23:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbYBQWJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 17:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755240AbYBQWJv
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 17:09:51 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:27957 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625AbYBQWJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 17:09:49 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1070654rvb.1
        for <git@vger.kernel.org>; Sun, 17 Feb 2008 14:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iEp/7fAkczLnn2y5n0V8tagSGSSToQYK8/46/vfkz94=;
        b=RlPpTXCtJ7jndvoxXzlx/nlRmY93wsKn5swJs5PtDyBdUvqrPns5QEJiqv2JaFeYwa50+MuqfgLBWWGpw9tzrxKTspWnqGhpdKG6xRegRVVNSrhF+vNZ7TbWo4iRmrhavJ2966wyGs/qU5+GKJ3lgOQasxic4LPPYVNTiC830gg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PAjQtfyIruVg2Qv1QRYHcnPnRuUP0McdYudGiy0jykikaq7//Xai1fOLoI6xSrTsiyniuPf6DEiTQnIG5k9bPeslagPKvDYSWporoEsx9eRXFYdxZrFp+yGYa/GH8Lc4R/U13QZc1MnAgQPlvtieKdvZU1uxA2owo9Rg90ci/M4=
Received: by 10.141.87.13 with SMTP id p13mr3385787rvl.163.1203286188851;
        Sun, 17 Feb 2008 14:09:48 -0800 (PST)
Received: by 10.140.135.17 with HTTP; Sun, 17 Feb 2008 14:09:48 -0800 (PST)
In-Reply-To: <871w7bz1ly.fsf@rho.meyering.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74189>

On Feb 17, 2008 1:58 PM, Jim Meyering <jim@meyering.net> wrote:
> This change removes all useless if-before-free tests.
> E.g., it replace code like this
>
>         if (some_expression)
>                 free (some_expression);
>
> with the now-equivalent
>
>         free (some_expression);
>
> It is equivalent not just because POSIX has required free(NULL)
> to work for a long time, but simply because it has worked for
> so long that no reasonable porting target fails the test.
> Here's some evidence from nearly 1.5 years ago:
>
>     http://www.winehq.org/pipermail/wine-patches/2006-October/031544.html

That's not great evidence. It only tests 9 systems, and misses several
targets that Git already runs on. It seems like a fairly minor cleanup
for a definite loss of portability.

It's also somewhat useful for indicating that the particular pointer
*might* be NULL.


Dave.
