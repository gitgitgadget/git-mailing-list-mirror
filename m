Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B23C01FF30
	for <e@80x24.org>; Tue, 23 May 2017 07:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936476AbdEWHur (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 03:50:47 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33108 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934401AbdEWHup (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 03:50:45 -0400
Received: by mail-pf0-f176.google.com with SMTP id e193so106757939pfh.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 00:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tG6i7WkqPKGTonLe2mQ4SGQNNOvKiLLObtVBVq9ytwM=;
        b=d1LlnxFrJHaOmeFvi6S8Y6y1xaCcGRoqddvAS+ipg97fR+UiqFG2hX4OTAtuZa8vBS
         9R8KuDrFsfJ8EkttjZ9DcmBzIU0nyzknsH/sI0rGvkiKlJuRtxhE1zHdbWItqAWt0qGY
         s4+W85kd+B9Ow3reVH483Ify+7Bf0ouLb3dMeRzZ9DuFOJCKyPvKc8X80XthdhMwUpKz
         Q3bYV1KHzQsh1LDBhs4jzuKheSYjCEsreIo9ZYqK6Jfq//f7FlUfCDxNRFgNuYbPE171
         j+aX0g7tOBqKpQdsRUYseZ/WKM/2Edc9L8DD50NrEMX6Y8eICiRxO78VAUqWEhNenOd2
         ofrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tG6i7WkqPKGTonLe2mQ4SGQNNOvKiLLObtVBVq9ytwM=;
        b=YaQ8m2wHOYohALvddjJqnCVLRWzegXz0XwKu3Bfrrl2vKhO+Ck25JkSF+lOItuFl92
         G6CEKZ3Jo0MsmtLWfi/uIFgExfZKunDF85u1kIeGEgPfwOZqy3pwY/oNu5kD3rSVcVdi
         B50q9XM1Joohb3JpHFVZjZ117nmpeY2yErtcd9769Cb/hph07NimNQIp+uq07EhK14J8
         mqEhRD+Io0kaRbmuhDhE+ZkIfW/pQKGgmSAPixoJXHbYbRWQaG2MgIYeAFlQHGAckJgH
         8tfNxLrTENPdI9hmWDW/9FPUW6KW/QRjq0PBGy0UUFuMAdnyhdo3DuxEg56sriFslkB5
         0wew==
X-Gm-Message-State: AODbwcCwAGhBAkhD0aTaXGYOLK+0H8KVGuXbLfqNcJgyyDL3of/aYt+w
        vD93VYRgOmr2GQ==
X-Received: by 10.84.130.7 with SMTP id 7mr33976935plc.35.1495525834470;
        Tue, 23 May 2017 00:50:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id y78sm36883170pfd.32.2017.05.23.00.50.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 00:50:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] clean: teach clean -d to skip dirs containing ignored files
References: <20170518082154.28643-1-sxlijin@gmail.com>
        <20170516073423.25762-1-sxlijin@gmail.com>
        <20170518082154.28643-7-sxlijin@gmail.com>
        <xmqqtw4do5tf.fsf@gitster.mtv.corp.google.com>
        <CAJZjrdX9BnuxY3tmpswG+yEdDm1+AR8rc5wKGZyVCMp-jP218A@mail.gmail.com>
        <xmqqk259o1o2.fsf@gitster.mtv.corp.google.com>
        <CAJZjrdVeGy6mgsjuHL+O29xys8z90J8aKXdZ5XqiNraNZ9pQfg@mail.gmail.com>
Date:   Tue, 23 May 2017 16:50:33 +0900
In-Reply-To: <CAJZjrdVeGy6mgsjuHL+O29xys8z90J8aKXdZ5XqiNraNZ9pQfg@mail.gmail.com>
        (Samuel Lijin's message of "Mon, 22 May 2017 22:43:34 -0400")
Message-ID: <xmqq1srgko52.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

>> As I said, I am undecided if the result is easier to follow than
>> your version ;-)
>
> I think I'll defer to your patch: I do agree that your version is
> easier to follow and understand. Should I reroll just this patch and
> its commit message, or would you prefer to handle that in the queuing
> yourself?

I was going thru the entries in "What's cooking" draft and was
wondering what the final outcome would be.  A v5 that I can just
apply without thinking would probably be easier for me (I can tend
to other topics while waiting your final version).

Thanks.
