Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE927225D7
	for <git@vger.kernel.org>; Sun,  1 Sep 2024 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725234353; cv=none; b=ob32m5p/tmMbwOtsu0S80Gdcv4i7m7jp2iSrDGjNc9VaRG4o7G+O4PaxXxuxx7eOzQOj1hytAcFWqOgg+oHabio8nks8U/halurLmo2rc+BSij5GDDiRVS0mpYj3ebmS/C0LyB3931c7K84rH6sq798jLm5YGbwKJlTIM9Kg58c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725234353; c=relaxed/simple;
	bh=71cTf3T4I5kGEbA7tx7xpAPrk9d/cGiJK2X+MEJHsxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asNXxJN+iw2wOmuaLqv9xl7hTqxSl+91jTUlIXPFwSrSpl4Wd6cgQrRlhABDP/SGrp5nW6MWnFZJ5Nx8FBCVDCU/TFsQ9rv6LuNBfViT848c8rGcKPWnkzQ0l4e9uFnG4aS5zwSe2DwBJLE00HEoRanhG7oHP0pus1cemSwOgv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S147NQmX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YtQKa5qg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S147NQmX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YtQKa5qg"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9135711401C7;
	Sun,  1 Sep 2024 19:45:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 01 Sep 2024 19:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725234348; x=1725320748; bh=y8uMHD5S6+
	To723azWxar9d218eM/dCtiaqoLNPk6CY=; b=S147NQmXUku/STjffnxFfFWSQc
	0XeJ5L2d07BG5Evw+WWOLlR+MbR666TCdJI50i6X6RFOv1kO+6btA/Y+qRVlGvZn
	S+8X3lnpnCFUT9Ys6JbLtg8iNAYCE5X9AK4hMxse4K1ilUImO+9MWvxGXU4/wwpZ
	l9wHsM7bu8uTX/PqyMCmO1cgykKrU+tp18gJZ1lR+qhVLwXg/1BpELn90/8kQfgA
	5QX62jFcnJKp7UXNBcwrI/O1s6ZKsaRzOPvIt65awToxnijxUISGkwPLKdkIJOqM
	+tC05QTUJYF+1tv2a6ZtbzjP35rq1SAL4yN63lmruDXpqszgyHt4AzYbbrrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725234348; x=1725320748; bh=y8uMHD5S6+To723azWxar9d218eM
	/dCtiaqoLNPk6CY=; b=YtQKa5qgzbndEvUz2PIxX3Tyj0yGLx/w83xA2sbBZ055
	Ih6PPBgPpIdNZttqcnlMmV8lBXqKAeebXdPiV5RvWi4n2f/YGh79rvD03Hhz/I84
	wdgegDhuTVGqujvJ0biiBauSwjxtCvvnSGzXH0Ic/tU3HCEk0XFxBj8jaO1xPpuY
	HROXvd5NqCP4kJ2LWW4wWyvzFkxsSvmpn4QGLqoo3Rvwfn0pq3jssc9kx3T/8ORA
	Z0yBTYUhggyyykI3303Q1MGk3tLQPfOHSLigXevsbpuie3zrqOuFT5777ZIOH1wX
	ig2EoMDItfj9rJ6Yg4KWfQJCHjhvv1k5QFM9KM4mUg==
X-ME-Sender: <xms:rPzUZr1wWLFbtH4mLjvMaFakA0i_ahrHdneMDO6ZyDRd6G0iR3hdfw>
    <xme:rPzUZqHqIxSld89krfJs104lVdqvd67_lZ9SavOR_GG4pVpnE0si6iU3W9SV-AQSS
    bUzJQND3Y67_rpjcg>
