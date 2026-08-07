Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3E73AFB14
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086220; cv=none; b=UWVcwf8HCooMIIbArFGKgZiUu0pjspnLzs+JPoz85JN2CawaJfb75BrEi3AB7Bf4thEjxlnnJZdgXsHuh2F4LzcNBrUkljPCK6iUtXx+vPqaJW2bTsaDU1nME+r4EonsnRwfFs++GMqgJ7Gqc3ISiDPtfMVD/VnMJn2s1dm1Q+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086220; c=relaxed/simple;
	bh=Zrj1bFui2VZmNsoqNiMDqmkelGzx1LIfENaJvIYCzXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEbBOmMCcMU/I4GJrzZxI4mBb1xvEBdol99NS556Se/cu5Ndos2CsEo/1vXtViVr+2ap94VbU5WU4NHj2+sQDQv/E9UigDgCUSlgt2JA7Xdo+BZNTJIAOlUxJX255Jvld2votVW03Wxp3fcNyU+iMzUyJtrdyB4LlOS0dOFDiMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gk4OhItd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KNNnAy1h; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gk4OhItd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KNNnAy1h"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 72854EC0191;
	Fri,  7 Aug 2026 03:03:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 07 Aug 2026 03:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786086217; x=1786172617; bh=uKtROZLAvU
	aVl3PNbLAHDT38oUcQWHJI5P4LueYl5JU=; b=Gk4OhItdLjwBltURv5nAvlvkZl
	Do8hNNzvCpttDa5wPnLaLue5UqhKgc/jAu5KhLfgf1THV1XTC5DfEowXu8S+jDKu
	popOx5MZh/0+7wO+NmcNmy+jyqmJir78zp0FU/41SQQuXVWMR9YLY3KrZTzEXocL
	m4v+TuLqbkD9TVu2MnJ/ekEUeop2bpdNj33AF5R/ah9R89lJB2+qfDft3z0f1++l
	GwHrI8wQXqQIqowu+gE7kMxPRv1R/IZd7i2oI/3VCcbPXW8Ewu9UZlCHU+yZncBT
	T2PPJWaIb56nLJ8v4kxpAGIdFjTBE25la/7vxXT6YV+rhOjJ8pRvnA55DaRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786086217; x=1786172617; bh=uKtROZLAvUaVl3PNbLAHDT38oUcQWHJI5P4
	LueYl5JU=; b=KNNnAy1hryzB3jk6avrmI3cSTbIiqA3ORWTBl5Piqx2enLnlsFI
	WgutB+SagOZR5m6Vy3iNBlO1kPBaFdyiupSvJfSCA3u/fnkGQf7W240kavquMbvq
	VruFK25GrqYXbpKWoVgfVUzDu3L6aEIlHrOMH5IHMZHTXyKy8WL8VRIjJ2FqbDW5
	qkFh98/3908BQHr6sVYV1z9MHR4edP27Ha5TOX68bnrBKlAaaTbeXlT62AZr8D1+
	ksEQ0CLNGacJ/Bz5VqNMj4Sh5goCP0tYqsu7wRwvager6uJO71PbD8UuPX6DkzlS
	gSzl7HDHZ44a0LUfaLaUp9FeK0HfeARqc1w==
X-ME-Sender: <xms:SYN1apjdyiPOGFhR-QP1blx92fRCkQSQYP3rz6g-v-BzmxdGo4khtA>
    <xme:SYN1akCJKnHfMWEEy-4aSJpyus3oZI_1jpQ5XYLraqgRYZYXbuh8fmMwPvOTOEVNv
    _Sl16do4YjRg1qIGuFT-BZ5s5qLXqx520R_dduxqiUFedfKIhtJAg>
