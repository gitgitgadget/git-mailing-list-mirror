Received: from mail-oi2-f42.google.com (mail-oi2-f42.google.com [74.125.231.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F23B7B6B
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896945; cv=pass; b=n/EBzpe4aUAu/0Q2+tfOOtAQRJrWqUhr5xqdLriRTkMdNcsaYEplp1Is+ToYeJ9zMshGyGPx+gs/IwroxRcULtjvhs0/Zkvn0OnQQ9MI5+vs5+ci3m9RCyuvrfwuhkZByUpcNEHeg89x4PKlR+nIVDPK0HRyhsx6nR7vZ5cUGhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896945; c=relaxed/simple;
	bh=MHzSU5EAsCma5f/bK/2m+iOiYYMt54akvrP1eXziHa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msxDlcSEwX64Yt2Ah+D/Gk53oi2Zo3RsGe1XKfUjVnqc6WfKZitfjRnr2Lqn1rKt1hTokpYKcwDpfQmxfgBdNLFoiWytSHufSXsOg8KTAl9jWEkQBKM0R8CFYPvesgOxcbk54X+1wB4nLNhewLeG6ZkxXWaZpXtUuNE6mnkDSkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJLnh61s; arc=pass smtp.client-ip=74.125.231.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJLnh61s"
Received: by mail-oi2-f42.google.com with SMTP id 5614622812f47-4db3c747ad8so4539498b6e.2
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 16:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790896943; cv=none;
        d=google.com; s=arc-20260327;
        b=i/UgmMwMzZblcYBDFCV/ioXoEgpaG10eKDTTt2eWa6y4IUowU1COmIFVMBZKnk04dO
         HXkigN06B+1ccOZv6xz5q6MxTQFkkVgDSwtlaN9mHbvopDQjTXGxRBBIGujZHMMyKzxt
         gc204FGN43hxK0Rdm1lSSk15rSM8HzhY9o5ec4rHRPH1B5UGpBABg5KQlLz0CpcliCT2
         PODlrPwjRfRL+27iixobreWTb3w2KLVZBY5YLCQFwilsGgO9IFSqWHifZucWynLrb7xE
         8g2xKcZGL3lf56vs9IWZ1hao+Nnq5F0W++M9Fw8TGj+mN5jl1HSS4CkO1kCDncdOsSfQ
         D7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DwgQuxJO6OZS+gkBjtXD06F19fWTbwF9RzzjR4E1g9U=;
        fh=LjiFYbubOI4PNWlo2PsAqFE+5895Is9PS0Pr5a0gUGg=;
        b=QCdtmhCGWI3uF6EO40UTsNHmWHArUl35tfAPFafTUxEMlxNKBkNnr8zS6gXvb4W1Cn
         bdAkIIbdAt2kMALCr7bswG7WYTBohovjYp7jfkg1F3GqBEKiCMKJ6xGfQ1auqCtAHlMh
         /5Zpbzlfk+kMqXN3D4oLOurAPQ90pGl1h9mLxWWIzdTy23ViJLKTjMvlSNVecVMU+Vqw
         sgoZ/w78Nf0SAJbLfQVAR6JchR05KenxJxDvrmjNeZwopT8XuOQ4hxNWvjzhLhzFl+4Q
         ERocamYPiLztg3PcXtJd8vbaZ9R0avU2IutkX97N2rjF5XPvUvLxHleF2gxRrm9gUSBw
         +YMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790896943; x=1791501743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DwgQuxJO6OZS+gkBjtXD06F19fWTbwF9RzzjR4E1g9U=;
        b=KJLnh61s7UIGzHSMhaHsqMVgnbzivSr7LMc6qn3ZjlhJYhy9RxXSNaZZRQfLVqnXSW
         FN1bXMctLcIRuAe6P5iLQFs/Xf1sRYwFkvr2pMJwPRS4PD3ieGsCKujYIckgSvh0C3l6
         52uSS8qk2v07htxME85UZRNKhimmpFLVB9EgXcq01ge90ynd7qmjltyAj3/bwfcGEh92
         KWPCvsPaaaCNeKrOAcfbCA0nZONfyo1NGFuOzEHeh4Yavvbw+syOCR3D/cj1hKaKB2bD
         ZoJRogLAdTrFog504vVhYzS3paCioNGmC/JP4rjCK8Sr1OHjy/MEBebq7SZ5aLQDWzuA
         LubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790896943; x=1791501743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DwgQuxJO6OZS+gkBjtXD06F19fWTbwF9RzzjR4E1g9U=;
        b=GnrO4ZDwwViyYcebXgkvTHTw3/vjRPTEEicK46Uz7Bwl3gr945OvsmFY9IYlVE3R/V
         fKXmGMrMamRCijBQePBPiwntWc2LErkonXaRNp+zgflh7Y+vtxv/MT5ULJncl5ikZswu
         FdOy4gODRTpaf5Ko6bYGWscnSgKguMoivk3LhMuDrApnK2ysrfdQWMB/Pd46PMZFpe0U
         u1Gs5qb5U9kJPbPdxVQbecmVszFxSfX07Se0iMKos307ctJOlO7VKMLcfz+9njaeazmK
         LjQPiGM0iRUSre8W6Wx6x0GURXtIhfR9CHMdxlqR2l2oIMBqYuou3X9RMOEik6TIGNTY
         NlCQ==
X-Forwarded-Encrypted: i=1; AKwUvByzgVso685CJvC4wSj6qlBiXucLPklEJX/ru90M2ajeRUU2FD6AX+rIUD/cvEgTHLg+VmU=@vger.kernel.org
X-Gm-Message-State: AFuF++nXgkOG8bTbYRPmXxp/DvCZPuT1453+nkZk5S0Z/uI8h4pZe4xo
	pAwUm39Gp6C3bdPQa6nQBv5NeotrZ+e4leFPA7oYcVioDuLjq0uitQic6+ANwzMhAGk0IlADBOp
	uoYoZiJyyyc0cdWfDmUJ0TynQ5Hs09D8=
X-Gm-Gg: AYBFou07UPs7qxOg+eg2TWE+GdUlIyS6Vk5RyuwWLYwhc72svSc1jRNashySxjS7P71
	svf30r7EaOrUmjAibxjdE9OCUQ2L4Bo1xaINsqAod813lVUdBhQUCK0eJbhh0ialI1C2fADzvRr
	MwRH4zIUz5Va4heJYJwEYhnjfBIIhcmRlOc6Kj6pJtNVVT4jpGW4oHgLKvEwM6XaqHaV/45oJl+
	9k//ANc5Qk0WTLpXMJNPDzz49aQ67OMzLMbESzwfA8j61SE+u/88FhjKDEAa+eej78jbjsPCPa8
	iMNtmKSeK3bOD5ioGkRXoXV/NIHsiQT2wWEGSktDYfiDg9En/sPI9Uv/xZf6wLezGEaOvvfImry
	bL4DRre8j0TdcPNXakN+UakfmczM2GAFp/+Hgw/DchiGCGMCITPOOiXWcpYf7/RRj9OO8MIvB
X-Received: by 2002:a05:6808:1993:b0:4d6:9335:d533 with SMTP id
 5614622812f47-4f52ab91601mr674301b6e.64.1790896942933; Thu, 01 Oct 2026
 16:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790731662.git.me@ttaylorr.com> <6348667e2e3fe63aeb139888e877dd8447570253.1790731662.git.me@ttaylorr.com>
 <a78a38ca-b08a-4194-b17c-b8802e4d43a7@gmail.com>
In-Reply-To: <a78a38ca-b08a-4194-b17c-b8802e4d43a7@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 1 Oct 2026 16:22:11 -0700
X-Gm-Features: AclHuK8S-RAUqovAgQD2Ic-roI2BJbWS2cZ6VVVKcwbOZQoSy0XnyTns-4kQNmg
Message-ID: <CABPp-BHE662t9aaNcZ4DZ+2AU_C7jR7_VyHZwt2Tm8JSPE3JZw@mail.gmail.com>
Subject: Re: [PATCH 2/4] pack-objects: ensure tree/tag closure with '--stdin-packs=follow'
To: Derrick Stolee <stolee@gmail.com>
Cc: Taylor Blau <ttaylorr@openai.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Ted Nyman <tnyman@openai.com>, 
	Elijah Newren <newren@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 3:23=E2=80=AFPM Derrick Stolee <stolee@gmail.com> w=
rote:
>
> On 9/29/2026 9:28 PM, Taylor Blau wrote:
>
> > Add trees and tags from included and '!' packs (and loose ones with
> > '--unpacked') as roots in '--stdin-packs=3Dfollow' mode. This rescues
> > their descendants even when no input commit reaches them. Walk these
> > roots after the existing traversal, preserving the `SEEN` bit to avoid
> > redundant traversals. Ensure that the walk takes place *after* the
> > existing traversal so that we don't lose the path prefix used for trees
> > and blobs wherever possible.
>
> > @@ -3807,6 +3807,7 @@ static int stdin_packs_hints_nr;
> >  struct stdin_packs_context {
> >       struct rev_info *revs;
> >       enum stdin_packs_mode mode;
> > +     struct oid_array extra_roots;
>
> I believe this should be an oidset to avoid adding duplicate objects
> that appear multiple times. The order of these extra roots doesn't
> matter (such as in a --topo-order walk). We only care about the
> binary "reachable or not?" question.

Is that true? After iterating with copilot for a while, it says:

The walk supplies paths to pack-objects, and those paths affect more
than reachability. In particular, they affect both namehash-based
delta selection and path-based attributes.

First, it is possible to demonstrate a pack-quality regression with a
vanilla repository configuration:

test_expect_success '--stdin-packs=3Dfollow preserves namehash ordering' '
    test_when_finished "rm -rf repo" &&
    git init repo &&
    (
        cd repo &&

        mkdir sub &&
        test-tool genrandom similar 8192 >sub/a &&
        cp sub/a sub/c &&
        printf x >>sub/c &&

        for name in \
            b yzz9 zzz9 aazz9 abzz9 aczz9 \
            adyz9 adzz9 aeyz9 aezz9 afyz9
        do
            test-tool genrandom "unrelated-9-$name" 8192 >"$name" ||
            return 1
        done &&
        git add . &&
        git commit -m base &&

        git rev-parse HEAD^{tree} HEAD:sub >in &&
        P=3D$(git pack-objects --window=3D0 $packdir/pack <in) &&
        echo "pack-$P.pack" >in &&

        git pack-objects --stdin-packs=3Dfollow \
            --no-reuse-delta $packdir/pack <in &&
        rm "$packdir/pack-$P.pack" "$packdir/pack-$P.idx" &&
        git prune-packed &&

        printf "%s\n" HEAD:sub/a HEAD:sub/c |
            git cat-file --batch-check=3D"%(deltabase)" >actual &&
        printf "%s\n" "$(git rev-parse HEAD:sub/c)" \
            "$ZERO_OID" >expect &&
        test_cmp expect actual
    )
'
The funny-looking names make the test deterministic: their namehashes
fall between the hashes for a and c, but not between those for sub/a
and sub/c. There are enough of them to fill the normal default delta
window. --window=3D0 on the input pack and --no-reuse-delta on the
output merely ensure that the test observes the new delta search; the
output pack uses the normal default window.

With the submitted oid_array, the parent-first input-pack order is
preserved. sub/a and sub/c remain adjacent in the namehash sort, and
sub/a is written as a six-byte delta against sub/c.

With the straightforward oidset conversion, hash iteration visits the
subtree first. The blobs are named a and c, the unrelated blobs
separate them in the namehash sort, and both are written in full. Both
packs are valid, so this is a pack-quality regression rather than
repository corruption.

There is also a shorter, but admittedly more contrived, example using
path-based attributes:

test_expect_success '--stdin-packs=3Dfollow preserves paths for attributes'=
 '
    test_when_finished "rm -rf repo" &&
    git init repo &&
    (
        cd repo &&

        echo "sub/* -delta" >.gitattributes &&
        mkdir sub &&
        test-tool genrandom seed-2 8192 >sub/a &&
        cp sub/a sub/b &&
        echo modified >>sub/b &&
        git add . &&
        git commit -m base &&

        git rev-parse HEAD^{tree} HEAD:sub >in &&
        P=3D$(git pack-objects $packdir/pack <in) &&
        echo "pack-$P.pack" >in &&

        git pack-objects --stdin-packs=3Dfollow $packdir/pack <in &&
        git prune-packed &&

        printf "%s\n" HEAD:sub/a HEAD:sub/b |
            git cat-file --batch-check=3D"%(deltabase)" >actual &&
        printf "%s\n" "$ZERO_OID" "$ZERO_OID" >expect &&
        test_cmp expect actual
    )
'
With the oid_array and parent-first pack order, the blobs are visited
as sub/a and sub/b, so sub/* -delta applies. With the oidset, the
subtree is visited first and the blobs are seen as a and b, so one is
delta-compressed. When the root is processed later, the subtree is
already marked SEEN and is not revisited with the sub/ prefix.

The oid_array does not manufacture parent-before-child ordering if the
input pack itself has the subtree first; this path information is
explicitly best-effort. But it preserves a useful order when one
exists, whereas an oidset discards it.
