Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D2AC19F2A
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 11:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiHAL6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 07:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiHAL5t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 07:57:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C6640BD2
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 04:52:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id tl27so2000444ejc.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 04:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=sl0M/bOxTINiQUQlm6ZvvZdpSdKiDEipw4hbQJUSpWQ=;
        b=hNt8EZYJzStjddRkWV7984uTnNifKLfUdbPMqUCjS7FPg+giXQZr07BXcpRxkzF6rd
         4VQG7ZQkRMt+oOf4RgQW3bkoCzvh1W/x7VTnuSJxYp4Y8SwZi5na4LjQ/iSSwF9kcPEn
         imPIbXYQ4fy/fZhU9lT+BdIqRW8lC6Vpeq8OZnKh70g7maBab0Z1pV1x5N0o/CmAH8LG
         H+xzEOk1VdimjDH6Ddzq2ncLtKs9KjtOYlc/Z84KbmddU4I/R4UrHcK6XFXr1e1gHZZN
         PKeRNAuWZVcZdctmV/zVSAXKvOoOkCuKHQX+zFtQ9YK8SWaIjTgwUBZSVya7e9wZbSI0
         xdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sl0M/bOxTINiQUQlm6ZvvZdpSdKiDEipw4hbQJUSpWQ=;
        b=OVwrGnHnC/cGar/FB9hZKF38I1szgdTbre8TLnW3SUKLU/tSKyuGcj6UNAOzfz1C0w
         7HsnrkPalcvKSn8pg/UVvvIY4fRUJKR3QYGImAkSRbiE1Rp2P1s1ksobbpwl+9wqjkT0
         vjH54KHzxMc9HWVADviXtQixtjZgEPNAwBqIx5ygJerp/UqBzyCI6fuix6zJegxWT+4s
         1lfzs6Cv9XZfqJDRmmVdDGI0Cvyapq1lcurTRfFtQat7SMztZ+dljcuW7Q20WH/gyodC
         GCQaol6xfYstv/i87u7gjGGROmOM7P1V7jJ0KyfNOtSD2DkAVkv4XghASnTu/JHIgsPH
         LH2A==
X-Gm-Message-State: AJIora9Suoh2VtKGUmyREzzWJTu9RWYPM/BpaNgcRyDngcd7ojFCq1EL
        oE0IVZWniV+m6BOKbvIOyFsqOzvnH5g=
X-Google-Smtp-Source: AGRyM1s7ETDEzE67akcKPe2ZXrH8YCYAPtMLVD/B9VyBhhCBDKMUbhohzZ8yRuy8sgs+ek/gNLIrIQ==
X-Received: by 2002:a17:907:7396:b0:72d:a080:86a9 with SMTP id er22-20020a170907739600b0072da08086a9mr11835390ejc.49.1659354726189;
        Mon, 01 Aug 2022 04:52:06 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o24-20020a170906769800b0073061212425sm2289253ejm.179.2022.08.01.04.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 04:52:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oITxs-008lMN-UL;
        Mon, 01 Aug 2022 13:52:04 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] t0021: implementation the rot13-filter.pl script
 in C
Date:   Mon, 01 Aug 2022 13:39:08 +0200
References: <cover.1659291025.git.matheus.bernardino@usp.br>
 <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br>
Message-ID: <220801.86h72wi3kr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 31 2022, Matheus Tavares wrote:

> +static void reply_list_available_blobs_cmd(void)
> +{
> +	struct hashmap_iter iter;
> +	struct strmap_entry *ent;
> +	struct string_list_item *str_item;
> +	struct string_list paths = STRING_LIST_INIT_NODUP;
> +
> +	/* flush */
> +	if (packet_read_line(0, NULL))
> +		die("bad list_available_blobs end");

Shouldn't anything that's not an OS error (e.g. write error) be a BUG()
instead in this code? I.e. it would be a bug in our own testcode if we
feed the wrong data here, or if pkt-line doesn't work as we expect...

> +
> +	strmap_for_each_entry(&delay, &iter, ent) {
> +		struct delay_entry *delay_entry = ent->value;
> +		if (!delay_entry->requested)
> +			continue;
> +		delay_entry->count--;
> +		if (!strcmp(ent->key, "invalid-delay.a")) {
> +			/* Send Git a pathname that was not delayed earlier */
> +			packet_write_fmt(1, "pathname=unfiltered");
> +		}
> +		if (!strcmp(ent->key, "missing-delay.a")) {
> +			/* Do not signal Git that this file is available */
> +		} else if (!delay_entry->count) {
> +			string_list_append(&paths, ent->key);
> +			packet_write_fmt(1, "pathname=%s", ent->key);
> +		}
> +	}
> +
> +	/* Print paths in sorted order. */
> +	string_list_sort(&paths);
> +	for_each_string_list_item(str_item, &paths)
> +		fprintf(logfile, " %s", str_item->string);
> +	string_list_clear(&paths, 0);
> +
> +	packet_flush(1);
> +
> +	fprintf(logfile, " [OK]\n");

I think it should be called out in the commit message that this is not
what the Perl version is doing, i.e. it does things like:

	print $debug " [OK]\n";
	$debug->flush();

After having previously printed the equivalent of your
for_each_string_list_item() to the log file.

In Perl anything that uses PerlIO is subject to internal buffering,
which doesn't have the same semantics as stdio buffering.

I think in this case it won't matter, since you're not expecting to have
concurrent writers. You could even use fputc() here.

But a faithful reproduction of the Perl version would be something like
appending the output here to a "struct strbuf", and then "flushing" it
at the end when the perl version does a "$debug->flush()".

I don't think that's worth the effort here, and we should just say that
it doesn't matter. I just think we should note it. Thanks!
