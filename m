Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F3132047F
	for <e@80x24.org>; Mon,  7 Aug 2017 14:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbdHGOmG (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 10:42:06 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35367 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdHGOmF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 10:42:05 -0400
Received: by mail-vk0-f45.google.com with SMTP id d124so2447169vkf.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 07:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6ppE81q+vnI47ec25tQLA45PpqGvvaAM2TJ3KYae8RU=;
        b=faN2gTVEFO0s44fZEYTwmvwn6dv/n2NPadN5Z37eEpQ6mzEk81MwtnOJH+5QckZiMG
         DuDQRh/7jNAJeYDr//t1tHCAARW1MYZGyUuGXZJORe92bIRRmD+KwMjwOQq1q5vPqOPJ
         vHK4vuGjUKy9xCMn3Dz1OJeOfp+wZyLZCQ97M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6ppE81q+vnI47ec25tQLA45PpqGvvaAM2TJ3KYae8RU=;
        b=f85wjkLjsr4nCMicUu7Xt4tigp1GKVaMG7nZFvn1gMEHC34A16uB20OHcl25yO/n2v
         QDsYKzu26Ms4m+WMelHO+odP4RIr74A3Wvx3HJsww/R8GAiaGzt8kF7JU0BtYIYJh6yV
         HyfgKwwD2AoLDZ0gebVG8pjeADPZP49w64iij0MVUxDxq/48UMpKAWp6RuB5m201svJA
         9T0s4TYN/cQNIeSTY3+EfytCE/GGlSObNC/qZl8WcvWQmh9jC+Xnmj6rQJ0qVqkTBLu5
         ORpUkJdOtl4j4hSfmFlfpzCpHeKrHXQMZtOSzdiOUZS45HcJHIP/sqOdayboeE379ZS6
         gPTw==
X-Gm-Message-State: AHYfb5hNwSl9nIDg8NuOA2AE4E6nI4iQRDp7RUKYyN5vK9w6WP4ZGR0A
        BNLah3zJNGXVBYuFnkcWgBGU5uBvSDc5
X-Received: by 10.31.60.78 with SMTP id j75mr516638vka.38.1502116924378; Mon,
 07 Aug 2017 07:42:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Mon, 7 Aug 2017 07:41:43 -0700 (PDT)
In-Reply-To: <CAOhB0ruYhGAyNn84ZjS7TH7QdwxNi2bPN8KFxEEBd58B9qVrmg@mail.gmail.com>
References: <CAJo=hJsOHF0KVmXvbSBiBgxq4zRdt7v7sj_GuKvcpbu8tkujFA@mail.gmail.com>
 <874ltkzlcf.fsf@gmail.com> <CAJo=hJuPwEWJEWOUpJ_T-=j0NxnzjOLy_=-qG51_zuYhKbBvrw@mail.gmail.com>
 <CAOhB0ruYhGAyNn84ZjS7TH7QdwxNi2bPN8KFxEEBd58B9qVrmg@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Mon, 7 Aug 2017 07:41:43 -0700
Message-ID: <CAJo=hJsEaKH40WnhxqvkASpiXnV8ipc+b1zrZ9VEjqRjpJ17Qg@mail.gmail.com>
Subject: Re: reftable [v5]: new ref storage format
To:     Ben Alex <ben.alex@acegi.com.au>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <David.Turner@twosigma.com>,
        Kristoffer Sjogren <stoffe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 6, 2017 at 4:37 PM, Ben Alex <ben.alex@acegi.com.au> wrote:
> Just on the LmdbJava specific pieces:
>
> On Mon, Aug 7, 2017 at 8:56 AM, Shawn Pearce <spearce@spearce.org> wrote:
>>
>> Looks pretty complete. Its a Java wrapper around the C implementation
>> of LMDB, which may be sufficient for reference storage. Keys are
>> limited to 511 bytes, so insanely long reference names would have to
>> be rejected. Reftable allows reference names up to the file's
>> `page_size`, minus overhead (~15 bytes) and value (20 bytes).
>
>
> For clarification LmdbJava code doesn't enforce a particular key size limit.
> For puts the caller nominates the size in the buffer they present for
> storage, and for get-style operations (cursors etc) the LMDB database stores
> the key size and LmdbJava adjusts the Java-visible buffer accordingly.
>
> A 511 byte key limit is specified at compile time for the native LMDB
> library. For convenience the native library is compiled for 64-bit Windows,
> Linux and Mac OS and included in the LmdbJava JAR, and this compilation is
> performed using default values (including the 511 key limit) by the
> https://github.com/lmdbjava/native project. Users can specify a different
> native library to use (eg one packaged by their OS or separately compiled
> using an LmdbJava Native-like automatic build) with a larger key size if
> they wish.
>
> As such if JGit wanted to use a longer key size, it is possible to implement
> similar automatic builds and packaging into JGit.

I don't know if we need a larger key size. $DAY_JOB limits ref names
to ~200 bytes in a hook. I think GitHub does similar. But I'm worried
about the general masses who might be using our software and expect
ref names thus far to be as long as PATH_MAX on their system. Most
systems run PATH_MAX around 1024.

The limitation of needing native JARs, and having such a low compile
time constant, may be annoying to some.

>> A downside for JGit is getting these two open source projects cleared.
>> We would have to get approval from our sponsor (Eclipse Foundation) to
>> use both lmdbjava (Apache License) and LMDB (LMDB license).
>
>
> I can't speak for the other contributors, but I'm happy to review LmdbJava's
> license if this assisted. For example changing to the OpenLDAP License would
> seem a reasonable variation given users of LmdbJava already need to accept
> the OpenLDAP License to use it. Kristoffer, do you have thoughts on this?

Thanks for considering it, but please don't change your licensing just
because of JGit. Its unlikely we can use LMDB for a lot of technical
reasons.

>> Plus it
>> looks like lmdbjava still relies on local disk and isn't giving us a
>> way to patch in a virtual filesystem the way I need to at $DAY_JOB.
>
>
> LMDB's mdb_env_open requires a const char* path, so we can pass through any
> char array desired. But I think you'll find LMDB native can't map to a
> virtual file system implemented by JVM code (the LMDB caveats section has
> further local file system considerations).

Mostly at $DAY_JOB its because we can't virtualize the filesystem
calls the C library is doing.

In git-core, I'm worried about the caveats related to locking. Git
tries to work nicely on NFS, and it seems LMDB wouldn't. Git also runs
fine on a read-only filesystem, and LMDB gets a little weird about
that. Finally, Git doesn't have nearly the risks LMDB has about a
crashed reader or writer locking out future operations until the locks
have been resolved. This is especially true with shared user
repositories, where another user might setup and own the semaphore.
