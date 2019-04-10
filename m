Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E685A20248
	for <e@80x24.org>; Wed, 10 Apr 2019 03:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDJDvF (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 23:51:05 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:50325 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfDJDvE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 23:51:04 -0400
Received: by mail-wm1-f49.google.com with SMTP id z11so922390wmi.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 20:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V/McQ0ZL5fAs2Y1z/3n0Jl6m5jZ4loBaFTvzRSPuNUA=;
        b=qn60o07cY/PWCpMe+tcpaDhZ1YH/UYzke5VVvqk2Jpw4EiI5QU/RPqTXcCmh4PvNh7
         QkiV/TxZmnx/Kfh6HRoMN3MH3A0rOhfBTQ6/li5pqmDQPthQpvDzO+jSuNp4YuYQK47c
         Eoa9yhQk9jXOtSeMgRdxeaip/x5AizGQRKyqyyi/8YAKRiYWIKUricRgA2k2Y5S58I4m
         h3Ct/suEHeJTuAb9hJYaOlcM01Myvju1dDY5D1fU/7RNqxPxkMVqOzxyv2UTgUrY9Zc4
         OA2YxpdQKCHv6+XA9OE1heIUiFmZnxXpbMRI56PkM8goYqsP6VSoPaC3H2y3ftiJKom0
         l17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V/McQ0ZL5fAs2Y1z/3n0Jl6m5jZ4loBaFTvzRSPuNUA=;
        b=SwHamAPC4sK8lmnhVWCVzoO7oeykkhbUE3aNvxsmS9gJ2yCQH8VNTWSuMnq35Vy3Gt
         4bveQk7st3AH5UI5XVDIUVH/4VT5psT56On6WN5sebWrAXqYJHxjQG7xaZujF/8hdBbP
         OlbTZ7wigTko2n5NyQpKZQWifgvNWRZUnRQXrIf70EDSlxCwKhycvQciDPi54Mf/fD/v
         62jB4FlBa/6bOU8oONHLRdLHY40BngK4n86t/zvAwlBo52RcXGY878kbgbN5seYdvUjn
         0PcMIgid6iGsriGy9Bn56r2PeOvdUuHbu7hg9ZOT2roSbtLyAmBpv3IRG/tc5VaiRlxG
         rSTg==
X-Gm-Message-State: APjAAAWEmmgNTxw4MPuMcsi1vQbrWBp9D7PihclF8tjkoSufWleFv3pL
        GzWn2mdqmb6fqqW/DiB7ubE=
X-Google-Smtp-Source: APXvYqzKNhl8qeDHIXiFEArADS7i2HlmIt3tEphw1eBzXazZ6DuBsG4t3NdlzaA0gAzL1iHUNPqnUg==
X-Received: by 2002:a1c:d1c5:: with SMTP id i188mr1004494wmg.8.1554868262472;
        Tue, 09 Apr 2019 20:51:02 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id d7sm910817wmf.31.2019.04.09.20.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 20:51:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] transport: warn if server options are unsupported
References: <20190405204413.93900-1-jonathantanmy@google.com>
        <cover.1554841624.git.jonathantanmy@google.com>
        <af3cc05324f53316eedb2f437789eacb24c11489.1554841624.git.jonathantanmy@google.com>
        <20190409204525.GA92879@google.com>
Date:   Wed, 10 Apr 2019 12:51:01 +0900
In-Reply-To: <20190409204525.GA92879@google.com> (Jonathan Nieder's message of
        "Tue, 9 Apr 2019 13:45:25 -0700")
Message-ID: <xmqq4l7634d6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thanks for writing this.  I'd be in favor of making this die().
> Compare what we already do in push:
>
> 	if (args->push_options && !push_options_supported)
> 		die(_("the receiving end does not support push options"));

That's a good point.

> What happens in the case of push with protocol v0, where server options
> are supported?

Are, or are not?

In any case, all other suggestions in your reviews are worth
following up, I would think.  Thanks for a quick review.
