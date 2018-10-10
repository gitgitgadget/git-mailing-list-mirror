Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93EE61F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 00:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeJJISc (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 04:18:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46152 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbeJJISc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 04:18:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id n11-v6so3640737wru.13
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 17:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ScAGMPYK5nZBZaGcx0iCeayHNm4eqxClvy5tbZSgCZ4=;
        b=QxH8ngA0pgyC07XmfnjNfE/ZAEZaRMLlaw0LsuDxSFcDQDmYTPIOaiwkNWZBS1rJPZ
         u0/g/s/R3dCAj5x7D3S3oaF6U3E8MPxwW0kFcOEm3jr0Sc+0LF0TGFeSBYyMFhrneFmr
         0UxVbmAXxwFUeYVYJjgS0ys2vMXQ2PPm/IF/FLJO9vE+OxCLo5uheYekle6+c5VJprCL
         ekHiG2Ezh1Fb11hAlaoeChEPfVMmBR6CyZUV+0GVBNLT3IfgI9Fqz94chs66v8B+s5F6
         hvnLRYaFNDtPYvDiaBtpPKvIKoDe7tZ1TSDI8R29PfQKRFL1MrLgHmC6tHDsOGAfnSrU
         8wIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ScAGMPYK5nZBZaGcx0iCeayHNm4eqxClvy5tbZSgCZ4=;
        b=fzxrQPCuI+C/OtRM+nRPWVe85+CdX80qUO+Kg9FS5xYJmbq8w0GWLMdBUdplruy5Gb
         P5+/Y9tG/G9IGOf1U3JM3fQIr6vXvwth+YLEdWhdFEKR7nxsJX+ws2BkB1YZQ63jp0bR
         1PBpIX/+0FVp3WyO3ESIFsZ80OKjQx1M/tk8qQg7CvzC7hb/UxyYIOZ0kc0tAgUoaBlR
         aAnggukRmZeUgVw/qtqxt8YsKluXqJOp+6jRe7WU20rMmAfvwUHDYUr/EEfcew1iwPIf
         YBTozTlqFOiy82Umw08ygDv98DXlvXgGyjuNhDmXaevanHBIJ7rRDGv5yR+pbwfwVsnW
         BxqQ==
X-Gm-Message-State: ABuFfoi2HaPiNDAyQx8dj2q63FtAf+gs+qWVi1h/IZq8rESk0h8+7oXx
        A7MZ/s8gui0ktdIfD+lVEZs=
X-Google-Smtp-Source: ACcGV61UiTcdkrRhoDSdE2aWlcAyxJnTVxmVv+93vj9n0oMCYKOBzmQbxps4UNxyt6ibwjzZzuMjBA==
X-Received: by 2002:adf:f681:: with SMTP id v1-v6mr23091794wrp.201.1539133133268;
        Tue, 09 Oct 2018 17:58:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l70-v6sm32358862wma.0.2018.10.09.17.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 17:58:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PoC -- do not apply 3/3] test-tree-bitmap: replace ewah with custom rle encoding
References: <20181009231250.GA19342@sigill.intra.peff.net>
        <20181009231441.GC23730@sigill.intra.peff.net>
Date:   Wed, 10 Oct 2018 09:58:51 +0900
In-Reply-To: <20181009231441.GC23730@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 9 Oct 2018 19:14:41 -0400")
Message-ID: <xmqqr2gyobw4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +static void strbuf_add_varint(struct strbuf *out, uintmax_t val)
> +{
> +	size_t len;
> +	strbuf_grow(out, 16); /* enough for any varint */
> +	len = encode_varint(val, (unsigned char *)out->buf + out->len);
> +	strbuf_setlen(out, out->len + len);
> +}
> +
> +static void bitmap_to_rle(struct strbuf *out, struct bitmap *bitmap)
> +{
> +	int curval = 0; /* count zeroes, then ones, then zeroes, etc */
> +	size_t run = 0;
> +	size_t word;
> +	size_t orig_len = out->len;
> +
> +	for (word = 0; word < bitmap->word_alloc; word++) {
> +		int bit;
> +
> +		for (bit = 0; bit < BITS_IN_EWORD; bit++) {
> +			int val = !!(bitmap->words[word] & (((eword_t)1) << bit));
> +			if (val == curval)
> +				run++;
> +			else {
> +				strbuf_add_varint(out, run);
> +				curval = 1 - curval; /* flip 0/1 */
> +				run = 1;
> +			}
> +		}

OK.  I find it a bit disturbing to see that the loop knows a bit too
much about how "struct bitmap" is implemented, but that is a complaint
against the bitmap API, not this new user of the API.

We do not try to handle the case where bitmap has bits that is not
multiple of BITS_IN_EWORD and instead pretend that size of such a
bitmap can be rounded up, because we ignore trailing 0-bit anyway,
and we know the "struct bitmap" would pad with 0-bit at the tail?

> +	}
> +
> +	/*
> +	 * complete the run, but do not bother with trailing zeroes, unless we
> +	 * failed to write even an initial run of 0's.
> +	 */
> +	if (curval && run)
> +		strbuf_add_varint(out, run);
> +	else if (orig_len == out->len)
> +		strbuf_add_varint(out, 0);
> +
> +	/* signal end-of-input with an empty run */
> +	strbuf_add_varint(out, 0);
> +}

OK.

> +static size_t rle_each_bit(const unsigned char *in, size_t len,
> +			   void (*fn)(size_t, void *), void *data)
> +{
> +	int curval = 0; /* look for zeroes first, then ones, etc */
> +	const unsigned char *cur = in;
> +	const unsigned char *end = in + len;
> +	size_t pos;
> +
> +	/* we always have a first run, even if it's 0 zeroes */
> +	pos = decode_varint(&cur);
> +
> +	/*
> +	 * ugh, varint does not seem to have a way to prevent reading past
> +	 * the end of the buffer. We'll do a length check after each one,
> +	 * so the worst case is bounded.
> +	 */

Sorry about that :-).

> +	if (cur > end) {
> +		error("input underflow in rle");
> +		return len;
> +	}
> +
> +	while (1) {
> +		size_t run = decode_varint(&cur);
> +
> +		if (cur > end) {
> +			error("input underflow in rle");
> +			return len;
> +		}
> +
> +		if (!run)
> +			break; /* empty run signals end */
> +
> +		curval = 1 - curval; /* flip 0/1 */
> +		if (curval) {
> +			/* we have a run of 1's; deliver them */
> +			size_t i;
> +			for (i = 0; i < run; i++)
> +				fn(pos + i, data);
> +		}
> +		pos += run;
> +	}
> +
> +	return cur - in;
> +}

Makes sense.

