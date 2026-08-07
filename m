Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BDD3BB103
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 04:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786076905; cv=none; b=ZMKE5x8Pg3IGLX40fyZ/ZGpDGaUCQ5Bt7AE1n7jvxPHu0S+bI8uCTrA0WkCkPKF2DV0mh3PzqfCC95m+QWXWpnc18PNxU4uzncbH65oAGaxzkowggNtIyhqjgM18SWpagz3Ux1MF5qkd1QYReHALibzHjmCokKHvULBr5ZY5oTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786076905; c=relaxed/simple;
	bh=NlctKPznehn63dJdFhjlivSmlKPXqON+t7h+CLzK9O0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YqU5MbyT5e24YbdOQOnNGR4iqdHGK62NA2FZhX2y1vJiueEPumi9K7L7vFpMlxUhtBgX23SNCuW74CPxhql0U4Y8EpiXHRLa8ARQ9nhseY/v2t2ob8rBK4SnUSIW1auW1wb6585qt7GDZd3T63FG0blOsGuyyHTUByt/5WRNPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kh675dC5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ID08ursL; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kh675dC5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ID08ursL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 64D471D0007E;
	Fri,  7 Aug 2026 00:28:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 07 Aug 2026 00:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786076901; x=1786163301; bh=gzuJ93nrx2
	dN8bsexkt1fN6SDQAw1AE3MPWoNvb6tMI=; b=Kh675dC5/182Sa9y6TIGMjvQZ+
	RcHuLARA5XmUGVDj+j1cOCjAZIeouef3I6g8lq+6Phz4OLSHnCaP+frndnkXqj3k
	smo6/RHlUQGE7ajlV0b/9BO+oGufZmmO/CFmrpsQ1oOMyKDzZDQSHH/oSWFsyeHd
	7vqcsNMG3rGjhyEh04NxWP7P7UjyE+W06ikocFqLYO7w2tUpakeirulFNAVtgAFs
	iSEe0glGRffYexqAZlZpUgkA3IMxJNQEVGZMXGmlRILRIa0kds573PbjpoHXdg1q
	4jnJr8JhXh8KiThETHDBv1gQ0Mkk7F/p2ZmRc8Shn4HcOepcKZa8AVfSOnog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786076901; x=1786163301; bh=gzuJ93nrx2dN8bsexkt1fN6SDQAw1AE3MPW
	oNvb6tMI=; b=ID08ursL8KijeFpIpMpW2795btx/95K45QfzK92xWuEbcT/E+In
	c5+lm2QUvzr9FqeqHdSZb/I6xxdlN70j++OM1tGML7W3jmniWqy4ot2hEvnNktW6
	t0PjGHkccJ2cRjZCtLHOweTKX78j0IS1/FwQPcLLtCUiiMilzhhlY6YzgC20eGEh
	loxTd+6Fnw19UTYw17EZ2NdgBNcWHXLj+iga1ShFKo9C+iRwwlGEuHlF9GfQJx7l
	Ld6eb/FLeVzaBkMwwnsez9UywCXJW8OoqHfV7IP67FqEhEyzpr3u9/6nlDpJbmF8
	mo0EEy2TyfaypsBNuJqK1HgDpDEJfBz2N0g==
X-ME-Sender: <xms:5V51akdPJdaZpLEB13ZJbBM4qGrOQjg0YsTZohcwxU7ujW1Z3HJ27Q>
    <xme:5V51atFxvXWlUrEp2iyumFOp-6KRWdlg_5AOGKlrefkYel_X4A7IfkKgzsXCmocsy
    WYrrmmhIdE-l5zRPmG75a-036Hnsv3lawkohQD-mcuPHQ00wPBPpA>
X-ME-Received: <xmr:5V51at3OqSO6YYmFaUv00mHy56I3D818Hemkc2nnUGo5tfpJnehiDNXXXaLz050PFUDWfVw_DJegr7x5l5x64c6CV58boEHQCw>
X-ME-Proxy-Cause: dmFkZTF8tghpWfxjf9ssYvutJ1h+CZ+I5WVf9Nzd3tqwpPSCTdXdZKgCAWA3WrCnm4sJQM
    c/DBWPxOnJUn3DAWvownrsRztcgm9iJe3hUyPqr+icdwBgpVosZJwKZpiFNOze3AkAWmZV
    V9BTjOvxM/S/l4DvkZVUeGczd5x5qq4E8A70IbGuiSdZUkBYLjv1W4AuwqaQoBLc8G6qdG
    xtQEthEcfKzlfGOzF5sD4/fj05huJYPierUeH98Y6aCUadaNBe9l+vggppRNEL5xTSysyA
    EQ2Gic9Dkp2tp0LyOKzAH9Fo4ou1AcAMHFKWWogJzjdHiAM3oI/RdUfIE9QNkz7E4NIplO
    +LXMJfwgJeqIGX6IefO38Nr7pXoqlPwAJvBZAJpqXPkLFxHSwAeaKve0yiUZpNQRSRjCUH
    OQQpaqbFFS/jjnD5HbNT1wyW6Cex9o4cV0BFtYgbXaiVTei1URn6jB/iHoBnN1ZTM+CO6o
    M6/JY/7LmwVx4yeqLMCBhRjF5LI3vBAV02Js4a9VJzZy7rdRNMVh9oPSTqp755Ca1DorS0
    mPUXb6Uf46UNzwq/be3Q1YQ2LTsbQ7FNxO43finMTmqxX8a+UCurlzcw0KlvsKH+Pz4q5E
    rkAPLjovoO2FiOwm6SHlZiOxrwFZ0eWMH5YGYK63ylxje20FA8m/muWx/zHw
X-ME-Proxy: <xmx:5V51alnMhJ4SjppD6qxjMqGbkXQj1CI5kLHJBRak54WR-n_dk2_Gdg>
    <xmx:5V51at-0RJNpFpd4KbqwOIN-najhOB3eX8kxchaa_5fWU4KPqgEIlw>
    <xmx:5V51aqq2UZLgmwqdAoa1D3NN3aosoBVhEEuI9Ej72Uw2Mb_ymAnLxw>
    <xmx:5V51amnK2N3WFR7S6RQWmKNWN2fl0levqgatJYNSMKqk6aBuXy9jjw>
    <xmx:5V51akCODcKd_lP3wJorA4PVqRVqL9x0V06cPtoYieMH8IEt_CMZPXI5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 00:28:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Toon Claes
 <toon@iotcl.com>
Subject: Re: [PATCH v5 4/6] setup: defer object database creation
In-Reply-To: <20260807-pks-odb-create-on-disk-v5-4-399da0b0b140@pks.im>
	(Patrick Steinhardt's message of "Fri, 07 Aug 2026 05:34:28 +0200")
References: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
	<20260807-pks-odb-create-on-disk-v5-4-399da0b0b140@pks.im>
Date: Thu, 06 Aug 2026 21:28:19 -0700
Message-ID: <xmqq1pcah7vg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/setup.c b/setup.c
> index 5dfab3e79e..97338cbc51 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1888,6 +1882,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
>  		read_and_verify_repository_format(&fmt, ".", NULL);
>  		if (apply_repository_format(repo, &fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
>  			die("%s", err.buf);
> +		repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
>  		startup_info->have_repository = 1;
>  
>  		clear_repository_format(&fmt);

The previous round corrected the overly long line while at it, but
it is no longer done here.

Which is OK either way.

> @@ -2090,6 +2085,7 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
>  			if (apply_repository_format(repo, &discovery.format,
>  						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
>  				die("%s", err.buf);
> +			repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);

Looks like the differences since the last round is truly minimum ;-)
