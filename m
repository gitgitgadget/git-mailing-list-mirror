Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA42C4332F
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 12:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiL0Mwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 07:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiL0Mwu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 07:52:50 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99B210DB
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 04:52:48 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id m4so13170762pls.4
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 04:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMGRoCtTWrJkVv3OycXZpOCg1/pie1Z7Mgdk0nhtxH4=;
        b=bi8wXEKDlkmCnutS7FAWKXoG3kfQof9fK9kZnvtG2SACEYS17a/zHDP8SfXYof89nV
         gUseHMz6JmqYdLvVoav9Z0k9lGeL+KINPbsOyq5mTXuACPooOzYkvo43/PHj+EqjfG2K
         Y3Hfh4hsJkXdpaJhIkplI2XhZAlFoQKVr+mRets/jJFQEfiGdaLsFV0aDNgWnLRElqLf
         /CU+oXSN9NPzRlPCdxmB9M81RXX4hzHUrO3xGOr9vK2oBVxl7R8hIiWt36cmw7raAvIh
         R1m9uVlwfXYBlcEYVSErY77lkhNNANFHpmQ6ynhDFHCuH1Xzd+Mb1kPDPJ1A4JSvGvNj
         dfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMGRoCtTWrJkVv3OycXZpOCg1/pie1Z7Mgdk0nhtxH4=;
        b=W0ncpsSFsyFt016IXAmVxEQ966RKKoOAgH6GOAJgIZCrFtZt5lVg7IcBgnHAKeNiK2
         yU+CNFdlgMe56QZg3KektA3tSXofmkbk4NLCUznFZCf5f25kLMdL7/TokOkCO2Jp/9o7
         SFDo6/KcOEn8TTuQsHVu70QWkifGZxxW6aKvS2J26NDhXjdbmTGRbQZa100VJ0lwZVMM
         9oMSXgpzZEtNscsJGMohele/J/5ZxrWljEra3HA/n0LdOqiUXPimHFRucB9K9WB5Uux7
         ybEnTMjUd+g0SydOVXg9pZA7SBdkfr4J1YJJ+n86Veo4sxlgKvB6t+tgCt6ZhA6ytV7f
         HVyA==
X-Gm-Message-State: AFqh2kpISYoB+670KGDAlu4RjyyhTrsSWwZO0ewXe+tb+ixs738BP1ZK
        3LLojSa+XM726rzl046c6cM=
X-Google-Smtp-Source: AMrXdXtkzI9jxMGaFvtowwBX+UU5iBYQzpV2qAfrQ7RJE1xDW5FYwugCrK/AkvHPUQUxAUOCbqZrPw==
X-Received: by 2002:a17:902:e2ca:b0:18e:c6b0:b2f6 with SMTP id l10-20020a170902e2ca00b0018ec6b0b2f6mr20755156plc.14.1672145567827;
        Tue, 27 Dec 2022 04:52:47 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b00185402cfedesm8999600plx.246.2022.12.27.04.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 04:52:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: js/drop-mingw-test-cmp, was Re: What's cooking in git.git (Dec
 2022, #03; Sun, 11)
References: <xmqqpmcqv7qh.fsf@gitster.g>
        <o428pr88-sn2p-o715-52ns-1r6750762572@tzk.qr>
        <xmqqa63ss3fl.fsf@gitster.g>
        <c57ecd23-7ca7-2501-983f-6661c7872a01@gmx.de>
        <xmqq7cyksy88.fsf@gitster.g>
        <3c55ac67-5090-b7af-a212-2996bad66fb2@kdbg.org>
        <2090204b-52e9-a22f-f0c9-f812d1231863@web.de>
        <ef79236a-1c47-8775-3acb-aa23b7a300f9@kdbg.org>
        <2a5433ae-ec48-0c24-c18e-9a415d29e590@web.de>
Date:   Tue, 27 Dec 2022 21:52:46 +0900
Message-ID: <xmqqilhxt3dt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Logged the sizes of files handed to test_cmp (on macOS).  19170 calls,
> median size 42 bytes, average size 617 bytes.  2307 calls with empty
> files, 1093 of which in t1092 alone.  The two biggest files in t1050,
> 2000000 and 2500000 bytes.  t9300 in third place with 180333, one
> magnitude smaller.
>
> t1050 at 8a4e8f6a67 (The second batch, 2022-12-26) on Windows:
>
> Benchmark 1: sh.exe t1050-large.sh
>   Time (mean ± σ):     18.312 s ±  0.069 s    [User: 0.000 s, System: 0.003 s]
>   Range (min … max):   18.218 s … 18.422 s    10 runs
>
> ... and with the patch:
>
> Benchmark 1: sh.exe t1050-large.sh
>   Time (mean ± σ):      5.709 s ±  0.046 s    [User: 0.000 s, System: 0.003 s]
>   Range (min … max):    5.647 s …  5.787 s    10 runs
>
> So it works as advertised for big files, but calling an external
> program 19000 times takes time as well, which explain the longer
> overall test suite duration.
>
> If we use test_cmp_bin for the two biggest comparisons we get the
> same speedup:
>
> Benchmark 1: sh.exe t1050-large.sh
>   Time (mean ± σ):      5.719 s ±  0.089 s    [User: 0.000 s, System: 0.006 s]
>   Range (min … max):    5.659 s …  5.960 s    10 runs
>
> Is this safe?  The files consist of X's and Y's at the point of
> comparison, so they aren't typical binary files, but they don't
> have line endings at all or any user-readable content, so I think
> treating them as blobs is appropriate.

Nice analysis.

If we can use the platform "diff -u" (i.e. we somehow find that it
is possible to stop ignoring crlf vs lf difference), then it should
give us similarly good performance for large files (but the cost to
spawn the tool 19000 times would also be comparable), but we are not
there yet, I presume.
