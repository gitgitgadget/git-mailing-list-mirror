Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96894208E9
	for <e@80x24.org>; Wed, 18 Jul 2018 20:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbeGRUwk (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:52:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37418 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbeGRUwj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:52:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so5867615wrd.4
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 13:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=p6E/a83+vld+rBpLodMqPLlab7Vjaz5FVuNHfQUKNHg=;
        b=LKKYDf0asLqiQdKNzlx4yma0y0FnPvcFUGG8ieXUM2suwLDacPFaN3snNbKJgHfkJV
         GyYUMb5VrrDlcnMWD+AJEnlQfJl69tDyzxleM6qlAJgMc7zdPjw+2EDmIXcAij7nS7kt
         UUupUd/v7XtqTMAfelVOcYzVjymPlQtrL2MxbiaV37SY45jvVlFUKrNGA2B95tXqzXD+
         KGEXhuNJ/9eP4UNhXy+mBkDGAgxjRLY5eNAWly39nnoIkjbCQsHRMIrCIfsdvmPBR1YL
         0ZTDzAAHMR5Zc3HJAyQkdIn95PwAVBUowdiPShF+enab254D1BB5jczQaK20eI1bukwV
         70QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=p6E/a83+vld+rBpLodMqPLlab7Vjaz5FVuNHfQUKNHg=;
        b=pjqZUjvs6xLK9kM+7cB2VjYH3kvr682DR8kD8f6SRkVhTM3bGZfSi9iy+SLTk69BTc
         Ik/XxYsSJDYRINK8+bH04H8rPcEbIBXqEgYiv7X2AR3HrxCp6d+A5Dn/Gw4X3J7df7LK
         uGBdpjN2AehxeF5WGPDRfLJbtoqEtvzd9Fx51/Mec+DZub+2xNNYEtoATIo2n8QX/wpS
         4Utzu1ZNrNZ6tgaJzvAH8jY7o4q53aqrCNYl7dZ3E02XqPs58p79v+BQvclh9VJ+kTV6
         TfWGdGvzERKrqtjnD0jigixD6W5RZxIy386zfbbpIW9sUXClA0bd+QXLL+e99jTZeWA4
         54xA==
X-Gm-Message-State: AOUpUlFFS5KrYmVWSuuLQ4upvcuzw98q+Oke24AMIl1Y4sMMyQHrAySr
        ZZjLShvw/IIu9uofNp1NUyc=
X-Google-Smtp-Source: AAOMgpdj/3WlC7L6ya+NbpOVT04QlhQOshfx+TkY2fLNFFhnH+9SnI05ZkHEmzZNPx9/MwSU08eZ9w==
X-Received: by 2002:adf:ef03:: with SMTP id e3-v6mr5142886wro.182.1531944788684;
        Wed, 18 Jul 2018 13:13:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x7-v6sm6395271wrr.95.2018.07.18.13.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 13:13:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Jakub =?utf-8?Q?N?= =?utf-8?Q?ar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 2/8] refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback
References: <pull.11.git.gitgitgadget@gmail.com>
        <22dc9ce8364dd20876ab5eb626ecc6a7396d3b3e.1531926932.git.gitgitgadget@gmail.com>
        <xmqqd0vkjsx3.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZ9oeqidNMppOx+PNfp-4RdDhLzvQHhm45Ceni=g1Q_7Q@mail.gmail.com>
Date:   Wed, 18 Jul 2018 13:13:07 -0700
In-Reply-To: <CAGZ79kZ9oeqidNMppOx+PNfp-4RdDhLzvQHhm45Ceni=g1Q_7Q@mail.gmail.com>
        (Stefan Beller's message of "Wed, 18 Jul 2018 12:19:05 -0700")
Message-ID: <xmqq4lgwjoa4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>  - existing users of for_each_replace_ref() who were all happy
>>    working in the_repository have to pass it explicitly, even
>>    thought they do not have any need to.
>
> All callbacks that are passed to for_each_replace_ref now
> operate on 'r' instead of the_repository, and that actually fixes
> a bug (commit message is lacking), but the cover letter hints at:
> ...
>> In this case, even if you introduced for_each_replace_ref_in_repo(),
>> making for_each_replace_ref() a thin wrapper that always uses
>> the_repository is a bit more cumbersome than just a simple macro.
>
> Yes, but such a callback would do the *wrong* subtle thing in some cases
> as you really want to work in the correct repository for e.g. looking up
> commits.
>
>> But it *is* doable (you'd need to use a wrapping structure around
>> cb_data), and a developer who case about maintainability during API
>> transition would have taken pains to do so.  A bit dissapointing.
>
> My original patches were RFC-ish and a trade off as for the reflog only
> there is nothing in flight to care about.
>
> Given that we would want to upgrade all the ref callbacks, we have to
> take this route, I think.

Try to rebuild 'pu' on top of 'master' yoruself to realize how many
in-flight topics you are hurting and causing unnecessary load on the
maintainer with the "let's add the 'r' parameter without changing
the function names; compiler would catch and cause breakages"
approach.  

Until that happens, I won't waste any more time trying to educate
you on this further.


