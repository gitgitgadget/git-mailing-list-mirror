Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 831D31F404
	for <e@80x24.org>; Mon, 10 Sep 2018 16:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeIJVud (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 17:50:33 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33625 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbeIJVuc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 17:50:32 -0400
Received: by mail-wr1-f54.google.com with SMTP id v90-v6so22764429wrc.0
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JE5A2l4x8Uthiij43jRcFenuZidll3SySeLb5DxyigE=;
        b=plhndaRn9/ZQonZJ/mmWyYMVTOKuBnf34YGtHCAld1dvfc7Pl1i7G+f7eGXCtPdSXC
         uN4PZ25w0zQsoGRv8CC4rb+89OeYyjWArYDtmaV9TGTQmTZ9jRNP8XspxJFYfzOyOEnw
         CfF4xL7UuV+mEQgVfS7PwjSZYk1Mt0llJkdItRlo0LYWJm/+d8mc1ztr1x5b3BRekK+E
         ee4EzWDYPW2hcU/10yCQk7qDSWDmu7zbBJuDCQsnovgpLYdRtXgMV0odJXhz2LTW1pXo
         NV/BX8/+WOPfyWJ+RyvZ04sEAoYply0KmqJR4BdCL3Qv+dZfH2O8JkZnBkEzSniKswpv
         nBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=JE5A2l4x8Uthiij43jRcFenuZidll3SySeLb5DxyigE=;
        b=BL7Y5BbCgs0ix88aQPUtXAfXyIsHdjXfRH/JCQCGnkbNSE2apzjTOrdt0y2z7jm0nn
         vht/wG3QY1nbzXRKVQo+o+XefOo3P3RVkUCQfgpFxw+GlPrTH/DkN62gbAomYIxaInqm
         ax72s9EPHCwedboA47DtIhJKfyW7mZ2Pt8y87efzPQB5bSXOSQYmWv0Di6YAHfJvbIfF
         lZjQoMb0U6/aGkNSv2HweBHJ9KVqdoOgNzeNhB0mRVv/WqzQZbSs2EKPHHAEg3dxAJIK
         yVYxPN6jEfpqaq+ew4b+oyicJ7A91s/z/ceoqxg5kOY8Dnj2YtnAW/X9cpW59+205cbk
         ql8A==
X-Gm-Message-State: APzg51CZ7E1o4UQJAXQ9UDRlDKWbAhav+PCbVXQzQPO888tBaILf7z+v
        LCHEkovHE2vcZYDmsngb/Cc=
X-Google-Smtp-Source: ANB0VdYVMpR4OL3Sxo3uqqQ/BRyNNaWkYbggfdkgv/I7/sJ7cHNghksEkErGidiK0NTvAqJL4CmYLw==
X-Received: by 2002:adf:8103:: with SMTP id 3-v6mr15740822wrm.213.1536598531913;
        Mon, 10 Sep 2018 09:55:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v133-v6sm22903683wma.36.2018.09.10.09.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 09:55:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Pratik Karki via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 10/11] builtin rebase: only store fully-qualified refs in `options.head_name`
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <pull.32.v2.git.gitgitgadget@gmail.com>
        <aab01f0b8e15db37bc17630b4298148aeacf41e2.1536096424.git.gitgitgadget@gmail.com>
        <20180908085207.GB10370@localhost>
Date:   Mon, 10 Sep 2018 09:55:30 -0700
In-Reply-To: <20180908085207.GB10370@localhost> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Sat, 8 Sep 2018 10:52:07 +0200")
Message-ID: <xmqqva7dthq5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>>  		} else {
>> -			options.head_name = xstrdup("detached HEAD");
>> +			free(options.head_name);
>> +			options.head_name = NULL;
>
> Please use FREE_AND_NULL(options.head_name) here.

Good; did contrib/coccinelle/free.cocci catch this?

>
>>  			branch_name = "HEAD";
>>  		}
>>  		if (get_oid("HEAD", &options.orig_head))
>> -- 
>> gitgitgadget
>> 