X-ME-Received: <xmr:rPzUZr7k47ncKY7VQskmeCh39b6z9Pa1Xs7e-t-N76OexpqGtpLt0q4LqpJoRFXWYa7Ts_6UcXOdXghZPnphNu5JOpn1GeZFc4wNJoKI7xNJnMUE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudegledgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvffekleduff
    fghefhveegleevjeevhfdvueehteejjeeuteehueehveevveetkeenucffohhmrghinhep
    vhgvrhhifhihqdhprggtkhdrtgifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    shgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoh
    epmhgvsedtuhhpthhirdhmvg
X-ME-Proxy: <xmx:rPzUZg2Fls0SQrX7azdpS_VZiBm4_5HGGMrVeZJcnIWBOaiBSMApiQ>
    <xmx:rPzUZuEY4O7CF1k22YZvRZp1uOk8kACkJpvX0fCZLXZJ1jNA5oLjhw>
    <xmx:rPzUZh9aF5rQW9XQ16JJhfWxQ-CAJX1I9RAAeQQA9cHyLUGDG0l_aA>
    <xmx:rPzUZrnKGgBNFKR1apIs-1a4TdencOLnPkaLn-QZ7S0wzQLFbZnpZw>
    <xmx:rPzUZqiXCzBUjmzFiae-9fCEfuVxPILUV8sP9kEeKIWb3X6y03Wf1EYm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Sep 2024 19:45:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 25e071ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 1 Sep 2024 23:45:41 +0000 (UTC)
Date: Mon, 2 Sep 2024 01:45:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ilya K <me@0upti.me>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git 2.46.0 crashes when trying to verify-pack outside of a repo
Message-ID: <ZtT8p06fdTwXO7iX@tanuki>
References: <14ec9394-a7ea-456c-800a-6a84c52e5cda@0upti.me>
 <xmqq7cbvpf8v.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7cbvpf8v.fsf@gitster.g>

On Sun, Sep 01, 2024 at 08:26:08AM -0700, Junio C Hamano wrote:
> Ilya K <me@0upti.me> writes:
> 
> > We've updated to Git 2.46.0 in NixOS, and encountered an issue
> > with Dulwich (a Python Git implementation) tests failing[0]
> > because it attempts to call `git verify-pack` on a bare pack, with
> > no surrounding repo. This used to work in Git 2.45.x, but in 2.46
> > it simply prints "error: index-pack died of signal 11".
> 
> Thanks.  This is a fallout from code-wide clean-up in 2.46.0 where
> we do not assume that everybody runs SHA-1.

