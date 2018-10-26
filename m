Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F7C1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 01:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeJZKe3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 06:34:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54207 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeJZKe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 06:34:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id l26-v6so3300744wmh.3
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 18:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dyW+9fEsLP3xp/QYf7mWp9t1NLzEWznT2dZvynqmX4g=;
        b=Ht3hdGJKSpOom2x2OuOo+3VW9GhwcuKTW/Xn4NuBA82566T8RrummLYdV83GN+qlyp
         w8JZJ6HOEQTnNqp/didU5Fio1BKcvGjljSJf8jwEoLYwQnmKK+X58n7ic5o/nghcm7RN
         PtQwnOqRXSjxfowikX3EgWZGE9Q+w1sliBHx1nlcNC4viNw1pLWLjg6HY3oRWPelP0mP
         SyX5vaGF0mJF/GZ25/A/xyRc6ZWHYKoPmqtPDaoSjFxWbg/Nvc6bqK1zNK2B8ue24Yfq
         Rk3yV5T/NcpDjnvBsFRioYBe6yJWzmdQ0daI1IcExgJVXYQa477iM+eIS0C+EX31dU0G
         YjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dyW+9fEsLP3xp/QYf7mWp9t1NLzEWznT2dZvynqmX4g=;
        b=tt14cJtPdsgC5sMHYqQEKO+BWJZjs4+M7FYFD4Mp/uK642ivRxqoXyMRylgPNaUigP
         aZN8ePrMDowH2r4TcSRkMHK3c/6ii7RoX+iM4c8rt1EJkcYYzRsOyRI+Aq+QZ7zLhQr0
         v4XQk+OKa2VvuSXg8nDxtnzhUjKy4I2AyHm2PALo1++o2BmCuBgYhvt7qpRUEhfI9FKX
         uj0nEH89zrDFbDHUU0F8z7VwX6pC4BDoynfPl3ni8CLvIFC49qq4LO6bs3R37NukiwLK
         vkQ1jrgSKeKTjbjjFmtfQwntE9rsCO9+Cu3efTWe0lAC2LRDFLobw9mxpUrpUegytC14
         V3fA==
X-Gm-Message-State: AGRZ1gLJJeQJJmpt8y+bCmIvVoMAT+HPmzH2/OWpmdI5UZxS9AAWyXRo
        gd5iV2zOD4qvcoMW42rvUdA=
X-Google-Smtp-Source: AJdET5cC+EWn3lAhh/50mBiRVQ1pyoUbIkLgT4vzWBSX3mqTT+/1cSaC0QkpRdXTgHlGvXZ7ru9hMQ==
X-Received: by 2002:a1c:930c:: with SMTP id v12-v6mr3974581wmd.9.1540519164502;
        Thu, 25 Oct 2018 18:59:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p8-v6sm9636763wre.50.2018.10.25.18.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 18:59:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Antonio Ospite <ao2@ao2.it>, git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v7 00/10] Make submodules work if .gitmodules is not checked out
References: <20181025161813.17252-1-ao2@ao2.it>
        <CAGZ79kZvzLtSgAw8epGpG+T2f2Q7z2ZkXe=4gKMQTkM8ikwcog@mail.gmail.com>
Date:   Fri, 26 Oct 2018 10:59:22 +0900
In-Reply-To: <CAGZ79kZvzLtSgAw8epGpG+T2f2Q7z2ZkXe=4gKMQTkM8ikwcog@mail.gmail.com>
        (Stefan Beller's message of "Thu, 25 Oct 2018 11:49:50 -0700")
Message-ID: <xmqqin1peadh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> In this series I am addressing the comments by Stefan Beller about the
>> tests in patch 9.
>>
>> If the new tests look OK, I'd say we try moving the series to "next" and
>> see what happens?
>
> Sounds good to me.

Which means (1) the plan sounds OK but I didn't look at these new
tests or (2) the new tests look OK and I am happy to see this go to
'next'?

tbdiff tells me that 9/10 is the only patch different from the
previous round, and I vaguely recall that the other patches looked
OK to me (even though I admit I only skimmed them quickly).

Thanks.
