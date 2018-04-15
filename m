Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74D871F404
	for <e@80x24.org>; Sun, 15 Apr 2018 03:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeDOD0r (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 23:26:47 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:42422 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbeDOD0q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 23:26:46 -0400
Received: by mail-qk0-f174.google.com with SMTP id d193so1784554qke.9
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 20:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jlShpHKmxVzhzV1+83PoH5YLbwhjkFnnlQcOXBhk5T4=;
        b=oKkX6EVCANdWPs4YYR7xv0+WDQbXw2tUmYDrt5uKZ4vauTxTlKRI0SWFQT9Ht76S+O
         fCsTi9878Fd/+MI7YBtZH7OyA4lTXy/wZo1GPZx9boxl/RBv0iTuhP4H31n5BB9dXVgQ
         2HUuB4MGuTTHbmKeblIpEFEPsitFev/5o1mkqFWQrwZgqW+2p0nY3XmmmPq00LTe10XM
         t2Q6JJcrQ++HlPEMn45KNyxKbzNiuOzOZUBHy9CUHmTE75w/f4XIVx+DFowIWk/FicjU
         6d/7ED8mM5icKtdL4wzyEiThM9l/moo9lKScow5NrNYka4x7xxacvkO6kRzRr5HQsAWT
         3K+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jlShpHKmxVzhzV1+83PoH5YLbwhjkFnnlQcOXBhk5T4=;
        b=FTc2kC4Jc6Q9eNb7D0vzlZRerJ15b169JsqAeN+xkpP+c2/N2PcO/hHCJg8LkfeOK/
         vEH8cnLqX3E0dGRrMNd7NHZkw7197DkiLIE1t1a3BaN0b8VcJipeOS6glumTfBTLZCAD
         Eclo6Z1lYO+C9p0jEzKzvn8ugOa936pFvkkh5StC89tvZ1gA6TGUWVdiBA84LO7V0v7K
         3ch9cqOI0GitXkRsTqY6qX+VnJrFIVFUjmqfHQ1fc9VIfuNnjZiEGPLlICIBaoz2Q+3y
         nTgD8sh7lkOqEZdtNzD55nBVcrgw5POuEMpu0ztb7iYGtKMyny7RYYzj+kxzIXmf9l/J
         DbSg==
X-Gm-Message-State: ALQs6tBDjekB7NfjkmgxJ7euk/Brj+igFPEc++5Slw9psY6nJ/pQEkcl
        TO7pet9OPdD21ewug9m5O/rU6JkxPiRNxxAkvgg=
X-Google-Smtp-Source: AIpwx4+D0C5aHehDry6n2AzSP6qYkB2vFrvdS8txtTWVRZJ1pfq5rWhYvY3qqRx7QcggHjvixhJOIipihf64eiYm48A=
X-Received: by 10.55.43.18 with SMTP id r18mr11367741qkh.152.1523762805514;
 Sat, 14 Apr 2018 20:26:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 14 Apr 2018 20:26:45 -0700 (PDT)
In-Reply-To: <868t9pl9jo.fsf@gmail.com>
References: <20180402203427.170177-1-dstolee@microsoft.com>
 <20180410125608.39443-1-dstolee@microsoft.com> <20180410125608.39443-9-dstolee@microsoft.com>
 <868t9pl9jo.fsf@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 14 Apr 2018 23:26:45 -0400
X-Google-Sender-Auth: sfFdv4hqkXaDgS_M9JUrrwQv_lk
Message-ID: <CAPig+cSP23Fve_hDnrvK++nz1DxkWy9-QBA58L-1FUoGy9psuA@mail.gmail.com>
Subject: Re: [PATCH v8 08/14] commit-graph: implement git commit-graph read
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 14, 2018 at 6:15 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>> +             NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
>
> I don't know if it is possible to do the above in a portable shell
> without using external 'wc' command.  Also, isn't $(( ... )) bashism?

$((...)) is POSIX and used heavily in existing Git test scripts.
