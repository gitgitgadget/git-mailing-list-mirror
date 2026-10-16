Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A553E0258
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133910; cv=none; b=WOH7PDMtpsH4vWjpB2y1QHKPuVO9MXyvIojGVGAj+noh6H02fK8YN3xWdFjQ/oBbcpTNh7ZFmWCQys3yxDohFLUK7K4KN/+cYlQj7ntTlQkBZ6O9pTOOgm9YtlLVXYKtBLdrjz6JK0kYFtA/RiEJLGTHg3OH310OXffIuCpLRaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133910; c=relaxed/simple;
	bh=H5OwvkzS6iIuZy0PnnYg9LgJKT6QzD9BBGDs3tbUmRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePB/pjofigEbIN3+XdpiL/Gd8VJAXtJc0KTkLbex6vkyV/05+/OjORH+AtvwLFHHrDUkxjNkMMd6Ck/mGjCH0G6ch1XV+SCgZ60pi7UkeZQvA3l4M+hgN745MALnQ7tdXbZ6+hjGnTQlSSyqp4fFXpgsUSeGDROEAUo2YZ9BdhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jyQ0UMdW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GbCcsVNl; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jyQ0UMdW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GbCcsVNl"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E0BD714000E3
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 02:58:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Oct 2026 02:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792133907; x=1792220307; bh=An9uHj55i1
	EaPYcE5+fbORBwvtMP1ZR7T/WyXXnbjjM=; b=jyQ0UMdWOZU2kNrpYgvkLg9iqL
	ssEvYyJaMfFGAn1Mcr6kyOzer7wYrp61Hz2eRIVIdwLdC/8Eh2AvjzEi0NFJGgYC
	4xEYFvZ3swc/s40x9Mv5ujreHlO3LGZWOR4OOxWvfCsKhAlGKJpfk6zBnmpb2hwv
	hg2lNoThOjuga3gEmw4sSAKgdZBC1XgSjeVuvkBrqztvktV3A9VxCBxuxkX2zXo2
	EerKy3FFLEwttJf+/vfjx9bwRCJK5aF40Te9yAt1Zxc4eGP+zvJGMPKbwpcsPJRJ
	/yBmKgrNJYebswXmJ6V3Ii3BRalJbUKrzK0oJuLG9U3riINjpqGkpQxOgjVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792133907; x=1792220307; bh=An9uHj55i1EaPYcE5+fbORBwvtMP1ZR7T/W
	yXXnbjjM=; b=GbCcsVNlLaDXw/cX74fAOoZx786V5XJtE+JpsY6XluJrgxy23h+
	l9kN0EImykBS18y3gbdn8VCBdaczD9QfAeD3GuPfk0VZSWqX0fWgGU2kofOaxnJR
	z+h9qMMVZqfuVrw3/7AwN4nDk5b0VZrKpjLMpVt6LOzs+PVZtVarSyAIUgRvMSG/
	QJO6kFrdljjubkJJanydifsqsscb9prtqa5yatCOUjoN4VCbT855QajgtBPMeVWk
	/xSdGyUDQdpcl2XrsVcLMTZjckdCpay0afAAfa2RVsPUfJlez0KswgYKju5ZJ5IE
	yiJieC8Yyl2ayP15Ax4wluMaK14PqSUHrDw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792133907; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AJGXdDlWFUHoCaCHs2Z/zRc122hzkQkfc/zsALiLmAagcwT
	3o4e/KdBcyCY9VdJKs3QOZjDBts13zGrcVZ4gmyNo4FsbJdMubreb4GTE5y2gBTD
	D7eMtZXOlRwvATA6CpEhxRAQx3NG56D+vo0Esn5BfMKusY92BpX/Gb0JaLH7I4vE
	dGTLs1LggpZX0Fu8IevBaG+GChMqYzP+f8ZTdz93x6hDiRBFIU/jDK+62eZGnMYX
	DhJw9oYlwbGZd+udZ0Af4jwqh0OPhz4vHIbuLdxMRm/Zi8EQfF1yW1Dy0D9ptTWp
	AbbjyhCwEcJaBRGuH4Y9J4LaHJQk1tdL7EjaMdQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3Pcu8wbfdCZBXDV2P2NYQOUu5rKpG74XM8dFNoDb/Hs=:H5OwvkzS6iIuZy0PnnYg9LgJKT6QzD9BBGDs3tbUmRM=;
