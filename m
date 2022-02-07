Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F39C433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 22:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244987AbiBGWq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 17:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiBGWq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 17:46:57 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22722C061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 14:46:57 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id j24so12295038qkk.10
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 14:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t/I9z5Cv/PHrOphX/dWRpkTAvjt5ZLh2kR+CERs4ugg=;
        b=Hx91TVaRb2owYKzGK/NX8ZGm+ByODe46eQfnwlG5QynqQWw9LgwBIurAi4rvTQNl8h
         +3X4oxCn4MawWzMK0oIFqQglDsXtS8GD6Giwkanb2ONB2wUR/KAOrYYZ/w8cfi6UchM9
         z9JOB0IGc1DcuNdSHfSf1BQ82kE0bRt4eoOJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t/I9z5Cv/PHrOphX/dWRpkTAvjt5ZLh2kR+CERs4ugg=;
        b=1Pir8TF88uDFLFnJWMbRXPxWtSQskfShBQF4BdVsRZchNDEc7J+Vw0wEkCB/e9FwQC
         biPeF8l2CW0bTFB5sljLRyMmoBvvca7l5wGnvyrj5Rf8w8g+t3BLzX4zDsoIuiKuqIgs
         EZ9bCuEs02QXQFtHHVXieEkYYFdB/ZHziC7I2TPOIeiwVFe++PN7qlOjzDT8uTBWwAtC
         MlUpW8tqwlqEyMtFdFwDP/TUvSFDQJXzKvH+tLuc6/BDC0ORixNQyZOl01awJHT7+Bw7
         R7v2ffZRrNsZ6KWKWAKpJ3AdOOEadxFrtVNVrsKlGijGPz+6Y7E0BSZfvNThSnFqhTU9
         SKnA==
X-Gm-Message-State: AOAM530VospNEQ7+dncGXfR7NMt9FxNuYbNVwT9DBWuRJlPyiHcDEmf3
        2wkw1pxaaGrGx5qcZWYiOqpZXQ==
X-Google-Smtp-Source: ABdhPJwW2hf8KtfbNaCkPV7Vq/Am7Wk5TvfpNhCtAgKnEXRoJJPJCv6DIlF0SiyWQh5pEclCzAqArA==
X-Received: by 2002:a05:620a:1991:: with SMTP id bm17mr1209262qkb.475.1644274016216;
        Mon, 07 Feb 2022 14:46:56 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id n6sm6433647qtx.23.2022.02.07.14.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:46:55 -0800 (PST)
Date:   Mon, 7 Feb 2022 17:46:54 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Gamblin, Todd" <gamblin2@llnl.gov>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Commit SHA1 == SHA1 checksum?
Message-ID: <20220207224654.aju3rmxcrhapi4d2@meerkat.local>
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
 <121ce485-bea8-3168-aa35-d11eb13022da@iee.email>
 <xmqq1r0gjo6h.fsf@gitster.g>
 <eca83634-ee91-89bd-567e-6b0807b5ff79@iee.email>
 <xmqqee4fix0l.fsf@gitster.g>
 <20220207133244.kpyczjsxriepjtdt@meerkat.local>
 <xmqqczjyiecs.fsf@gitster.g>
 <20220207213449.ljqjhdx4f45a3lx5@meerkat.local>
 <8A241137-C8D6-40A6-ABB8-5624B9E617A9@llnl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8A241137-C8D6-40A6-ABB8-5624B9E617A9@llnl.gov>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 07, 2022 at 10:29:37PM +0000, Gamblin, Todd wrote:
> > 2. packagers would be able to perform cryptographic verification without
> >   needing to track any extra sources like corresponding .sig files; they
> >   would just need to add a build-time dependency on git (plus whatever it
> >   calls for cryptographic verification, such as gnupg or openssh)
> 
> This is a cool idea, but tar/gzip/etc. are vulnerable to input attacks (or
> at least there have been CVEs in the past), so this does not eliminate the
> need to verify a downloaded .tar or .tar.gz file independently.  You can
> verify the contents of the tar, but to do that you have to expand it, and to
> do that you’re still passing untrusted input to tar.

That's not really different from what git does when it clones a remote
repository to run "git verify-tag". It still accepts untrusted input from the
remote server, performs a lot of compression/decompression operations, etc, so
this is not introducing anything that git isn't already required to do.

I know there's a lot to be said about the simplicity of just computing a
signature over file bytes, but there are features you end up sacrificing, such
as ability to provide a single signature for multiple compression types,
adding a better compression algorithm in the future, or simply recompressing
with better flags in a long background process.

My goal is to improve the current situation where we're actually doing pretty
good for signed in-git objects, but none of that is carried over to packaging
systems. The only effort I know in that area is sigstore, but it requires
quite a bit of work to properly use on the part of the project maintainer,
whereas it would be great to be able to say "just do git tag -s and the
packaging systems will be able to use that."

-K
