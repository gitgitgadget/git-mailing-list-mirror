Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289B11F453
	for <e@80x24.org>; Tue, 16 Oct 2018 02:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeJPKBh (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 06:01:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54313 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeJPKBh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 06:01:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so20749739wma.4
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 19:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=H7cBaG+21VmlIzhC3QfDJ94QQC1ViocIsxoAm12pGtk=;
        b=HmnkLU07HXmtVhglNcKG9RXYvbY8KkjKZHWUtfrjgahMu4s15C42tgQGruC2cn4GRM
         QmXyHZnJcg0Zeexrsdhb/A73R2koZY6pcTWExBgc3OtoZfvdtDwcGYQhAbElzmZl3uid
         CsZNNjCZmkD9QoQu2KyBa61TlqEYKMc9aDyB/tRW0/YdsaeQoCSxedTWuIa5aedBhiac
         s8R3KvWKvQ7UrEMynzrT7vBvDARLOBn6QDaJ+jigPvN7c/mrK0NmlGAnPutddvPobyX3
         gikqc3NWtuZWdhoqaXYe2MCwiRkuvDwWKXYZ0DfnnYeLGK1oTR6uFR0a0IA8CRId607A
         HPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=H7cBaG+21VmlIzhC3QfDJ94QQC1ViocIsxoAm12pGtk=;
        b=q4ToDawv4E8bPZVDAo5cuj6amUAsEpOH+nC74liedVTvfIUTyZucVcKTYRPhD5q7oR
         0Wd2qA4dOYS+ZpXSu5/vPCyYFAzFozflrmZ+HzmPwase4uqYOg3IQBek5v/2l3jHefTK
         yCElX4rTcCD3SFKuVzDh71WYuMPEYHohMIaZ+PYXQxLmTVrWLrUXrargABt97EqJYzS5
         l1klluFRTVfDGxu2qRhwr26ylsUav9tCEfWLikFmtHXXwjK1+8w89LYrnD84umP0A6gL
         SjhVdmzJhrvZAhFUFAoO1bvgKQs5ZlZpbs2vbTPUI4c366dlkEYuuDhXXaV2VKYYmfk0
         ks2Q==
X-Gm-Message-State: ABuFfohgKHkyu+0UcIZ03PDA3h6Gy13CkKWbvSj6kdxJDgJSdcJpKJFo
        drR+GORcgELbFU1HRUc4qrE=
X-Google-Smtp-Source: ACcGV62DwDduhLSZZTnCA/VXqnblFS7PwXKLO840ofoSIHGqanXVVSeFl3m4B+qTH9S3PfHKg3xamw==
X-Received: by 2002:a1c:d10d:: with SMTP id i13-v6mr14885277wmg.68.1539656015942;
        Mon, 15 Oct 2018 19:13:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m136-v6sm11452669wmb.4.2018.10.15.19.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 19:13:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] gpg-interface.c: detect and reject multiple signatures on commits
References: <20181012210928.18033-1-mgorny@gentoo.org>
        <xmqqva636g2t.fsf@gitster-ct.c.googlers.com>
        <1539636266.1014.6.camel@gentoo.org>
Date:   Tue, 16 Oct 2018 11:13:34 +0900
In-Reply-To: <1539636266.1014.6.camel@gentoo.org> (=?utf-8?Q?=22Micha?=
 =?utf-8?Q?=C5=82_G=C3=B3rny=22's?= message of
        "Mon, 15 Oct 2018 22:44:26 +0200")
Message-ID: <xmqqva623agh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michał Górny <mgorny@gentoo.org> writes:

>> OK, so the whole thing makes sense to me.
>> 
>> Having said that, if we wanted to short-circuit, I think
>> 
>>                 for (each line) {
>>                         for (each sigcheck_gpg_status[]) {
>>                                 if (not the one on line)
>>                                         continue;
>>                                 if (sigc->result != 'U') {
>>                                         if (sigc->key)
>>                                                 goto found_dup;
>>                                         sigc->key = make a copy;
>>                                         if (*next && sigc->result != 'E') {
>>                                                 if (sigc->signer)
>>                                                         goto found_dup;
>>                                                 sigc->signer = make a copy;
>>                                         }
>>                                 }
>>                                 break;
>>                         }
>>                 }
>>                 return;
>> 
>>         found_dup:
>>                 sigc->result = 'E';
>>                 FREE_AND_NULL(sigc->signer);
>>                 FREE_AND_NULL(sigc->key);
>>                 return;
>> 		
>> would also be fine.
>
> Do I understand correctly that you mean to take advantage that 'seen
> exclusive status' cases match 'seen key' cases?  I think this would be
> a little less readable.


Yes, the above is taking advantage of: exclusive ones do give us
key and/or signer, so it is a sign that we've found collision
between two exclusive status line if we need to free and replace.

But that was "whole thing makes sense, but if we wanted to...".  I
do not know if we want to short-circuit upon finding a single
problem, or parse the whole thing to the end.  I guess we could
short-circuit while still using the "seen-exclusive" variable (we
can just do so at the place seen-exclusive is incremented---if it is
already one, then we know we have seen one already and we are
looking at another one).

> That said, I was planning on next patch that replaced the "!= 'U'" test
> with explicit flags for whether a particular status includes key
> and UID.  If you'd agree with this direction, I think having this one
> separate as well would make sense.

Yup, it might be a bit over-engineered for this code, but we are
adding the "exclusive" bit to the status[] array already, and I
think it makes sense to also have "does this give us key?" and "does
this tell us signer?" bit there.

Thanks.
