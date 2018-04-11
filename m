Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66111F404
	for <e@80x24.org>; Wed, 11 Apr 2018 02:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeDKCv2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 22:51:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35061 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbeDKCv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 22:51:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id r82so986080wme.0
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 19:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=e4W2882aIP9sj7iVsO6NgejugG+mixRHDmvJp4isqJY=;
        b=X8rEaaIyF+XAbYxovBwHl2Gx11Ytgb/f11Vgd6tzTIQ6MdG9Zw9ejNd5PPG1hmdKqc
         QhcVHFWrVv6uI7hVdEZi/gpxHZRk4d0XWo+IbXmxfsaY5gowRvST46tueIA2BxMM0/Or
         S/z311FDXlPQlvkvzJzYT33cNfXtWHUGtPb0DjdCQzQHlzaNYVn0Jr53OnzOMo7k3/rh
         imqkhOD/EjbLQ2+dGQX5R5YgWElnRcUk6O/4PBeDQ0ulbfmHGTgexe0yAY8/PJ1FEqV9
         Vb6cegTGDMKs8vQvuYQSuZvBAJ7kYTjmMZKoq7Q+k17hepHnMd9jOclr8aNjXJHN3h7q
         Nmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=e4W2882aIP9sj7iVsO6NgejugG+mixRHDmvJp4isqJY=;
        b=D08pKYu/ULMioQkDhZ4B9U6UsTaer0TY8F2Ld/EkyXXL5bd4oO/86XlAZF3SHrt+ez
         8eO1pzXE7aYSgsqprXt9NQBFu4373PYd3dnktsi6FWqfk+qkJ+XMQDcVS8O86X00erMe
         wDIioDix7caU7u14doxxvQunltNTCuJtv0TrC8gtNzbnzomC6D49lwrf8lbqHtPcMZcY
         IyNsMUpotcHQW2QsD/cFHRH1VOXOmN5O3UTiUnKAhdSToFA9PstjhynGQnP6SPvo/fU1
         7doLmw+IuwbaVpu7hMZUPiHK0+KFi4vG0yNbJP0iph0bfJmqtGKXKqee7FrptmD7XkEN
         BY+g==
X-Gm-Message-State: ALQs6tAeTyn0xcBn+jb6yDHlMxKhWeD0j459HFmJ57oTyJYCb2BCR2cX
        QDsyMSahBqmCLmZ2KGS5gS4=
X-Google-Smtp-Source: AIpwx48hkv5W/de10vGKMkXt1cXllBrWAt/9w+knxw7jo3P6O7FZbce+ZZzaVPJlo/gGf6hP1K2aHg==
X-Received: by 10.28.109.88 with SMTP id i85mr1102464wmc.150.1523415086005;
        Tue, 10 Apr 2018 19:51:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f54sm63351wra.80.2018.04.10.19.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 19:51:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>,
        "bmwill\@google.com" <bmwill@google.com>
Subject: Re: [PATCH v2 04/10] commit-graph: compute generation numbers
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <20180409164131.37312-1-dstolee@microsoft.com>
        <20180409164131.37312-5-dstolee@microsoft.com>
Date:   Wed, 11 Apr 2018 11:51:25 +0900
In-Reply-To: <20180409164131.37312-5-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 9 Apr 2018 16:42:01 +0000")
Message-ID: <xmqqa7uazc9e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> +		if ((*list)->generation != GENERATION_NUMBER_INFINITY) {
> +			if ((*list)->generation > GENERATION_NUMBER_MAX)
> +				die("generation number %u is too large to store in commit-graph",
> +				    (*list)->generation);
> +			packedDate[0] |= htonl((*list)->generation << 2);
> +		}


How serious do we want this feature to be?  On one extreme, we could
be irresponsible and say it will be a problem for our descendants in
the future if their repositories have more than billion pearls on a
single strand, and the above certainly is a reasonable way to punt.
Those who actually encounter the problem will notice by Git dying
somewhere rather deep in the callchain.

Or we could say Git actually does support a history that is
arbitrarily long, even though such a deep portion of history will
not benefit from having generation numbers in commit-graph.

I've been assuming that our stance is the latter and that is why I
made noises about overflowing 30-bit generation field in my review
of the previous step.

In case we want to do the "we know this is very large, but we do not
know the exact value", we may actually want a mode where we can
pretend that GENERATION_NUMBER_MAX is set to quite low (say 256) and
make sure that the code to handle overflow behaves sensibly.

> +	for (i = 0; i < nr_commits; i++) {
> +		if (commits[i]->generation != GENERATION_NUMBER_INFINITY &&
> +		    commits[i]->generation != GENERATION_NUMBER_ZERO)
> +			continue;
> +
> +		commit_list_insert(commits[i], &list);
> +		while (list) {
> +...
> +		}
> +	}

So we go over the list of commits just _once_ and make sure each of
them gets the generation assigned correctly by (conceptually
recursively but iteratively in implementation by using a commit
list) making sure that all its parents have generation assigned and
compute the generation for the commit, before moving to the next
one.  Which sounds correct.


