Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B501F453
	for <e@80x24.org>; Tue, 22 Jan 2019 22:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfAVWAH (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 17:00:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39998 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfAVWAG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 17:00:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so96879wrt.7
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 14:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6hKwjR+xUL0z9bBfSUFOZ54A3qSmDjpW82E2781ABb8=;
        b=jHvp5r+CFMDt8hMeKE/VHwl2Y73y6nios9khHZRv6bnCqu19LNSxEidhxzE6k6WDF5
         cMehLIFfn4FG8Z20ehAAY49F+wL6Ols7FFlnj28DGEq+sDPAuBfxEc2qx2PMxbwgv9Sx
         mwEbJCsyNjpE/TfXQszUlmf3/g59qpSEcTxvU+3shq2ogaKVvXxB58DS4EOQ79kZ1Fvf
         Mwk1voCt0fqayFU6ZEYhluBRt4qONjpXcvAvxlZZKyEg8NWO91O89Rx3Ee6KMX+nQ7oN
         dolNFoDNd+OTvWKOYfO+6VIb+sP6zlpM8OrLVQaoRnktTzswamIPnyvp4kG7YW4MEMwe
         gBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6hKwjR+xUL0z9bBfSUFOZ54A3qSmDjpW82E2781ABb8=;
        b=tL0UMmn4lx5wdiTHuQC9rgJrrFYBuzlsZcYbTG8NUsp/EkaZrpJ+INKLCboEIXmwpR
         2hxPAKSvbTDzRktIYORuEPY74p50mOM2JHmUVf2dk3bD8GGgFwClDe8wP6u/4E0R+PQI
         7PhpqkHncQCADNko4KxI7FUhRQ4Y10OBRSKXrJKyte+BAgqE0+nmMZ0iFO18SMeW491s
         N28LEqrtbdSDzSexMdZEy/5kL/XKg9rysz+75IjH58JJp+i0wkyU+FL7FpqxKdA+TKy+
         fYraKefv2veIscgfQ4D1eyOS9+ryXZh2poVAgtZTtUagw9iuqZeIPLHD8X6+vT0yCgt9
         0Cqw==
X-Gm-Message-State: AJcUukdQaDhsXvtf9b0PJ4CBx8SlEz5P39Hf4Im+L29xSY1Y+bSsAcfV
        Rta4TABjOD4XgJlgoSGVTjc=
X-Google-Smtp-Source: ALg8bN5RSCLrwxGH/k6f0IWqH1tVrRiq/IwvcTT6PUWo3pmc/M0h32Zn5ihXHVpsFOuJBrxcOrseBQ==
X-Received: by 2002:adf:be8b:: with SMTP id i11mr36509165wrh.235.1548194404671;
        Tue, 22 Jan 2019 14:00:04 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r12sm111824640wrq.3.2019.01.22.14.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 14:00:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?S=C3=A9rgio?= Peixoto <sergio.peixoto@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] attr: do not mark queried macros as unset
References: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
        <20190117160752.GA29375@sigill.intra.peff.net>
        <CAK3b1GJPZ5X3uEP1a-NF9PZkE0tTKVLda5hM32jExVz_OD2E=g@mail.gmail.com>
        <20190118165800.GA9956@sigill.intra.peff.net>
        <20190118213458.GB28808@sigill.intra.peff.net>
        <20190118214626.GC28808@sigill.intra.peff.net>
Date:   Tue, 22 Jan 2019 14:00:03 -0800
In-Reply-To: <20190118214626.GC28808@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 18 Jan 2019 16:46:27 -0500")
Message-ID: <xmqqef94e4kc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And here's a resurrection of the optimization that _seems_ to work, but
> I'm not 100% confident in.
>
> In particular, it does not care about macros at all. It simply asks: is
> this queried attribute a thing which was ever mentioned in the
> attributes files (either as a path match or as a possible macro
> expansion). If not, then we know we do not need to look further for it.

So, if we are looking for 'diff' and we know no .gitattributes (or
$GIT_DIR/info/attributes) entry for 'diff' or any macro that expands
to touch 'diff' (e.g. 'binary') is in use, we know for any path
governed by the current attr-stack 'diff' attribute is unspecified.
But if we see an entry, say, "*.exe binary", then we do need to be
aware of the possibility that 'diff' may be unset for some paths.

Makes sense.

> I guess maybe what I'm missing is that asking for "diff" means that we
> need to care about:
>
>   - whether "diff" was mentioned in the stack
>
>   - whether "binary" was mentioned in the stack
>
> But just "binary" mentioning "diff" is not interesting without somebody
> actually mentioning "binary".

Yeah, that matches my understanding (which mostly comes from the
original design before even Duy's optimization).

> I'm not sure how to do it robustly without being able to reverse-map all
> of the macros after we've resolved them (i.e., to know that "diff" gets
> mentioned by "binary", and then check if "binary" is actually
> mentioned). I think that would be possible now, as we should know that
> after determine_macros(). But I also wonder if we are hitting
> diminishing returns (after all, determine_macros() is already walking
> the attr stack).