Yup, indeed. The problem lies deeper than what the below patch fixes
though. The issue isn't in git-verify-pack(1), but in git-index-pack(1),
and can be fixed like this:

    diff --git a/builtin/index-pack.c b/builtin/index-pack.c
    index fd968d673d2..e6edd96d099 100644
    --- a/builtin/index-pack.c
    +++ b/builtin/index-pack.c
    @@ -1733,7 +1733,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
        unsigned char pack_hash[GIT_MAX_RAWSZ];
        unsigned foreign_nr = 1;	/* zero is a "good" value, assume bad */
        int report_end_of_input = 0;
    -	int hash_algo = 0;
    +	int hash_algo = GIT_HASH_UNKNOWN;;
     
        /*
         * index-pack never needs to fetch missing objects except when
    @@ -1857,6 +1857,9 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
            pack_name = arg;
        }
     
    +	if (!the_repository->hash_algo && hash_algo == GIT_HASH_UNKNOWN)
    +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
    +
        if (!pack_name && !from_stdin)
            usage(index_pack_usage);
        if (fix_thin_pack && !from_stdin)

Unfortunately, this once again uncovers a deeper issue: neither the
packfile nor their index encode the object format they use. So while
falling back to SHA1 papers over the issue, it means that we misparse
SHA256 indices. Also, we misparse SHA1 indices if we happen to be in a
SHA256 repository. E.g. when parsing a SHA256 file in a SHA1 repo:

    $ git index-pack --verify '/tmp/git-tests/trash directory.t5300-pack-object/repo/.git/objects/pack/pack-aa45f7f08f043c9f0388f1844a2a797587254e249919b35ac9dc2b52c1aada29.pack'
    error: wrong index v2 file size in /tmp/git-tests/trash directory.t5300-pack-object/repo/.git/objects/pack/pack-aa45f7f08f043c9f0388f1844a2a797587254e249919b35ac9dc2b52c1aada29.idx
    fatal: Cannot open existing pack idx file for '/tmp/git-tests/trash directory.t5300-pack-object/repo/.git/objects/pack/pack-aa45f7f08f043c9f0388f1844a2a797587254e249919b35ac9dc2b52c1aada29.idx'

The error message isn't even properly indicating what the actual issue
is.

One potential solution would be to try and derive the object format from
the hash that the packfile index name has. But that is quite roundabout
and rather ugly, and packfiles may not necessarily have that hash in the
first place. It would also become potentially ambiguous in the future if
we were to ever adopt another hash that has the same length as either
SHA1 or SHA256.

So we basically have three different options:

  - Accept that we just don't handle this case correctly and let the
    code error out. This pessimizes all hashes but SHA256.

  - Bail out when outside of a repository when `--object-format=` wasn't
    given. This pessimizes all hashes, but gives a clear indicator to
    the user why things don't work.

  - Introduce packfiles v3 and encode the object format into the header.
    Then do either (1) or (2) on top.

The last option is of course the cleanest, but also the most involved.

Patrick

> ------- >8 -------
> Subject: verify-pack: fall back to SHA-1 outside a repo
> 
> In c8aed5e8da (repository: stop setting SHA1 as the default object hash,
> 2024-05-07), we have stopped setting the default hash algorithm for
> `the_repository`. Consequently, code that relies on `the_hash_algo` will
> now crash when it hasn't explicitly been initialized, which may be the
> case when running outside of a Git repository.
> 
> As the verify-pack command ought to be able to infer what algorithm
> is used in the input file (and if the input file does not have such
> an information, that by itself is a problem), and the command allows
> an option to explicitly tell what algorithm to use in case it cannot
> be guessed from the input file, in theory we shouldn't have to use
> the default algorithm anywhere in the operation of the command, but
> we fail fairly early in the process when run outside a repository
> without any default algorithm set.
> 
> Resurrect the setting of the default algorithm just like we used to
> do before 2.46.0
> 
> Reported-by: Ilya K <me@0upti.me>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/verify-pack.c  | 4 ++++
>  t/t5300-pack-object.sh | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git c/builtin/verify-pack.c w/builtin/verify-pack.c
> index 011dddd2dc..5b663905ae 100644
> --- c/builtin/verify-pack.c
> +++ w/builtin/verify-pack.c
> @@ -1,6 +1,7 @@
>  #include "builtin.h"
>  #include "config.h"
>  #include "gettext.h"
> +#include "hash.h"
>  #include "run-command.h"
>  #include "parse-options.h"
>  #include "strbuf.h"
> @@ -77,6 +78,9 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>  
> +	if (!the_hash_algo)
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +
>  	git_config(git_default_config, NULL);
>  	argc = parse_options(argc, argv, prefix, verify_pack_options,
>  			     verify_pack_usage, 0);
> diff --git c/t/t5300-pack-object.sh w/t/t5300-pack-object.sh
> index 4ad023c846..d6f45d8923 100755
> --- c/t/t5300-pack-object.sh
> +++ w/t/t5300-pack-object.sh
> @@ -322,6 +322,10 @@ test_expect_success 'verify-pack catches a corrupted sum of the index file itsel
>  	fi
>  '
>  
> +test_expect_success 'verify-pack outside a repository' '
> +	nongit git verify-pack -v "$(pwd)/test-1-${packname_1}.idx"
> +'
> +
>  test_expect_success 'build pack index for an existing pack' '
>  	cat test-1-${packname_1}.pack >test-3.pack &&
>  	git index-pack -o tmp.idx test-3.pack &&
