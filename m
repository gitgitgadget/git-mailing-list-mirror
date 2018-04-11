Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E07AA1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 02:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeDKCbr (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 22:31:47 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35929 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeDKCbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 22:31:46 -0400
Received: by mail-wm0-f53.google.com with SMTP id x82so926720wmg.1
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 19:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QyshfexSWqBiwF4ALiVqAKiJg3le7UWeLgJIdHdNvko=;
        b=tde2X7FcZ1krRqaFs8u3cv2sHUpNLXkaqrWsv0X69WEpQU5aPdqsHe8sxzgQBvX/QN
         0AJC6U3HkGltccBb2+KS40teQ9gIAvzwWAmEr1TYqiGEYFSDr1VrTmnnt0lhcFElsE/r
         5GUdDCtYSn9Oaghqi4Lw5PZ2/D/a/lN1QFInhHxw2xG1OvO+zTuHs+P5lrO3K3QrQLot
         1OPbt67YAwzqTIVpTxr9idlDYMUTwrwomMvyA8qAoRbWmIqWisb3wCJogWwZ6jMlBPTQ
         SdP7Ddo9NYULO5RuQYw+rzPL20yIxrLeTk6fDGPMoHVU4UANtAdIBEYifq4ip5XkoOrM
         ockg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QyshfexSWqBiwF4ALiVqAKiJg3le7UWeLgJIdHdNvko=;
        b=baOZCg5G0ez/LZfwg7ALZj78IZdUc7g0pTeqmENiu/VU/WclQRecTicMw4EN4CFPV9
         zEhJvvUHopJwYgJN/DBKm/hduhbfWxfrcFMEM85j9wVu++zxNS3AmrraQWdEqS73eUSs
         9tBKTNyc2/YRY0QEm+Z0iU7emi6thWQ7eSKsHrA8a9en4GxzG31WHAZ+mGXacqKdPkJU
         tZcQQTUMaT1M6Q9yWM1P2pMfcyrOEH6tAGrBNf5KN6paX4Rbvdp5Kuq3U9F9fTwAxQDZ
         9EFtx3H/JB/pUBgruhYDwbKzeTTGZvVb7U5f4/RUqR3ud4fzPAhLsX/wQDxQS+hU4X/1
         +IWg==
X-Gm-Message-State: ALQs6tCBGBp1vuFsmP0o1g9LSGI1IftrigOWap8szwdoc2x3zNLbRQf8
        k39HhhdkIfN41fmx+JJhPO8=
X-Google-Smtp-Source: AIpwx48gfeS6bciholIIZKZOX/6MZVu5QfZYC8VxZFPqzRg7jc7JYQ8MjP72q3tSIozRND4eXX71Zg==
X-Received: by 10.28.167.204 with SMTP id q195mr1122607wme.48.1523413905474;
        Tue, 10 Apr 2018 19:31:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 185sm437414wmj.46.2018.04.10.19.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 19:31:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>,
        "bmwill\@google.com" <bmwill@google.com>
Subject: Re: [PATCH v2 03/10] commit: add generation number to struct commmit
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <20180409164131.37312-1-dstolee@microsoft.com>
        <20180409164131.37312-4-dstolee@microsoft.com>
Date:   Wed, 11 Apr 2018 11:31:44 +0900
In-Reply-To: <20180409164131.37312-4-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 9 Apr 2018 16:42:00 +0000")
Message-ID: <xmqqefjmzd67.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The generation number of a commit is defined recursively as follows:
>
> * If a commit A has no parents, then the generation number of A is one.
> * If a commit A has parents, then the generation number of A is one
>   more than the maximum generation number among the parents of A.
>
> Add a uint32_t generation field to struct commit so we can pass this
> information to revision walks. We use two special values to signal
> the generation number is invalid:
>
> GENERATION_NUMBER_ININITY 0xFFFFFFFF
> GENERATION_NUMBER_ZERO 0
>
> The first (_INFINITY) means the generation number has not been loaded or
> computed. The second (_ZERO) means the generation number was loaded
> from a commit graph file that was stored before generation numbers
> were computed.

Should it also be possible for a caller to tell if a given commit
has too deep a history, i.e. we do not know its generation number
exactly, but we know it is larger than 1<<30?

It seems that we only have a 30-bit field in the file, so wouldn't
we need a special value defined in (e.g. "0") so that we can tell
that the commit has such a large generation number?  E.g.

> +	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;

	if (!item->generation)
		item->generation = GENERATION_NUMBER_OVERFLOW;

when we read it from the file?

We obviously need to do something similar when assigning a
generation number to a child commit, perhaps like

	#define GENERATION_NUMBER_OVERFLOW (GENERATION_NUMBER_MAX + 1)

	commit->generation = 1; /* assume no parent */
	for (p = commit->parents; p; p++) {
		uint32_t gen = p->item->generation + 1;

		if (gen >= GENERATION_NUMBER_OVERFLOW) {
			commit->generation = GENERATION_NUMBER_OVERFLOW;
			break;
		} else if (commit->generation < gen)
			commit->generation = gen;
	}
        
or something?  And then on the writing side you'd encode too large a
generation as '0'.