X-ME-Received: <xmr:SYN1amvmtKG_RrCbk5jtXgJtVuy2_CMeyn8yKDRjCQybeZIT0WcdRFuyFd212u-jYMAIZx8eEh2FKarmNsW5xidTgVZR_GYnQ96jBzpEvE6wzQ>
X-ME-Proxy-Cause: dmFkZTE26y9njCNpXPcmZxYe4ifaNpV+sYlC5mYRUIr+ln+pB38Sh4kjo5WX0zU5LY8sit
    +oeUUeuwuVDmjatud2iyJtMdnBGrHtsLnRGmbTcsfv4XslNEpw1gmYRc4vkyxvvkVzb6bZ
    FW+Hc4Ewp0bN9yMqVLHrPU0VZXSxvfa2uONHO4C1LZMZN/4xo/SlyjWqoa1PpzuveaGMel
    tb8CZN49JwAhjMMI8vzeUDPe9GRJE1Pij+NlRwONiI8W2cbrpyJAIUbCY4UmewvnRVelNo
    mmLmZkIFSOfTf9/ExxwJZ9KjT4RrzlQa8TreUzcLYfr16STGdtDWK6anYTN5DZxvjKF6oa
    xTVzlw6Ei9MH+nCriR5K78lAp2Uus/2BzWGE6ApAt5lPdw0Nolmjcr4RhQ84jaI2bHle0R
    xHxy8UqYqWgbz+qL63l3zfM3n95RdPPq+hd9aMisTSvvBZRgsoRMCEaDDXremr2TeqPBNB
    7hofnY8k+ToSURJswZnLhhgx/1E+/dVpEVdib2HN5lomdJCr3FbGQZZGVV9pciBfK0f8SZ
    GesAv46T04WK0RBHfjJ3L733X1YL81/0uhRq/pO0pD7HfYu+6SW18p6ZAfn+3BHoF3Vq7k
    hgiO/Sxfh2f0OedyAVVom63toMBgX7zUmwv0wAUTgnfijJc3netZ0SjM2BwA
X-ME-Proxy: <xmx:SYN1apaGiL3Nbh8srD04J9LzIHbiwbcJn8UWQvJXtU8Of0bmg-dPIg>
    <xmx:SYN1apWPGmxTA4YDZKb2UJjiMalDvxLS7KrikQGmbT2xQF_NsBXhTg>
    <xmx:SYN1at7rQhXPsetrORRQeOEJ5Lz_FmTwUPbAILYfHdJPSFK5aQjPVQ>
    <xmx:SYN1akiUpP0Svdl4KyRgnkd2S76to3NpKuyU27ZuvWJOLilKRQolBA>
    <xmx:SYN1ahTye-C5Q1E9utB5e5s6Uev-fYiSBCSeLcuBQg0woffCi0SaMhmM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 03:03:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 031a8841 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 07:03:36 +0000 (UTC)
Date: Fri, 7 Aug 2026 09:03:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] builtin/receive-pack: pass shallow file explicitly
Message-ID: <anWDRVA0mSQva2QX@pks.im>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260806213859.816157-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806213859.816157-3-jltobler@gmail.com>

On Thu, Aug 06, 2026 at 04:38:55PM -0500, Justin Tobler wrote:
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 420de9aa7f..6da854fca2 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -86,7 +86,6 @@ static const char *head_name;
>  static void *head_name_to_free;
>  static int sent_capabilities;
>  static int shallow_update;
> -static const char *alt_shallow_file;
>  static struct strbuf push_cert = STRBUF_INIT;
>  static struct object_id push_cert_oid;
>  static struct signature_check sigcheck;

I always like seeing less global state.

> @@ -2354,10 +2353,9 @@ static const char *unpack(int err_fd, struct shallow_info *si,
>  		return hdr_err;
>  	}
>  
> -	if (si->nr_ours || si->nr_theirs) {
> -		alt_shallow_file = setup_temporary_shallow(si->shallow);
> +	if (shallow_file) {
>  		strvec_push(&child.args, "--shallow-file");
> -		strvec_push(&child.args, alt_shallow_file);
> +		strvec_push(&child.args, shallow_file);
>  	}
>  
>  	odb_transaction_env(transaction, &child.env);

Okay, so instead of creating the shallow file here, ...

> @@ -2705,11 +2705,17 @@ int cmd_receive_pack(int argc,
>  		if (!si.nr_ours && !si.nr_theirs)
>  			shallow_update = 0;
>  		if (!delete_only(commands)) {
> +			const char *alt_shallow_file = NULL;
> +
> +			if (si.nr_ours || si.nr_theirs)
> +				alt_shallow_file = setup_temporary_shallow(si.shallow);
> +
>  			if (odb_transaction_begin(the_repository->objects, &transaction, ODB_TRANSACTION_RECEIVE))
>  				unpack_status = "unable to start object transaction";
>  			else
> -				unpack_status = unpack_with_sideband(&si, transaction);
> -			update_shallow_info(commands, &si, &ref);
> +				unpack_status = unpack_with_sideband(transaction, alt_shallow_file);
> +
> +			update_shallow_info(commands, &si, &ref, alt_shallow_file);
>  		}

... we create it in a transitive caller and then pass it down the stack.
Makes sense.

It's nice that we don't have to pass the shallow information at all
anymore as a consequence.

Patrick
