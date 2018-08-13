Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27F2A1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 21:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbeHNAF3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 20:05:29 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:54032 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHNAF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 20:05:29 -0400
Received: by mail-wm0-f46.google.com with SMTP id s9-v6so10253770wmh.3
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YG+7yMWx9rLPOXbsUfAVx4IHJ0V4NRNQUoU6jPOzmN8=;
        b=Ea0bN0CwmXJqXCirULuLm0N5XzsOg7IJxvgLJ5WNLL155X9FF+x+hbKDIWRqtpfmxu
         ZhHS6RMm2YwvYW1EPWpj8QnG7ehjLK0i67SD0/3xnTpNCixdctv4inQEXBTZWvG7dixw
         GS+HFrzL3j80rTCrZJpPWNs+zMHUZ4v4YwVgvnvR39yuR17XNQ4IwCqbd4wv6FgaCUzS
         Y6pRHehQEVQA3DrK8p0CgeK5Ny9Dt+tKNxKKn0X4pk/Ma4lZQCZOfzGa+HDMZB4qF+rq
         dt77IoM+Hd02a2K6LiqkAqlZ6zAzwdijTanXRmjkTLtFuRHeA57lrQnF5PunuA678/+G
         qUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YG+7yMWx9rLPOXbsUfAVx4IHJ0V4NRNQUoU6jPOzmN8=;
        b=AqYRRbDHrrSGbaHk8fqtfWVHQPRudKZrDFaFr7d12Ah09+gltVDrV1LOOCJC3gJXCc
         hew9e+3nKEQd/35ChNXXnAy0fqyTcaFeSiOGaJqwhYeb0/g60cJMnVc0hv2ICqL0/CEq
         lW9eNrWL+ejkXnla8rlmOz2TSXKcc9NaAOH27vhQ59Y5jFDjeIlSMKo1CJkU1QeNs/Hm
         SlbwLlUPzC2ZcFy34GtgFXnav+Nd7ztc7MfnZI5GOAILIdrU+lk8tUvs2tv7c1kqiECL
         /TQqYDlRQPvlynZ6lDVPEN+Pz1XguIOxA1bi+EEhKuqAm32zhvwxJWeP/CW6ceKyzBz0
         /TVQ==
X-Gm-Message-State: AOUpUlHS27w+FiN+zMAj9WMxDvWJdKnBK4UKW/2kBd60UuDbyPQ8CUAn
        JwcVfMMq5yQez/NsDHv5Ghk=
X-Google-Smtp-Source: AA+uWPwNvDao40tHHwS7tutBZgjes3Jnmm9sftgP4djils/DNnB+nuf/dXS1m0ujHy1Cd3K+HHf4Cw==
X-Received: by 2002:a1c:cf05:: with SMTP id f5-v6mr9041974wmg.64.1534195290279;
        Mon, 13 Aug 2018 14:21:30 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m68-v6sm25203638wmb.10.2018.08.13.14.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 14:21:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/24] convert.c: remove an implicit dependency on the_index
References: <20180813161441.16824-1-pclouds@gmail.com>
        <20180813161441.16824-5-pclouds@gmail.com>
Date:   Mon, 13 Aug 2018 14:21:29 -0700
In-Reply-To: <20180813161441.16824-5-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 13 Aug 2018 18:14:21 +0200")
Message-ID: <xmqq4lfy3que.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Make the convert API take an index_state instead of assuming the_index
> in convert.c. All external call sites are converted blindly to keep
> the patch simple and retain current behavior. Individual call sites
> may receive further updates to use the right index instead of
> the_index.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

Nice progression from inside to outside, a bit by bit.  Quite a
pleasant read so far ;-)
