Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15E0B1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 17:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933678AbeGIReK (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 13:34:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50802 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933537AbeGIReI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 13:34:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id v25-v6so22005774wmc.0
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 10:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CWLt3ontvgqai584asSkN/V9ZI4bEDERryr2Tr5v+5E=;
        b=S2LwRYi/5HJC1a5MMTEwZKqBHep7PflKcd2gE4ZOsmoNcxCPhBYxl/M5lBEILOmaQu
         6Hsi+JXAaWltsP4rasc+H0hw/Xx1p1oB6yr0rGufPiwuUULwe69Vs1sZG/YRibYDbulc
         gTbDKRLrku45Nklh4gstDFQOKJtRaEILXycG4E20mpr5LxKwYobqn74/AqGssrbhI5lf
         OdXtnauAXk3bp+B1gCoJ5CG7+8XDbnScWgSZUVy9P9NhL/JtQYHcg3Jnje64gukmu/CR
         Q+vKxuHFtfkmoxpZhCXFQKMIbcuQBL2peMNrVU11EB0gL9ORRptSuray9apYbAdcp0Bj
         pgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CWLt3ontvgqai584asSkN/V9ZI4bEDERryr2Tr5v+5E=;
        b=GjOYgTL+DOwHI3scmB60WwZ2y9imd19oLwUfxMVigKH8UjRj62m3PjV5/NAfKEnfZd
         cy1AbFcZpXpWzim0N6yzEuhOK8sk4oz719Luut9Di+s26n9IaxVGduEqfPD8qVJNDYxg
         jkLbFTJM8DV+DryiGmGOTtfVXmUfZfkMwvzw8mwbZxGkB436kZrxh05YbTmEgq3XYGzR
         EnwQAmRwiVotegzmsAvxRGpqtSqYbTSJCUz1pHv7BUEnC4Z+yNzevoK1rUQt86d6vZFw
         gzZf3t+iuu8mFkwoXK+YmoUvj+0lDJTt+Ia4UquxQCElsH7bl5VEDMKV6I0bBLYEaAPi
         kWtQ==
X-Gm-Message-State: APt69E2pLmDdKLxWFOI6QnaZzuk1jtX0KAT68nZRL3NWkRcubIOqkGD9
        oNYKQrdRZX1H1tqgCc3kSE0=
X-Google-Smtp-Source: AAOMgpeMNxyHX4xpqVgYxrJQgl2sZHaZSCEmfhNNm4ItBYEdKW4LgeMyKpswz7D5UEeY/eHteQlxjg==
X-Received: by 2002:a1c:b94c:: with SMTP id j73-v6mr13848391wmf.104.1531157647478;
        Mon, 09 Jul 2018 10:34:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q8-v6sm30377384wmb.3.2018.07.09.10.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 10:34:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/17] commit: increase commit message buffer size
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
        <20180708233638.520172-8-sandals@crustytoothpaste.net>
        <4eb44f33-ac9c-7ce2-0e53-ec6fcb4560fd@gmail.com>
        <CAGZ79kaJKjWj9SY-cZYYcKShuooh3nuRqf26CzhCsusTXX42NA@mail.gmail.com>
        <20180709172716.GA81741@google.com>
Date:   Mon, 09 Jul 2018 10:34:06 -0700
In-Reply-To: <20180709172716.GA81741@google.com> (Brandon Williams's message
        of "Mon, 9 Jul 2018 10:27:16 -0700")
Message-ID: <xmqqzhz0e2k1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> > > diff --git a/refs/files-backend.c b/refs/files-backend.c
>> > > index a9a066dcfb..252f835bae 100644
>> > > --- a/refs/files-backend.c
>> > > +++ b/refs/files-backend.c
>> > > @@ -1587,7 +1587,7 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
>> > >       char *logrec;
>> > >
>> > >       msglen = msg ? strlen(msg) : 0;
>> > > -     maxlen = strlen(committer) + msglen + 100;
>> > > +     maxlen = strlen(committer) + msglen + 200;
>> > >       logrec = xmalloc(maxlen);
>> > >       len = xsnprintf(logrec, maxlen, "%s %s %s\n",
>> > >                       oid_to_hex(old_oid),
>> >
>> > nit: 100 is not enough anymore, but wasn't a very descriptive value. 200
>> > may be enough now, but I'm not sure why.
>> 
>> That line was touched in by Michael in 7bd9bcf372d (refs: split filesystem-based
>> refs code into a new file, 2015-11-09) and before that by Ronnie in 2c6207abbd6
>> (refs.c: add a function to append a reflog entry to a fd, 2014-12-12)
>> and introduced
>> by Junio in 8ac65937d03 (Make sure we do not write bogus reflog
>> entries., 2007-01-26)
>> and it appears to me that 2*40 + 5 ought to be sufficient, but no
>> comments or commit
>> messages are found as to why we rather choose 100.
>
> Whats the reason for not using a strbuf here so that we don't have to
> play with magic numbers?

Quite a legitimate question.  

I suspect that the reason is because the code (even though it now
sits in a file that was relatively recently creted) predates either
the introduction or wide adoption of strbuf.

Back when 6de08ae6 ("Log ref updates to logs/refs/<ref>",
2006-05-17) was done, we already had strbuf.c, but it only had
read_line() and nothing else back then, so it wouldn't have been
possible to use a strbuf there.


