Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A879251DDE3
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169404; cv=none; b=JxU6L3A2B98G6dYcx5X/lfWGovzcfsTpfvlLzh44yahWmQq/NaSJaPb18E4LUCB8jNZBArEKywuDfxoJh3XHdHlavo/6XEvs8Nv+qa0n5cdzaDWDTPqRQ1tPTp571zv0PACuR3WqftF4+hwKOYuxDePHlxd9QmVrka1Xn5m10Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169404; c=relaxed/simple;
	bh=u4CTYhAeo4rmJZfZwxj6ubPc9LfUwo5Z84NqeX2UYTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxU/ej7HoGXh6EZjfsrQD0yQHtQP9FM6yKKlsJGaEoyDQYAxKG4y2vcXyWOA4MVKcqQ1l9mU1ECGKTgRiStD48VDAeT1b8UDVU2tNAA/gqQfz/8wtKxVUOdQeaffWkdAoES+UrPbLE+JBs5L8z07u+Wi6SAK1jDFzcqlrNiPAYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jAL5mmEd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=re6q5DxU; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jAL5mmEd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="re6q5DxU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BF6B91D000B0;
	Wed, 23 Sep 2026 09:16:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 23 Sep 2026 09:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790169401; x=1790255801; bh=9dQ9Mcd/kz
	uB4gKz8ooUFsKBpZwAv7kYbFbLY74K5CM=; b=jAL5mmEdo9r808BFlztKOhnwMO
	QaiuOFaxmkzdrkpd5rVSchEJAHmPgshjptMAxuE7OqH15oYtQP1cWmBBTIVXyC03
	SL5P4u73ewQGss3PDCAbzYsPb0/MIvZEM5D/wDn63lNsAxNozWTiZRH+t1RuNDvh
	Rb3fg/8mzE6DLrZlW+XxP83f8944/rVOjbpYnSlxe8rcvq4Hw7ubQnwDstAchlza
	hDhlzD2T7f60bM4Tc3edf5jNkwFXKXCVftxbkkI7gLpkBu5lcznV8hZajb3BGw2k
	KOdqmXWlVw+PVOD1Qpo7TUDZjQfmaM3N5ja4UzObZedH6lkgLCnoRsI31qlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790169401; x=1790255801; bh=9dQ9Mcd/kzuB4gKz8ooUFsKBpZwAv7kYbFb
	LY74K5CM=; b=re6q5DxUEELNMU3mWPqK9mAp3cjda2/mt5uVHqE+0/2Tz5njIqF
	YChOMkAbWJN62ajOFzTtISopovmDMOwE+5wSec7n+1ArwN13jkC0Jz8ycTViwg0p
	SYQfk/2zL2AOf7dYtwVjwQU0USrSPpAoz8F6f5NytAgxfPhuDg4XuGtmKVaBafLl
	hyT9bsYHeF+tSz/Hbt8UM/vW8g5ilxO5+dm1vwOLYZTeoDCC5cSGYaOSftxy3cXy
	28mezro5A+V7wEGutTOqSEOqRmvk5sjgbEAADpy3ZxnuBnu7FjVGh2m4K53srIZj
	UilOc9nJtg3KU9l1dJUeSApABgIQKcGcnrQ==
X-ME-Sender: <xms:OdGzauUn4DJSnLYkxpEB1Z88qMW0iNJhlHLEOcgi8Vw6ZoewKMOv4w>
    <xme:OdGzagla-EL6kXZ9ULyuWe3f231atAHum8NcJb9bMp9Ns2Byil7M1RYXSaPWM7jds
    FAvOb5Oa-klhs5rSPZH80sR5mIvt_-XM1364A-Ia-AR7sXUwWhCOGg>
