Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78516C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 17:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345254AbhLFR5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345200AbhLFR5C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 12:57:02 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30671C0613F8
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 09:53:34 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso518371pjb.0
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 09:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5Z7jA34SMVywaSgl9Olo6+DIvEZeCjUPwdeGlZiCULc=;
        b=JBSaiTe9WJtLi4oHt373QP7lXlgcMRptvhxWAtkXQH0isHDeDLaTSzmalBsy49Kp+v
         Kqs2KXPaGMChn9EdNDrfApUx9KuvgzZkMAK9pmdZmTveICQza/eYO9B/66R7DfFbFjJl
         NVZCPaN3El9q35zp8TiGKnI4Almk+blwn8lc2RwrhU7KpYD2CH0sjCKBJ0xeb637PjAn
         c3y5u6e8sU9whWPmLfACkDfypi7BVFRPXEZ9Gl1bEH5HP+2OOqA1MBOJv/TKlh0qdq6V
         GmY9ugbvvMtPnixIXprEAuc7G15jc3yq1/zzYE82TptsZjfDW++ofMjFIspuN5GGL5LV
         yxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5Z7jA34SMVywaSgl9Olo6+DIvEZeCjUPwdeGlZiCULc=;
        b=neHcheiUdftNHhEfIG5Qob+hp40xYi9BfMojiAsfwZAAmUHdEnCuvt0d3O0e7vv5rB
         xFlo923I5pffEE0xk6lUXdMKFsS3gFr9671JXV+NWC47bKzc/ngqTzaPV4Ob6myqsv8V
         7FsF7KW5TPeNfw+brlb8+s4HCj/JFird45o9JQTptD3kcq2B0do1k9lLVrYWBv9LYZyK
         7YTsOarh/EuBwyS/tD+PO+szgmTkDuCSsTfaETnEIFwPvYj/kJ33kGJ6mrux8qG8hFuX
         unJmGuC/SN0HwuPhkQj6IZq91j+HiRiXfPhvNQQXiwCTGDKE+5jnlstbHvXk9sNcA4jM
         2nAA==
X-Gm-Message-State: AOAM532uez+TiedndNNMhldMYi7bky9SJPyJepSHSGmWs0sROnNmC8nt
        TfdAl/jSNCTAU2s31R9AIBM=
X-Google-Smtp-Source: ABdhPJzRvBlvZVY2Z0zIpJ6ZPlZ8G3aRgext9WoQAxLzonoxRt94OxhXedEkdbiPlEQ0+JhuA6u5gQ==
X-Received: by 2002:a17:903:11cd:b0:143:d220:fddb with SMTP id q13-20020a17090311cd00b00143d220fddbmr45181910plh.5.1638813213630;
        Mon, 06 Dec 2021 09:53:33 -0800 (PST)
Received: from localhost ([2620:15c:289:200:9206:9546:da97:4e9c])
        by smtp.gmail.com with ESMTPSA id mv22sm26024pjb.36.2021.12.06.09.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:53:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Jeff King <peff@peff.net>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [PATCH 2/2] git-worktree.txt: add missing `-v` to synopsis for
 `worktree list`
References: <20211203034420.47447-1-sunshine@sunshineco.com>
        <20211203034420.47447-3-sunshine@sunshineco.com>
        <211203.86k0gmt5fl.gmgdl@evledraar.gmail.com>
        <CAPig+cR7f1koM7d2GoHMcDhZkQe3=XJD2RVuMajXSpcwZiyGtQ@mail.gmail.com>
        <xmqqa6hfmn3u.fsf@gitster.g>
        <CAPig+cQ82UC3MRSswGtnCcB13wdhTNYzDex=tFSuFwFCjL3ErA@mail.gmail.com>
        <211206.86bl1trbdp.gmgdl@evledraar.gmail.com>
Date:   Mon, 06 Dec 2021 09:53:32 -0800
In-Reply-To: <211206.86bl1trbdp.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 06 Dec 2021 16:06:10 +0100")
Message-ID: <xmqqh7blhb6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> Taking this point into consideration, a middle-ground alternative to
>> Ævar's idea would be to add tooling which only compares (by some
>> definition of "compare") the output of `git blah -h` with the synopsis
>> in `git-blah.txt` and complains if there are significant differences
>> (by some definition "significant" and "difference"). It doesn't
>> automate-away the work of keeping the synopsis up-to-date, but at
>> least would flag inconsistencies.
>
> Or we could do the reverse and move the source code version of it to be
> generated from the [verse] sections in the documentation.

Either would be far more preferrable than committing generated files,
or committing us to work on unreadable sources.

Thanks.

