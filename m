Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4A7C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C4F619E5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbhKHXJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 18:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhKHXJA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 18:09:00 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF17C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 15:06:15 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y124-20020a623282000000b0047a09271e49so11551442pfy.16
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 15:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nKU7chBJfFQE7YlZvn/Ll7HTpn7YgniRbcQk5goQwuI=;
        b=k9YIfkF3oCtnhDFE7bivcvns61g3LjfiEX7nNGXkNcmWu2Qi2UyfVL400Bz0KTdrfr
         lXUf833K6tsRJ/BQjJ4EB21rQZU+mxDdNyHxSoBNKg17Souk2XYEZhTPi3HlVW7LHtkj
         OgVH2wK+r/tupBql43fcFqlMWhq+O4nVuqbKyLp6yhgEqxe9VY0L264xg4+TjsK3xawq
         eXXBa1uiLlqUH2fdflTXlJSb4l3VuEwujxs394x3Esxi3RHOsAgk6DJsXPFYSpMI95FV
         +6u69012gwsy+zmfhVm8DGDLVUdllzS1R0ImlMxbZdbaWDhEWvlFgAxmmWHuRnIy5fSY
         EItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nKU7chBJfFQE7YlZvn/Ll7HTpn7YgniRbcQk5goQwuI=;
        b=g9U/ugdYiE/SW/88G/H8WJzFzplsbFvjmYkhiC86on5LMSXPx3twpgEocMVmYlCX67
         +R3GmdZyYM4857WbqdC9EawWYHvwB6wwj0QyoDPt+szT8ZpELK/CdP25dbw3EqnWP/F3
         zwCEmL7f5WeteB+oi1E0f7VlmT0G/1ByPbY53CZ3Mfwo9rf5+KX7PN6FsmnIQWLmB1td
         JjFqKmJ434TqBgqL4DPPfv4iQJXg6W4so8LdHDs6hOax01dp6s10bAlbqw4c6Lz7q17a
         pYZnMw59duJYq/DYxUxKi28W2Mx4XLbyP1vWd9d5mE+sYrUMytcs2T2qJgjSn7GyzVEO
         zNJw==
X-Gm-Message-State: AOAM530ogG+DNs8G7XHwDfC8HUilYZbrdvheVNCkA3D3LgdVrgAcaeqP
        YaqpkatlJ9dmlEvOvnsN+Z2VZ65VMZ4XyWGx6RMD
X-Google-Smtp-Source: ABdhPJynCQmlRRankOiYAScaXMhDco/3Y/XtPhV8UqeQeeIDTEDZ3WlV8H1iCbDZcTJRJepvuhLMx7zAM2m56MqSG+lv
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:7ac8:: with SMTP id
 b8mr2132200pjl.206.1636412774851; Mon, 08 Nov 2021 15:06:14 -0800 (PST)
Date:   Mon,  8 Nov 2021 15:06:12 -0800
In-Reply-To: <38859ae7b7de0f6406180a0427b9ce07fe3b9aa3.1635532975.git.gitgitgadget@gmail.com>
Message-Id: <20211108230612.1102476-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <38859ae7b7de0f6406180a0427b9ce07fe3b9aa3.1635532975.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: Re: [PATCH v6 2/2] http-fetch: redact url on die() message
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, avarab@gmail.com, sunshine@sunshineco.com,
        ifrade@google.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -63,8 +64,17 @@ static void fetch_single_packfile(struct object_id *packfile_hash,
>  	if (start_active_slot(preq->slot)) {
>  		run_active_slot(preq->slot);
>  		if (results.curl_result != CURLE_OK) {
> -			die("Unable to get pack file %s\n%s", preq->url,
> -			    curl_errorstr);
> +			struct url_info url;
> +			char *nurl = url_normalize(preq->url, &url);
> +			if (!nurl || !git_env_bool("GIT_TRACE_REDACT", 1)) {
> +				die("unable to get pack file '%s'\n%s", preq->url,
> +				    curl_errorstr);
> +			} else {
> +				die("failed to get '%.*s' url from '%.*s' "
> +				    "(full URL redacted due to GIT_TRACE_REDACT setting)\n%s",
> +				    (int)url.scheme_len, url.url,
> +				    (int)url.host_len, &url.url[url.host_off], curl_errorstr);
> +			}

I was confused why nurl was set but never used in "else", but I see that
it's because url_normalize() also sets that value in the urlinfo struct.
This patch looks good (and patch 1 too, with my suggested changes).
