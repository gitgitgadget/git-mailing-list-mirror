Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C02220248
	for <e@80x24.org>; Fri, 22 Feb 2019 18:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfBVSam (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 13:30:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53640 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVSal (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 13:30:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id e74so2806450wmg.3
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 10:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=e3luUSvBHd8iMnQzj+HoU3MsxONqAcY0Pj1I8NuV2oY=;
        b=oSMTIPNK1B/iWOcXeUb5x7k2lbs+EuPw8FBuQ2fbCyVBYA7+2WEWcgIIGuQesOjzNM
         ZPXn8byerKN6xc9i5n+tYs3U7cbbaMEcQYEMjMc5pjQfiIFtuYNdXFdmNObJqaemxd+r
         O+iVbtCgDLX6V/M4+MIlYJ8/vgL3nYt/weAzzJIlVmFJ6ICW8/m1dQ98DQ/8xdTZ/VjY
         214fjwbhEmk+LzhXBBfKyr8P73hCp4xj68o/MRIiF+BcHB7A7qA/QywQhdLzWfuE5ejD
         BS67pAll1AH8+mVMliRVOojyAitST4sUv5vpAeb+0Ijn3mQDrH6AnMbuiIMyo9g99iYp
         Y46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=e3luUSvBHd8iMnQzj+HoU3MsxONqAcY0Pj1I8NuV2oY=;
        b=k3+TboZ2hChgaFccQSEF7i5KUilqRdl+oCDBrTKl/jlGwJ28SLB41lG/in6QvAKd6y
         DWpbCdVEmJzCH3lzV8JNb3AVhwCldP2dHZ3GBXPsLbPTGZLJ7ut0VBSaQiLML8gXKldH
         QYWM4PDawOiuilaLs7XI9j2o7Jl6hwZV6GR7DUGFDyIGrrydB5fUV4UnWBLg5DI4og7w
         8T/247zrr3emGq21nxTHXaWZbppbP7K7HbNhlxeEaNV+VdleDPKCOpw90oPu+jVPmbvK
         0GTbXULC4I0j6BoJhIBfh8tJg5hDREEhS21Y6PCf/UUB4S+/WlsFtNRkmt6ON5oxWyma
         5kDg==
X-Gm-Message-State: AHQUAubXg1YYxjACXGfmscG86yX5EAe3oHbDftgkYtI1LjQVDcpyyxSa
        00wyxuDG7cMC7N+tZ3fL/HE=
X-Google-Smtp-Source: AHgI3IYcpOWzkblnJz31ZWykLJ44XnuPijdr0+fWfP9QnPZW0JEnh4ZvmU3OQmcbK+hkat8WAhsSUg==
X-Received: by 2002:a1c:7510:: with SMTP id o16mr3322729wmc.38.1550860239595;
        Fri, 22 Feb 2019 10:30:39 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y5sm2391329wmg.31.2019.02.22.10.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 10:30:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Sebastian Staudt <koraktor@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] commit-graph tests: fix cryptic unportable "dd" invocation
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
        <20190221192849.6581-3-avarab@gmail.com>
        <20190221204310.GS1622@szeder.dev>
        <878sy86anh.fsf@evledraar.gmail.com>
        <20190222105053.GU1622@szeder.dev>
        <8736of6gej.fsf@evledraar.gmail.com>
Date:   Fri, 22 Feb 2019 10:30:38 -0800
In-Reply-To: <8736of6gej.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 22 Feb 2019 15:34:28 +0100")
Message-ID: <xmqqbm33r7zl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> It was my reading of the seek=* section ("the implementation shall seek
> to the specified offset"). I didn't spot that bit covered in of=*. Yeah,
> I see that's defined & safe after reading that.

OK, so...

-- >8 --
From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Date: Thu, 21 Feb 2019 20:28:49 +0100
Subject: [PATCH] commit-graph tests: fix cryptic unportable "dd" invocation

Change an unportable invocation of "dd" with count=0, that wanted to
truncate the commit-graph file.  In POSIX it is unspecified what
happens when count=0 is provided[1]. The NetBSD "dd" behavior
differs from GNU (and seemingly other BSDs), which as left this test
broken since d2b86fbaa1 ("commit-graph: fix buffer read-overflow",
2019-01-15).

Copying from /dev/null would seek/truncate to seek=$zero_pos and
stop immediately after that (without being able to copy anything),
which is the right way to truncate the file.

1. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/dd.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5318-commit-graph.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d4bd1522fe..561796f280 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -382,7 +382,7 @@ corrupt_graph_and_verify() {
 	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
 	cp $objdir/info/commit-graph commit-graph-backup &&
 	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
-	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
+	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null &&
 	generate_zero_bytes $(($orig_size - $zero_pos)) >>"$objdir/info/commit-graph" &&
 	test_must_fail git commit-graph verify 2>test_err &&
 	grep -v "^+" test_err >err &&
-- 
2.21.0-rc2

