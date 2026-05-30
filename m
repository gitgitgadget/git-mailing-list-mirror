Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52A371CF5
	for <git@vger.kernel.org>; Sat, 30 May 2026 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780183047; cv=none; b=bF/OG5WvMOZaYsv7rn8yr3k1WLcDlU18u4RKWA3+VPrtTr0CskNMcH2PUMyAJZ3Js3zAj19mHrPCeZvdE5kbpdIIPk38BQQgEu20fyVyyX1hPZgsLmQa16hc3iwxJ+mBIJceRbJ3h0tnedF0NJV+bh4GnPaT9G7De/iWeU9OmJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780183047; c=relaxed/simple;
	bh=p04w58rwxbNCX7YHeDL8RJ5G4qE+l5RCpdXOgk46Brg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TrO+iHH+s5YMyexYEB3GWh70uuNeYLIpirkG2axBAP9dYdiWWRkB/dMFM+MNo4AKtwsj6IPAFZzYWHP3K8oCVdOdJlfcwLqoClUdkxN0QsGhll/5d34VKiPFnJMMMNMR+RuzJaJ8NkjgIy4iNHACxo/UtRYKnPQ9iAdSII9oucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y9r/D2ZA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rkWRP+KH; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y9r/D2ZA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rkWRP+KH"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id C101B1D00031;
	Sat, 30 May 2026 19:17:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Sat, 30 May 2026 19:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780183044; x=1780269444; bh=UPIg9BhtUV
	QLrl74hyCwWc2qQqGVMfBEWT2hCPGg0Jw=; b=Y9r/D2ZAFzReEUJxH66OdzBqOD
	hNBNolkOj3FRWWqksggnYhSAWSSqw4g3diepieKEewryUNfztj100cog8tjNPVz7
	/fSlQixbHGtFQELlKE00hZ/btvqPuDqKrpWvex+RClhRapboFqbrAV+oJrOaS6pt
	m6VFNslqA9K3vcZPpZvxGTOw9/YjjZBYlIRqE3K2N2bWaqbRfNHXm3aWSTtlBgd+
	iJ53S4u2zMypUzmiYSqPBBkFRE5mxj0hXTvYQuq2GvbIJZVbI1hst3FPSqC0Rhej
	3kFT9fablvYYfT2TaRQqwLBk0+vcqCRmZhlWjLqAGbZo0ziyKtLlhoQFH99w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780183044; x=1780269444; bh=UPIg9BhtUVQLrl74hyCwWc2qQqGVMfBEWT2
	hCPGg0Jw=; b=rkWRP+KHH80bupspjbHDAExsT1Mrsl57/1iAhEKJ415gLPVF0t7
	bt/Ev1lOJmu7yP199mHFvHKLwN7//HBikzzN0dn1UBeEc/t7y092lcAUtm0suin7
	iYjZ3CqEjs2NKm18fRCamyPkiofVHaSHVe0IGkqdsnZZ208Fy6t4kxoQT6pjwlY2
	1VEYdV+jzff8dL+xNJWTOfeUl3BQpj3r+i3rmTL4NpW4r/NcWeqcV4Ws7Hgi24ST
	EV5MNdfQSrJLlYTU/r9ccWZvoxLkgC10OQlm6PcbrOMzEYpYCrPoVJg4hi0mcBba
	Fk8VfJkyK1/uliAOugGBdaMmoLjmoj0FAiQ==
X-ME-Sender: <xms:BHAbanzo6soEzvFxVBIh_HC4rILvzPPRN6EvFiFZBX1Hno-T-_eYLA>
    <xme:BHAbahhpAkxUKbwv4x9-979wjvtwmxoicHmy6WA628k99gW-rjZle0kNUWdg9vKbz
    3JRlkPnH5zN-1fHKrAChPvgUNS1j1avVYCZClsVizg2YBEQDY9dvw>
X-ME-Received: <xmr:BHAbajkr1iQL8LrCuj2e-JDId1N9VnICp51ftmq-bpnwSeIe29yCQ2eSVONPg59Q9Rewd6hvWXdutH_bOL9VFYAffIbSRQcRN69w>
X-ME-Proxy-Cause: dmFkZTEb5C+VVXcpa/dSncBXF/AIby5VrjINLUa6Kvo9ILAi9u/2hFEl2vDg/GtzXrWCtk
    ISv4hxrvNsEL63lGxDK4nrfZv6QcyhipAdGGQZjyCoP67pCiAHgtqRDss14Qj4u/7OtCN+
    v60R0h6zi5X8eYNKW0esItrpBdwL9nH58F6Iu9rYE8s5pcHDLBEzgZVQAmG2/vMd7J9fdn
    ZWX6g82V97FSw8gL4FDvPGLeEzISxhpw/oZszdRTQ0xSRmrz0SuZ8EYoWHgVzAD2p0+cPn
    UgPGNG0PYhTG4QFKRGHl2iPh3kGQjOsiGIrEhW3xOQCjdVdliB55+Mq4kP1wfsM6ZU1mle
    JlZESZy1FcG3tKPGfegpKu1tHTTyx+xzvxuMbKQ5Xq5xbpp2wrpDPipFHMrbQcmKcGwuPO
    oY1UzkcZlDY2TZS6dxDYB5OA/ZF2TWDiFsPGoFjlFYGwn+lBBVFyHH9IkC/rQZBAUuD1Es
    J+fHXvwecA8pA0rZ4M0QPkrWw/tqlmRIMhqh0Nn4N/KDA8Ly1aT9KM3A5t0d4sbmtAUclc
    /VZFg1kknpP1cC1wqVESksFXSMB2c9kGhHTFpPiCifDD3xOd/nBMBJK+FYqFqoAwupPTZn
    MClzro7obUWSa5A9ng4V9nTDBBBW3gX9yYWTeqKwetdUOVEpNuRXsHNzTxFg
