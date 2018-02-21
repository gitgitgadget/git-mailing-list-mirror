Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665521F404
	for <e@80x24.org>; Wed, 21 Feb 2018 19:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeBUTTV (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 14:19:21 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37064 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeBUTTU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 14:19:20 -0500
Received: by mail-qk0-f195.google.com with SMTP id y137so3409997qka.4
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 11:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NsqNKAm1xsfzw7wXQXdlpgxa0q8Pqsp4wGKHzciI6Wk=;
        b=upxBj9L7t+JgfpYINx3sL5cTUCf+SPVQ+ZPgP3/bY2SxVRIvnRKCjpnHVAeZV188Td
         NW2vsMRmjI4josxH/F9W9A4/yMjyPTbYz2YWbLJIXTIZK7PkOXUZtOLW2a5Anow/tFwp
         NHY/Dn72QEAd/LG5/suK0WID1AjuXNYG3dYvyICyWkN5Sb27IW8QhrU1CaYqpOqJc/5V
         wGSe2zIveCmkEY8tcsTtYZUabbanrwUoedqA9DG0FXV0kuxD2u3mk/WYiYptH2Vb60ZQ
         BHnQkhxzH+79wvjDxS26W/0hcqGP9+6ffhY3/6XpIYOEMgREK89gFJPQrPfreSwBwCuq
         7x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NsqNKAm1xsfzw7wXQXdlpgxa0q8Pqsp4wGKHzciI6Wk=;
        b=HudKlmJV8f0oeQZ6SOJnUHCwbhZI08BhqnSAuDay5pg1yrSPLnACMmrE6rDZLkR0y5
         XtA7S7UgIMGDccPzG4Nfm15+W93llpkYvxo6Vs5wP0dQpmOIlwShr6pyuUn4bup9QK5V
         /JENK5CVh/hPniJh++ApB96g96gU/ROhODGF0gan7Dp3r/wbTbyedi32rGYUw7FixCkH
         J8+x7CQri2l6xeh00qYUR/PLzk1Xvxyt5n/Bw+/6l7BxMf2XsHtjXKJ5qh46FIPRC86S
         h6dCilFLp1H6OwQ1Pn+gyhbHw+4SogudIpPPMClOHITshpSiUX6EOezZC0Nu/K9awq9+
         ymew==
X-Gm-Message-State: APf1xPAngQxXOuprZRaKFrXGQOuf8y4QHnEWIpJHlwUfCEvHiNHGJQBC
        M0ZXnqSve4crF2REOadu+Pyn/O5d
X-Google-Smtp-Source: AH8x227ySI0t7wgVIg/kQJq3b+2IZw7CL3Pd3rUZMaZGwmEilpPANSd86k0nPOrQlU1zTnvwZUfFxw==
X-Received: by 10.55.33.129 with SMTP id f1mr6976318qki.158.1519240759171;
        Wed, 21 Feb 2018 11:19:19 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id f134sm4704842qke.78.2018.02.21.11.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2018 11:19:18 -0800 (PST)
Subject: Re: [PATCH] commit: drop uses of get_cached_commit_buffer()
To:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Cc:     peff@peff.net
References: <20180221185204.GA8476@sigill.intra.peff.net>
 <1519240631-221761-1-git-send-email-dstolee@microsoft.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <07690508-e6c6-5b3b-6c03-5ad83c9c3501@gmail.com>
Date:   Wed, 21 Feb 2018 14:19:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519240631-221761-1-git-send-email-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/21/2018 2:17 PM, Derrick Stolee wrote:
> The get_cached_commit_buffer() method provides access to the buffer
> loaded for a struct commit, if it was ever loadead and was not freed.
>
> Two places use this to inform how to output information about commits.
>
> log-tree.c uses this method to short-circuit the output of commit
> information when the buffer is not cached. However, this leads to
> incorrect output in 'git log --oneline' where the short-OID is written
> but then the rest of the commit information is dropped and the next
> commit is written on the same line.
>
> rev-list uses this method for two reasons:
>
> - First, if the revision walk visits a commit twice, the buffer was
>    freed by rev-list in the first write. The output then does not
>    match the format expectations, since the OID is written without the
>    rest of the content.
>
> - Second, if the revision walk visits a commit that was marked
>    UNINTERESTING, the walk may never load a buffer and hence rev-list
>    will not output the verbose information.
>
> These behaviors are undocumented, untested, and unlikely to be
> expected by users or other software attempting to parse this output.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

This would be a good time to allow multiple authors, or to just change 
the author, since this is exactly the diff you (Peff) provided in an 
earlier email. The commit message hopefully summarizes our discussion, 
but I welcome edits.

> ---
>   builtin/rev-list.c | 2 +-
>   log-tree.c         | 3 ---
>   2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 48300d9..d320b6f 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -134,7 +134,7 @@ static void show_commit(struct commit *commit, void *data)
>   	else
>   		putchar('\n');
>   
> -	if (revs->verbose_header && get_cached_commit_buffer(commit, NULL)) {
> +	if (revs->verbose_header) {
>   		struct strbuf buf = STRBUF_INIT;
>   		struct pretty_print_context ctx = {0};
>   		ctx.abbrev = revs->abbrev;
> diff --git a/log-tree.c b/log-tree.c
> index fc0cc0d..22b2fb6 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -659,9 +659,6 @@ void show_log(struct rev_info *opt)
>   		show_mergetag(opt, commit);
>   	}
>   
> -	if (!get_cached_commit_buffer(commit, NULL))
> -		return;
> -
>   	if (opt->show_notes) {
>   		int raw;
>   		struct strbuf notebuf = STRBUF_INIT;

