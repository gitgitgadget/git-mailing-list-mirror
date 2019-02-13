Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 269651F453
	for <e@80x24.org>; Wed, 13 Feb 2019 17:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388566AbfBMRZ3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 12:25:29 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:36979 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733301AbfBMRZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 12:25:29 -0500
Received: by mail-wm1-f43.google.com with SMTP id x10so3274272wmg.2
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 09:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MKq1UBmOVlw6xIeV2A+Sgs6dAeGrF7HF3jrkrqlUGnk=;
        b=Qrq2dwOUxzKkR0fMv4z1W7HzxKcuxUNY6XokaNK3+0CB2GjiggUfqIn82FV7ep8t2w
         ktwX8Mc+/mADZx7C/0RDKcsaMy0WjRv4aj/NdHYN2JJLapNQdsrwma3KdUYlPxuIb+p4
         ILAEz8Pt04pVOieUOeX66hAgKcZt/GLl1lya8OOaFJMc5N+tRUuaEc/UDaeaBj8RdwKm
         8bmfkta5Kwcpxoi05Q7nHaKX8h7q1vbIGx2Mld7/rN9+ca6vTbQSjiF4qvxvLLfZWI9O
         fnC9k/zsFjvMrxKH05d+3rl09mCHZOG9Z66JVeTsE9JON0cQVBZhB9h7xKVpGrvK4dsr
         6T0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MKq1UBmOVlw6xIeV2A+Sgs6dAeGrF7HF3jrkrqlUGnk=;
        b=dKzdHTTuWEJVB4w9e/jodRrN+/vWWtV74D9/D7pnhTQqMBmTDjB/rraFkMH+JrAOwn
         4fVeIcsyEwutchXE7NqAIOzcQHrMp1sFQJ2TKyvGbLveBpG6U76ZV+xysGhjo7qJ2MsV
         WbgKaJlxSsWrtrzhk4x9PtlxZcI9yCwpzlbM6N/gJurUDz+/j8I5Wa/M2RlcTol/v/TW
         U6co9IGRIspxW3BPNPvYjIaV8EmI+YaVzFWuuM3oWi3jQ06c3QyqyXypom2H/8A3i/6C
         bawHDoktkadCR5p4pUc5uITovRJL5TSS+r4s0cm+j2ESLD7hGr9s6rPz8LUeaILJZaTw
         vV7w==
X-Gm-Message-State: AHQUAubNMHbXr7Qwal/PLDMLFyQaHKXSinFjBX7psoSCtt7FjsElZRk/
        Ei5gJZpmL4pHtCnVmLhXLX0=
X-Google-Smtp-Source: AHgI3IaVT4rA4F0vuwA4DC3R7axMPPfMKUFWGkdZbNvdXAvGhdh2cL2byvWQgP8ta2A7ILRRbweJQw==
X-Received: by 2002:a1c:7dd6:: with SMTP id y205mr1084377wmc.121.1550078726980;
        Wed, 13 Feb 2019 09:25:26 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c1sm5149900wrw.7.2019.02.13.09.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 09:25:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     randall.s.becker@rogers.com, Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Patch v1 2/3] t5318: replace use of /dev/zero with generate_zero_bytes
References: <20190209185930.5256-1-randall.s.becker@rogers.com>
        <20190209185930.5256-3-randall.s.becker@rogers.com>
        <CAPig+cTMoYMmnHVuay_4RGr_FN-HWC1tN4TPDsNM4vKCH3GzXw@mail.gmail.com>
        <xmqqh8d9diy8.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 13 Feb 2019 09:25:24 -0800
In-Reply-To: <xmqqh8d9diy8.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 12 Feb 2019 09:18:07 -0800")
Message-ID: <xmqqh8d7d2ij.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Sat, Feb 9, 2019 at 2:00 PM <randall.s.becker@rogers.com> wrote:
>>> This change removes the dependency on /dev/zero with generate_zero_bytes
>>> appending NUL values to blocks generating wrong signatures for test cases.
>>
>> This commit message says what the patch does but not _why_. At
>> minimum, it should explain that /dev/zero is not available on all
>> platforms, therefore, not portable, and (perhaps) cite NonStop as an
>> example.
>
> Does sombody want to do the honors?  [PATCH 1/3] would become wasted
> effort until that happens.  On the other hand, if this is not urgent
> (it is only urgent for those without /dev/zero, and to others it may
> be distraction/disruption this close to the final release to add
> increased risk of fat finger mistakes), obviously I can wait.

So, before I lose the access to my primary screen (I was told that
somehow I need to reimage the workstation today X-<), here is what I
have now.

-- >8 --
From: "Randall S. Becker" <rsbecker@nexbridge.com>
Date: Sat, 9 Feb 2019 13:59:29 -0500
Subject: [PATCH] t5318: replace use of /dev/zero with generate_zero_bytes

There are platforms (e.g. NonStop) that lack /dev/zero; use the
generate_zero_bytes helper we just introduced to append stream
of NULs at the end of the file.

The original, even though it uses "dd seek=... count=..." to make it
look like it is overwriting the middle part of an existing file, has
truncated the file before this step with another use of "dd", which
may make it tricky to see why this rewrite is a correct one.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5318-commit-graph.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 16d10ebce8..d4bd1522fe 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -383,7 +383,7 @@ corrupt_graph_and_verify() {
 	cp $objdir/info/commit-graph commit-graph-backup &&
 	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
 	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
-	dd if=/dev/zero of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
+	generate_zero_bytes $(($orig_size - $zero_pos)) >>"$objdir/info/commit-graph" &&
 	test_must_fail git commit-graph verify 2>test_err &&
 	grep -v "^+" test_err >err &&
 	test_i18ngrep "$grepstr" err
-- 
2.21.0-rc0-36-ge9bd4aa026

