Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8AC61FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbdFMRak (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:30:40 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34020 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbdFMRaj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:30:39 -0400
Received: by mail-pf0-f195.google.com with SMTP id d5so10521871pfe.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Lw06MYxvHHljj69z9/TD00TEPb98zsyKJNYeYWMJh0k=;
        b=if784GH2yNp8F4SQKql57otu+NsaO8jB3CZlLOLrUnKa1rsl1ohajoH6GUySQ1eyFM
         qBZzgUuTXlhGboe6DufEd7cc7jU42n4r0w4ijuTVVOK7sL0AAEGdqFN/d/ZeAwwMWK6E
         /mWKHGpRyZpy12I5ylf+j71Ut0NX1et03dpf0wdGw57k7HKU9p087XW+JkPGcUTUghH7
         BSgzH+zuquzqQqJ1CzIXt2+8dNUMcJuTQSd58gHThCD66QBACa22bE9+n2ubtCpVNKiD
         x8Cr0cEBq8VmGhJdpBnuq/8EIDQfg1T0xneCGc1gFl3kRwk0DC8MTReSskRu+9pwW/RS
         U+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Lw06MYxvHHljj69z9/TD00TEPb98zsyKJNYeYWMJh0k=;
        b=mbg/7YHgEDB/CNRD4nmHCCpVaGynTNiZ6rFHyKCY/jrFD6jas/1MPwj4+mPhwKME2i
         M/q4RA9SQkYW1onH+dd9Fq8FLJR14Wbx1ibfeuYa+kUobP5dR+mchDwE7FdqKJpGicwH
         KbSSPi/FE4r9B5B1NnPQQYuNB5dcOTujmjsuq740cYba4cfqQMk973iSRmRAO+MYA7rB
         W98KrnBEw5+xDQEYeBSuXwXsweiGZuPYJjhCBh5/nbmOMQljTfzeMpu1mIL6Xy2FSrAT
         ZVdMex/QeEfx2cgEoYiAKaziLD/7DkIgCUR0h7mIREqeb7zn5BGYSObdh6ADL1qe46EM
         6fUw==
X-Gm-Message-State: AKS2vOyKHhdZBkVPMcDvB7iGvg9bFIV8bEL1H85QGSURRhP17qYCPygJ
        Km9HObw3etKxlw==
X-Received: by 10.84.216.88 with SMTP id f24mr823319plj.103.1497375038441;
        Tue, 13 Jun 2017 10:30:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id 15sm26478872pfk.115.2017.06.13.10.30.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 10:30:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] branch: add a --copy (-c) option to go with --move (-m)
References: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
        <0102015ca23f054b-b7c281d9-c9e0-4691-bfa9-8c46fb77dfc7-000000@eu-west-1.amazonses.com>
        <xmqq60fz95sb.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 13 Jun 2017 10:30:37 -0700
In-Reply-To: <xmqq60fz95sb.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 13 Jun 2017 10:05:56 -0700")
Message-ID: <xmqqfuf37q2q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sahil Dua <sahildua2305@gmail.com> writes:
>
>> Add the ability to --copy a branch and its reflog and configuration,
>> this uses the same underlying machinery as the --move (-m) option
>> except the reflog and configuration is copied instead of being moved.
>>
>> This is useful for e.g. copying a topic branch to a new version,
>> e.g. work to work-2 after submitting the work topic to the list, while
>> preserving all the tracking info and other configuration that goes
>> with the branch, and unlike --move keeping the other already-submitted
>> branch around for reference.
>>
>> Like --move, when the source branch is the currently checked out
>> branch the HEAD is moved to the destination branch. In the case of
>> --move we don't really have a choice (other than remaining on a
>> detached HEAD), but it makes sense to do the same for --copy.
>
> I strongly disagree with this "it makes sense to do the same".  It
> would equally (if not more) make sense to keep the HEAD pointing at
> the same.
>
> Personally, I may use this feature if it didn't move HEAD, but I
> wouldn't if HEAD gets moved.  But that may be just me.

Ah, that came out to be stronger than I intended.

While I do prefer "the HEAD is not moved by this command---if you
want to move to the newly created branch after copying, check it out
yourself" a lot better than what the patch does, I do not think I'd
care so strongly that I'd reject this patch series unless the
behaviour is changed.

But I do react strongly to an unsubstantiated claim "it makes sense
to do the same".  I can buy "We anticipate that in 50% of the case
users would find this branch switching annoying and in the other 50%
of the case, users would find it useful; since we need to pick one,
we just randomly decide to do the same as --move", though.
