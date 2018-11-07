Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B8341F453
	for <e@80x24.org>; Wed,  7 Nov 2018 00:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388718AbeKGJ7F (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 04:59:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40468 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388491AbeKGJ7F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 04:59:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id i17-v6so15546016wre.7
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 16:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lMD4w3NkEzs6L3vmtzxt3arsrj6iqrbRVhbHxPocha0=;
        b=IcnP2pNxLTd8/qVWtGxt5p9Fjiek9dM8MoPK7qCSJkOXD9cwpPhCHM1C/3AavxmN91
         9BpO15FojLlffKUkwPLBWnPPewSB2bM5wCsZZTAGNk0dn+tJP9NMI/JjCniFbKUM9dyo
         okjyEzax4saIw33Fpm2zzN88bBEEL9nbkbjJ9ao1vnt13cEkFflSxnYnqetYuw3jaJy1
         CwNZ5ulBd3YnFBoE69wHjIPhYQAQfsYRclluqrG+a5AwM1+P95Trw9iKA8P4IACzALK1
         z/lBVr1mWCGMl2cp47K0MXTzRvCkm7K26dUHC9nQAheP6sDHIgC8zMJNd8Z7rH3K5phz
         iF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lMD4w3NkEzs6L3vmtzxt3arsrj6iqrbRVhbHxPocha0=;
        b=DVuTcnP5q0Ho2d5NWEFmurd5ylyRQYSx+mgXYrcDtAZrBRMB43tP4OIa3cOKVPRwop
         ZpSRcQ9nl3DakjGHF+afR5kB1RLNoFClCvhUikiNib+PE8BorxaWgEUwKsfeCymXT06W
         VvV8xdWTQkQEc9q1ZDcLI990kz2Xs/16tc3n9tWA1+UF0hlQsYLk9+AgxRMwkGBj9NiN
         NoOs4mFp5ooZDveCgnJV2nbQNNmgTBF+8bPXgdfEeHwEVQn7CsJ/u3OXXWK6ibIIypFc
         cZxBpheE9mHSlEIwzkHbMNnzvGRz0s/Xp69RZM+kzTEWwqtZf3Q1Qd5eg41Bxjlk/05F
         8aAQ==
X-Gm-Message-State: AGRZ1gILmnltBjjeCx9c+mtL56QwXrl5if5NXRHOryqQ0qpR8IjP/mrR
        jzS/McsheP/XP9C+0kY/L+0=
X-Google-Smtp-Source: AJdET5ekKEyUz8I4w8dsL71WZc7MrejdsiX6uHG49TNZgH4POxFZTzxmZaRouQDztAjtoS4X4bmyQQ==
X-Received: by 2002:a5d:4907:: with SMTP id x7-v6mr24551365wrq.272.1541550669200;
        Tue, 06 Nov 2018 16:31:09 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g1-v6sm2924837wmg.2.2018.11.06.16.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 16:31:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        andals@crustytoothpaste.net,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH/RFC] Support --append-trailer in cherry-pick and revert
References: <20181104181026.8451-1-pclouds@gmail.com>
        <20181106171637.15562-1-pclouds@gmail.com>
Date:   Wed, 07 Nov 2018 09:31:07 +0900
In-Reply-To: <20181106171637.15562-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 6 Nov 2018 18:16:37 +0100")
Message-ID: <xmqq4lctenjo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> OK here is a less constroversal attempt to add new trailers. Instead
> of changing the default behavior (which could be done incrementally
> later), this patch simply adds a new option --append-trailer to revert
> and cherry-pick.

I almost agree, except that the the textual description in a revert
and the funny-looking trailer-wannabe in a cherry-pick are two
fundamentally different things, and adding duplicate to the latter
does not make much sense, while keeping both does make sense for the
former.

> PS. maybe --append-trailer is too generic? We have --signoff which is
> also a trailer. But that one carries more weights than just "machine
> generated tags".

> +		if (opts->append_trailer) {
> +			strbuf_addstr(&msgbuf, "\n");
> +			if (parent_id != -1)
> +				strbuf_addf(&msgbuf, "Reverts: %s~%d\n",
> +					    oid_to_hex(&commit->object.oid),
> +					    parent_id);
> +			else
> +				strbuf_addf(&msgbuf, "Reverts: %s\n",
> +					    oid_to_hex(&commit->object.oid));
> +		}

Makes sense, I guess.

> @@ -1780,14 +1792,28 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  		if (find_commit_subject(msg.message, &p))
>  			strbuf_addstr(&msgbuf, p);
>  
> -		if (opts->record_origin) {
> +		if (opts->record_origin || opts->append_trailer) {
>  			strbuf_complete_line(&msgbuf);
>  			if (!has_conforming_footer(&msgbuf, NULL, 0))
>  				strbuf_addch(&msgbuf, '\n');
> +		}
> +
> +		if (opts->record_origin) {
>  			strbuf_addstr(&msgbuf, cherry_picked_prefix);
>  			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
>  			strbuf_addstr(&msgbuf, ")\n");
>  		}
> +		if (opts->append_trailer) {

These should be either-or, I would think, as adding exactly the same
piece of information in two different machine-readable form does not
make much sense.  The command line parser may even want to make sure
that both are not given at the same time.

Alternatively, we can keep using -x as "we are going to record where
the change was cherry-picked from" and use .record_origin to store
that bit, and use the new .append_trailer bit as "if we are recording
the origin, in which format between the old and the new do we do
so?" bit.

I think the latter makes more sense, at least to me.


> +			if (opts->record_origin)
> +				strbuf_addstr(&msgbuf, "\n");
> +			if (parent_id != -1)
> +				strbuf_addf(&msgbuf, "Cherry-picked-from: %s~%d\n",
> +					    oid_to_hex(&commit->object.oid),
> +					    parent_id);
> +			else
> +				strbuf_addf(&msgbuf, "Cherry-picked-from: %s\n",
> +					    oid_to_hex(&commit->object.oid));
> +		}
