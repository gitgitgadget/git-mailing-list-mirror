Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 906291F404
	for <e@80x24.org>; Fri, 23 Feb 2018 19:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754658AbeBWTaQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 14:30:16 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33416 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754646AbeBWTaL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 14:30:11 -0500
Received: by mail-wr0-f196.google.com with SMTP id s5so15208059wra.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 11:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=c3LYKPlMUn1+SLDgdhOBqWByzU3xeHNCmPBM9TVFvP8=;
        b=MJWT3hh7Cu+i2Rk8QHnAmQseCpjhdc7SYwkk0th5tmtS5V5McvTpoI5Bmpkc2ESms+
         TP3gD0fzXMAoym4AYfRIw0za+SjDUkKocUW7U+WAK4EtkyEZ5iWzQ/Qu6keezFwuPqki
         QHDrf+cIGO5MSUx0hF1IDaqnddSW7kicSQ5WbT5/FNAZHU4FrvJr6dKSw9i0aSXAdrf8
         MRxfMSqM5tCwBb4jF1W/7D4yJxjvZ2WIJbyUDcFRuIcu4mZjZCM+7d0SMhNZaSYSPl6J
         1gL/FhEsXcEiPi3FioEWCsvE5+OYXPfmyWFpdZbSQ7WfOkb8gaLglznR6tXCq9Qnhuj8
         E88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=c3LYKPlMUn1+SLDgdhOBqWByzU3xeHNCmPBM9TVFvP8=;
        b=jvQch9NAA8+Z21ReXRdVdQPcZSUlIGAzmyeSg5mFxbzdDeuPUxQIKhJJLPRAfyUYtc
         XDX1fKxCdmp1qAvvDLPp8287oYxOPXeOWigWGZD9+jluvEk7Z7TyfhO9nl9GwAy5NrXR
         CETSonWhv+RgPN2vCiWe4nKfdYwr86ojo8PZxJduxR5VnQ2+KM1ycxumvzUZjggHJ01e
         1upWIhpWqNeCNZwd8V5FSeKsG3JL61yP0k+AR3Xt0RMis55iZ3izEp86dZgYOFhiJ29L
         ulbquUgfmJ7LctnYCsPMYSIGn8++gLjVN+1Mc1T7B9OXKBf/OS8RQ5aFj9I/mqbaLq++
         /Wcg==
X-Gm-Message-State: APf1xPBisG5/lNRzY615/BGNL7YTh8cc9CIW7LPkQYjAkki6pK6ticZj
        Cs/0/CuqbdqXNY33fuxXCvo=
X-Google-Smtp-Source: AH8x225f7A+bweeWvoYk9rdrvty50fe5FgniSSaRHIF4NlQTNccLMBhZNldujfyLdKz+/VfPoj7lLQ==
X-Received: by 10.223.144.163 with SMTP id i32mr2787700wri.73.1519414208942;
        Fri, 23 Feb 2018 11:30:08 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 77sm3229837wmu.17.2018.02.23.11.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 11:30:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 04/13] commit-graph: implement write_commit_graph()
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-5-git-send-email-dstolee@microsoft.com>
        <xmqqmv031d7d.fsf@gitster-ct.c.googlers.com>
        <4d453f29-8e5b-2a98-ab11-415f63613be8@gmail.com>
Date:   Fri, 23 Feb 2018 11:30:07 -0800
In-Reply-To: <4d453f29-8e5b-2a98-ab11-415f63613be8@gmail.com> (Derrick
        Stolee's message of "Fri, 23 Feb 2018 12:23:26 -0500")
Message-ID: <xmqqsh9rtsg0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> jt/binsearch-with-fanout introduces one when there is a 256-entry
> fanout table (not the case here).
>
> The bsearch() method in search.h (and used in
> pack-write.c:need_large_offset) does not return the _position_ of a
> found element.
>
> Neither of these suit my needs, but I could just be searching for the
> wrong strings. Also, I could divert my energies in this area to create
> a generic search in the style of jt/binsearch-with-fanout.

... me goes and digs ...

What I had in mind was the one in sha1-lookup.c, actually.  Having
said that, hand-rolling another one is not too huge a deal;
eventually people will notice and consolidate code after the series
stabilizes anyway ;-)

