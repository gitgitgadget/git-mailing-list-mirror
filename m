Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D00AC433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 23:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiKOXkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 18:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiKOXkl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 18:40:41 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D4CF09
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 15:40:39 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gv23so7406863ejb.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 15:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+7b8jKDqG10YR+sSr23/wkLb9ApoENPL7pyRkFAROw=;
        b=j5aMa+a0+80Mm3SeYzOG2zi5jC31+i+XS3dumivGm3yDmO49Bl+yNZN8oyuTT1HniA
         4fyBxwHMBDa77NgRCEqQ0b/2NZ6W8W68JfbZC0rwv7f7E+/ImYtWlMn5MPWdPnHgZshm
         n3FcS9z1NSLJf+Ns8BSTokMDu9ZHft8cDLWUJr+2/7oSSziA0luZiAict0SKVK+RF6vL
         0TgyBRBTOMy41c+CUx4fzo8bd1knyrpLNIq60x3BKKdfO5zB8S3l5kYmjC1fWWgUY09q
         tjj7Iw9kkW8uaabfPWTNbm8Iy5cqXWR6p9E96v9JVfKZNaQMmf6CXa/RLn2GVTUbjH1K
         llQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+7b8jKDqG10YR+sSr23/wkLb9ApoENPL7pyRkFAROw=;
        b=QAutmiKYadj8DE0IY5xaxxSraV6GcDLprKzMo5IvDusrIRqu5LPWEAvNhtR4Qmgu1h
         9kmRLqxjOiLlUZ3mO4iONOlvBf7QDUZ1T3r2sUXZs676FwP89ImR20dt4fXrgOnjLpIL
         ETuqtg0ct14EBN4HCUdO5y2cUWygluqHiN4bSGSXRWvHn5V+3IGRvyzMioKLsF6Cwryq
         qDK8xJn0E3UdKXbVJbkIVejR/xrj4Qtwi3CcQW47Eo4ccoQ7MspwAhglN5gsKlxfxR9P
         qYNmwjXzksmY2FT0Ugl7NlalNnmdcdU517DXn4JpiiE0NZdldbaLeF4sfKwx0eijkV04
         8NrQ==
X-Gm-Message-State: ANoB5pmHS/BEdWHaN/wX5ofGeMDPt7uVuC2xmu6nk/gW7lUwBhbkjKd8
        dgVDxYNxbspJziTLT1Rvfp1IMFkFAZIxLw==
X-Google-Smtp-Source: AA0mqf6ZTmOwgP2URpBvsOaN1MzjwuZ4hkrx+gtkgMuPMLDKackT2pv94dzIwyQEx39FlTqAyNSEsw==
X-Received: by 2002:a17:906:5054:b0:79b:413b:d64 with SMTP id e20-20020a170906505400b0079b413b0d64mr15322973ejk.538.1668555636112;
        Tue, 15 Nov 2022 15:40:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906309500b007add62dafbasm6083163ejv.157.2022.11.15.15.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 15:40:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] t7610: use "file:///dev/null", not "/dev/null", fixes MinGW
Date:   Wed, 16 Nov 2022 00:40:14 +0100
Message-Id: <patch-1.1-21a9cb49299-20221115T233516Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1473.g172bcc0511c
In-Reply-To: <Y3PrjMLcEGfoHifZ@nand.local>
References: <Y3PrjMLcEGfoHifZ@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On MinGW the "/dev/null" is translated to "nul" on command-lines, even
though as in this case it'll never end up referring to an actual file.

So on Windows the fix for the previous "example.com" timeout issue in
8354cf752ec (t7610: fix flaky timeout issue, don't clone from
example.com, 2022-11-05) would yield:

  fatal: repo URL: 'nul' must be absolute or begin with ./|../

Let's evade this yet again by prefixing this with "file://", which
makes this pass in the Windows CI.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Tue, Nov 15 2022, Taylor Blau wrote:

> On Wed, Nov 09, 2022 at 09:17:25PM -0500, Taylor Blau wrote:
>> On Thu, Nov 10, 2022 at 12:55:30AM +0100, Ævar Arnfjörð Bjarmason wrote:
>> > But we generally just fail some or all of 3..9 pretty fast, and don't
>> > start taking 20 minutes to run the test, when it took 10s before (or
>> > whatever).
>>
>> OK. I still think that in principle this is indistinguishable from not
>> running a setup test to completion.
>>
>> *But*: I'm willing to treat them differently since instead of
>> manifesting in an immediate failure later on in the suite, we hang for a
>> substantial period of time.
>>
>> So I'm content to merge this down, but I don't think it's worth
>> searching out for more of these in the future.
>
> Having merged this down to 'next', it looks like there is some CI
> fallout on the Windows tests, see:
>
>   https://github.com/ttaylorr/git/actions/runs/3473324797/jobs/5805324776
>
> I am not sure how I might have caught this earlier not having a Windows
> machine myself. Regardless, let's make sure that it is fixed up before
> this graduates.

Sorry again :( I think my CI was quite queued up at the time, and I
figured surely *this* won't have any porability issues, but forgot
about MinGW's sneaky /dev/null string-replacement behavior.

Windows CI passes with this:
https://github.com/avar/git/actions/runs/3473817195

 t/t7610-mergetool.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index b1ba0d9a088..7b957022f1a 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -33,7 +33,7 @@ test_expect_success 'setup' '
 		git add foo &&
 		git commit -m "Add foo"
 	) &&
-	git submodule add /dev/null submod &&
+	git submodule add file:///dev/null submod &&
 	git add file1 "spaced name" file1[1-4] subdir/file3 .gitmodules submod &&
 	git commit -m "add initial versions" &&
 
@@ -614,7 +614,7 @@ test_expect_success 'submodule in subdirectory' '
 		)
 	) &&
 	test_when_finished "rm -rf subdir/subdir_module" &&
-	git submodule add /dev/null subdir/subdir_module &&
+	git submodule add file:///dev/null subdir/subdir_module &&
 	git add subdir/subdir_module &&
 	git commit -m "add submodule in subdirectory" &&
 
-- 
2.38.0.1473.g172bcc0511c

