Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 319CF207D6
	for <e@80x24.org>; Tue,  2 May 2017 04:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750946AbdEBES5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 00:18:57 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35159 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbdEBES5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 00:18:57 -0400
Received: by mail-pg0-f44.google.com with SMTP id o3so49057412pgn.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 21:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1mW6eyxH0WvXAUw4+aU/C449h82PJ0u+t45gql07agU=;
        b=iV3Zr+QEUU70H9eDa6r+CyuRf0GNRNpFcNbxwlOivP1AM/CRW66ZGgpFVDDQjIvu7W
         1q5z9Z5AbqvMZBj9MqfQSC4yDJbWYDrJfBc0PzY+toFDskWSjIUwQJVWTRRgC6Jue7he
         C36FXLi2n+g84whbw1bZenjyxDe71KmPunUb2A2KZsSIDtkpPPxRUuIxywrI7uKXXQ9d
         2pb3xUwiEwAF2kyaAF/273T1N7uuFOvkLJ+qGYeQdUvAtqM3C/fE7IunjP67eIiiDDVS
         y5Wi0rxic9bkEdT8pL2nfNUI9gUtpHP34dVUZqx2nhDa8hvvzUBh1clbZWjLcBelKYYm
         Sazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1mW6eyxH0WvXAUw4+aU/C449h82PJ0u+t45gql07agU=;
        b=r6EiKYJdD3sjXzUEIxPvoSms9ia3nEQgvmNPt+4V85niEq6Wz+a0VS9zpgwjiaYD/K
         SClZTO32ENucxt4iqeDMs7Mcyc5JTdF8p6S+XA94Drtb5riu/3ySkoD0GNTI2gIZA8J7
         YAiCfUq77j5TPfhUDwjKhsMvt3V/jQIjynvuk+lJJVsOWFlKkeZytClZyFj76gsH00E5
         Y0TdKSp55XcrVdJyBmxc2s8CQN6RS5wpvId+Y4kRRJLFAvVi+ZxtZDHV8F60AWv1JF3D
         e+yD5V3uqc8RP3P4BqoYgPpVBz7rZgCQIq7R82xtc1YupxyMoeIRe7KvJBd0x+p2iMk4
         an2Q==
X-Gm-Message-State: AN3rC/42Ox8q8Yxu3ZiRzKNwwMsSBuy3H8+OjqgDNt+gV40BcSkPyn7X
        MTiY/LacAzJhHtMsKJ1VwqHXBfCG6O5v
X-Received: by 10.99.56.66 with SMTP id h2mr31052525pgn.40.1493698736132; Mon,
 01 May 2017 21:18:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.169.14 with HTTP; Mon, 1 May 2017 21:18:55 -0700 (PDT)
In-Reply-To: <xmqqy3ugdnfu.fsf@gitster.mtv.corp.google.com>
References: <20170501180058.8063-1-sbeller@google.com> <20170501180058.8063-3-sbeller@google.com>
 <xmqqy3ugdnfu.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 1 May 2017 21:18:55 -0700
Message-ID: <CAGZ79ka61UjNkQ7Avhp5hvq39JvVX2_b2m=Rf7dTOe+XpkGUxA@mail.gmail.com>
Subject: Re: [PATCH 2/5] submodule_move_head: prepare env for child correctly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2017 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> We forgot to prepare the submodule env, which is only a problem for
>> nested submodules. See 2e5d6503bd (ls-files: fix recurse-submodules
>> with nested submodules, 2017-04-13) for further explanation.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> Sounds good (if only because this makes it similar to other
> codepaths).
>
> Is this something whose breakage before the patch is easily
> demonstrated with a test?

I'll try to come up with a test in a reroll.

Thanks,
Stefan
