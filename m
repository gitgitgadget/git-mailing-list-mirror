Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BB8C20282
	for <e@80x24.org>; Wed, 14 Jun 2017 18:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbdFNSgb (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 14:36:31 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33229 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbdFNSga (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 14:36:30 -0400
Received: by mail-pg0-f65.google.com with SMTP id a70so1072866pge.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=06Zzgy+nZoxWL6koDY4m76EB/pF/HXlddW2QCdTxtlg=;
        b=nlq1k4wP0/fdKMKIiPkIigd/BQB7IGLX+PmJgDhazwOt0yXyT/sWfePxGGELoew0CQ
         aq74SjIVgFtll2Uja3U97/cS0v9yDb/8ONRgMqmRxWoLwyjhDJTe6SwrtNWEKcD9141l
         ASodwf4cG50y+H5KUILMFebxajVKM4Fv2WGQ87uHVfOMO2dIeUBFgPzTUp8DiPoqVnoy
         WeCPTAVp1ZkBroCGltUoJp6pVmUugUQiViPeQJBqiBCcT/FJgrP5bgwH4cr09COOO+Tr
         CVIYbAXshAoQRknWyXkEXMQVoW1SfpPoj7PGuAsi8hVQ/uZs8V0mHbh2sSxMh4F7Gpul
         iArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=06Zzgy+nZoxWL6koDY4m76EB/pF/HXlddW2QCdTxtlg=;
        b=iK5nxACxzD39CnOA5j/bTZwzN6+tDDtUyRzA0rVXGxCOm1JfuXbVN4XXa6XHZ5Ub0l
         rOsnH33ZCP0l4ZEa9xPZjzRg1vklvl0+/Tdfswut5wrq6TVcIH9usnc2GHG7bN95KcI5
         luMtwrnizZhZkrDU+4PirhhTj5xqpbVRDGk0cMbUkp51tFFJTSa43rcFyKXzGX30Yg98
         9h0JoLlnttILF77fNPUr2G+6tyu+9WkCq1fg1hvBinvMJYoFQGX4/0NEkasck6snNVeM
         eubkBS6NLgz1a0fTN1bj0TgoIlHwHze/uRcONKxNSRdKxQc9Ivp4GFAZDYkE1b3Ajv2C
         LXsA==
X-Gm-Message-State: AKS2vOyxDu3eJHS7UfNZF+J4ePyMfcbW76r07ji/9hs2g0+/QUVJ/+iT
        DL857JIeEgYgyg==
X-Received: by 10.84.217.87 with SMTP id e23mr1540209plj.143.1497465389530;
        Wed, 14 Jun 2017 11:36:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9e8:46fc:1af4:4618])
        by smtp.gmail.com with ESMTPSA id m134sm1177634pga.15.2017.06.14.11.36.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 11:36:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v5 7/7] fsmonitor: add a performance test
References: <20170610134026.104552-1-benpeart@microsoft.com>
        <20170610134026.104552-8-benpeart@microsoft.com>
        <xmqqo9tsn9qg.fsf@gitster.mtv.corp.google.com>
        <9c1ed8d4-6bdb-e709-758d-4b010525e9e3@gmail.com>
Date:   Wed, 14 Jun 2017 11:36:27 -0700
In-Reply-To: <9c1ed8d4-6bdb-e709-758d-4b010525e9e3@gmail.com> (Ben Peart's
        message of "Wed, 14 Jun 2017 10:12:42 -0400")
Message-ID: <xmqqvany2z84.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

>> Having said all that, I think you are using this ONLY on windows;
>> perhaps it is better to drop #ifdef GIT_WINDOWS_NATIVE from all of
>> the above and arrange Makefile to build test-drop-cache only on that
>> platform, or something?
>
> I didn't find any other examples of Windows only tools.  I'll update
> the #ifdef to properly dump the file system cache on Linux as well and
> only error out on other platforms.

If this will become Windows-only, then I have no problem with
platform specfic typedef ;-) I have no problem with CamelCase,
either, as that follows the local convention on the platform
(similar to those in compat/* that are only for Windows).

Having said all that.

Another approach is to build this helper on all platforms, with
sections protected by "#ifdef LINUX", "#ifdef WINDOWS", etc.  That
way, the platform detection and switching between running this
program and echoing something into /proc filesystem performed in
p7519 can be removed (this test-helper program will be responsible
to implement that logic instead).  When p7519 wants to drop the
filesystem cache, regardless of the platform, it can call this
test-helper without having to know how the filesystem cache is
dropped.

I do not have strong preference either way, but I have a slight
suspicion that the "another approach" above may give us a better
result.  For one thing, the test-helper can be reused in new perf
scripts people will write in the future.

Thanks.
