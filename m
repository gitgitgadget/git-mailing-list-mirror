Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49FDF1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 17:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeCNRAK (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 13:00:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55246 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeCNRAH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 13:00:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id h76so5462982wme.4
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uJ/hgTfkax2BxS/bTLZNV46Z9UTgulIRH/fxhm7dFx0=;
        b=FdSDzLbYXAKM+7IYfXm1NGSa5EqX3QcDRYFcb7ayNZLm4VvjcwjOWRT4gpoPRjtQnj
         ytXGBpkyru7jvayANarnwsr3x5cUbuENkGd3GWkSRws3eRGpmZ272073FS1x5Ru82pqK
         frL0Mbk/vzXK9flejt+VJ+Z8BN59eKXzv9CB7UDmbEKfysKZ3dLIjQx6aq34hGvXaodz
         kdzoOFvNNVBMUqiiHIW511zSTs/dQKa+TdQXA02n/+0etjaShWPaFX2NDOwulMbv6uHC
         bd8+3DjmZSVQud9NXtz+bgswxYFuRoCTnkJYtpTwVDDgorp6LwZtZ0lRajceG+lTM1Ow
         TZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uJ/hgTfkax2BxS/bTLZNV46Z9UTgulIRH/fxhm7dFx0=;
        b=UaiApDhCamz7Jve5bTlXpR//hAeTk7/RglaQL536TKwep9JB2W+b43hlCg/8l8jJ+w
         AIlp0n6LXJv3HB1RXyxvPttLO5B1X2cN75dGNmMQF4QdiHd6Ze+HBn8LrCWxbzdGEiFQ
         dGI2mWRsdd/ccqZqWci/osA2yl3iYCUI5B7O78ssGo6VBiFb6LCVYhxoVyoZxuO/uVYi
         Iw+W8MAaofkjhCMLN/PyOmDcjhxh1UXYLbmk7S2g4ChyfZ1MFOAgsXZOxZbKTgzmTGX4
         LTOyBn88TGOomIot7dpioZV6cs5ZSVAkIsThyM0Bf28z2g1KU+q+KhMGSS9Z7r1T9PZU
         uRTg==
X-Gm-Message-State: AElRT7GeGK7+Lmv7e86prjUnB0SvepPeNEjAC3Ma8nGi5Dmk8rYJG9Pf
        XTVJDKMpegC7eJc/6AgS1u0=
X-Google-Smtp-Source: AG47ELtgWf/b64qjQTdwvDdW4QyWV3Z0Ln+Bugj3pxz2QlR+tY4YHAcNy0WIAhaqBqBMVV8OaX6Xnw==
X-Received: by 10.28.52.9 with SMTP id b9mr2445113wma.134.1521046805621;
        Wed, 14 Mar 2018 10:00:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p21sm1644268wmc.0.2018.03.14.10.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 10:00:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 04/13] csum-file: add CSUM_KEEP_OPEN flag
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
        <1519698787-190494-5-git-send-email-dstolee@microsoft.com>
        <e1264d9a-9d6c-b294-6d56-46382a28b280@gmail.com>
        <xmqqsh931wl1.fsf@gitster-ct.c.googlers.com>
        <9d491d74-87e5-e6b7-362f-c5f166b3ea35@gmail.com>
Date:   Wed, 14 Mar 2018 10:00:04 -0700
In-Reply-To: <9d491d74-87e5-e6b7-362f-c5f166b3ea35@gmail.com> (Derrick
        Stolee's message of "Tue, 13 Mar 2018 22:26:23 -0400")
Message-ID: <xmqqpo46zj6z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> 	close_commit_graph();
>>
>> And after writing all data out (oh by the way, why aren't we passing
>> commit_graph instance around and instead relying on a file-scope
>> static global?)...
>
> Yeah, we should remove the global dependence. Is this a blocker for
> the series?

I do not think it is such a big deal.  It was just that I found it a
bit curious while reading it through, knowing that you are already
familiar with the work being done in that "the_repository" area.

>> I _think_ the word "close" in the name hashclose() is about closing
>> the (virtual) stream for the hashing that is overlayed on top of the
>> underlying file descriptor, and being able to choose between closing
>> and not closing the underlying file descriptor when "closing" the
>> hashing layer sort of makes sense.  So I won't complain too much
>> about hashclose() that takes optional CSUM_CLOSE flag.
>
> I agree this "close" word is incorrect. We really want
> "finalize_hashfile()" which may include closing the file.

Yeah, that is much better.  I do not think I'd mind seeing a prelim
step at the very beginning of the series to just rename the function
before the series starts to change anything else (there aren't that
many callers and I do not think there is any topic in flight that
changes these existing callsites).  Or we can leave it for clean-up
after the dust settles.  Either is fine as long as we know that we
eventually get there.

> My new solution works this way. The only caveat is that existing
> callers end up with this diff:
>
> - hashclose(f, _, CSUM_FSYNC);
> + hashclose(f, _, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);

I think I am fine with that.  It feels a bit nonsensical for a
caller to ask fsync when it is not asking fd to be closed, as I'd
imagine that the typical reason why the caller wants the fd left
open is because the caller still wants to do something to it
(e.g. write some more things into it) and a caller who would care
about fsync would want to do so _after_ finishing its own writing,
but that may be just me.

>> And then we can keep the "FSYNC means fsync and then close" the
>> current set of callers rely on.  I dunno if that is a major issue,
>> but I do think "close this, or no, keep it open" is far worse than
>> "do we want the resulting hash in the stream?"
>
> I'm not happy with this solution of needing an extra call like this
> in-between, especially since hashclose() knows how to FSYNC.

I guess we are repeating the same as above ;-)  As I said, I do not
care too deeply either way.

>> An alternative design of the above is without making
>> CSUM_HASH_IN_STREAM a new flag bit.  I highly suspect that the
>> calling codepath _knows_ whether the resulting final hash will be
>> written out at the end of the stream or not when it wraps an fd with
>> a hashfile structure, so "struct hashfile" could gain a bit to tell
>> hashclose() whether the resulting hash need to be written (or not).
>> That would be a bit larger change than what I outlined above, and I
>> do not know if it is worth doing, though.
>
> This certainly seems trickier to get right, but if we think it is the
> right solution I'll spend the time pairing struct creations with
> stream closings.

I still do not think of a compelling reason why such an alternative
approach would be worth taking, and do prefer the approach to let
the caller choose when finalize function is called via a flag bit.

Thanks.

