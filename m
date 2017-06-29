Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643ED1F623
	for <e@80x24.org>; Thu, 29 Jun 2017 21:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbdF2VBq (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 17:01:46 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34479 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbdF2VBp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 17:01:45 -0400
Received: by mail-pg0-f51.google.com with SMTP id t186so53674097pgb.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V4c8QX7N+IROs62vth50AxC2scAfK7Uaw6K0BkkLugs=;
        b=eJT/zYeN6rUC4PoJaNAkz3trN+dnLLvx05oc5bAs88NwtnW03FTj9skOojEpQ1xLG8
         upfGyM1nbVaLTresoOL1XRk13gRFi6kM1giDUYhiA4NFl1gQnb/V8NV0z5zzsUisHr7C
         01HvIRpAOPKMmV87KoRveirsAf35v5iQXQmvLRfIx0aOXkmmaHP13y0HsuCW5vWgWoQu
         Lz6Hn51RNz4wk/kqOOnYNfsw0aRTbCdEwDjYsC+ne7uNkpZg+7nuDleamV1o/WkYwH74
         XrB+f+7VPHjzQk9ZMWV7A5Wm3xYPeqlPrZg0AL/O5HZtp6Ruj043phfthYALPecAsX0A
         nPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V4c8QX7N+IROs62vth50AxC2scAfK7Uaw6K0BkkLugs=;
        b=LiBBBA3n0inO7xsS/0vyMHTz7e4tiN/MC1zpKHf6auqk/jDlWGb+ThTKonWxYeHj21
         25/8g0Y5nQl1ElRuFNZoZv7SckYqOyX98YHFGm+pCBHjqJxXTIB6QpmUhaqAC4nNCrsN
         KFY5zTgqaI0ExYG2qHNwBy7I4rI+kBr9dv6jBr5KiJPcr7/xH4J946wxnhsdW1JNC51y
         cvt4cC5qDqWZUOmtLDdm+urHLNZ/ReQJpq83Hm54Wokh5dZ1XQ9zlg16gev9dpk24mS9
         C7o2FHiKXPOlvf9KhfxUDPfxUBfLDp0j5GMEUrsM64kdBOx2NsMUjld0MZJNXBxvuGU1
         QgJw==
X-Gm-Message-State: AKS2vOxLHJvs4b/LjnJK6oKEx/foErRV5DbA6ORORX2s8w+drVcNmq2Z
        8+uC1IA6oASB2XSh4fwqwDb7GZoG4mASi+RXZQ==
X-Received: by 10.84.224.74 with SMTP id a10mr20097612plt.210.1498770104653;
 Thu, 29 Jun 2017 14:01:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Thu, 29 Jun 2017 14:01:44 -0700 (PDT)
In-Reply-To: <xmqq37akya3j.fsf@gitster.mtv.corp.google.com>
References: <20170628005651.8110-1-sbeller@google.com> <20170628005651.8110-7-sbeller@google.com>
 <xmqqshikye0o.fsf@gitster.mtv.corp.google.com> <xmqq37akya3j.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Jun 2017 14:01:44 -0700
Message-ID: <CAGZ79kaq2ym9aSAcHXRSd=onkqjoO-2_0B8PHed2j4q_9gwvCA@mail.gmail.com>
Subject: Re: [PATCH 6/6] diff.c: detect blocks despite whitespace changes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2017 at 10:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Looking at the implementation of get_ws_cleaned_string() that is the
>> workhorse of emitted_symbol_cmp_no_ws(), it seems to be doing wrong
>> things for various "ignore whitespace" options (i.e. there is only
>> one implementation, while "git diff" family takes things like
>> "ignore space change", "ignore all whitespace", etc.), though.
>
> This probably deserves a bit more illustration of how I envision the
> code should evolve.
>
> In the longer term, I would prefer to see emitted_symbol_cmp_no_ws()
> to go and instead emitted_symbol_cmp() to take the diff options so
> that it can change the behaviour of the comparison function based on
> the -w/-b/--ignore-space-at-eol/etc. settings.  And compare two strings
> in place.
>
> For that, you may need a helper function that takes a pointer to a
> character pointer, picks the next byte that matters while advancing
> the pointer, and returns that byte.  The emitted_symbol_cmp(a, b)
> which is not used for real comparison (i.e. ordering to see if a
> sorts earlier than b) but for equivalence (i.e. considering various
> whitespace-ignoring settings, does a and b matfch?) may become
> something like:
>
>         int
>         emitted_symbol_eqv(struct emitted_diff_symbol *a,
>                            struct emitted_diff_symbol *b,
>                            const void *keydata) {
>                 struct diff_options *diffopt = keydata;
>                 const char *ap = a->line;
>                 const char *bp = b->line;
>
>                 while (1) {
>                         int ca, cb;
>                         ca = next_byte(&ap, diffopt);
>                         cb = next_byte(&bp, diffopt);
>                         if (ca != cb)
>                                 return 1; /* differs */
>                         if (!ca)
>                                 return 0;
>                 };
>         }
>
> where next_byte() may look like:
>
>         static int
>         next_byte(const char **cp, struct diff_options *diffopt)
>         {
>                 int retval;
>
>         again:
>                 retval = **cp;
>                 if (!retval)
>                         return retval; /* end of string */
>                 if (!isspace(retval)) {
>                         (*cp)++; /* advance */
>                         return retval;
>                 }
>
>                 switch (ignore_space_type(diffopt)) {
>                 case NOT_IGNORING:
>                         (*cp)++; /* advance */
>                         return retval;
>                 case IGNORE_SPACE_CHANGE:
>                         while (**cp && isspace(**cp))
>                                 (*cp)++; /* squash consecutive spaces */
>                         return ' '; /* normalize spaces with a SP */
>                 case IGNORE_ALL_SPACE:
>                         (*cp)++; /* advance */
>                         goto again;
>                 ... other cases here ...
>                 }
>         }
>
>

I just rebased the diff series on top of the hashmap series and now
I want to implement the compare function based on the new data
feature. So I thought I might start off this proposal, as you seem to
have good taste for how to approach problems.

It turns out that the code here is rather a very loose proposal,
not to be copied literally, because of these constraints:
* When dealing with user content, we do not have C-strings,
  but memory + length, such that next_byte also needs to be
  aware of the end pointer.
* The ignore_space_type() as well as these constants do not exist
  as-is, I think the cleanest for now is to parse diffopt->xdl_opts via
  DIFF_XDL_TST

Thanks,
Stefan