X-ME-Received: <xmr:OdGzagBiN6fukJg36UMuwH9-wRASNn7pMpouYu2GdKY7yyqHTuX_wA>
X-ME-Proxy-Cause: dmFkZTFa1hixJCekOmaJB6nWWd1s3QrVXiTY8NHwhWqFBzRieTg1OHaRdoWuNDZz2zskZb
    rfrdf/bNe1nZIKP3Qj7z5lsT3DU/MDgJgg/vumkR3oBFEoycbYKKZjqkcEmkszlFI+6DvO
    CKT/JAULBavls/72OmW2AGizQUUOYNe9ExeMXGbQCdvEpVnBvBuumuL9kXzQPCeMEDYiMO
    wHpw3GAqPNPw7IAg4+hW2CORqN4pYwbHyJudTq1zBGxdEK1OwXVoKY1fPVJnQ5+Y4qjoel
    6Z4UOfphnkoLzQ7oeFz37TpRJSX4xfioiueDKH+S5N8l2WuVlWJ4NNJcRWUZvdAS9629NG
    AicW17NQJzOI/0yZ4gYypqzCvkpmBWc96OswvqzxMbSk4P42foYJkAJPHfdP+dDVimUDgc
    ChiOhSHTIjFmGQIViXUKUFGLYkWQnQ7XtTweqCrKwBhmn8OrgT1E2S4sAY1jlSnHgnzaZS
    o58cQqGdcNu0WyvBxEeZD6wCPW6R/z1qMhvIkWLXnKhQ2LjhtxN45R2Zblo1swGYsk9aLy
    UozfgVzecihOOLMYH0+m1lAoEwa8fs+DN35/JH5KITfgHyuhJooUjYK2GvnUZ4wmCK+jwg
    iZOn/vbwju2wwFSMpZGzAhoQkBSoVSdHo8cpinL5kOzXyEHI0dEE8Ok7ZMmg
X-ME-Proxy: <xmx:OdGzagcDe3TXFimtAYwezHxBzpx-8bRRBe3Jft00DkNXBXi9GTMYwA>
    <xmx:OdGzarIRU-Pzzahhqo8BA_CLLoyPQ_5JVR5qU9lxiTqHx0e0lm33Kw>
    <xmx:OdGzajdg9LU4N-CfQNjjQQ7psLhYlSIYzcnD2OMcI43LuWFolVkj0A>
    <xmx:OdGzai0Ux0dk-PGBxFjWCqkwnu8ZmbgAqJ80DwZmt99S2Vcn6raZzg>
    <xmx:OdGzajFZWGv8qchRg9_t1fPJOoY-3iE3EMv3SyAKeEeyxtXRZvg72UfS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 09:16:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0b2159ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Sep 2026 13:16:40 +0000 (UTC)
Date: Wed, 23 Sep 2026 15:16:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] object-file: flush transaction packfile before
 migrating objects
Message-ID: <arPRM191URNQGu7V@pks.im>
References: <cover.1789328612.git.jltobler@gmail.com>
 <18a1798d958d7f089614ec588346096c10b0666a.1789328612.git.jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18a1798d958d7f089614ec588346096c10b0666a.1789328612.git.jltobler@gmail.com>

On Sun, Sep 13, 2026 at 03:26:22PM -0500, Justin Tobler wrote:
> diff --git a/object-file.c b/object-file.c
> index 0f123b79fad1..210984f82532 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1262,6 +1262,8 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
>  		container_of(base, struct odb_transaction_files, base);
>  	int have_packfile = !!transaction->packfile.f;
>  
> +	flush_packfile_transaction(transaction);
> +
>  	if (transaction->objdir) {
>  		struct strbuf temp_path = STRBUF_INIT;
>  		struct tempfile *temp;
> @@ -1292,8 +1294,6 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
>  		transaction->objdir = NULL;
>  	}
>  
> -	flush_packfile_transaction(transaction);
> -
>  	if (have_packfile)
>  		odb_reprepare(transaction->base.source->odb);
>  

In the preceding commit you wrote:

    In a subsequent commit, repreparing the ODB is slightly deferred
    when committing a "files" ODB transaction.

But that's not really true -- you don't delay repreparing the object
database, but instead only flush earlier. The reprepare still happens at
the same point in time.

> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index d295c265c75c..fb83c8fba619 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -87,6 +87,22 @@ test_expect_success 'add a large file or two' '
>  	test $count = 1
>  '
>  
> +test_expect_success 'add large file with loose object in batch fsync' '
> +	test_when_finished "rm -rf batch" &&
> +	git init batch &&

I feel like using a subshell might've helped here for readability. But,
oh well, it saves us an extra process.

> +	git -C batch config core.bigFileThreshold 5 &&
> +	echo foo >batch/1-small &&
> +	echo foobar >batch/2-large &&
> +
> +	git -C batch -c core.fsync=loose-object -c core.fsyncMethod=batch \
> +		add 1-small 2-large &&
> +
> +	# Neither object may be left behind in a temporary location.

You don't really verify whether they are left behind, but rather verify
that the can be read. Which is a bit of a different thing.

Sorry, feels like I'm in a nitpicky mood today :)

Thanks!

Patrick