X-ME-Proxy: <xmx:BHAbangLQe_xk5HvuDjouovYOykyrq5sJL8Y_a39NW5B7bj2OeMudA>
    <xmx:BHAban2GVDkoHaKGBqz2qLGfpPbsSZmyUZxRLWOoIyxpxqWM04pPCA>
    <xmx:BHAbagLxWg0OQgxbO1qOaw8lI-2Imi1QV1WrNIkc3m2COmj-Ogr6NA>
    <xmx:BHAbanzF8sHcbCt9TrEYYlwtVOdSUhkx28YxOcF7_ngp17yq41Wj1Q>
    <xmx:BHAbajMAWasoQrFJB9YtLyQAqvM2P1UlUsDsmXyDsFV1S0lgJbqJjvya>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 May 2026 19:17:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,  Ayush
 Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v1 3/4] environment: move 'trust_executable_bit' into
 repo_config_values
In-Reply-To: <20260530160520.77859-4-cat@malon.dev> (Tian Yuchen's message of
	"Sun, 31 May 2026 00:05:18 +0800")
References: <20260530160520.77859-1-cat@malon.dev>
	<20260530160520.77859-4-cat@malon.dev>
Date: Sun, 31 May 2026 08:17:22 +0900
Message-ID: <xmqq7bokebct.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> diff --git a/apply.c b/apply.c
> index 249248d4f2..73ca9907f8 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3890,10 +3890,12 @@ static int check_preimage(struct apply_state *state,
>  	}
>  
>  	if (!state->cached && !previous) {
> +		struct repo_config_values *cfg = repo_config_values(the_repository);
> +
>  		if (*ce && !(*ce)->ce_mode)
>  			BUG("ce_mode == 0 for path '%s'", old_name);
>  
> -		if (trust_executable_bit || !S_ISREG(st->st_mode))
> +		if (cfg->trust_executable_bit || !S_ISREG(st->st_mode))
>  			st_mode = ce_mode_from_stat(*ce, st->st_mode);
>  		else if (*ce)
>  			st_mode = (*ce)->ce_mode;
> diff --git a/read-cache.c b/read-cache.c
> index 54150fe756..18af533649 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -204,10 +204,12 @@ void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, st
>  
>  unsigned int ce_mode_from_stat(const struct cache_entry *ce, unsigned int mode)
>  {
> +	struct repo_config_values *cfg = repo_config_values(the_repository);
> +
>  	if (!has_symlinks && S_ISREG(mode) &&
>  	    ce && S_ISLNK(ce->ce_mode))
>  		return ce->ce_mode;
> -	if (!trust_executable_bit && S_ISREG(mode)) {
> +	if (!cfg->trust_executable_bit && S_ISREG(mode)) {
>  		if (ce && S_ISREG(ce->ce_mode))
>  			return ce->ce_mode;
>  		return create_ce_mode(0666);

How hot are the code paths that call into this helper function?  In
the original under some condition, it was possible to return without
even consulting the trust_executable_bit variable, but in the
updated code, the helper unconditionally makes a call to the
repo_config_values() helper function even before it knows it needs
to know the value of trust_executable_bit.

> @@ -217,11 +219,13 @@ unsigned int ce_mode_from_stat(const struct cache_entry *ce, unsigned int mode)
>  
>  static unsigned int st_mode_from_ce(const struct cache_entry *ce)
>  {
> +	struct repo_config_values *cfg = repo_config_values(the_repository);
> +
>  	switch (ce->ce_mode & S_IFMT) {
>  	case S_IFLNK:
>  		return has_symlinks ? S_IFLNK : (S_IFREG | 0644);
>  	case S_IFREG:
> -		return (ce->ce_mode & (trust_executable_bit ? 0755 : 0644)) | S_IFREG;
> +		return (ce->ce_mode & (cfg->trust_executable_bit ? 0755 : 0644)) | S_IFREG;
>  	case S_IFGITLINK:
>  		return S_IFDIR | 0755;
>  	case S_IFDIR:

Ditto.

> @@ -321,6 +325,7 @@ static int ce_modified_check_fs(struct index_state *istate,
>  static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
>  {
>  	unsigned int changed = 0;
> +	struct repo_config_values *cfg = repo_config_values(the_repository);
>  
>  	if (ce->ce_flags & CE_REMOVE)
>  		return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;
> @@ -331,7 +336,7 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
>  		/* We consider only the owner x bit to be relevant for
>  		 * "mode changes"
>  		 */
> -		if (trust_executable_bit &&
> +		if (cfg->trust_executable_bit &&
>  		    (0100 & (ce->ce_mode ^ st->st_mode)))
>  			changed |= MODE_CHANGED;
>  		break;

Ditto.

> @@ -732,6 +737,8 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>  			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
>  	unsigned hash_flags = pretend ? 0 : INDEX_WRITE_OBJECT;
>  
> +	struct repo_config_values *cfg = repo_config_values(the_repository);
> +

Lose the excess blank line before the new declaration.

>  	if (flags & ADD_CACHE_RENORMALIZE)
>  		hash_flags |= INDEX_RENORMALIZE;
>  
> @@ -752,7 +759,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>  		ce->ce_flags |= CE_INTENT_TO_ADD;
>  
>  
> -	if (trust_executable_bit && has_symlinks) {
> +	if (cfg->trust_executable_bit && has_symlinks) {
>  		ce->ce_mode = create_ce_mode(st_mode);
>  	} else {
>  		/* If there is an existing entry, pick the mode bits and type

Almost all of these places that care about trust_executable_bit also
cares about has_symlinks.  I wonder if they should be converted to
repo-local settings in the same series.
