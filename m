Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C627C1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 22:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeBUW6I (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 17:58:08 -0500
Received: from mail-pl0-f51.google.com ([209.85.160.51]:35495 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbeBUW6I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 17:58:08 -0500
Received: by mail-pl0-f51.google.com with SMTP id bb3so1791310plb.2
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 14:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pKL7gtmsdW7U/tGsalSELpQyX8+qPj92A+PaOogbXHw=;
        b=QZAYcAfQBftYOqHtovFZexwLR5g+wsH9JylqBAQS6dGFueBvOwXSsDiFwrtlLsilns
         SvYuVNYtuQnvy2O0DpaYbXBtp5nNmLsD1h2DesqI5bxq8dtbwCq0sNlpobtdi2aZZwkX
         fJ8socFgClBkHOBnLj7e0gPTSNNgt3jbTAU17VMjr2iHpLZLdyDLFt4NnqreG5VlSdOl
         UJnziB/ATvM8c6L6NnAsbSpMWIh46Td6Nd5p+QQnstOQCyIRRZWoYQLlhjXRgVz1jw91
         4KjMjBcUOdTG6PPTRmpo4LZJQ8zDeIYND9+dD8Ku8DOEyB4No9Hp27JL0XRxwMolqnOx
         xndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pKL7gtmsdW7U/tGsalSELpQyX8+qPj92A+PaOogbXHw=;
        b=YSuqppkwdRCsCSqYmAEay3OPuIi0Tdeyd3EeiAaxFuO2QdsMXEE+gDuPAvJSy0YaS9
         h+Vst1b0DvLtyfYGxeQCfAqiJHQ4ruR7MGv9WqjLbkWVT2fljOC6b3aYxvTvmQkDdXRJ
         AwVW5ojxPOaE5EtqTPBD/dJskxjMhKB/froBfTfiDsAh+VNXZ/Yxg3oH3jZgy+1WOZn/
         0W/6Ekv+f3KkB3U3WATICWkYjuEpADygydE6OADlMjPplUp4OguQPYs+pIV+y4H9AcT7
         zGhs6hD9QJziAj1TKUuuHVEAkoTglM2s/uGedh4RezYYPE8+4tDX6tU2cflkYuEn6b3C
         hPnQ==
X-Gm-Message-State: APf1xPC6AL5QkjmNOwjYcJCIxBb1l8NsBP15POqRBVTmOwvjVOv963wh
        +tDt/QdzZkNg+gRg3ZqI/90Sgg==
X-Google-Smtp-Source: AH8x226FvorVdl53r9HDJw7X3W6DHl1wyyCqmvIMznpk+evSX5eG7A7m/6wlJ8eQvLScCorYj/7a+g==
X-Received: by 2002:a17:902:7082:: with SMTP id z2-v6mr4630120plk.244.1519253887361;
        Wed, 21 Feb 2018 14:58:07 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id n27sm74345077pfb.63.2018.02.21.14.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 14:58:05 -0800 (PST)
Date:   Wed, 21 Feb 2018 14:58:04 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 16/35] transport: convert transport_get_remote_refs
 to take a list of ref patterns
Message-Id: <20180221145804.f483fb21559f71618812404d@google.com>
In-Reply-To: <20180207011312.189834-17-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-17-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  6 Feb 2018 17:12:53 -0800
Brandon Williams <bmwill@google.com> wrote:

> -const struct ref *transport_get_remote_refs(struct transport *transport)
> +const struct ref *transport_get_remote_refs(struct transport *transport,
> +					    const struct argv_array *ref_patterns)
>  {
>  	if (!transport->got_remote_refs) {
> -		transport->remote_refs = transport->vtable->get_refs_list(transport, 0, NULL);
> +		transport->remote_refs =
> +			transport->vtable->get_refs_list(transport, 0,
> +							 ref_patterns);
>  		transport->got_remote_refs = 1;
>  	}

Should we do our own client-side filtering if the server side cannot do
it for us (because it doesn't support protocol v2)? Either way, this
decision should be mentioned in the commit message.
