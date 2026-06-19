Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8911F2AD03
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781879330; cv=none; b=ZM9pqwZYShCNAeV17C4X3nx99jh/Va+9VCFsWNAfsGffE4znKwwzoFvajuqL4UdkPxm4rblyIeNL3D5cIdynxRoIdGrEGVO6gesbd/bv+eKkv4DI+Ey8zq7z4Eg4JHlHi7hrN9nmnz3CqYsxxrHn1R9UVOg0T2xSfccSHJnTq90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781879330; c=relaxed/simple;
	bh=yKNYLzOT0z4dy69HxcVPxH0EY8ZhGSLOMCxLAZPLXe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBEk9q8SD9jlk4DIvQ4RlbpzZTJ74Hik1jciPLhZxSHjmYv8L8acvqKsmn/Npx7BM6zY0lL2ytBLGNlhkklxTezG239QdjumjpO+I8jKjSeuYlLkcbCrKkT5irvc5hw/gmq9H/GD0Woh7JWq/sPLvIwWXPk1Zaxn7zb//xVPd3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=HHXg2LQ0; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="HHXg2LQ0"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7fedf0e99bbso26163327b3.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1781879328; x=1782484128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ2hHFDW5Q8IuYppON1CuTzrNEaDAct342EL1cJmesQ=;
        b=HHXg2LQ05O0k/vGk0HYpm1Xz3lB+MXSNTJ/Y1QwoIOugyEHc7uSL+oHI5i85PIYjbq
         hz/9Z5oMibjcUBb046dzRrEtw2ivi5DNB2NKFiO/5JkIARnwnAmurZEVppsUn7FVxvCi
         JsDDExoIjwmvNIc8NQms9l72IaGVQiANLjJDSoXTKA++/D5MQNvC8F/KcvRYzdeHZp2O
         Zp7LlwtF5OfJuVYNoehBpOrPoawkfvka9fxEPZykgxxqKrp/OqgXeRSmHmDyrhUT4CDy
         Lx548IU4IjAvNNKlTlORTUweYP9/2jzYesAltxus55bb9+oiffzpTel66YG/s5zu8liy
         882w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781879328; x=1782484128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJ2hHFDW5Q8IuYppON1CuTzrNEaDAct342EL1cJmesQ=;
        b=qDCpLWOLPlgNHPCSTmETaqy3pGGAH7ZYg+NF2UzSKoid2u1eVRZQCpXM/XiyKexQKW
         oVIS/Cqf7+PH5moL1ehb4YA0IaoMeNMSnMsVHPK7HiHWph62ydtutRod8uRnYz1/DT/J
         pPO+TMJvFO8XL9dMeVQNsNsbv3sJxZd40PznhWscJk2Gi6OvlB7qLg08N/b0nx+5D5XK
         Kh4jPJkpTyvIpDYNrK1oWltNBhHCot/bthSjOqZgvVJKFsLL15lKJo60Hj5q00odCvNx
         278YXsyDzrPF3ADQDDn+upR6bTqBgCATAbgdhzTVxMVlQSOGu9dvJg0hUux536kH7Gt+
         phQQ==
X-Gm-Message-State: AOJu0Yxxv5i50y5StZObOSONupaJ2QoAoop+7aUwmuOvJrseUy5tsRAM
	MH+db+PkqQEwt/g7+RNYeENDv2XUTu9Z9PS7aVzlA4zuviALi0ofmf1dIDxIvpwd6wSN2iKA8CK
	HCWvIJPk=
X-Gm-Gg: AfdE7cnswV6zx+l/BXXC22nLkTCPKMWBolegVzTyMp5/1RO5By7wM4yAbhn64hXep0w
	GwioSKKPUUY9rbQLfawKKo5gze+qi2XX7tMRHAUk0jNkILvI3ZJeQK9zVjCJB8f1qOK2mDiqlgG
	4k0ZiD05d9K+fvjmourSbTef8zI0+3N0Ut2ey7MmGPHG7Ux2kRPAo54uy42Ivo7QpfYfSbmRfTb
	EPkBNzrByWtrHAGCNwbmD+8BzmxwebKQIrNVtU2qG1A406Ok/kOnbNIpVIjiMHVPmmw6zj2Gz5j
	CeXYNPwrfRMvyypV/2Ylkk2wFWziqG3DGnxccN9wBYyDikirwmSilSPv2yrmx6OzkdVECZSUdo8
	QSzUV9Oz/yFU1fGsNs1HMIp5UGpEzKAQ+5tyP1mdT65pGSh+LurVEDvTzppLSFvBZFQk5kQliPT
	nh2bZMyebjDuQxiF1pP6i81iOncHgtK48lgdTt/AmQjFLSghrrfj77xBnyFzsxyuc6bNSgdhZSx
	wN1vSLgUwWUkt/F9+A7372f7Qj9imqVY7leKl0tHgVDwj5p5rIJ1QFqD1rAkfqT3ZpQ2nmahNw/
	3guGnw==