>>> +				num_large_edges++;
>>> +				parent = parent->next;
>>> +			} while (parent);
>> It feels somewhat wasteful to traverse the commit's parents list
>> only to count, without populating the octopus table (which I
>> understand is assumed to be minority case under this design).
>
> Since we are writing the commit graph file in-order, we cannot write
> the octopus table until after the chunk lengths are known.

Oh, my "minority case" comment was me wondering "since we expect
there are only a few, why not keep them in memory while we discover
them here, so that the writing phase that come later do not have to
go through all commits again counting their parents?  would it be
more performant and a better trade-off?"  We can certainly do such
an optimization later (iow, it is not all that crucial issue and
certainly I didn't mention the above as something that needs to be
"fixed"--there is nothing broken).

> store the octopus table in memory and then dump it into the file
> later, but walking the parents is quite fast after all the commits are
> loaded. I'm not sure the time optimization merits the extra complexity
> here. (I'm happy to revisit this if we do see this performance
> lacking.)
>
> P.S. I really like the name "octopus table" and will use that for
> informal discussions of this format.

I actually do not mind that name used as the official term.  I find
it far more descriptive and understandable than "long edge" / "large
edge" at least to a Git person.

> You're right that int_id isn't great, and your more-specific
> "oid_table_pos" shows an extra reason why it isn't great: when we add
> the GRAPH_LAST_EDGE bit or set it to GRAPH_PARENT_MISSING, the value
> is NOT a table position.

Perhaps I am somewhat biased, but it is quite natural for our
codebase and internal API to say something like this:

    x_pos(table, key) function's return value is the non-negative
    position for the key in the table when the key is there; when it
    returns a negative value, it is (-1 - position) where the "position"
    is the position in the table they key would have been found if
    it was in there.

and store the return value from such a function in a variable called
"pos".  Surely, sometimes "pos" does not have _the_ position, but
that does not make it a bad name.

Saying "MISSING is a special value that denotes 'nothing is here'"
and allowing it to be set to a variable that meant to hold the
position is not such a bad thing, though.  After all, that is how
you use NULL as a special value for a pointer variable ;-).

Same for using the high bit to mean something else.  Taking these
together you would explain "low 31-bit of pos holds the position for
the item in the table.  MISSING is a special value that you can use
to denote there is nothing.  The LAST_EDGE bit denotes that one
group of positions ends there", or something like that.

> I think the current name makes the following call very clear:

It is still a strange name nevertheless.

>>> +char *write_commit_graph(const char *obj_dir)
>>> +{
>>> +	struct packed_oid_list oids;
>>> +	struct packed_commit_list commits;
>>> +	struct sha1file *f;
>>> +	int i, count_distinct = 0;
>>> +	DIR *info_dir;
>>> +	struct strbuf tmp_file = STRBUF_INIT;
>>> +	struct strbuf graph_file = STRBUF_INIT;
>>> +	unsigned char final_hash[GIT_MAX_RAWSZ];
>>> +	char *graph_name;
>>> +	int fd;
>>> +	uint32_t chunk_ids[5];
>>> +	uint64_t chunk_offsets[5];
>>> +	int num_chunks;
>>> +	int num_long_edges;
>>> +	struct commit_list *parent;
>>> +
>>> +	oids.nr = 0;
>>> +	oids.alloc = (int)(0.15 * approximate_object_count());
>> Heh, traditionalist would probably avoid unnecessary use of float
>> and use something like 1/4 or 1/8 ;-)  After all, it is merely a
>> ballpark guestimate.
>>
>>> +	num_long_edges = 0;
>> This again is about naming, but I find it a bit unnatural to call
>> the edge between a chind and its octopus parents "long".  Individual
>> edges are not long--the only thing that is long is your "list of
>> edges".  Some other codepaths in this patch seems to call the same
>> concept with s/long/large/, which I found somewhat puzzling.
>
> How about "num_extra_edges"...

Yes, "extra" in the name makes it very understandable.