X-ME-Sender: <xms:E8vRau8H_-4twEtixZSAZDtzcJKCCbVEtte3n1ZYuIYzvmLSmckr6w>
    <xme:E8vRaku6nk4QChT8kNch65_dqlvJkorxxeKLfKEHudWVJaojnRAIuv74dlPz63t_L
    BkBlfgJGaauQdW1sI3VuC_twBoGM-C6u3yB2VjktoCjlaifc6wjWCk>
X-ME-Received: <xmr:E8vRahqqYRDbfofcwRlyUvPQNNO_TWhjPO7OBux3c6V1PaeYO_Ej-g>
X-ME-Proxy-Cause: dmFkZTFGoFjsx/d+3hw8CfhsT/b0+6zumOST0Dxk8obmKWjvcgc6uFR7RPyk4qNQP6cDUN
    V8wExRHZNwtTW/fPtnq3A9iunZx5/ji2neNmsihFjcHFWOMXpRA6UqjPZvOBNh0cbpSnkT
    Y1Zs86NuuWiGbATFTgjLi4s7w8XFk6TlWbtDJVuQ8tx022VXBfo/DZ/WcnDRRqF5Z1kQFp
    Sq0nDCBKbwA/xLcbgcb/Ooppm4Vj/0gLmw8Dzf1+oUJFxiHb4MlH3p+dI48UQSTYMQ+STJ
    aw1jOV3YgSsugdC62ayJTatG76SzBb9cF4vBazERq1xzoPcwgux2mhSiomKbx07hs6DZtF
    GYAayH9KSdoBhN5ggQeBY56AQxHF9GLh/9UgMIs5gBBRgQIQKRzOCLXtVumpyzWnt/2aSS
    qhrBdKd1M+xVxsOPfo8s5rbP+ssl9ZOrPdDWdVTqm5q1lsWO+H9CRjZJhHFN0Dp3FBukDG
    8L16hczp1qLFfXnKTt3CDPj06B3mr/IFh2A1mLfaXw11WukFVIkouId6gvBWo7eeHOMPnX
    3+mU0BOEGu6zWJg02OKW9ayF5eead27RQIwrhTfvviyjOCBikY5xNx0Ssa02smuRsjyHV4
    DqBp6EzG/UYkKtypMQMVHpaPPG/XC0Fj4eKBXaWJsolOlB2N+5CoCkiq5hhQ
X-ME-Proxy: <xmx:E8vRahkSOzyN7MBD9oR32Uq5rWuwBUQfgv83gu06_CegSUBj_8y7og>
    <xmx:E8vRalyoO_48l5VTTKlQbK9aYU8u4d81vQXT1XjNQpxrwG4lhrEwxA>
    <xmx:E8vRaplCEXOKz-HLs9t-Jd4jomNDXeuhzbagqlRguf8xE4o1moUrYw>
    <xmx:E8vRaueDz25sxkpiwr2NFK3WXfeB1PYoLhEWMnvPuE3q_wzM9kzT-w>
    <xmx:E8vRatupuAslv0eqI4WEub3DsyqDF_8BncoP1891ZIEGdzHENrOQQfkM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 02:58:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a9263494 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Oct 2026 06:58:26 +0000 (UTC)
Date: Fri, 16 Oct 2026 08:58:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] object-file: explicitly write ".keep" lockfile
Message-ID: <atHLDysZmYGyMiKk@pks.im>
References: <20261016022901.3838402-1-jltobler@gmail.com>
 <20261016022901.3838402-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016022901.3838402-3-jltobler@gmail.com>

On Thu, Oct 15, 2026 at 09:29:00PM -0500, Justin Tobler wrote:
> diff --git a/object-file.c b/object-file.c
> index 210984f825..ebe46d35de 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1256,6 +1256,43 @@ int read_loose_object(struct repository *repo,
>  	return ret;
>  }
>  
> +static int write_pack_lock(struct odb_source *source, const char *pack_name,
> +			   const char *keep_msg)

