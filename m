From: Dingyuan Wang <abcdoyle888@gmail.com>
Subject: assert failed in pathspec.c
Date: Thu, 11 Feb 2016 11:59:16 +0800
Message-ID: <56BC0714.1010007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 04:59:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTiPz-0001K8-Bm
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 04:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbcBKD7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 22:59:22 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36085 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbcBKD7U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 22:59:20 -0500
Received: by mail-pf0-f177.google.com with SMTP id e127so22734909pfe.3
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 19:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=pfTJXnilEBLEvcSjZAvUJi5IT3KUAPOCFgaehZ0Jj6s=;
        b=hSKAiCbZqTGhnjgVw+Tvw2/nw0lW29uDHhiMYOcZine8sbvwBkLMdFegTvgRRE1s55
         Ll16VkyAWWTnPIq/G8VZnHYk3qyF/+U0vd7nhl8qS+5o+FQMsdRzcy6JkMF5VOzsXvR1
         8wB16VSGG1T2GUAJ8eJkCNCzcyEIp/Ilh9m9Y9G5W6fCjTh2xZwVzHiLsLY0cMEHSv6P
         FNJ9h2R8mgio6TASwmBtkQE4cx295+CYSQD8wmw/u91KFUl3lUI2XTb2a09ZyonSqLVJ
         /1WTUMdHhbNHP4bO2ItRmkck4YDROnNUQzuefXdDu/4994f8GjeA9tfuNiR+9VDKO6q+
         oKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=pfTJXnilEBLEvcSjZAvUJi5IT3KUAPOCFgaehZ0Jj6s=;
        b=GGgVfHntkvQOWCgD4M0AALmbmm9q0G9xe0vE51nRY7vpI187iHBVHZhZ8HpTRS0sw4
         bKzP55O0uxs2H/3QSEj0pXHTEOEKIC+ocDncpxe7LfgiTxEV2aijFKhQ7WuCTu9UYlhO
         rT4H5sORFV04xWqTrJR11+AWlkxOblQLBr3nLRS+twnbYRebjESA992rQuei9/XCTWYF
         M0kK4EeByzeBEemw4weBi3Waq2eJdWnl2iMbE9C1TiFx3jM2wb+C+lxmGt2GY5ol+EDR
         zpUrRJS39zO72saYgOOU58T9Fx3sTtRxWLXz+lCFxFMW5IVgc1elgjvuTVVwhoCqn8Bx
         nG1g==
X-Gm-Message-State: AG10YORrJQSnQRpI1xFD/rW00P1XWQ7L8sFf0mt438aSdRGw0rrJ8WIKFNn80bsgejz48w==
X-Received: by 10.98.86.145 with SMTP id h17mr64059450pfj.9.1455163160298;
        Wed, 10 Feb 2016 19:59:20 -0800 (PST)
Received: from [192.168.1.12] ([114.85.11.215])
        by smtp.gmail.com with ESMTPSA id yx4sm8365950pac.5.2016.02.10.19.59.18
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Feb 2016 19:59:19 -0800 (PST)
X-Enigmail-Draft-Status: N1010
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285946>

Hi all,

I've got an assertion error when `git add .`

git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len <=
item->len && item->prefix <= item->len' failed.
Aborted (core dumped)

I think the repo doesn't have anything interesting.
No submodules or subrepos. It's like:

repo/
 .gitignore
 .git/
 scripts/
  .gitignore
  foo.py
  bar.json
 something/
 someanother/
 other/         (gitignored)
  scripts.git/  (original .git for scripts/)
  foo.txt

With

modified:   ../something/a.txt
modified:   ../someanother/b.txt
...

Working directory is repo/scripts.

I think the bug is related to this post: [assert failed in submodule
edge case](https://marc.info/?l=git&m=142894416621088&w=2).

(gdb) r
Starting program: /home/gumble/software/git-master/git-add .
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
git-add: pathspec.c:317: prefix_pathspec: Assertion
`item->nowildcard_len <= item->len && item->prefix <= item->len' failed.

Program received signal SIGABRT, Aborted.
0x00007ffff6fc8507 in __GI_raise (sig=sig@entry=6) at
../sysdeps/unix/sysv/linux/raise.c:55
55	../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) bt
#0  0x00007ffff6fc8507 in __GI_raise (sig=sig@entry=6) at
../sysdeps/unix/sysv/linux/raise.c:55
#1  0x00007ffff6fc98da in __GI_abort () at abort.c:89
#2  0x00007ffff6fc159d in __assert_fail_base (fmt=0x7ffff70fe6b8
"%s%s%s:%u: %s%sAssertion `%s' failed.\n%n",
    assertion=assertion@entry=0x56ffe0 "item->nowildcard_len <=
item->len && item->prefix <= item->len", file=file@entry=0x5701a6
"pathspec.c", line=line@entry=317,
    function=function@entry=0x5701d0 <__PRETTY_FUNCTION__.22386>
"prefix_pathspec") at assert.c:92
#3  0x00007ffff6fc1652 in __GI___assert_fail
(assertion=assertion@entry=0x56ffe0 "item->nowildcard_len <= item->len
&& item->prefix <= item->len", file=file@entry=0x5701a6 "pathspec.c",
    line=line@entry=317, function=function@entry=0x5701d0
<__PRETTY_FUNCTION__.22386> "prefix_pathspec") at assert.c:101
#4  0x00000000004deb3e in prefix_pathspec (elt=0x7fffffffe3f5 ".",
prefixlen=8, prefix=0x7e71f3 "scripts/", flags=50, raw=0x7fffffffe0a0,
p_short_magic=<synthetic pointer>, item=<optimized out>)
    at pathspec.c:316
#5  parse_pathspec (pathspec=pathspec@entry=0x7fffffffd530,
magic_mask=magic_mask@entry=0, flags=flags@entry=50,
prefix=prefix@entry=0x7e71f3 "scripts/", argv=argv@entry=0x7fffffffe0a0)
at pathspec.c:417
#6  0x0000000000406423 in cmd_add (argc=<optimized out>,
argv=0x7fffffffe0a0, prefix=0x7e71f3 "scripts/") at builtin/add.c:364
#7  0x0000000000405cc8 in run_builtin (argv=0x7fffffffe098, argc=2,
p=0x7b2520 <commands>) at git.c:352
#8  handle_builtin (argc=2, argv=0x7fffffffe098) at git.c:542
#9  0x0000000000404e7a in main (argc=2, av=<optimized out>) at git.c:665


--
Dingyuan Wang
