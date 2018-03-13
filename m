Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474F81F404
	for <e@80x24.org>; Tue, 13 Mar 2018 21:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeCMVmj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 17:42:39 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:53375 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeCMVmi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 17:42:38 -0400
Received: by mail-wm0-f44.google.com with SMTP id e194so638980wmd.3
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mZAU1N9WQqsJmbtxYHJWNKaxMzrdX7N/wO4TyGQMLCI=;
        b=n2yUKmYQLHstZ+80TkNv55Trk7HYhUh/Ayr0bV4XxbdLLjWiXdul1DUM5/oyBBpAbp
         HMweO5Vh+Y5Tc0Ffw/O3xSxOwBeB6fQu4kuY36RXC9Ct0Uw6vs9NI5mDy1lqMK5TYeYw
         curbC7VuKIaFbrSpOkyo4UI/0Jot2/vvgCcTLfp3dSKB3YkCsItUhvxH0hsjIWjHZjFX
         jqNsVK0IONIw0C12gu5AzhsvYALs79wBdp+ccDQjjj9n10jkmt0A4I/TeUjp+1BO8XJc
         7R7iNfb7/t60IDuiBB0DNgVs0fGzSK4evjZzfcuN8gZxSF2SZBGtMpmwu8JfG8SXSBHF
         2BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mZAU1N9WQqsJmbtxYHJWNKaxMzrdX7N/wO4TyGQMLCI=;
        b=Y0C64j+b4pNsJ4+sTFENnUVTqugF/2kW5Xx7B5ib5quxrnu+9+ETQKo2QejQZ33itw
         cvMbtAApqmNF96NVXOyT0++bIh/6+IFMSlOmMbnnDSExJi3ng6gpcOWcc7OaUjPXhv76
         vqH+iiCwqVa9MK30rBgFyG+7zzFkrCqbOOVpiX+N9fmQE3btNV6Ot9pcwQGRgLc3gu70
         B+qDDHy9nbsDz7Y7+cfwI9tJY4SvkiEMALZo0iKBEosCddY0PhvRpFEwFNV9YoBu5iWa
         kVndrUwmCBT+7coPeOPuSyEYg1zz2o/tGH3GMSsTSF90U/fqTBmHoY21vE6wqEV4Ge8w
         769g==
X-Gm-Message-State: AElRT7FUnp9bq7LFis6hRkiUzMHym0lciEIojpCo/QrlBMvZMJC8ofwg
        Lt424kxAA1pY5i9CMw4yxMjQViYp
X-Google-Smtp-Source: AG47ELuIus+UqoN8K01ziQJhGiwiB55KD/fWsnomEdbFs8btebxjhbYQrZBqd5IR42SN96Yp7mP1Gw==
X-Received: by 10.28.28.208 with SMTP id c199mr467281wmc.150.1520977356054;
        Tue, 13 Mar 2018 14:42:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z73sm1402953wrb.50.2018.03.13.14.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 14:42:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 04/13] csum-file: add CSUM_KEEP_OPEN flag
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
        <1519698787-190494-5-git-send-email-dstolee@microsoft.com>
        <e1264d9a-9d6c-b294-6d56-46382a28b280@gmail.com>
Date:   Tue, 13 Mar 2018 14:42:34 -0700
In-Reply-To: <e1264d9a-9d6c-b294-6d56-46382a28b280@gmail.com> (Derrick
        Stolee's message of "Mon, 12 Mar 2018 09:55:45 -0400")
Message-ID: <xmqqsh931wl1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 2/26/2018 9:32 PM, Derrick Stolee wrote:
>> This patch is new to the series due to the interactions with the lockfile API
>> and the hashfile API. I need to ensure the hashfile writes the hash value at
>> the end of the file, but keep the file descriptor open so the lock is valid.
>>
>> I welcome any susggestions to this patch or to the way I use it in the commit
>> that follows.
>>
>> -- >8 --
>
> I haven't gotten any feedback on this step of the patch. Could someone
> take a look and let me know what you think?

Let's follow the commit-graph writing codepath to see what happens:

	fd = hold_lock_file_for_update(&lk, graph_name, 0);
	...
	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);

The caller creates a lockfile, and then wraps its file descriptor in
a hashfile.

	hashwrite_be32(f, GRAPH_SIGNATURE);
	...

Then it goes on writing to the hashfile, growing the lockfile.

        ...
	write_graph_chunk_large_edges(f, commits.list, commits.nr);

	close_commit_graph();

And after writing all data out (oh by the way, why aren't we passing
commit_graph instance around and instead relying on a file-scope
static global?)...

	hashclose(f, final_hash, CSUM_CLOSE | CSUM_FSYNC | CSUM_KEEP_OPEN);

We ask for the final hash value to be written to the file (and also
returned to us---although you do not seem to use that at all).  See
a comment on this, though, at the end.

	commit_lock_file(&lk);

And then, we put the lockfile to its final place, while closing its
file descriptor.

The overall API sounds sensible, from the above.

However.

The function whose name is hashclose() that takes a flag word whose
possible bit value includes "Please close this thing" feels strange
enough (does it mean the hashclose() function does not close it if
CSUM_CLOSE is not given?), but adding another to the mix that lets
us say "Please close this (with or without FSYNC), oh by the way
please leave it open" feels a bit borderline to insanity.

