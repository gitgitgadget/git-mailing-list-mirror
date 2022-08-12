Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D97C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 19:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiHLTVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 15:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiHLTVK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 15:21:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728889A991
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 12:21:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so958173wmc.1
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=kp2V31pl69zmrmmUzw0WMGqHCRVJNpWqPVxmmBv4SKc=;
        b=m8Q9H0MbG+b+OMLw5qfjCoM/WVmfe8yVZ7YsOVi6MVjIxSBtIEBpzWbeD83zEIBHqQ
         Hr4k/ssjC3tw10jIaE4J5wt65PDl0+LYLivLyN6dNy+1vp5VDnLWEDP1XDiOTXPnyMOP
         dSCj7+C6aOrI1r1csxtWc7MPxanrhSdTXN20nyDySaPL0i4PCLpPuNWSvvY5jbCoySar
         AIL/aSbETW4Fw1M7GGXRZSxT6oQHpfljDd/1znwM7Kks1/6X0Tqp2MVMlnbpjRhx9MDI
         K8DYT2LNFCoQEm8SvK0Ui2ixH583JADKBSD/uLPy/rusiOgMSjHBtMAL4XZb4hfTrJ5c
         DHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=kp2V31pl69zmrmmUzw0WMGqHCRVJNpWqPVxmmBv4SKc=;
        b=HBvTtYBfmseFjMgs7em02c5hssfNuxNeonW/pP4Ie/578VU2vjWc4zBgg8Ty8zhxga
         wW+mwV93/6deQmlmu5v7LqqmdVay4DiFtj13qbhpGea0vbiA6z/C3vKws9T39JP6OMLX
         3+PzkSJa2ttHoKrBvW4JsAYrhgxaGv4K1AsDEeUlXWWhAGWk5AqXzussnb/ZbNaPAv9t
         5bvsqabvz/oPfAdSR/bH/+XH3xVip2tgThmLCDX19SNhoTGIEVZscoCcKx1T2j73sotw
         gff4ZPAxJFpcT7pvCdr1iHeQdj3c0ZdjUS/lAD6WnXksr3meV72BeGnBeZW31GMqJsLB
         Zq1w==
X-Gm-Message-State: ACgBeo0pbEy76S6VLRJlfdb15unZxSPsWo1O+9AZsB5saqbyxJyka6vS
        dwrxakPlypujuNXpeSgn0fYSac97WLY=
X-Google-Smtp-Source: AA6agR5RezAOi851KB0YtPeuZstSPFIx0n5pX1HMs1dUtTdKMJzUemkt01VdkBQq1i9NLAoOGrMMgA==
X-Received: by 2002:a1c:7209:0:b0:3a5:c069:25d1 with SMTP id n9-20020a1c7209000000b003a5c06925d1mr6054710wmc.71.1660332065931;
        Fri, 12 Aug 2022 12:21:05 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id v187-20020a1cacc4000000b0039747cf8354sm389122wme.39.2022.08.12.12.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 12:21:05 -0700 (PDT)
Message-ID: <333bbaa9-d484-7c20-90d6-e64edf8a8248@gmail.com>
Date:   Fri, 12 Aug 2022 20:21:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC/PATCH] sequencer: do not translate reflog messages
Content-Language: en-GB-large
To:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <b8ab40b2b0e3e5d762b414329ad2f4552f935d28.1660318162.git.git@grubix.eu>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <b8ab40b2b0e3e5d762b414329ad2f4552f935d28.1660318162.git.git@grubix.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael

On 12/08/2022 16:38, Michael J Gruber wrote:
> Traditionally, reflog messages were never translated, in particular not
> on storage.
> 
> Due to the switch of more parts of git to the sequencer, old changes in
> the sequencer code may lead to recent changes in git's behaviour. E.g.:
> c28cbc5ea6 ("sequencer: mark action_name() for translation", 2016-10-21)
> marked several uses of `action_name()` for translation. Recently, this
> lead to a partially translated reflog:
> 
> `rebase: fast-forward` is translated (e.g. in de to `Rebase: Vorspulen`)
> whereas other reflog entries such as `rebase (pick):` remain
> untranslated as they should be.
> 
> Change the relevant line in the sequencer so that this reflog entry
> remains untranslated, as well.
> 
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
> The patch also changes `action_name()` not to translate the names This > makes no difference for `rebase: fast-forward` (I don't quite grok why
> so far) but in any case, the callers mark the result of `action_name()`
> (or do not mark it) so that the result itself should not be translated.
> The full test suite passes either way.
> 
> RFC for my lack of full grasp of the relevant code paths.
> 
>   sequencer.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 5f22b7cd37..b456489590 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -395,11 +395,11 @@ static const char *action_name(const struct replay_opts *opts)
>   {
>   	switch (opts->action) {
>   	case REPLAY_REVERT:
> -		return N_("revert");
> +		return "revert";
>   	case REPLAY_PICK:
> -		return N_("cherry-pick");
> +		return "cherry-pick";
>   	case REPLAY_INTERACTIVE_REBASE:
> -		return N_("rebase");
> +		return "rebase";

Removing the N_() stops these strings from being extracted for 
translation, but there are several callers left that are still using _() 
to get the (now non-existent) translated string. I only had a quick look 
but I think we should remove the _() from all the callers of action_name().

Best Wishes

Phillip

>   	}
>   	die(_("unknown action: %d"), opts->action);
>   }
> @@ -575,7 +575,7 @@ static int fast_forward_to(struct repository *r,
>   	if (checkout_fast_forward(r, from, to, 1))
>   		return -1; /* the callee should have complained already */
>   
> -	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
> +	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
>   
>   	transaction = ref_transaction_begin(&err);
>   	if (!transaction ||
