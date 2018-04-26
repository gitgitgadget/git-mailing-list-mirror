Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7D911F424
	for <e@80x24.org>; Thu, 26 Apr 2018 05:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeDZFZt (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 01:25:49 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:37348 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeDZFZs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 01:25:48 -0400
Received: by mail-wr0-f180.google.com with SMTP id c14-v6so15241021wrd.4
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 22:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aEsSvH01UWCCEUW5AdHvPBlL6GKtbZL77F7vbn8oMLw=;
        b=C3KW1emcrRTeO6A4P3UwU8Om5aQ2lFCOGmXyJ/hfspUwElmcDRKA843xFpF6ooGk2R
         v2XsRh8DwYqzddPqDyPdBC3b9ujHS1q4Hapc+rx6KtBs3q6mO9xNfC+req0xi4a5eFwQ
         4QKkvTuSSqreSGV6rGO9fV1mELRAABncOhueBxnychKfIT7TNmloNi/AIu+5W7IPxIYN
         a2VpHwERE9Vs5EZNJhuZl9hyp9J00hjtQusbKVUU52H4DPhAnO4QEop96/P+TzXcMDgm
         WqSVl13/lcaAjypK1ZnxvPrQYSxaamI7D3l7xgLnNhL9qKdYV/RJx+Lb7z53DWC/ImxU
         Wv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aEsSvH01UWCCEUW5AdHvPBlL6GKtbZL77F7vbn8oMLw=;
        b=c2lXTATDnwtiSx5fzN66rwijYD75iaw67v0G1amxIr8xiuCpZpDWxeukUw8fTOv196
         NOv6Mqmck663DjIX9F2QVuz8CBPdfdFiC8k0SSvz49WoKS4PRg+lDVY06yGlNi8friUw
         s7NdWHSjTfX5CUXidi1JsKU5jpuyl+0Pzb+PBEpV34+K1jdVhnpKZJcDsW3CR2sgfDOt
         oWLvohS2SjdEym5B3D0B81k8FF+O4QIAU/JkN2Kx1pUQMnP+EYmV1QOSozzHVjBQHPSd
         A5Ky2IbxGii9tL5qmpThmBNi7nFpsw1FznGCAhXb9qJIkSUE/syjDJU7SHXwjg9ghTSK
         Smog==
X-Gm-Message-State: ALQs6tCXglxrUpYWjFzxHAea7GO4ywBZUdCSTV8oNB4udZ5ukcQo1wR7
        1Lg+aKumGf89SR3ZnzHxJIA=
X-Google-Smtp-Source: AIpwx4/+7NaRp0PiZeG85AXn7h2UZ6khNeygmammn7sFDWUy7Dcm08OEQVX6+QRynW/QR9J7/DiZnA==
X-Received: by 2002:adf:8186:: with SMTP id 6-v6mr26822322wra.160.1524720346585;
        Wed, 25 Apr 2018 22:25:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q16-v6sm22618534wrn.81.2018.04.25.22.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 22:25:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] builtin/config.c: support `--type=<type>` as preferred alias for `--type`
References: <cover.1524716420.git.me@ttaylorr.com>
        <1bc42a611089a2552b1d8bc83ff229be0a5136ff.1524716420.git.me@ttaylorr.com>
Date:   Thu, 26 Apr 2018 14:25:44 +0900
In-Reply-To: <1bc42a611089a2552b1d8bc83ff229be0a5136ff.1524716420.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 25 Apr 2018 21:25:22 -0700")
Message-ID: <xmqq7eou35ev.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Subject: Re: [PATCH 2/5] builtin/config.c: support `--type=<type>` as preferred alias for `--type`

I'd retitle while queuing, as the last 'type' is a placeholder for
concrete types like <type> above.

> +static int option_parse_type(const struct option *opt, const char *arg,
> +			     int unset)
> +{
> +	int new_type;
> +	int *to_type;

Splitting these into two lines (unlike placing on a single same
line, which was how the previous round was queued) like this is
good.

> +...
> +	new_type = opt->defval;
> +	if (!new_type) {
> +...
> +	}
> +
> +	*to_type = opt->value;

But this is wrong, no?  You meant opt->value points at an integer
variable that receives the type we discover by parsing, i.e.

	to_type = opt->value;

