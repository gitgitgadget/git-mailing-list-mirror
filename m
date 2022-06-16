Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F398C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 13:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiFPNdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiFPNdB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 09:33:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF8513F0A
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:32:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o7so2843872eja.1
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=480BPN4ELFjCrM/pPcOuieBKWzluu9bNmesnS7EJlIg=;
        b=iNCChmF+npevItGGnmvjhCKt12tTsbcNprIQrw2u2bW8wgLw0kKX+oMCXThXXOkxle
         hvssFIcNx/HlU7waE9HngKzhF+xk9EK9W3h/z9Ik2eYgw/eLBpvnpPrGXvjkynR5zA65
         bW07FV0qITo+thxJ6bhDIav5Z+81zPsuDB3IvT4Py6ZvzA3YPieD8gOz6XWuL5GLpwS3
         n2Uuuss1BGKVTtTasZl/3P/WGCXVJCVUoY6235uMNKysIKG/eeU0DjaAFFhh7hRshEVD
         mFdDHHdzmwP4J3PtEpnU4J+6ePDbdP8HzC/W50xIglhdWuQTntiW9j61wBRkpN+GoXTp
         bC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=480BPN4ELFjCrM/pPcOuieBKWzluu9bNmesnS7EJlIg=;
        b=MXdkwS7zFl89nINIDGQOz+t7kUKv1a0pBDH5GR4s4KQ/d0VOWTjlKtaRAcFoGScRCy
         VqebRDPETpH1DYcTG3Y7L5A946kuL+MUeqam/5DCd1h8ncwTK/OnWIuDPAzcC/C5flcp
         wxTQ/KYWnEBEmy9M9p6y2kbPgABiNzJM32mUGTaUD3jMBgJS6Vgj4IB5KxJ97Zch7ja7
         Jz9nVR7HVJG7P/9D2MCjbtwjjBwU+rjFcsyNqRrb20bumY723cpv/XwKsR8bTBM6D7VH
         aoB9TAgTLTHN+sntHDgAW7mv5B+SjzjC9ocGScVFQYojgOuk2q8DoBujbcK/3aCzI+bu
         UuDA==
X-Gm-Message-State: AJIora+j+iR5GodCjr51Behr5HavTY3UwuiItGDZdafUNvj2X2bBaA4Y
        9578h4b7KQ3LjPgXWDsBcXo2+HY3P0o=
X-Google-Smtp-Source: AGRyM1uK+fiwuCYnB00dUrSC//X5f0qvHZmomVoahpnfd6nhemMDJNDXOvrrIKc8brIi1R9CMfcSKg==
X-Received: by 2002:a17:907:80ca:b0:70f:77fd:cfbd with SMTP id io10-20020a17090780ca00b0070f77fdcfbdmr4481357ejc.82.1655386375062;
        Thu, 16 Jun 2022 06:32:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id e25-20020a056402089900b0042be14040c1sm1844341edy.86.2022.06.16.06.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:32:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o1pcE-0014cb-1N;
        Thu, 16 Jun 2022 15:32:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 10/11] relative_url(): fix incorrect condition
Date:   Thu, 16 Jun 2022 15:09:38 +0200
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
 <0bf70e65d2c9e187203a77088ff0f7d18510caca.1655336146.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <0bf70e65d2c9e187203a77088ff0f7d18510caca.1655336146.git.gitgitgadget@gmail.com>
Message-ID: <220616.86k09gwx6i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 15 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 63e95beb085c (submodule: port resolve_relative_url from shell to C,
> 2016-04-15), we added a loop over `url` where we are looking for `../`
> or `./` components.
>
> The loop condition we used is the pointer `url` itself, which is clearly
> not what we wanted.

Clearly, but having looked at this I think it's useful to note that
coverity must be (I don't know what it actually emitted) be complaining
about the "url" condition being useless, i.e. it's the same as a "while
(1)", not that we run off the end of the string.

I.e. due to the way those start_with*() functions work we would abort
early if we were running off th end of the string.

> Pointed out by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index 9b9bbfe80ec..bded6acbfe8 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2846,7 +2846,7 @@ char *relative_url(const char *remote_url, const char *url,
>  	 * When the url starts with '../', remove that and the
>  	 * last directory in remoteurl.
>  	 */
> -	while (url) {
> +	while (*url) {
>  		if (starts_with_dot_dot_slash_native(url)) {
>  			url += 3;
>  			colonsep |= chop_last_dir(&remoteurl, is_relative);

Which I tested with this:
	
	diff --git a/remote.c b/remote.c
	index 9b9bbfe80ec..e049bbb791c 100644
	--- a/remote.c
	+++ b/remote.c
	@@ -2846,14 +2846,17 @@ char *relative_url(const char *remote_url, const char *url,
	 	 * When the url starts with '../', remove that and the
	 	 * last directory in remoteurl.
	 	 */
	-	while (url) {
	+	while (1) {
	 		if (starts_with_dot_dot_slash_native(url)) {
	 			url += 3;
	 			colonsep |= chop_last_dir(&remoteurl, is_relative);
	-		} else if (starts_with_dot_slash_native(url))
	+		} else if (starts_with_dot_slash_native(url)) {
	 			url += 2;
	-		else
	-			break;
	+		} else if (!*url) {
	+			BUG("ran off the end of our url?");
	+		} else {
	+			break; 
	+		}
	 	}
	 	strbuf_reset(&sb);
	 	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
	
Which will fail e.g. on this test in t3420-rebase-autostash.sh:

	+ git submodule add ./ sub
	BUG: remote.c:2856: ran off the end of our url?
	Aborted

I worried a bit about this since we released this with v2.9.0, so in all
this time we haven't been infinitely looping on this case, or at least
haven't had any reports about that.

So if we hadn't been catching this in starts_with_*() I wouldn't be
confident that this was the correct fix, yes it's almost certainly not
what not what was intended, but if we change it to that are we confident
that the side-effects are going to be what we want?

But in this case I'm pretty sure that the behavior before/after will be
the same, and that the only change will be to make coverity happier, and
the code less confusing.

