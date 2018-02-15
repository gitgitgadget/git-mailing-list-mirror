Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF3E51F404
	for <e@80x24.org>; Thu, 15 Feb 2018 18:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163585AbeBOSTQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 13:19:16 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37879 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163505AbeBOSTO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 13:19:14 -0500
Received: by mail-wr0-f194.google.com with SMTP id k32so603497wrk.4
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z7RInvocupDDRE3PO+0V/LtQWM+WkzWW096mZVyzQx4=;
        b=Ou/fjadZdtcn6o/c9ZJtihlIqbUzDTxgjlthQMfVObPcutnPwwOe3bbmBNze7sLGwe
         sIgsw0xqafw9VSBc8J0mVVGbONGq4fW8CYaf4yzzITaihkNQLN+kqMtqc7/2mJObmHUl
         ivSo/B3skpnQXZD+K9Bkqv2YDuJzWp1+v5Rv91HhAvBlatr+B9Um28uCtcr8CJ3fzumK
         OB3/KLJH5akQFE2JMkDW+KjJ0M6pdFNv5GM6cb4Vw6swIC+ZZjXt+f0Z682XJSxk6c9s
         iwpyLtmwWMPsfvDCf/v6q4LoRIVGFWj7V7E37Mj2Vt6UtMZhlJeX9Vasy3jFUwvj4mBg
         p7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z7RInvocupDDRE3PO+0V/LtQWM+WkzWW096mZVyzQx4=;
        b=HCd+OZajDWeOz4FBKRqvqFNSDE0RtvE7skCdyBCGkHfkZjeDs6K/B3Vl/UItMT99sj
         wq9oX3lQ/exeX34aGMXx/FY+JQg+6MlW69i9IFp/U5Lw3YbYwZ3OhUKhLNs0mgZzZA9L
         VRqHOW3ZwBQ7dm6tl0Zvj9hBRd2UEmt/xYva4ow70aX4UrjALK9Od494GrKA6yJ9AXb0
         +9OOfq3PxArQHgSaHnQMoB8UC8MFVq4NzvlQbtHRMuLVuAiMyRk8h5+eScDRDEql+TIN
         +/PPWckoMp0qzurA2Fk7QR6mkZ1xEddaWBcYEXLDUUoyx79aou4ue8Kmtr+VPqppwkaH
         WGmA==
X-Gm-Message-State: APf1xPBi4+w3jJ1xnwJn/tjrxZWYSeWpR/giazM2f4F+SPorWuk0FCBP
        DY8ACZJZDXZAP3WBkz3e7sk=
X-Google-Smtp-Source: AH8x227gAoVV0R7AR/xAzQzSQU2CuGePf5V7A1Ck3k5TbAKDUGRrqWlRaTH966pd5BFBMLfwk1SbGw==
X-Received: by 10.223.196.143 with SMTP id m15mr3184352wrf.207.1518718752741;
        Thu, 15 Feb 2018 10:19:12 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s9sm16429193wra.4.2018.02.15.10.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 10:19:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 04/14] commit-graph: implement write_commit_graph()
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-5-git-send-email-dstolee@microsoft.com>
Date:   Thu, 15 Feb 2018 10:19:11 -0800
In-Reply-To: <1518122258-157281-5-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Thu, 8 Feb 2018 15:37:28 -0500")
Message-ID: <xmqqinay9kv4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +struct packed_oid_list {
> +	struct object_id **list;
> +	int nr;
> +	int alloc;
> +};

What is the typical access pattern for this data structure?  If it
is pretty much "allocate and grow as we find more", then a dynamic
array of struct (rather than a dynamic array of pointers to struct)
would be a lot more appropriate.  IOW

	struct packed_oid_list {
		struct object_id *list;
		int nr, alloc;
	};

The version in the posted patch has to pay malloc overhead plus an
extra pointer for each object id in the list; unless you often
replace elements in the list randomly and/or you borrow object ID
field in other existing data structure whose lifetime is longer than
this list by pointing at it, I do not see how the extra indirection
is worth it.


