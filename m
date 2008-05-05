From: "Jeremy Ramer" <jdramer@gmail.com>
Subject: Re: Trouble merging to master when topic branch has a dir added
Date: Mon, 5 May 2008 08:27:14 -0600
Message-ID: <b9fd99020805050727o54cb9af2o3b43257fb32aac60@mail.gmail.com>
References: <1cdff3fa0805030651j5d1936bdh4f7999163b7444ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Frodo Baggins" <frodo.drogo@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 16:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt1fi-0003mx-Hu
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 16:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759259AbYEEO1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 10:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759163AbYEEO1R
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 10:27:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:24263 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758748AbYEEO1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 10:27:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so136345fgg.17
        for <git@vger.kernel.org>; Mon, 05 May 2008 07:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=LOy/peh/mgSBYzvWDXcsN1vbi/rDleY8kF8BF24qR5M=;
        b=qg3KdiMeHT8X9880aFLTK1V8Pbnd8wM1qiBgW1+T+ECxnEgHmD06ILHJiNoDQjgZcqeqvPAQtPYDNcE41rzeeXCDqyc79tI6yemuFdlYt/gT1SHfTRirESMKs8pFKDWqU4vjRwPiJt8OoqKEfzjE2Mzk1paEKtCuqlgZT7N1g7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SI5EBpZtN9/5VOPDQh3nAnLKIrSRjNJFFxLpXDRLkCgNo1rb8VjiKcKXVIR7aZu3qXC/E+Qtfx983bdM/5sjD0QsWrv9pjmDuMy6qsQCCCFYsinIJluGwzzEDaG2fJLxJzrlIkwhOjrrER4bWjhXYVmINHVJULWD0QdSklFEb08=
Received: by 10.86.31.18 with SMTP id e18mr11732289fge.22.1209997634436;
        Mon, 05 May 2008 07:27:14 -0700 (PDT)
Received: by 10.86.90.19 with HTTP; Mon, 5 May 2008 07:27:14 -0700 (PDT)
In-Reply-To: <1cdff3fa0805030651j5d1936bdh4f7999163b7444ba@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81286>

It looks like there is some uncommitted changes in the file
logger-src/logger.cpp.  You cannot switch to the master branch because
it has no knowledge of that file so any uncommitted changes will be
lost.  If the changes are important you should commit them first (to a
side branch if you don't want them to be part of the merge) or if
useless you can remove them with
git checkout HEAD logger-src/logger.cpp

On Sat, May 3, 2008 at 7:51 AM, Frodo Baggins <frodo.drogo@gmail.com> wrote:
> Hi,
>  This is a newbie question.
>
>  I created a topic branch and made a few commits which added a few
>  directories. I'd like to merge these changes back to master.
>  I get the following error messages.
>
>  frodo@laptop-zion:~/src/c/logger$ ls
>  logger-inc  logger-src  Makefile  test-driver
>  frodo@laptop-zion:~/src/c/logger$ git branch
>   debug-printf-help
>   debug-static
>   master
>  * split-into-dirs
>  frodo@laptop-zion:~/src/c/logger$ git checkout master
>  fatal: Entry 'logger-src/logger.cpp' would be overwritten by merge.
>  Cannot merge.
>
>  I think the above error is due to the fact that the branch master did
>  not have these directories.
>
>  frodo@laptop-zion:~/src/c/logger$ git-ls-tree master
>  100644 blob 82ccb7971fc36db2bc54bb5a590f97cd37c998fb    .gitignore
>  100644 blob 9971a5a432d575cc682145454e5260f83e1b9fb3    Makefile
>  100644 blob b8f6c213ebb831ed8704b7f0e0e665212b808649    client.cpp
>  100644 blob d01aaec4138862ccae4be9de2c672ddaeccfa21d    logger.cpp
>  100644 blob 37c15a22b325934ea685a76cfd528c2bf6464f2b    logger.h
>  frodo@laptop-zion:~/src/c/logger$ git-ls-tree split-into-dirs
>  100644 blob 82ccb7971fc36db2bc54bb5a590f97cd37c998fb    .gitignore
>  100644 blob 7c497aff60175ce212415c1737e224f517f785e9    Makefile
>  040000 tree 4f181412688afaa30929b752cc1fb3f2cda3cba9    logger-inc
>        <=== new dir
>  040000 tree 4fb363dac2a00d93d1a958f74021fcd0e3bc861e    logger-src
>       <===
>  040000 tree bb2b91b6ec1d11d23ab8e7a3c8935504079f6bf3    test-driver         <===
>
>
>  Could someone help me out with this?
>  frodo@laptop-zion:~/src/c/logger$ git --version
>  git version 1.5.2.5
>
>  Regards,
>  Frodo B
>  --
>  Never laugh at live dragons.
>                               -- Bilbo Baggins
>  --
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
