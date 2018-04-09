Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9BFF1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 02:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757551AbeDICJM (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 22:09:12 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:55429 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757271AbeDICJK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 22:09:10 -0400
Received: by mail-wm0-f45.google.com with SMTP id b127so15140683wmf.5
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 19:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QBjyqP0ZQfvRdhNjWRCeSyzjMPBQNjPileW12Orhtm8=;
        b=RlMiTaXWNHtJDDPMSCxNuhz9xYQz300yjOsnFfW21/Zu4K5QKGxNjbM9CDvtpEi+13
         1ZZPrFXPm0weo8HLNnT1EMMxA7AbXOQvgpIqJOSGNe6szQskwnqUmVUrX7QIL80lJw59
         y3vBUEZrYj1pm/HpZ4QOubU4VDjeMT1N0iKVBDavkwLSZnUMUNMIPkLRwIbrL+7Khhqz
         ASKip+BiCePPzRAEC/wQZKdWMMvyP7nWV4OeV8YbSzADi6ZrR8WM7Lgx+FVIrQcButBN
         5xGzKz5UaPvrQg794HYk1PFCmSbYxjbsOeWhDGRitVnec4aV9hbtFr6LRgQhZNkykBTC
         nJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=QBjyqP0ZQfvRdhNjWRCeSyzjMPBQNjPileW12Orhtm8=;
        b=XWOecN1fAtATl+fZCnxYeH1a1isTY9DeCOO0P1PgCRT/A0Me7tFmgyKeH4UKhql68b
         l3c1CKLku1tkWcfYqUt4mWd33JxGsYBsxw3hrf+OfBK8dNQ+mLdt5985oKMYIOf1t/nI
         eEJnDFhb6opaFVOEaVGpASr/8lFnZpXtfYeYrYlIf6cuDOgeyxuqpPG4N2kvcBzyQkCN
         Yo3fDQMM27GhL2haLdTT9C5s3acq5PW2IJnQfqlj45hMWKFll30s98WaO5DAkpwtbLFP
         H47xayPFblSo2iCzg2qU88Uv0qAax6caJcmZU4bD4NBV+ua5OybEL1TnYE7AY25VfYdI
         WUWw==
X-Gm-Message-State: ALQs6tBD21Mcq/lzWRZggTtSLlj1fo2jqtGnc3D5K9mHqNoPEi6tn68Z
        ggxvRQnvTXX/C+an3pxplvE=
X-Google-Smtp-Source: AIpwx4+7tbUoI/qxAR9hTm0AzRP9JvgqN7mi+kBH+Pq85uylNEszOEDm9gLjX1YpXA49ej4Gzgg9iw==
X-Received: by 10.28.173.77 with SMTP id w74mr17248419wme.60.1523239748750;
        Sun, 08 Apr 2018 19:09:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n29sm11645009wmi.32.2018.04.08.19.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 19:09:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Joseph Mingrone <jrm@ftfl.ca>,
        garga@FreeBSD.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Caradoc-Davies <ben@transient.nz>, 894997@bugs.debian.org
Subject: Re: [PATCH] git-svn: avoid warning on undef readline()
References: <86h8oobl36.fsf@phe.ftfl.ca>
        <20180406131514.740-1-avarab@gmail.com>
        <20180406165618.GA6367@80x24.org>
Date:   Mon, 09 Apr 2018 11:09:07 +0900
In-Reply-To: <20180406165618.GA6367@80x24.org> (Eric Wong's message of "Fri, 6
        Apr 2018 16:56:18 +0000")
Message-ID: <xmqqa7ud6sho.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> See https://public-inbox.org/git/86h8oobl36.fsf@phe.ftfl.ca/ for the
>> original report.
>
> Thanks for taking a look at this.  Also https://bugs.debian.org/894997
>
>> --- a/perl/Git.pm
>> +++ b/perl/Git.pm
>> @@ -554,7 +554,7 @@ sub get_record {
>>  	my ($fh, $rs) = @_;
>>  	local $/ = $rs;
>>  	my $rec = <$fh>;
>> -	chomp $rec if defined $rs;
>> +	chomp $rec if defined $rs and defined $rec;
>
> I'm struggling to understand the reason for the "defined $rs"
> check.  I think it was a braino on my part and meant to use:
>
> 	chomp $rec if defined $rec;

That sounds quite plausible, so if there is no further discussion,
let me queue a version that does s/rs/rec/ on that line myself
(bypassing a pull from your repository at bogomips.org/).

Thanks.


