Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D91020248
	for <e@80x24.org>; Mon,  8 Apr 2019 03:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDHDqZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 23:46:25 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36146 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfDHDqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 23:46:25 -0400
Received: by mail-wr1-f42.google.com with SMTP id y13so14529699wrd.3
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 20:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DeLz8w3Y/jd7qmwIw8exhyxKtlNaxi3SoeDBO7/mWKA=;
        b=Iuaz9aVQJ3O5/xGw7Sr/REWAtUh6X6FoUWXdowInQw3TSG2mDoKeN/JpCyKTIZg+1z
         T/xmt7COluWgwxJgY6lwX/UWAyP2sfKjyRucRubny8MoCdeI8yMX+D05reez+kcbaera
         WVa7BpjgF5MbagZxpgFe3PMXqVD677fJgpsSQElwsIBsZqSq9jIcGCmx0QDBOdXU7CIA
         1NQvIGgpvZ0lN6IX+Lk76wxhNR47aUr2tRZpLBB5ek6lhw1t7w4Ge+7r8xFimEbJqPWp
         /FsXdmDDPW5ZLiKE6chV67ELLR8oErtcn+7wEMWFT7jQS92Lo6FEbJmjOFRCha8sc6aE
         A68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DeLz8w3Y/jd7qmwIw8exhyxKtlNaxi3SoeDBO7/mWKA=;
        b=MNrsI87ju1mO9uVxJEqnkk/P4BSdpTlLpRCylF6ZhUccKPFK99WG770Fg02XtIvTK6
         JBIsKa7tNYkJuyVUZBDSnlAS6TrXDBny1ed2ztJp9tCb2x0xotKL2ipKk1nLAEgZzHEz
         p609TqGStsL6XrOg48liBzfrjunUArt+2jge4s8OodoSSnvu31PtiLhtSHLmxNoxfwUP
         saKI0diopZMS+De7YoM1MJ57MAL5RoZPlAWekKV5WUd/cR0jX7PVzqOHbqAClYcLiYKN
         +86BsXQrqPv1iB9/kBluYLMxo+mBkq4L24asFiTINySyfAc3lw7b8z3basfwCri/1IRB
         iUIw==
X-Gm-Message-State: APjAAAV86HmVk/Bzq4dWSdYD5aSBBti0XfnhqNc7ABHvzUTjWSIlAAgz
        ubN+OrjUd0e0aadQNY8yEgY=
X-Google-Smtp-Source: APXvYqyJHhEHMP7aIKmH88AxZRZtwrImg3rrZnew/eZKupr/p8IKS5x8F5ZJNXlyGtNDSC/FxEyS0Q==
X-Received: by 2002:adf:f488:: with SMTP id l8mr16074699wro.213.1554695183718;
        Sun, 07 Apr 2019 20:46:23 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g12sm26475748wrw.40.2019.04.07.20.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 20:46:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fixup! diff: batch fetching of missing blobs
References: <CACsJy8CgXLZxqab4vcP1jh3OMCGh1i=easb5BpCs1J8Uf_jsxw@mail.gmail.com>
        <20190405170934.20441-1-jonathantanmy@google.com>
        <CACsJy8AjyY1Azbf4VfnJMA3O8NNBV1P16dZRrHOUJdsYQHUu4g@mail.gmail.com>
Date:   Mon, 08 Apr 2019 12:46:22 +0900
In-Reply-To: <CACsJy8AjyY1Azbf4VfnJMA3O8NNBV1P16dZRrHOUJdsYQHUu4g@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 6 Apr 2019 11:17:46 +0700")
Message-ID: <xmqqsgutb1m9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> -static void add_if_missing(struct oid_array *to_fetch,
>> +static void add_if_missing(struct oid_array *to_fetch, struct repository *r,
>
> One last nit. "struct repository *r" is often the first argument. See

Yes, and that's easy enough to tweak locally ;-)

Thanks.