X-Received: by 2002:a05:690c:883:b0:7bd:7c16:1711 with SMTP id 00721157ae682-80131aa8d2emr37893737b3.22.1781879328529;
        Fri, 19 Jun 2026 07:28:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8011a8bc1dbsm12131787b3.20.2026.06.19.07.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 07:28:48 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:28:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/4] pack-objects: support reachability bitmaps with
 `--path-walk`
Message-ID: <ajVSHvL+On9AEV+g@nand.local>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1780438896.git.me@ttaylorr.com>
 <ffad584a43ebf3cb2138e8dce7daef84ab72712f.1780438896.git.me@ttaylorr.com>
 <849c659f-efa8-430a-bfac-0c26a3ed1aaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <849c659f-efa8-430a-bfac-0c26a3ed1aaa@gmail.com>

On Fri, Jun 12, 2026 at 09:24:32AM -0400, Derrick Stolee wrote:
> On 6/2/2026 6:21 PM, Taylor Blau wrote:
> > When 'pack-objects' is invoked with '--path-walk', it prevents us from
> > using reachability bitmaps.
>
> My earlier response focused on the _use_ of bitmaps when creating a
> packfile, but your patch also enables _writing_ bitmaps with the
> --path-walk option, which is significant and potentially more
> interesting from my perspective: we have evidence that --path-walk
> can produce significantly smaller packfiles than the standard
> algorithm, and once those packfiles are created we can benefit from
> that size in later packfile creation steps by reusing those deltas.

I am perhaps splitting hairs here, but I would frame the use of bitmaps
when reading with "--path-walk" as "either/or" not "both/and". The main
goal of this patch is to enable us to still generate bitmaps when
*writing* a pack with "--path-walk".

> Even more important here is that we have demonstrated examples of repos
> that change their packfile size when using the --path-walk method. We
> should demonstrate that the size continues to shrink with --path-walk
> even when producing a matching .bitmap file with --write-bitmap-index.

That's fair. One way to do this would be to:

--- 8< ---
diff --git a/t/perf/p5311-pack-bitmaps-fetch.sh b/t/perf/p5311-pack-bitmaps-fetch.sh
index 1b115d921a1..c1aed3e2aef 100755
--- a/t/perf/p5311-pack-bitmaps-fetch.sh
+++ b/t/perf/p5311-pack-bitmaps-fetch.sh
@@ -18,6 +18,10 @@ test_fetch_bitmaps () {
 		git repack -ad $argv
 	'

+	test_size "size of bitmapped pack ${argv:+($argv)}" '
+		test_file_size .git/objects/pack/pack-*.pack
+	'
+
 	# simulate a fetch from a repository that last fetched N days ago, for
 	# various values of N. We do so by following the first-parent chain,
 	# and assume the first entry in the chain that is N days older than the current
--- >8 ---

, which gives us:

    Test                                            HEAD^             HEAD
    ----------------------------------------------------------------------------------------
    5311.3: size of bitmapped pack                           278.8M            278.8M -0.0%
    5311.38: size of bitmapped pack (--path-walk)            278.7M            278.7M +0.0%

(eliding other tests). I considered whether there are other interesting
tests, but I think "repack" is the right layer to run perf tests, since
you're always writing a closed pack. We could try different subsets of
the repository's objects (which would also have to be closed), but I
don't think this is that interesting.

> The other thing that I notice here is that the bitmaps will need to
> compute their reachable object set independently from the path-walk
> algorithm. But I suppose that already happens separately from the
> revision-walk approach that normally produces the packfile contents.

Right. The only wrinkle here is how we handle the internal traversal's
"--boundary" option, but see the last paragraph in the commit message
for details on why the proposed approach is OK.

> >From my perspective, the point of integrating these two things are:
>
> 1. Reachability bitmaps make it much faster to discover the reachable
>    set and reuse bits of existing packfiles. (Your performance table
>    demonstrates this is true.)
>
> 2. The --path-walk option can shrink packfile sizes by grouping
>    trees and blobs by path before those paths collide in the name-hash
>    sort. (I haven't seen evidence that this is happening.)
>
> With evidence of (1) and not (2), it's not clear from the data that
> these features are integrating completely. Without looking at the
> code, those numbers would be the same if we had instead swapped the
> preference of "the --path-walk option disables bitmaps" to "bitmaps
> disable --path-walk".

Let me know if modifying the perf test as above (and including the
relevant results in the commit message) would be sufficient in
addressing your concern.

Thanks,
Taylor
