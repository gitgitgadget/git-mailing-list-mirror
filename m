Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27B111F404
	for <e@80x24.org>; Wed, 21 Feb 2018 22:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeBUW4n (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 17:56:43 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33954 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbeBUW4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 17:56:42 -0500
Received: by mail-pg0-f52.google.com with SMTP id m19so1254848pgn.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 14:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vxyKxjFlgM5kdLmhIXsxGqABgvccfYJmdAhrU02su3Q=;
        b=o6p1P3zYRNKVxLFFlMAe0LqEB+4qRwKOig5AGscPAygvC7ilHY7J5m4gndy5UgaaJY
         iALN17RW7O+pWUbynAR86/wLatVtZXUj4uieIrk0PIopNGN9AuGgF7tdTMaeng9e/YLX
         XyGkJJI3BgFWKH7MA7Z5ma4XbsR7EUiHxmSxmjWG/ea+G9jS4ybbbfu985kZH6OZ1UMj
         mbsnoiLmZQBEwyGcGG7dTbVoUMlNwyXEohzP0Q1+mbh2XcjEXh686Z9hTZgzEt+kA6X+
         0BN0ymFihJyhmSO57vqxX1yJhf5U4wwGrA4mM7w9AQvKRBPPRZBMAjA6i/IHxO/bucLB
         gUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vxyKxjFlgM5kdLmhIXsxGqABgvccfYJmdAhrU02su3Q=;
        b=j1uJC76EE7U+EbFFoPu9iWLehhEzjen+msiuoK3ZtPvzb313ebGjBlROswlIvmyZT8
         NBQNyDgDh6rwpsS8blapTTuubkvn9MnLyHtNwrCNBdIxLE5RR1x1G0ABvVBa2U5aXVYT
         jWvOpZReUVpVoJ1snaassDmTRv9uX7k7BX1IuUL5t3O+NvaLk1MS8UbjOt7FkGYuV99g
         D3HQoExJFfb3rUOiB48oXIU8YgYElKGuMXyaOidLVzCJwLbgosiK13pCOUX4jxyV4qFE
         wyZek08pUXukhniYVmWrDWL8Z0LPGi9uzFcidsf1rzd0ctNiUHeQLZj9DfaVQpYX3b3l
         GxtA==
X-Gm-Message-State: APf1xPCtprGcfPCEZice4FjdOdTF3qq4F/Ur62k4/PnIa+8mqlBT2eja
        RM17apgxUTFZTrHcix0Wg6G2Hw==
X-Google-Smtp-Source: AH8x226LTgS+rxszzlou45jE7YMwNYsyvRrctz3myPd271CE/t047KAvHuZh2AriTxSOqhVCZOV5kg==
X-Received: by 10.98.247.9 with SMTP id h9mr4792646pfi.212.1519253801660;
        Wed, 21 Feb 2018 14:56:41 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id u9sm42430599pgb.11.2018.02.21.14.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 14:56:40 -0800 (PST)
Date:   Wed, 21 Feb 2018 14:56:39 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 15/35] transport: convert get_refs_list to take a
 list of ref patterns
Message-Id: <20180221145639.c6cf2409ce2120109bdd169f@google.com>
In-Reply-To: <20180207011312.189834-16-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-16-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  6 Feb 2018 17:12:52 -0800
Brandon Williams <bmwill@google.com> wrote:

> @@ -21,7 +22,8 @@ struct transport_vtable {
>  	 * the ref without a huge amount of effort, it should store it
>  	 * in the ref's old_sha1 field; otherwise it should be all 0.
>  	 **/
> -	struct ref *(*get_refs_list)(struct transport *transport, int for_push);
> +	struct ref *(*get_refs_list)(struct transport *transport, int for_push,
> +				     const struct argv_array *ref_patterns);

Also mention in the documentation that this function is allowed to
return refs that do not match the ref patterns.