Nit: I'd have called this `write_pack_keep()`, but I see that we refer
to the files as "lock" in `index_pack_lockfile(), too. Should we align
those two functions and call this `write_pack_lockfile()`?

> +{
> +	struct strbuf lock_path = STRBUF_INIT;
> +	struct strbuf contents = STRBUF_INIT;
> +	int ret = -1;
> +	int fd;
> +
> +	strbuf_addf(&lock_path, "%s/pack/pack-%s.keep",
> +		    source->path, pack_name);
> +	strbuf_addf(&contents, "%s\n", keep_msg);
> +
> +	fd = safe_create_file_with_leading_directories(source->odb->repo,
> +						       lock_path.buf);

The command has just written its packfile, so can't we assume that
leading directories have already been created?

> +	if (fd < 0)
> +		goto out;
> +
> +	if (write_in_full(fd, contents.buf, contents.len) < 0) {
> +		close(fd);
> +		unlink(lock_path.buf);
> +		goto out;
> +	}
> +
> +	if (close(fd)) {

`if (close(fd) < 0)`, just to be consistent.

> @@ -1389,18 +1426,17 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
>  			return -1;
>  		}
>  	} else {
> +		struct strbuf final_path = STRBUF_INIT;
> +		struct strbuf pack_name = STRBUF_INIT;
> +		struct strbuf keep_msg = STRBUF_INIT;
>  		char hostname[HOST_NAME_MAX + 1];
> -		char *lockfile;
> +		int ret;
>  
>  		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
>  		push_header_arg(&child.args, &hdr);
>  
>  		if (xgethostname(hostname, sizeof(hostname)))
>  			xsnprintf(hostname, sizeof(hostname), "localhost");
> -		strvec_pushf(&child.args,
> -			     "--keep=receive-pack %"PRIuMAX" on %s",
> -			     (uintmax_t)getpid(),
> -			     hostname);

Okay. So instead of asking git-index-pack(1) to write the ".keep" file,
we now...

> @@ -1424,31 +1460,54 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
>  			return -1;
>  		}
>  
> -		/*
> -		 * The lockfile filepath is expected to be the final location of
> -		 * the ".keep" file after being migrated to the main ODB source.
> -		 * This ensures the lockfile can be found and removed later
> -		 * after the ODB transaction has been committed.
> -		 */
> -		lockfile = index_pack_lockfile(base->source, child.out, NULL);
> -		if (lockfile) {
> -			ALLOC_GROW(transaction->pack_lockfiles,
> -				   transaction->pack_lockfiles_nr + 1,
> -				   transaction->pack_lockfiles_alloc);
> -			transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
> -				register_tempfile(lockfile);
> -			free(lockfile);
> -		}
> +		ret = read_index_pack_report(repo, child.out, &pack_name, NULL);
> +

... read its stdout to figure out where the packfile was written to
and...

>  		status = finish_command(&child);
>  		if (status) {
> +			strbuf_release(&pack_name);
>  			strbuf_addstr(err_msg, "index-pack abnormal exit");
>  			return -1;
>  		}
>  
> +		if (ret) {
> +			strbuf_release(&pack_name);
> +			strbuf_addstr(err_msg, "index-pack failed to report pack name");
> +			return -1;
> +		}
> +
> +		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
> +			    (uintmax_t)getpid(), hostname);
> +
> +		if (write_pack_lock(transaction->quarantine, pack_name.buf, keep_msg.buf)) {
> +			strbuf_release(&pack_name);
> +			strbuf_release(&keep_msg);
> +			strbuf_addstr(err_msg, "lockfile write failed");
> +			return -1;
> +		}

... then write the lockfile ourselves.

By the way, the error handling here starts to become unwieldy. Can we
maybe have a common exit path that releases all resources for us?

> +		ALLOC_GROW(transaction->pack_lockfiles,
> +			   transaction->pack_lockfiles_nr + 1,
> +			   transaction->pack_lockfiles_alloc);
> +
> +		/*
> +		 * The lockfile filepath is expected to be the final location of
> +		 * the ".keep" file after being migrated to the main ODB source.
> +		 * This ensures the lockfile can be found and removed later
> +		 * after the ODB transaction has been committed.
> +		 */
> +		strbuf_addf(&final_path, "%s/pack/pack-%s.keep",
> +			    base->source->path, pack_name.buf);
> +		transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
> +			register_tempfile(final_path.buf);

So here we retain the status quo, which is to record the lockfile in the
final location even though it doesn't exist there yet. And that can lead
to us pruning a pack lockfile from a different process.

Patrick