I _think_ the word "close" in the name hashclose() is about closing
the (virtual) stream for the hashing that is overlayed on top of the
underlying file descriptor, and being able to choose between closing
and not closing the underlying file descriptor when "closing" the
hashing layer sort of makes sense.  So I won't complain too much
about hashclose() that takes optional CSUM_CLOSE flag.

But then what does it mean to give KEEP_OPEN and CLOSE together?

The new caller (which is the only one that wants the nominally
nonsensical CLOSE|KEEP_OPEN combination, which is shown above) wants
the final checksum of the data sent over the (virtual) stream
computed and written, and the file descriptor fsync'ed, but the file
descriptor kept open.  As we _DO_ want to keep the verbs in flags
CSUM_CLOSE and CSUM_FSYNC to be about the underlying file
descriptor, I think your new code for KEEP_OPEN that is inside the
if() block that is for CSUM_CLOSE is an ugly hack, and your asking
for improvements is very much appreciated.

Let's step back and see what different behaviours the existing code
wants to support before your patch:

    - hashclose() is always about finializing the hash computation
      over the data sent through the struct hashfile (i.e. the
      virtual stream opened by hashfd()).  The optional *result can
      be used to receive this hash value, even when the caller does
      not want to write that hash value to the output stream.

    - when CSUM_CLOSE is given, however, the hash value is written
      out as the trailing record to the output stream and the stream
      is closed.  CSUM_FSYNC can instead be used to ensure that the
      data hits the disk platter when the output stream is closed.

    - when CSUM_CLOSE nor CSUM_FSYNC is not given, hash value is not
      written to the output stream (the caller takes responsibility
      of using *result), and the output stream is left open.

I think the first mistake in the existing code is to associate
"close the underlying stream" and "write the hash out to the
underlying stream" more closely than it should.  It should be
possible to "close the underlying steam" without first writing the
hash out to the underlying stream", and vice versa.

IOW, I think

        hashclose() {
                hashflush();
                the_hash_algo->final_fn();
                if (result)             
                        hashcpy(result, f->buffer);
        +       if (flags & CSUM_HASH_IN_STREAM)
        +               flush(f, f->buffer, the_hash_algo->rawsz);
        +       if (flags & CSUM_FSYNC)
        +               fsync_or_die();
                if (flags & (CSUM_CLOSE | CSUM_FSYNC)) {
        -               flush();                
        -               if (flags & CSUM_FSYNC)
        -                       fsync_or_die();
                        if (close(f->fd))
                                die_errno();
                        fd = 0;
                } else
                        fd = f->fd;
                if (0 <= f->check_fd) {
                        ...
                }
                free(f);
                return fd;
        }

with would be a good first "preliminary preparation" step.

Existing callers that pass CSUM_FSYNC or CSUM_CLOSE now need to also
say "I want the resulting hash in the output stream", but that
allows your later caller to omit CSUM_CLOSE and then ask for
HASH_IN_STREAM alone.

Existing callers can expect that FSYNC alone means fsync and close,
but your caller wants hashclose() to compute the hash, write the hash
to the output stream, and fsync the output stream, and return
without closing the output stream.  For that, you'd make FSYNC not
to imply CLOSE, and you'd need to vet all the existing callers that
use FSYNC are OK with such a change.  And then the above would
become

        hashclose() {
                hashflush();
                the_hash_algo->final_fn();
                if (result)             
                        hashcpy(result, f->buffer);
                if (flags & CSUM_HASH_IN_STREAM)
                        flush(f, f->buffer, the_hash_algo->rawsz);
                if (flags & CSUM_FSYNC)
                        fsync_or_die();
                if (flags & CSUM_CLOSE) {
                        if (close(f->fd))
                                die_errno();
                        fd = 0;
                } else
                        fd = f->fd;
                if (0 <= f->check_fd) {
                        ...
                }
                free(f);
                return fd;
        }

Once we reach that state, the new caller in write_commit_graph()
does not have to pass nonsensical CLOSE|KEEP_OPEN combination.
Instead we can do

	hashclose(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);

or something like that, I would think, without having KEEP_OPEN.

I am actually wondering if it is worth making CSUM_FSYNC not imply
CSUM_CLOSE.  There aren't that many existing callers of hashclose()
that uses FSYNC, so vetting all of them and replacing their FSYNC
with (FSYNC|CLOSE) is not all that difficult, but if this new caller
is an oddball then another strategy may be to do the fsync_or_die()
on the caller side, something like:

                hashclose(f, NULL, CSUM_HASH_IN_STREAM);
        +       fsync_or_die(fd, get_lock_file_path(&lk));
                commit_lock_file(&lk);

And then we can keep the "FSYNC means fsync and then close" the
current set of callers rely on.  I dunno if that is a major issue,
but I do think "close this, or no, keep it open" is far worse than
"do we want the resulting hash in the stream?"

An alternative design of the above is without making
CSUM_HASH_IN_STREAM a new flag bit.  I highly suspect that the
calling codepath _knows_ whether the resulting final hash will be
written out at the end of the stream or not when it wraps an fd with
a hashfile structure, so "struct hashfile" could gain a bit to tell
hashclose() whether the resulting hash need to be written (or not).
That would be a bit larger change than what I outlined above, and I
do not know if it is worth doing, though.



