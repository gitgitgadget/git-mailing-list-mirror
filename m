From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Feature Request: gitignore recursion
Date: Thu, 10 Oct 2013 09:59:13 +0200
Message-ID: <52565E51.7050401@gmail.com>
References: <CACsJy8CHcyDrzieX1Ps3LU2UxCP+QJdv9+5BXZj9Mw2bMs5v3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: pclouds@gmail.com, alljeep@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 10 09:59:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUB9S-0008B3-Py
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 09:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480Ab3JJH7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 03:59:14 -0400
Received: from mail-ea0-f182.google.com ([209.85.215.182]:59662 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab3JJH7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 03:59:14 -0400
Received: by mail-ea0-f182.google.com with SMTP id o10so947118eaj.13
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=zwP12mSsqC+J0BY6CuKoUTvS5d8SOJcj0mjDW6oycCY=;
        b=aY6HxsMIZS0uWUagLNj6SaIIE/FXVL/9h7yfI3Xkq+l5g3cpk6z7rKWrcniGGzmYiP
         8Mninqypl0xZQa5KUCO21DFrnZm1KGUXMipuRqrEoEbbo7qQhSiqzDGU6ZccxbpwYaAG
         VVGMN5gd2mc3X+Vj6gMb8mL/x8PGYCiZUJVW1x+72EoialccsGYwNF17S6poXzmvmkFK
         cppWWR1/ssUCaodaCNh1HbCjCllo81647mFJuO/rmtW8AanzX40fwkgZ3SXqYVg7l3kB
         wWUdo/eWH3loxczqyB4QP3JIwW1q8H/eEf4I1D1geOpCMGHsLH5jlafBHjQtqwPIfFqy
         28fg==
X-Received: by 10.14.122.132 with SMTP id t4mr18818539eeh.20.1381391953116;
        Thu, 10 Oct 2013 00:59:13 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id r48sm98376178eev.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 00:59:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CACsJy8CHcyDrzieX1Ps3LU2UxCP+QJdv9+5BXZj9Mw2bMs5v3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235855>

> On Mon, Oct 7, 2013 at 5:23 AM, AJ <allj...@gmail.com> wrote:
>> I'm hoping to get the following feature implemented into git.
>>
>> Add the ability to recursively include using:
>> !/my_dir/**/*
> 
> 
> You can do that since v1.8.2. Actually the pattern should be
> 
> !/my_dir/**
> 

Another solution to include just one specific directory:

  /*
  !/wp-content
  /wp-content/*
  !/wp-content/themes

Note the "/*", instead of "*" which matches everything everywhere.


> Checkout gitignore man page for more information.
> 

The compiled version reads like this:

"A trailing "/" matches everything inside. For example, "abc/" matches all files inside directory "abc"..."


--- 8< ---
Subject: [PATCH] gitignore.txt: fix documentation of "**" patterns

"**" means bold in ASCIIDOC, so we need to escape it.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Documentation/gitignore.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 54e334e..f971960 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -113,12 +113,12 @@ full pathname may have special meaning:
 
  - A leading "`**`" followed by a slash means match in all
    directories. For example, "`**/foo`" matches file or directory
-   "`foo`" anywhere, the same as pattern "`foo`". "**/foo/bar"
+   "`foo`" anywhere, the same as pattern "`foo`". "`**/foo/bar`"
    matches file or directory "`bar`" anywhere that is directly
    under directory "`foo`".
 
- - A trailing "/**" matches everything inside. For example,
-   "abc/**" matches all files inside directory "abc", relative
+ - A trailing "`/**`" matches everything inside. For example,
+   "`abc/**`" matches all files inside directory "`abc`", relative
    to the location of the `.gitignore` file, with infinite depth.
 
  - A slash followed by two consecutive asterisks then a slash
-- 
1.8.4.msysgit.1
