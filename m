Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139391FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 22:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbdBJWdG (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 17:33:06 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34735 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdBJWdE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 17:33:04 -0500
Received: by mail-pg0-f65.google.com with SMTP id v184so4018026pgv.1
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 14:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jEgLu+DwmkQpbjQOS+RrB9K1qIz+QDL/ScskDKby2nQ=;
        b=UjwGfdQUp6Ed3Ipp1xSRso5kj38IemNDDcB9UEDBcLgeD3yYF0FDcai1Od20mYCCtd
         EcUnVqtCxg7m2B3dCe3Q6iNyL1mb+WyWmfLcWOq1tvcR9fnMQdOzTi6irx4SiAjgegoJ
         oiYdRo3tllNoGug4KO+wUpfg4utM7vh/gvORWSjQrjOcJpvjkXxkzAAlshF6l/P9C2WE
         Jya8FGX3S+elaEpZEI7W4qj+IyQfLbn//af/QZwzyObPPudkI1IsFodNgKyKrNRMheG+
         r2q09e6cWAqCMuo4AKUwxDd94gFEOISemxYQL9ccPrXULVzO/i+kWgZkv0WmPDKF8OrE
         VTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jEgLu+DwmkQpbjQOS+RrB9K1qIz+QDL/ScskDKby2nQ=;
        b=cNPS+ESsJm/iVFWj+C4fNJGILaW5S99+DjEWc5ZWOyPnE0ROWSr8IOcRpAIvNAFZok
         rCY1UxiXkOEX8+rdwVgNZsvyzufnWbo6aKw/pqfSWLaCSoeqvYHy1R3Xq6ZrGSBB98iZ
         trTYNIVjHe9EJg7If3GfjzlU06u+8gtg21jxcV4fk3+kWFjDLKYliNvNrv1wSPncn9hA
         Zr5KuCo7sXlXWJK+IpQe/aOah6I93Gmcjzd6qoD7xLmbWUrUcRuFE47iBGFZVvLdm+aE
         c8cZU4e2he5JNPIG8K5GtdVlKV0XTjxzg08gvar7/b1nWaOF14//wxaD3rnGRUlYhGci
         Lv9Q==
X-Gm-Message-State: AMke39kjg+KJd2dpqEmWLRBFf4mFLjoMl9Wys20vSbRYfgb+J6thw6cbeOZO/CLp2IhzBg==
X-Received: by 10.84.215.154 with SMTP id l26mr14530415pli.120.1486765979259;
        Fri, 10 Feb 2017 14:32:59 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id r17sm7498727pgg.19.2017.02.10.14.32.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 14:32:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH v2] git-p4: fix git-p4.pathEncoding for removed files
References: <CAE5ih7-=bD_ZoL5pFYfD2Qvy-XE24V_cgge0XoAvuoTK02EDfg@mail.gmail.com>
        <20170209150656.9070-1-larsxschneider@gmail.com>
        <xmqqfujnlyru.fsf@gitster.mtv.corp.google.com>
        <CAE5ih78xRAOFb+MC53qzNJyZ_d7j+87UYEt5Ku6JrkFhgHdD7w@mail.gmail.com>
Date:   Fri, 10 Feb 2017 14:32:57 -0800
In-Reply-To: <CAE5ih78xRAOFb+MC53qzNJyZ_d7j+87UYEt5Ku6JrkFhgHdD7w@mail.gmail.com>
        (Luke Diamand's message of "Fri, 10 Feb 2017 22:05:26 +0000")
Message-ID: <xmqqtw81isme.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> On 9 February 2017 at 23:39, Junio C Hamano <gitster@pobox.com> wrote:
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>
>>> unfortunately, I missed to send this v2. I agree with Luke's review and
>>> I moved the re-encode of the path name to the `streamOneP4File` and
>>> `streamOneP4Deletion` explicitly.
>>>
>>> Discussion:
>>> http://public-inbox.org/git/CAE5ih7-=bD_ZoL5pFYfD2Qvy-XE24V_cgge0XoAvuoTK02EDfg@mail.gmail.com/
>>>
>>> Thanks,
>>> Lars
>>
>> Thanks.  Will replace but will not immediately merge to 'next' yet,
>> just in case Luke wants to tell me add his "Reviewed-by:".
>
> Yes, this looks good to me now.

Thanks.
