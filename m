Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6279420401
	for <e@80x24.org>; Wed, 21 Jun 2017 23:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbdFUXAP (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 19:00:15 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33299 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbdFUXAN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 19:00:13 -0400
Received: by mail-pf0-f171.google.com with SMTP id e7so11816069pfk.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 16:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jq5nRv2TBG26+jC6jPOrCRDPrXfj5L1J94cG0JEEAsc=;
        b=t76d76g8mA6MQn02zUc1TXSqr7pcSJUI3hANX6LlQ2WkR0BY8CecnEB+kmco+kEdSv
         3w//i4V2hE7YsZybIXXU+hFmP44Trwq5m4FOWALwa9d5p5mCtJNJXIaHcTE2ma3GS1+I
         h9KO5cuQHYJeWK5DbzhuveNFSpUTusSGtWYnQ/J/0CLR97mDny72zc6xPBzVs9glq/5H
         yHuS3Sui8yh/t2vcxKSisaMvly9Gfc7g1k76o3l/zjo2EGuZZpYESQ+wgQAkWqOGWCv7
         vgvpsR6eVkpMGrN0TgvrClmbq0pU7QY7NjdMsP/ckEtU2Zvr452O4Da1Gkd4gITgIFw1
         PyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jq5nRv2TBG26+jC6jPOrCRDPrXfj5L1J94cG0JEEAsc=;
        b=U5e2Py0/G1R1YukF4rWrQHgOdNhhg0eQQVVvb4QnYnJsTWCUNtUf79mhkMg/++MwjS
         97djDildmeDBHl9LmHKS0ojVJMoXcNheqOgowTCC8F17UcXR6goep4UE/7aho1ziaeLo
         cn6FhylFHGoMjW8lOYGH4rkxRVpG01xM6qua3lHEnDIcDVxYjVPoIKHEcC7psEgWOu57
         sIuENLw6X4ee3x/dCSVRiH9snTPgPdYD/jOaVjCwgislykKNZmuZLojhoQvrHHlHDKxV
         oPFzfsEE8LoSH4SQWL+Pp68bHM1Gifjjcj8m8IlJ1OlK/5bcuChLIkU0Nstw3GS9m3Fe
         Qfog==
X-Gm-Message-State: AKS2vOx7qFDpLN6uv47m4YyCEOJShvBn5yJIEdpRzB4i9/febnOoZMkf
        eogP2B9u3LRY48zQrYiCUzqf75B8RvrBebUXGw==
X-Received: by 10.98.205.194 with SMTP id o185mr38469068pfg.105.1498086012377;
 Wed, 21 Jun 2017 16:00:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Wed, 21 Jun 2017 16:00:11 -0700 (PDT)
In-Reply-To: <20170621225403.GH53348@google.com>
References: <20170608234100.188529-1-bmwill@google.com> <20170620191951.84791-1-bmwill@google.com>
 <20170620191951.84791-16-bmwill@google.com> <20170621155059.3ae2c601@twelve2.svl.corp.google.com>
 <20170621225403.GH53348@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Jun 2017 16:00:11 -0700
Message-ID: <CAGZ79kaCLO=CVZLtc3BF8WHXPtO06oaa8RmsXYB6kUHU8ty1Rg@mail.gmail.com>
Subject: Re: [PATCH v3 15/20] repository: add index_state to struct repo
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 3:54 PM, Brandon Williams <bmwill@google.com> wrote:
> On 06/21, Jonathan Tan wrote:
>> On Tue, 20 Jun 2017 12:19:46 -0700
>> Brandon Williams <bmwill@google.com> wrote:
>>
>> > +int repo_read_index(struct repository *repo)
>> > +{
>> > +   if (!repo->index)
>> > +           repo->index = xcalloc(1, sizeof(struct index_state));
>>
>> sizeof(*repo->index)?
>
> Is there a reason to prefer one versus the other? Either way I can
> change.

If repo->index changes its type, then we do not need to fix it here
strictly. We may fix surrounding code, but not necessarily, e.g.
when the type change is a cast to a wider type (subclass so to speak),
so e.g. *repo->index is made to be:

    struct new_index {
      struct index_state index;
      int more_state
    };

then this area of code would just work fine, no maintenance burden.
