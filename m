Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EC5D1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 15:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJ3AXf (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 20:23:35 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:53587 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeJ3AXe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 20:23:34 -0400
Received: by mail-wm1-f51.google.com with SMTP id l26-v6so8695478wmh.3
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hmtU4k5K/9knGXgdbblOkUuqwH1JV3wj3aMWe1fnp2w=;
        b=IJXP3A94vR4Hw53BwmNsNVEsqa2M7uly9gOiV3sXnD3l/Bilo2a22go1Lu4x/AkpWJ
         8nhCeZC5HOIIDOJQx9gD7XKqsixhhs+WsZkzYnIaU9svwvT9ELPgATQrRIoOyBI20An9
         jQZh+fRrDzuhc95SEi6IJ7adWRteZhSo2urB93YXZmM/3wmzHVLPRYzbayaFZWdkEQyM
         NHaKZYDIA6GsRXSlvTRtIDWEBW0s/Ok9F2rnF8hrljyYe2a11IkNtOq+PpD/BX8w7VGR
         xqvP1xVe1y8a5rsPc8Y4SHUxwrkurLYrDZhjgFlj24Sle8tknKALIP5DDb0G4a21+41w
         1Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hmtU4k5K/9knGXgdbblOkUuqwH1JV3wj3aMWe1fnp2w=;
        b=Nunabg52Llwk4GQgTXOViOghmTqyBpBizlZXortcC4HayKKaHcJM5Nmj+kpHFGVI0l
         +hKZ2IO79ZCZOrCfKXSCBvBqter8drUjHbqBQZTr1NWS+mSArT1pG7rBCYB2uCLuL9IB
         QjjTuZFOSrvP95DAyotRwBFDzdELG7Z8ltWBCnCdQ84cD6gCFyPUEyDxovqai/CZEGQO
         Htxxdx9aJHJOPXZcTCoWV9BR1ApmAcZTjRlMOZc/Kxw7ebJSYuEsgCIwZTvzeG1a6xTX
         eqT5S55QiAC7AFj5LQsfSeWTXLgPtEtqykUzlTeCFRJMjDlpRsRMV5po2mj4FlQ6ndiC
         iAZA==
X-Gm-Message-State: AGRZ1gLDys163ImjsQe6xZ1T/r8+MZwuv+j2dRnG6ndbwSDg5U1KUngi
        +KRT1MUEKBH1JGlI8Uof0Ls=
X-Google-Smtp-Source: AJdET5fiYbUHeEbRHxKSaOzT7j+PiWaW2fSmeHC3Yqp6hJVC7YTEfMoh0Mv+X5f4dBFvQwZBfM2HPQ==
X-Received: by 2002:a1c:104:: with SMTP id 4-v6mr4527126wmb.69.1540827264853;
        Mon, 29 Oct 2018 08:34:24 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-69-130.w92-136.abo.wanadoo.fr. [92.136.31.130])
        by smtp.gmail.com with ESMTPSA id 140-v6sm13883848wmx.34.2018.10.29.08.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 08:34:24 -0700 (PDT)
Subject: Re: [PATCH v2 00/16] sequencer: refactor functions working on a
 todo_list
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
 <xmqqd0rt8nao.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ea891987-1030-2208-e76c-567e6c9777d0@gmail.com>
Date:   Mon, 29 Oct 2018 16:34:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqd0rt8nao.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 29/10/2018 à 04:05, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
[…]
>> It is based onto ag/rebase-i-in-c (34b4731, "rebase -i: move
>> rebase--helper modes to rebase--interactive").
> 
> As there are quite a lot of fixes to the sequencer machinery since
> that topic forked from the mainline.  For example, [06/16] has
> unpleasant merge conflicts with 1ace63bc ("rebase --exec: make it
> work with --rebase-merges", 2018-08-09) that has been in master for
> the past couple of months.  IOW, the tip of ag/rebase-i-in-c is a
> bit too old a base to work on by now.  
> 
> I think I queued the previous round on the result of merging
> ag/rebase-i-in-c into master, i.e. 61dc7b24 ("Merge branch
> 'ag/rebase-i-in-c' into ag/sequencer-reduce-rewriting-todo",
> 2018-10-09).  That may be a more reasonable place to start this
> update on.
> 

Right.

My next iteration will be based on 61dc7b24, I just rebased my branch
onto it.

