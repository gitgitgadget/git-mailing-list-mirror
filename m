Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25BF1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 20:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbeGQVa4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 17:30:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40478 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbeGQVa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 17:30:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so664155wma.5
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uKLB9J9MAtY/12eCN0bB2kt8T834hW4ATGCEHcIMxMQ=;
        b=YcRNpISfAhd4ITHFMT+OKVfQElweKIsWEMaAVrDZwDntMwZyCcaLliMynpo+48iTjW
         UjKY2wyhboJVobt2v00koVFqdr4A6NIX7TdZRwl0/j0tH1fu6qA2M0AnmHl1G/x4EwT6
         /HVaauAyrdkeC6cD0YRKF8I/9tvC8N6JutWQZbM7LHPD8Q10JbCW0fa04D0U+lYW+Try
         9YBL8jptvNV5uKz0EtEHMLNG0sgmMsV5brML74PQaAEHp792Ixm6TT+9FUT1q7P+uMCx
         Db8z4h9l/E+SJ/ij0/gFVht2rituTSHzdnBr3DzGstARn1T1WvU/6fhr4ofGTDpCVM7U
         /yDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uKLB9J9MAtY/12eCN0bB2kt8T834hW4ATGCEHcIMxMQ=;
        b=OQAJDJCthPfwI/KpjR/AeEDKbt4GWEO+OagPHY+Rqo14b5S4g9HrH2Vf7KMTsS5iXu
         ENTMN9DNMiYaswh4XVahjQ7CXcJDYTL3PV+fYj0XQlA3Y2Xr37E2R23XqNDoshW/FtiR
         SGZ6IdRSuP8Q9fYzudmjD8oftcer3TbRqBxr9xCTsV/wVYQQF3SI43gE3Yiuw8eke2zX
         pLZd9tlzt864bbzmn4adMhRHaLIvEGiEePXPHHhNQFG9wyITlMcesdtya7cBZ8Fy3NM2
         3zSfOuJv3cXF91+ICN4taZ+ruucGKTBFSRvZ5nok9nYrn38Ra1Su4w1S0R7bBr/Wdmy6
         3Eng==
X-Gm-Message-State: AOUpUlFgOtjgm3mACRbDNWhIl9/5gKaiu5pVv+oGn/8US6uDKbv31wIx
        QcB6K/FRRBW/bJE3v9ZN688=
X-Google-Smtp-Source: AAOMgpcrpOvVrqYr2pzJtBXq+nNpDjpaDKu+u8Drpf8H1xJm2X25nmql6W0MHrlnta8uOZOLFkDLaA==
X-Received: by 2002:a1c:dc41:: with SMTP id t62-v6mr2374696wmg.42.1531860989259;
        Tue, 17 Jul 2018 13:56:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v4-v6sm3727008wra.22.2018.07.17.13.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 13:56:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 3/7] gpg-interface: introduce an abstraction for multiple gpg formats
References: <cover.1531831244.git.henning.schild@siemens.com>
        <cover.1531831244.git.henning.schild@siemens.com>
        <afe7d2ef577d265ace458ef73f7a18b9ded91cd8.1531831244.git.henning.schild@siemens.com>
Date:   Tue, 17 Jul 2018 13:56:26 -0700
In-Reply-To: <afe7d2ef577d265ace458ef73f7a18b9ded91cd8.1531831244.git.henning.schild@siemens.com>
        (Henning Schild's message of "Tue, 17 Jul 2018 14:50:09 +0200")
Message-ID: <xmqq1sc1oa2t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> Create a struct that holds the format details for the supported formats.
> At the moment that is still just "openpgp". This commit prepares for the
> introduction of more formats, that might use other programs and match
> other signatures.
>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---

I didn't spot anything questionable in this version.  Looking good.

