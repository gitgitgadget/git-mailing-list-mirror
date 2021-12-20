Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3F2C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 17:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhLTRYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 12:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhLTRYM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 12:24:12 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BD9C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 09:24:12 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j6so20515147edw.12
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 09:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=cXlUImO50kU7rrAZ1Ar5mQgFzYFVTF4Zrl6lt3cotw4=;
        b=i+qGaAX9Tcm9qqhHO3WrYjDodF/cbm9yMPSqc1BtK4Vt+MPeoIKz4IuGTN/VPmHFVM
         FRc7Hf/XfQNrNrk3JVEw/pGVUQmiy74wyd70X9JDn44abkUjujNQB/mnDh3PzkmECtN+
         oYDcHDiM0Kxl0/8DnxW5mzy4YPZOy9e1csEf8eYTHX9EZMxIPz4JT/LaPpr+lkJq9KAG
         j3bUKIDoyysEqkGmKtbXLuzeHN0g6bOL/zVoMJQMCNM1Q7Ho0uha5bp4wCzvAMT0bPAW
         ye0zioe43OvP3+clXV4XaqF4fSa8vMqbe17otWAz1JwGIP5eJ2Sn1HvcTd7nC28M21Kx
         /Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=cXlUImO50kU7rrAZ1Ar5mQgFzYFVTF4Zrl6lt3cotw4=;
        b=0dsEuXgMpEJm+7l2PAguHnUSl68BBhHZntBPhIBrSQaHPMDrKnEIydnZp2nycVsdi5
         /ue9biRDBK4YEeBLr21ASZnsLchm/klnjWgfeLYpLiRw8IFMmkdrQgUc41X+hHuC28dV
         pLDpr2cMPkCxTwR0XNQ8FslNCQYxtXsd27AYnSiaTg0pGfm9Bz6znbprYej1YT1sgSud
         oqzefo99QLWBQ8iAs7tazSYFfRjdNBh79C0iOaMfzkV3u8ZqUx1KVQgTnirZAu3bgfjK
         WEpz6aJtJo0bGWgk+nky7e/r9bZfO2KFwuahwb9ka43SZp8Omk7cawjhDfQAgTOpZHWi
         Ox4w==
X-Gm-Message-State: AOAM532RX7AXNJasnRMJC1HCnZWUmbt9wsFPHINmPkRAJCgKzDLEbufA
        ModljyGobk2X/e1gzP4tbJ0=
X-Google-Smtp-Source: ABdhPJyrpE4id086x4WsMpadi7rHX7GRVd0hX1MZWb5ahP+uM/MJXhUvjFmmiiRNanRbLfTO9uhMRA==
X-Received: by 2002:a05:6402:2315:: with SMTP id l21mr12637731eda.135.1640021050667;
        Mon, 20 Dec 2021 09:24:10 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jt4sm3615542ejb.105.2021.12.20.09.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 09:24:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzMOP-000UT4-EI;
        Mon, 20 Dec 2021 18:24:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 9/9] trace2: add global counters
Date:   Mon, 20 Dec 2021 18:14:28 +0100
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <596caede216c44d2a01358229bc1a47248e708b1.1640012469.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <596caede216c44d2a01358229bc1a47248e708b1.1640012469.git.gitgitgadget@gmail.com>
Message-ID: <211220.868rwfur46.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> [...]
> +struct ut_011_data {
> +	int v1, v2;
> +};
> [...]
> +	struct ut_011_data data = { 0, 0 };

Nit: Just "{ 0 }" is OK for zero'd out initialization. No need to keep
extending this for every field.

For things that want to exhaustively list fields for clarity, designated
would be preferred:
o
    { .v1 = 0, .v2 = 0 }

> +	int nr_threads = 0;
> +	int k;
> +	pthread_t *pids = NULL;
> +
> +	if (argc != 3)
> +		die("%s", usage_error);
> +	if (get_i(&data.v1, argv[0]))
> +		die("%s", usage_error);
> +	if (get_i(&data.v2, argv[1]))
> +		die("%s", usage_error);
> +	if (get_i(&nr_threads, argv[2]))
> +		die("%s", usage_error);

A partial nit on existing code, as this just extends the pattern, but
couldn't much of this get_i() etc. just be made redundant by simply
using the parse-options.c API here?  I.e. OPTION_INTEGER and using named
arguments would do the validation or you.

> +# Exercise the global counter in a loop and confirm that we get the
> +# expected sum in an event record.
> +#
> +
> +have_counter_event () {
> +	thread=$1
> +	name=$2
> +	value=$3
> +	file=$4
> +
> +	grep "\"event\":\"counter\".*\"thread\":\"${thread}\".*\"name\":\"${name}\".*\"value\":${value}" $file
> +
> +	return $?
> +}

It looks like there's no helper, but this is the Nth thing I see where
wish our "test_region" helper were just a bit more generalized. I.e.:

    test_trace2 --match=counter --match=thread=$thread --match=name=$name --match=value=$value <trace>

With test_region just being a wrapper for something like:

    test_trace2 --match=region_enter --match=category=$category --match=label=$label <trace> &&
    test_trace2 --match=region_leave --match=category=$category --match=label=$label <trace>

> +static void tr2main_emit_summary_counters(uint64_t us_elapsed_absolute)
> +{
> +	struct tr2_tgt *tgt_j;
> +	int j;
> +	struct tr2ctr_block merged;
> +
> +	memset(&merged, 0, sizeof(merged));

nit: more memset v.s. "{ 0 }".
