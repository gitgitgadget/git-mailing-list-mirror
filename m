Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459891F428
	for <e@80x24.org>; Tue, 14 Aug 2018 19:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbeHNWmC (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 18:42:02 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38654 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbeHNWmB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 18:42:01 -0400
Received: by mail-wm0-f45.google.com with SMTP id t25-v6so13327985wmi.3
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HBzJjLvUAiO8KdNsKSOEI7H48trXVUrahw3zGFbEQV0=;
        b=Zpz4dr+ElFKldFl3Z4WzRwkgsLxgwpt2l4P4d7BUdMldtEqs7L4CwF+J09l9Qyed0W
         OmV+4lglka2Ns6/5oOWM6+7nlhkZ9So3MvX+Y6JLTWG8gUfzQ4kgdDu1lC2bjwZL8AD2
         NhqxRhBmmVHvlAXsqgST3A212nOfFKQc9lC5MpVIC4EoZuACLrPXVcI0yAc3Kw+lNXmV
         2A/xI32vPMiUIE3ys6S9DWZS2lZNrFbXIqh9Zi7i5Y3qOoQQdG/zKT99mMZzdqiWuoid
         pbk+uL/bNM8hRV2ZZhaR2MbV5+9cq8zRoRUzd160aC3sic+qo9gpJcDrfWgoXqnchu6v
         qSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HBzJjLvUAiO8KdNsKSOEI7H48trXVUrahw3zGFbEQV0=;
        b=bY2yi7OVclItKxCU9Y1MMgRoAkHrxr7AWghRZp48tJVAgcxmg8xyjlp4XyjU/7gHii
         tmzkfAmEjEpCaWln2k8FGWsr9RFhooSsByPZXp84SE9FaokwPTuAJU/2BwyPlWkgxfRH
         qwWjRuEhnTjKv8od8stA3BUwIqya05dmnfZP/APkVLGucZQajFBcCk9vePEtnWnl/Lsz
         ilJLd5vn9M2du38TY+3bTZ8+Drm4eMhQoJleAOsicpN3q8gzotUFshkSct5wIL9npH6l
         HuhinnvQA63RbxDaDTEgPHSfhG+rCNyShZDLvCVIj+LB2w3Dt1HjyLAuLzG1S1iCBGse
         zVjg==
X-Gm-Message-State: AOUpUlEngwP7QhaOttcWS7HBsFBLRyuNvM9qP5VLjLz1hk/DLrTFf/sa
        CEY96Ko4k3vX75dTp4xitgo=
X-Google-Smtp-Source: AA+uWPwnM1ksTdEAGXiTllVNxfgcyM4s871dfTFeOsQ3ZaoVy7HdKdMVDKYWVvWzrvWhr6MDpjbXVg==
X-Received: by 2002:a1c:e043:: with SMTP id x64-v6mr11957468wmg.58.1534276394502;
        Tue, 14 Aug 2018 12:53:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o14-v6sm20762546wmd.35.2018.08.14.12.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 12:53:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] send-email: add an option to impose delay sent E-Mails
References: <20180325182803.30036-1-avarab@gmail.com>
        <20180814181534.21234-1-avarab@gmail.com>
        <20180814184509.GA16659@dcvr>
Date:   Tue, 14 Aug 2018 12:53:13 -0700
In-Reply-To: <20180814184509.GA16659@dcvr> (Eric Wong's message of "Tue, 14
        Aug 2018 18:45:09 +0000")
Message-ID: <xmqqftzg209i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

>> Some popular E-Mail clients completely ignore the "Date" header, which
>> format-patch is careful to set such that the patches will be displayed
>> in order, and instead sort by the time the E-mail was received.

It is send-email that carefully shows monotonically increasing
timestamps so that the sender's datestamp can be used for sorting by
the recipient, not format-patch, which records author-date,
primarily meant for local replaying, in the generated messages but
discarded by send-email.

> Disconnecting during the delay might be more sympathetic to
> existing mail servers (which aren't C10K-optimized).  If the
> client sleeps, the server may disconnect the client anyways
> to save resources.
>
> But maybe --send-delay can be a shortcut for
> --relogin-delay and --batch-size=1

Both good points to point at a simpler and better solution, I guess.


