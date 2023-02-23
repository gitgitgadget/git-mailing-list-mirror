Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070DBC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 23:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBWXhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 18:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBWXhO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 18:37:14 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED935C149
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 15:37:06 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so979073pjb.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 15:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Rlwhcv//BZuKPRKMWmR6iIivHua1bSv0/11VgnpITQQ=;
        b=Fqtpw7NUBwtJcqN9s6BfGol5GS78H/rMTYkgWSTDD71A6g0Rjx0bp4d5apNnrnI+5Z
         O05EzNGtWAwkCd/L3W4HonY6LN4q9KSJiT73M07kE6WtZbcu7sej+jwoe3xUv7CdCT0b
         5C5vUdliYxapQOg3PBv48mUFyoC+KPxA8Zcp2IOuatspVNg0K2bPKbw9ZvT0aHuYIID3
         693PWuM4UKGC59RBsjhVFqDi4p/qnpx6lyTBQ+cbdellFGpf4H3/t/cnUNAcVcWvXnx2
         O8Dmn3Ev6EeO4DRuMVDE9VVp4Dd9s2EO96jaJnQWMpm2PIcqFVENn8oqKF1q834xaHv8
         etuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rlwhcv//BZuKPRKMWmR6iIivHua1bSv0/11VgnpITQQ=;
        b=cLQRkIa6WDDedY44z0ecDMJeHQCvOQP1VAnhv3r2V6SH0c2e29n8OzV8K7lFTn7zJn
         Qm4OmPVdQtotufz+QXVccTP0JdvXH++Qm4Y7y/D9ypMfOkict6bIxyMjtlL/gzEXzmQJ
         KJwASMEMQVcZyOL+9RjEn9duXZwJFx42zecV/ksYiWAxzSXpycBOi5XO5lWIkYqRCSnR
         e80rO2nisTTYzHeotvaUfCT36oT6V9GzWQZFmiFEESKAJntuD9QER0YA6UJMFoD7EC1E
         nmRYObzPFCKBlNPySNg/KXJdms16ZOi5CfLbx08CIllPwp+C6w2u8rTpuD0HE6kB5g0J
         NLCg==
X-Gm-Message-State: AO0yUKVkTHe0H4eKJ0VF+unMCRdHEAj323Zl/MavomQKSdrBxihm+Qo+
        s216tX092eXoN0EfPSeopSZwvIfz1yg=
X-Google-Smtp-Source: AK7set+HDvFz5aDYVNkBPRJBUX2h0b6gaXzRFodd/KcaM/nStsaD1KRIn3VTEFaE7quAh6vKWoEoNg==
X-Received: by 2002:a17:90b:4a4d:b0:233:cea2:dac6 with SMTP id lb13-20020a17090b4a4d00b00233cea2dac6mr13298442pjb.47.1677195426131;
        Thu, 23 Feb 2023 15:37:06 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id jh18-20020a170903329200b001991f07f41dsm2153450plb.297.2023.02.23.15.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 15:37:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/16] http test bug potpourri
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Date:   Thu, 23 Feb 2023 15:37:05 -0800
Message-ID: <xmqq8rgo3qe6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So all I wanted to do was this one-liner:
>
> diff --git a/t/t5559-http-fetch-smart-http2.sh b/t/t5559-http-fetch-smart-http2.sh
> index 9eece71c2c..54aa9d3bff 100755
> --- a/t/t5559-http-fetch-smart-http2.sh
> +++ b/t/t5559-http-fetch-smart-http2.sh
> @@ -1,4 +1,5 @@
>  #!/bin/sh
>  
>  HTTP_PROTO=HTTP/2
> +LIB_HTTPD_SSL=1
>  . ./t5551-http-fetch-smart.sh
>
> but somehow I'm 16 patches deep. Let me back up.
>
> I got bit once again by the "oops, HTTP/2 tests in t5559 are sometimes
> flaky" bug. One thing that came up in earlier discussion is that HTTP/2
> over TLS should be much more reliable, because it doesn't have to go
> through the funny HTTP-upgrade path.
>
> Hence the patch above, which is also patch 16 here. And it does make the
> consistent failure of t5551.30 go away. And it even makes --stress work
> longer before a racy failure, though it still fails for me pretty
> consistently within a few dozen runs.
>
> But in doing so, I found out all sorts of neat things, like:
>
>   - when I tested with HTTP/2 and TLS before, I was accidentally not
>     using HTTP/2!
>
>   - we even have a test that should detect which version is used, but
>     it's a silent noop unless you set GIT_TEST_PROTOCOL_VERSION=0, which
>     clearly nobody does
>
>   - it turns out there are a bunch of tests which are skipped (some of
>     which even fail!) unless you set that variable
>
> So this series fixes the broken tests, adapts them to work with both v0
> and v2 Git protocol, makes them work with HTTP/2 when needed, sprinkles
> in a couple other fixes, and then finally does that one-liner.
>
> I'm actually not sure if the final patch is a good idea or not, but
> certainly all of the fixes leading up to it are worth doing.

Thanks; this must have been a lot of work.  From the "test what the
end users use, or at least something close to it" standpoint, 16/16
certainly is the right thing to do, I would think.

