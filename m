Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501391F403
	for <e@80x24.org>; Wed, 13 Jun 2018 17:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935000AbeFMRNL (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 13:13:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34742 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934817AbeFMRNK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 13:13:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id a12-v6so3570083wro.1
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 10:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gfi3iZnkWqrNYglEYGY5nclFxViaEOYFFrvGcNKpSTM=;
        b=fZB8VUaO7iuTG6K0A15M1BCecyKep4z3bPXovjCQerjpTpxw5JsFlz3H1MNr4TQVJE
         dyj44MZj8c/d9dyuqNAsrY9Jul5Vzgz93p6IRnw+SKNSNp5T8V3zqDOu29029gm8lakU
         DZcKG8TxteM9uU8vLw8EO/q6q6aoh4uJ0wtFcM3BXJGiPx52hxWNuI2btcvxF2qVrprV
         H0DqwJgKnU8WUgqLmRbOc5c2oK1S2Ocjr4VfChB3rqdkLnx/RTQKKInBppBOKdffLk3w
         5pYGkv5oK9AyYfEe2lasBk+9QouRxOW+oQIIxFm4D3FFIHdQ2pd4osmlucYGklN5kYi+
         7VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gfi3iZnkWqrNYglEYGY5nclFxViaEOYFFrvGcNKpSTM=;
        b=Bhlk72ZHaaXkVfL8ND/RENCtE8nF2zJT0TffaCd6KGc1Vof+nnOy0/ra7WRD8bU0F5
         wE5/R2MlsTTFr2CpuxiTkk5U32gSR/6teA+yqx0GkKGEOOTTKn2lOGzgNocmaQadRmsf
         cB4GpYYRMBnBZgpFBNnfnlLmI7KCnYbkhRq4VSfWkWY6aE1B+vj22J5Crt0bXqa+FIMK
         KFv4aIlu/IF/PgHaajKGcAhXcedP0adG1OZPKyLSIDDQ/bizPL/PxSau2SCF1tD0Cxz5
         1f7BdmUa52kdWHmj/uTLb8fheDFeaOCY0mwyI/YF2gcJhnNu6+E0ToIPgUbOeQiphsP0
         sZrw==
X-Gm-Message-State: APt69E3QEXqZs8SX5J4kAASW5RhwD3o0zlIoTR6bo+B5ZK1TCw78kAQc
        ktBUdu6EhI7cLh9KU79q33U=
X-Google-Smtp-Source: ADUXVKJy2BGnjT+Oo9umXEYK+QVI5VYARhlzkGTJwVOaV11sJcbSZlEZKgdg+tR98k6J278OcqL5UA==
X-Received: by 2002:adf:dd8c:: with SMTP id x12-v6mr5336518wrl.212.1528909988780;
        Wed, 13 Jun 2018 10:13:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u13-v6sm3797882wrr.70.2018.06.13.10.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 10:13:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] fetch-pack: demonstrate --all failure when remote is empty
References: <20180610143231.7131-1-kirr@nexedi.com>
        <20180611042016.GA31642@sigill.intra.peff.net>
        <20180611044710.GB31642@sigill.intra.peff.net>
        <CAPig+cT73d0rYoSbt7oHVG4MYHVvjKidP0ogRwV+9F73jcjZEA@mail.gmail.com>
        <20180611055357.GA16430@sigill.intra.peff.net>
        <20180611094255.GA15563@deco.navytux.spb.ru>
        <20180612094849.GB26123@sigill.intra.peff.net>
        <20180612185413.GA21856@deco.navytux.spb.ru>
        <20180613125549.4mshuymvdpwh44qk@deco.navytux.spb.ru>
Date:   Wed, 13 Jun 2018 10:13:07 -0700
In-Reply-To: <20180613125549.4mshuymvdpwh44qk@deco.navytux.spb.ru> (Kirill
        Smelkov's message of "Wed, 13 Jun 2018 12:55:53 +0000")
Message-ID: <xmqqh8m67gpo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

> ( Junio, please pick up the patch provided in the end )
>
> On Tue, Jun 12, 2018 at 06:54:17PM +0000, Kirill Smelkov wrote:
>> On Tue, Jun 12, 2018 at 05:48:49AM -0400, Jeff King wrote:
>> > On Mon, Jun 11, 2018 at 09:43:02AM +0000, Kirill Smelkov wrote:
> [...]
>
>> > > I'm not sure, but I would say that `fetch-pack --all` from an empty
>> > > repository should not fail and should just give empty output as fetch
>> > > does.
>> > 
>> > Yeah, that seems reasonable to me. The die() that catches this dates
>> > back to 2005-era, and we later taught the "fetch" porcelain to handle
>> > this. I don't _think_ anybody would be upset that the plumbing learned
>> > to treat this as a noop. It's probably a one-liner change in
>> > fetch_pack() to return early instead of dying.

I actually have a slight preference to the current "attempting to
fetch from a total emptiness is so rare that it is worth grabbing
attention of whoever does so" behaviour, to be honest.

Oh, wait, is this specific to "fetch-pack" and the behaviour of
end-user-facing "git fetch" is kept same as before?  If then, I'd be
somewhat sympathetic to the cause---it would be more convenient for
the calling Porcelain script if this turned into a silent noop (even
though it would probably make it harder to diagnose when such a
Porcelain is set up incorrectly e.g. pointing at an empty repository
that is not the one the Porcelain writer intended to fetch from).

> However with transport.c being there too, since I'm no longer using
> `fetch-pack --all`, now it is best for me to not delve into this story
> and just stop with attached patch.

If we do not plan to change the behaviour later ourselves, I do not
think it makes sense, nor it is fair to those future developers who
inherit this project, to declare that the established behaviour is
wrong with an 'expect-failure' test like this, to be honest.

> +test_expect_failure 'test --all wrt empty.git' '
> +	git init --bare empty.git &&
> +	(
> +		cd client &&
> +		git fetch-pack --all ../empty.git
> +	)
> +'

