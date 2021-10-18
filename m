Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADDEC433EF
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 17:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC79A61074
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 17:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhJRRwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbhJRRwe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 13:52:34 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666BDC061765
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 10:50:23 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id x61-20020a17090a6c4300b0019f789f61bdso18846pjj.0
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=AyTug4YVTYWhRGSh7/qugqAYyL5X5+dG7E37Exc4dJE=;
        b=EmAcDxfCAfJxCmhm4Oby3w8zTL41IWy01G57+5u5A6aBqZevt3z9EQOC9e2jlRJZ4F
         laZp6v8nhCcE5bkbR5jrD93O7KOy/iqbB3ZqTwQ0zGutorQu/HVkXJXaRAOshPn/DOMi
         yATg45zHi/KiuDCxH4AvIOsZSRohUdE8eHo7Xc4yl8CGsUq6N8zCNbGnw3kMpJ5SB6UF
         xW+HdrlCFH+efPMrYJ8zIOr8frnc1Gcp5iChRTQEvOHaTNpNxVICYO3ZiM8QRZHpM8ow
         ABKp3bb7RbEnrZg1GGnUYbCBFYKnxYCA7zVSSv+xEGszTOw69gogPgv1jFEej7hhdhaq
         VGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=AyTug4YVTYWhRGSh7/qugqAYyL5X5+dG7E37Exc4dJE=;
        b=ggXpn3lv3yAb4gICTP0Yd/YxQ9fG5i6fSyyMtPAIOn9yy8fKby6yrI3bJ7ZY3rQwvh
         HuQpX5qg1Send3L73Qpnf95Ff/KZ0Edl+VwRRZFOm/UflVJTlMDUXj7X/2vgJetPSw+z
         m+XN6VSulcdXUBwcGQafLrHpdg824wSxdIU+0hdOJXmybQecehiktqYMxsrW/FO76+EZ
         4Mwb6sktoGRwH596Itne0az1cbFTI085hbofBhEpqIVfrbVUipHMNWKNRoau81Ys00/1
         ItVmkdOfScLPGu2VSbcl0de4K7HaPD5BVIGzy8KGMf1xjw4Lg2duH1ohxIJMaafH44Al
         m4Tg==
X-Gm-Message-State: AOAM531zJ1X329HdNrnsnQSRgS0mJ0Jm1pupE//MZhVBqmJtIrUhTiPb
        TaQoSzn5a6H3FDAj72lqo2DRbzLWbLdT1Q==
X-Google-Smtp-Source: ABdhPJz8vpEitYZNoF3ue8OlrWTFQa+xav7YsKiUS3lteLBUyv3WYj5XQ5GE5ku+d0ZoLSF6wnejAcCTiuiLZg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:8c7:b0:44c:a7f9:d8d1 with SMTP
 id s7-20020a056a0008c700b0044ca7f9d8d1mr30317057pfu.49.1634579422926; Mon, 18
 Oct 2021 10:50:22 -0700 (PDT)
Date:   Mon, 18 Oct 2021 10:50:21 -0700
In-Reply-To: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
Message-Id: <kl6lwnmaz0gy.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
Subject: Re: [RFC PATCH] branch: add "inherit" option for branch.autoSetupMerge
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> +static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
> +{
> +	struct strbuf key = STRBUF_INIT;
> +	char *remote;
> +	const char *bare_ref;
> +
> +	bare_ref = orig_ref;
> +	skip_prefix(orig_ref, "refs/heads/", &bare_ref);
> +
> +	strbuf_addf(&key, "branch.%s.remote", bare_ref);
> +	if (git_config_get_string(key.buf, &remote)) {
> +		warning("branch.autoSetupMerge=inherit, but could not find %s",
> +			key.buf);
> +		strbuf_release(&key);
> +		return 1;
> +	}
> +	tracking->remote = remote;
> +
> +	strbuf_reset(&key);
> +	strbuf_addf(&key, "branch.%s.merge", bare_ref);
> +	if (git_config_get_string(key.buf, &tracking->src)) {
> +		warning("branch.autoSetupMerge=inherit, but could not find %s",
> +			key.buf);
> +		strbuf_release(&key);
> +		return 1;
> +	}
> +
> +	tracking->matches = 1;
> +	strbuf_release(&key);
> +	return 0;
> +}

I believe that we can get the branch remote via struct branch. Instead
of reading the config, we could do something along the lines of:

   int *explicit;
   struct branch *branch = branch_get();
   char *remote = remote_for_branch(branch, explicit);
   /* Optionally check explicit if we don't want to fall back to
    * "origin" */

I'm not sure which is the idiomatic way to get the branch remote, feel
free to correct me.
