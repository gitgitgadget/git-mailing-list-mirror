Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E3F20966
	for <e@80x24.org>; Thu, 30 Mar 2017 20:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934033AbdC3U73 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 16:59:29 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36187 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754435AbdC3U72 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 16:59:28 -0400
Received: by mail-oi0-f44.google.com with SMTP id r203so43239384oib.3
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 13:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=W6C76F/pP598fUuZX5aPLYpCjgpH2cwsf4vWEnUYz0U=;
        b=hk4hhQ8eclUZ/9QvohzSaSqvJ1A741Jhnzpby+EUotbQ2+JiqBxKWI8VC0WHhApo2P
         WJPVz9wT2phgaJIWJAFDhj+AabWaBeYnec1U+b6+5ULMTYN7Lp490oAdabIS0AD54yoj
         D1jNQrzsZeO1ZMzE5TO469qK1ejLbK064a+xyMFD3kSKCWVLM1xc1P89Qg5lgZWXrsXA
         2RxrXnO+BHUNZxEAnA8CLbdaaJ61AYc9a4s1lsG1TLeRogSX255CwGmNCJd1Ht8PSJMa
         AbRGNKZ4m5ER7qdrED4NHUQmTuApHzOKH0mgor1j+pl2gTHwYdK86/wu2t+7ZrxCdR99
         7Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=W6C76F/pP598fUuZX5aPLYpCjgpH2cwsf4vWEnUYz0U=;
        b=ARJr4typyU40Fn2ieAF4DSavdwwRotR7Ze81/3pegtEaJHywlr2ekaTBtkKxHD8Ky9
         YviIWW5ycOWXQpFnkKBpzBcYwDdSZi6X7i1lIj1fIe3xliiiuoJ5LGYOMk7/8gxKJ1Q3
         sWWQMlaxs63yjyGeX2NBja9xP20mjRp6+BUoo4/5TSyyVPJt8jEW6T6XdqJBqzH84+9n
         nPoYjLDW7/udl6erd3F5PbIyDD+ptiSP3lxg/DhvgzwX+3pp/1NrPhyeHA0xI06NmaMv
         SzPLnzcShgDEZuJ9R+NLfemVNhzNntyj0yaRTtWjON9CRk8M23QrrDwQ3ZUCfzRhHeZm
         l4aw==
X-Gm-Message-State: AFeK/H1mmOUBrwYh3HXwIFNc4Doyjy1yrGUY7M4YrFo0vm1R9GS3lhlgKUvFdVWYfKHWjm60c9HkTO14oIbw7A==
X-Received: by 10.157.8.129 with SMTP id 1mr1282486otf.123.1490907567384; Thu,
 30 Mar 2017 13:59:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.31.131 with HTTP; Thu, 30 Mar 2017 13:59:27 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 30 Mar 2017 16:59:27 -0400
Message-ID: <CAH8yC8kOeuVjvoeg0WsSfDeakJh_es2xhYK_O_bM87DEBVcB1w@mail.gmail.com>
Subject: Git and PCRE2 vs PCRE?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some more 2.12.2 testing on Solaris 11.3 x86_64:

    ...
    CC ident.o
    CC kwset.o
    CC line-log.o
    CC levenshtein.o
    CC line-range.o
    CC list-objects.o
In file included from revision.h:5:0,
                 from line-log.c:10:
grep.h:5:18: fatal error: pcre.h: No such file or directory
 #include <pcre.h>
                  ^
compilation terminated.
gmake: *** [line-log.o] Error 1


Configure has an option for libpcre, but its not clear to me how to
fine tune it for libpcre2:

$ ./configure --help | /usr/gnu/bin/grep -A 2 -i pcre
  --with-libpcre          support Perl-compatible regexes (default is NO)
                          ARG can be also prefix for libpcre library and
                          headers

Is it possible to use PCRE2 with Git? If so, how do I tell Git to use PCRE2?

Thanks in advance.

**********

$ ls /usr/local/include/pcre*
/usr/local/include/pcre2.h       /usr/local/include/pcre2posix.h

$ ls /usr/local/lib64/libpcre*
/usr/local/lib64/libpcre2-16.a
/usr/local/lib64/libpcre2-16.la
/usr/local/lib64/libpcre2-16.so
/usr/local/lib64/libpcre2-16.so.0
/usr/local/lib64/libpcre2-16.so.0.5.0
/usr/local/lib64/libpcre2-32.a
/usr/local/lib64/libpcre2-32.la
/usr/local/lib64/libpcre2-32.so
/usr/local/lib64/libpcre2-32.so.0
/usr/local/lib64/libpcre2-32.so.0.5.0
/usr/local/lib64/libpcre2-8.a
/usr/local/lib64/libpcre2-8.la
/usr/local/lib64/libpcre2-8.so
/usr/local/lib64/libpcre2-8.so.0
/usr/local/lib64/libpcre2-8.so.0.5.0
/usr/local/lib64/libpcre2-posix.a
/usr/local/lib64/libpcre2-posix.la
/usr/local/lib64/libpcre2-posix.so
/usr/local/lib64/libpcre2-posix.so.1
/usr/local/lib64/libpcre2-posix.so.1.0.1
