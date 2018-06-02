Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71DEF1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 18:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeFBSj4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 14:39:56 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:50229 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeFBSjz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 14:39:55 -0400
Received: by mail-wm0-f50.google.com with SMTP id t11-v6so8475273wmt.0
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 11:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=DD1j5YgR5xas2D6Tx0WsDAJpjCha2EAvt9K367KsI4A=;
        b=To7Md6Fh+kwNRF3XhGNOnN+VSR3F/3AKpM0FG5f7ROCuMKrX4Gq1MLpWAICqIepDKH
         Q+wEWqBQC6yjJMrSuLsqkmIC2OlKNeNFLOeERf5GBMGD+u3cJlPjhIp+81FRKvKE7YXL
         7eoLU6wPA0KwapEFCJA3lbYRnlunZpHY4e94jyV5SIIYWVrnXwcj3aGVGmbXmqmnT9Z2
         7X/oFMS0+7MF9nsUmoFeEB5SHLd5t2uM4ZX/awdjiL+y/mFnAKE93P0KWt1cQS7+6eHV
         PjSmetDcmQeS/ZHsr9p+LwC/CSZ6wX4lsVNempFrGPYcaHUGmlyIiXuRWPU2gM4Ej7ib
         UTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=DD1j5YgR5xas2D6Tx0WsDAJpjCha2EAvt9K367KsI4A=;
        b=sv3PLOpCR8D12D9S65R1eJwbnRNmb3dDGHsJFxTlMQnMSnc6VPKCNy6+nVONGbSywR
         28aWJ3PGEnzTb6/13754HeYw4ptczsN4BI+10N10CcKWuzrUoKhwSTZSuftEy3oBtbtq
         B3qfs+dYIshgct/XDFOiPGmcERxNJdzBMUR2UO59SLKtaUINmx/F67xxMyojR9TU+mGV
         Fu3V8voH338oxNLjOyxfrRGhXAyDKjgYUtgMIV75o3dBk7F/dnUyJtfyT8uyVt+HUaaI
         9IVkSJmtybT65ofHE5M2xxVIu6N6U9G4S3gjYjy+pfUm7v//E5DBVoYlfIy8AxECP8AA
         P0Jg==
X-Gm-Message-State: ALKqPwdKayqsVUixaEz1XRqo25kCYqs0WGEK9N8OIjynJqJVMnCT4guA
        lQRBlWv9BiU1DQge3YabVHg=
X-Google-Smtp-Source: ADUXVKIYDgx9AyZNcYMsOX/iR7Occnh8SqMbg84cYUK2DiRZoCMkyYw+xPlCQRzQEjI4qFLLgxE/Ug==
X-Received: by 2002:a1c:11c3:: with SMTP id 186-v6mr5899399wmr.139.1527964794518;
        Sat, 02 Jun 2018 11:39:54 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abri204.neoplus.adsl.tpnet.pl. [83.8.102.204])
        by smtp.gmail.com with ESMTPSA id 141-v6sm7230350wmf.35.2018.06.02.11.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Jun 2018 11:39:52 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller\@google.com" <sbeller@google.com>
Subject: Re: [RFC PATCH 4/6] commit-graph: avoid writing when repo is shallow
References: <20180531174024.124488-1-dstolee@microsoft.com>
        <20180531174024.124488-5-dstolee@microsoft.com>
        <xmqqd0xb9r1k.fsf@gitster-ct.c.googlers.com>
        <95354da4-7590-4fa6-de83-30f883d77188@gmail.com>
Date:   Sat, 02 Jun 2018 20:39:49 +0200
In-Reply-To: <95354da4-7590-4fa6-de83-30f883d77188@gmail.com> (Derrick
        Stolee's message of "Fri, 1 Jun 2018 07:46:08 -0400")
Message-ID: <86r2lpqbgq.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 5/31/2018 10:30 PM, Junio C Hamano wrote:
>> Derrick Stolee <dstolee@microsoft.com> writes:
>>
>>> Shallow clones do not interact well with the commit-graph feature for
>>> several reasons. Instead of doing the hard thing to fix those
>>> interactions, instead prevent reading or writing a commit-graph file for
>>> shallow repositories.
>>
>> The latter instead would want to vanish, I would guess.
>
> Do you mean that we should call destroy_commit_graph() if we detect a
> shallow repository during write_commit_graph(), then I can make that
> change.

I think Junio meant here the "instead" word, because you have it twice
in the second sentence of quoted paragraph.

--=20
Jakub Nar=C4=99bski
