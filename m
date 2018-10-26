Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E6931F453
	for <e@80x24.org>; Fri, 26 Oct 2018 20:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbeJ0FRP (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 01:17:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37194 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeJ0FRP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 01:17:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id c15-v6so2396943eds.4
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JB5YOEhkdvMOieGyCp4dXJU6qUG7p1drThS4ypUbU60=;
        b=XZEgdQe4fIrUa884dqv9NIcmQkhunCHPDNs7KYaCd1LGUC5hxjYVRp2EqdyVFr7guS
         ehAHADIehsKAJDTkoDBjCDQ5Z/asGV5svnXlUOy3P2lSmIQ0FPIdJM78yBDWfhQ8eWZs
         gRTazGKGXp1j4CeMynctGkpqF4vUQrjJ3ytResl9l7wc3cTKAB4Qc65AukwlA9RRqUua
         KGCK9WIu3odATddlvmm5LwRnVduEnWSOOB4lnxEhZPmgO0JGsFBCnb/lKalItOzzeU40
         +CsbW0eCAIVR/OkgYRv9lardtv3kzzWwspN3CkbwkoEdSictbgE0k+mLZSvVGHdvsMmL
         UgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=JB5YOEhkdvMOieGyCp4dXJU6qUG7p1drThS4ypUbU60=;
        b=oadSQqeN2asKOp9AeSwt/avxb6BexIfpUR4zFmo9LGAaRltEFhvnVb1LKDqiaRTEmV
         vXKvhDRIrGHz2g8IGxvZsufaZcGKXdk6IFvyO5tnd3ToTv8ueqVLVthZ73rE2lDQr3wW
         986vlvy1TYdY2b1e7Vu1Os5un47YVLGv5ASzhrrsyumPRgSiSxOEtVhhF7tkUZeVtY0P
         lr/g10WqzzIJLgo7/jI5M9MIwNQ0Dzkitt/R5BTkTMbrWdADvf0EKog9pmwqA1N+h4pH
         3d/zwdYg+FmZgpgUmZijHLzFig7Y1Cd5chp9v558Wg0Rj0FOSwJ7lEDuk2pPcRbHfL4h
         SDGg==
X-Gm-Message-State: AGRZ1gJAsJut+hERVml7ujxewzN4ONtXI8rNQzb+V/Q87GCWeIZZxr2z
        i+eeheGBJbkMhbKuFs9bwd4=
X-Google-Smtp-Source: AJdET5deekHRMsYbDywnBeI6ZrZJCKGkf8IzQss6zgZRMjDotzxT18TMisIbFejXBLH0uLe1h0dW6Q==
X-Received: by 2002:a17:906:1551:: with SMTP id c17-v6mr3463413ejd.32.1540586324660;
        Fri, 26 Oct 2018 13:38:44 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id b18-v6sm2386537eju.38.2018.10.26.13.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 13:38:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Jansen\, Geert" <gerardu@amazon.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com> <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 26 Oct 2018 22:38:42 +0200
Message-ID: <87o9bgl9yl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 26 2018, Junio C Hamano wrote:

> "Jansen, Geert" <gerardu@amazon.com> writes:
>
>> The index-pack command determines if a sha1 collision test is needed by
>> checking the existence of a loose object with the given hash. In my tests, I
>> can improve performance of “git clone” on Amazon EFS by 8x when used with a
>> non-default mount option (lookupcache=pos) that's required for a Gitlab HA
>> setup. My assumption is that this check is unnecessary when cloning into a new
>> repository because the repository will be empty.
>
> My knee-jerk reaction is that your insight that we can skip the "dup
> check" when starting from emptiness is probably correct, but your
> use of .cloning flag as an approximation of "are we starting from
> emptiness?" is probably wrong, at least for two reasons.
>
>  - "git clone --reference=..." does not strictly start from
>    emptiness, and would still have to make sure that incoming pack
>    does not try to inject an object with different contents but with
>    the same name.
>
>  - "git init && git fetch ..." starts from emptiness and would want
>    to benefit from the same optimization as you are implementing
>    here.
>
> As to the implementation, I think the patch adjusts the right "if()"
> condition to skip the collision test here.
>
>> -	if (startup_info->have_repository) {
>> +	if (startup_info->have_repository && !cloning) {
>>  		read_lock();
>>  		collision_test_needed =
>>  			has_sha1_file_with_flags(oid->hash, OBJECT_INFO_QUICK);
>
> I just do not think !cloning is quite correct.

Geert: Thanks for working on this. A GitLab instance I'm involved in
managing at work has suffered from this issue, e.g. with "fork" being a
"clone" under the hood on GitLab, and taking ages on the NetApp NFS
filer due to this issue, so I'm very interested in this moving forward.

But as Junio notes the devil's in the details, another one I thought of
is:

    GIT_OBJECT_DIRECTORY=/some/other/repository git clone ...

It seems to me that it's better to stick this into
setup_git_directory_gently() in setup.c and check various edge cases
there. I.e. make this a new "have_object_already" member of the
startup_info struct.

That would be set depending on whether we find objects/packs in the
objects dir, and would know about GIT_OBJECT_DIRECTORY (either just
punting, or looking at those too). It would also need to know about
read_info_alternates(), depending on when that's checked it would handle
git clone --reference too since it just sets it up via
add_to_alternates_file().

Then you'd change sha1_object() to just check
startup_info->have_objects_already instead of
startup_info->have_repository, and since we'd checked "did we have
objects already?" it would work for the init && fetch case Junio
mentioned.

It would also be very nice to have a test for this, even if it's
something OS-specific that only works on Linux after we probe for
strace(1).

Testing (without your patch, because git-am barfs on it , seems to
dislake the base64 encoding):

    rm -rf /tmp/df; strace -f git clone --bare git@github.com:git/git.git /tmp/df 2>&1 | grep '".*ENOENT' 2>&1|perl -pe 's/^.*?"([^"]+)".*/$1/'|sort|uniq -c|sort -nr|less

I see we also check if packed-refs exists ~2800 times, and check for
each ref we find on the remote. Those are obviously less of a
performance issue when cloning in the common case, but perhaps another
place where we can insert a "don't check, we don't have anything
already" condition.
