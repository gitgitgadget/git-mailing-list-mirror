Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3A8C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC20613DB
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhDTQje (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 12:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhDTQjd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 12:39:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4BBC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 09:39:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j21-20020a17090ae615b02901505b998b45so7348068pjy.0
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=p5uB+Mf/Y0FObWN7ALiccyM4bsERcNfyc1bURZo+Row=;
        b=nCdCUitDkjEcxdC2HGbR7s/uE/1K9NwG2JQgsGXCwuB/Mx3z+dXcg3Jp33Q7AAWmJw
         Gt8wFfvl0wmla5iGPYNjAUi3vsKS9TE1h/djbzGIUyPNoX/69hhkthVUwEDxQeq7qq52
         3s7tDugurN8pcEj3L8yILD2+RE4X0uziRbqaoJq1RWuCzRpKyYvloOxKOw4v5fK3JwI8
         76/o1qH5LHn+D/cLs2OtrsDYc0p9EP1krFqXd/P2Ch22aqg7FhESxzTi9uO1EU0i0Qa7
         put+k9YlqNGYOorBW6E+3z9eKb/fxFQgk4fLdvSkusYLn+ODFmbnf8ZBHlCXnww03BwE
         Qa7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=p5uB+Mf/Y0FObWN7ALiccyM4bsERcNfyc1bURZo+Row=;
        b=EnXO/fpptpTqq0Hhn0FGsYyq4qxH/6iMRJ9UkEcLOiOyzXMuo2uKydYHmMlNBYo/Db
         kNIH4faEOwvLGG5n5lEiwi8QQXIfmyYgVFzyKVFXyvN7zECN3VtqSgml1Xs4wTTQi/++
         Yw90PSwVv2z14BEGqAHpAmKWw/GokXn9pZBzXd1l3pC0fZq9n+fQgZvF6E5JVPcdZJN+
         TPYWZnR0lsd4XT9pgHK1XcitPthdEFxcNK/2613WL7bIJP6xIqS53nti2uwu7uE+GQlh
         H5mkXS2fx0ZVztTMqc3qVndcaUOUYjG8r476DXo0e++7sqVzl6yLSoMMq6ggmyBT/MDi
         wzmA==
X-Gm-Message-State: AOAM532IAcy5v7UVCumfV1LRcPWROjuTWW/QD9/kpQK811sw55tMY60L
        zRk3qyQWmM3l7OHypI7Pm+c16vpOBlCSEw==
X-Google-Smtp-Source: ABdhPJz1xJvV9S8jxkxH69gzmVidaQot5szTnIjdtE8PhwNN2Hbzq3KjDrkjBgoShK6/jPWZx5v/mg==
X-Received: by 2002:a17:902:ff09:b029:eb:3d5a:1332 with SMTP id f9-20020a170902ff09b02900eb3d5a1332mr29865469plj.24.1618936741053;
        Tue, 20 Apr 2021 09:39:01 -0700 (PDT)
Received: from [110.32.98.18] (c-73-158-43-156.hsd1.ca.comcast.net. [73.158.43.156])
        by smtp.gmail.com with ESMTPSA id 195sm11775365pfy.194.2021.04.20.09.39.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 09:39:00 -0700 (PDT)
To:     git@vger.kernel.org
From:   Count of San Francisco <countofsanfrancisco@gmail.com>
Subject: git diff word diff bug??
Message-ID: <215a2703-7a16-5ebd-41b5-de0830a1cf63@gmail.com>
Date:   Tue, 20 Apr 2021 09:38:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

Here is my "git bugreport":

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
   git diff --word-diff=porcelain file0.txt file1.txt
     or
   git diff --word-diff file0.txt file1.txt

What did you expect to happen? (Expected behavior)

   I expected the diff for porcelain or default word-diff to be clear on 
which lines got removed and which changes belong to which line. I 
explain more in details below.

What happened instead? (Actual behavior)

   The diff was not clear.

What's different between what you expected and what actually happened?

   The diff made it looked like all the removed text were on one line 
and a later change in a line look like it was meant for a different 
line. When in fact, the later changes were for the same line (i.e. the 
first line). More details below.

Anything else you want to add:

Here are the details to reproduce and more details on how I interpreted 
the diff. If I am writing a script to highlight changes or to do extra 
processing for my specific use case, my script would get confused as to 
what really changed.

file0.txt content:
*** Begin Content *** --> this line is not in the actual file but just a 
marker here for clarity.
The fox jumped over the wall.
Blah1e32
q432423
qe23234
  233
253
345235

53243
afsfffas
*** End Content ****

file1.txt content:
*** Begin Content ***
The fox jumped over the river.
   He made it over.
*** End Content ****

git diff --word-diff file0.txt file1.txt produced this:
diff --git a/file0.txt b/file1.txt
index c8756ba..3413f10 100644
--- a/file0.txt
+++ b/file1.txt
@@ -1,11 +1,2 @@
The fox jumped over the [-wall.-]
[-Blah1e32-]
[-q432423-]
[-qe23234-]
[- 233-]
[-253-]
[-345235-]

[-53243-]
[-afsfffas-]{+river.+}
{+  He made it over.+}

The diff above does not make it clear that the "{+river+}" is really to 
be appended (or related) to the first line.
I expected the first diff line to look like this:
The fox jumped over the [-wall.-]{+river+} and the rest of the lines are 
delete lines.

git diff --word-diff=porcelain file0.txt file1.txt produced this:
diff --git a/file0.txt b/file1.txt
index c8756ba..3413f10 100644
--- a/file0.txt
+++ b/file1.txt
@@ -1,11 +1,2 @@
  The fox jumped over the
-wall.
~
-Blah1e32
~
-q432423
~
-qe23234
~
- 233
~
-253
~
-345235
~
~
-53243
~
-afsfffas
+river.
~
+  He made it over.
~

This is more non-discernable. The git diff --help documentation says 
that "Newlines in the input are represented by a tilde ~ on a line of 
its own". So a script would see the '~' character and interpret that as 
a new line. The script would have mistaken the "+river" for a different 
line. The git diff --help documentation does not explain what to do in 
this scenario.

I expected this:
  The fox jumped over the
-wall.
+river.
~

Is this a bug? If not, how do I make the distinction that the {+river+} 
(in the first case) and the +river (in the 2nd case) is really for the 
first line?

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.30.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.3.0 Darwin Kernel Version 20.3.0: Thu Jan 21 00:07:06 
PST 2021; root:xnu-7195.81.3~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.28)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show

