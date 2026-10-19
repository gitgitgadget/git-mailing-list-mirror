Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BC33D6CB4
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390494; cv=none; b=bh3/oc6xTO18fpAf+Q+SkLTqoJzN6mDKzUnNmI3WYH3h8y7Bu1mGiFlXDG3O6Ewf7CbauORxDToPuX78REfUGukzUuMwP20kG7pWX4VVNl1sSk3ZpcBqlD723+6arh5TJ/60VfnYehCS6aF96RGiWAeB68c00auANP6S8v1Y8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390494; c=relaxed/simple;
	bh=Pe8MTiEVwRS9V4w/kJ9y7aQbEdAyldOKSulOpUeRGz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cv1Mupb5yCn5y/dfymAWYfgPKtq2HSWR17MgDOYMy1BtYZzUhFbS/e2MqrwplgbqiWvsGULvFSXBOWEeUTafDRNcLkd5nJH09QSMJbeIysOnriug/R5ob2tZojcjtAkcS6IdfkQQqbvfbBWBSS90Q3283vGm2UeZgHI7DF5QlxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HLJalBzm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=InEWx9uP; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HLJalBzm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="InEWx9uP"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id E1CCD1D000EC
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 02:14:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 19 Oct 2026 02:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792390491; x=1792476891; bh=PCaUWbWqks
	1pzSqcJVQgAzpLn/RMelbFPl6Ww/POK/o=; b=HLJalBzmcPjgxFJUBs72LHnq2y
	oH2s6oFSNOBzakTWLyFTAcIJK1Fajgns+exxfSzHAdix+NW6StwvOyaWIVC0f2BC
	uKOL+1pxCHe0Pf6gASLX4Y9M+TXVUntSqnXaexI9UQrN2q1WOPyyoxJcihe+cSnr
	/oythDKzkOCKXgbWznQp+PJjC9FtoqjwDJlD65hvF69dDzhlqbukcQWWzPL08A+g
	Ox6/UIBkzfcjAVLZS7fox4BGweYNnihmoPSKxjPzsix6Wd+pv+xIuPChe+7ARYEE
	cCoXVk6Gfi9fJNibpWd1IdYXazTfQwUgE+KnHWoyZ40PXsmWhZDbxpRx/BQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792390491; x=1792476891; bh=PCaUWbWqks1pzSqcJVQgAzpLn/RMelbFPl6
	Ww/POK/o=; b=InEWx9uPwEDaK4xFjsuUsFUwcUSCLMUwysHq7iX6PpWRs0oA4iI
	DousIEzEg5BgKdeQzEFnPrZSw+KQmfhHMBz7OlwMFHASUwBNcDU6K+1fyEAYASDP
	r/jn7PSV1znHpT97MpNBICTmBJn5KpkimO/yK/dYyVKQwxMEOeHYO/bp1FMFc54K
	87B8ktCHP8bwdltMY0Udb1E9238q2bj4+JFx7xowRyS9GW2FmX/3OLF2pSn4MCGG
	HiUUGm7L1Q0HErbR28HRgqLjIfAMLLn4bYBUdWAV0OzLwB2xuln+KlmJTEeOlIhh
	JTMV+rG3E99wT+6HfybL1AWCke0Q6V2Yclg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792390491; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:k3gOARg0N53k1b1mq/RyNmVpLVYZi5J6YgqgpEfJof+bRUq
	zqMfl0Nq3MWAt+TFDN5mabZd2RMb6lwPC1zdfqVX80blaPlUEoL8z69YIsIHDXBH
	1Y2d0snl7aX5dHRJGjeaxkR4I5O5TzUfSt/CeQmJ1Csx7Y7fk+U7i4fkg8Fy4Ru6
	7HYDvo5fa0oQeUUUv9ZFzo9fYAAe/aaT823heueMnrWhiHGmM932yB/c70wCL5T5
	v1kaJ5D/XjeZH10Kh+8LuCFOnXS4Va2+YM1ke6ytutI9CKqWC7Yrewfjk+s83tUD
	r8GLo+9YyF9lKut76vj650BRke1jSJNXW3BZk7g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Qm6FhBRUcwAemb/pPpIZODmP1vXSu5NRjdQxkFTQ+d4=:Pe8MTiEVwRS9V4w/kJ9y7aQbEdAyldOKSulOpUeRGz8=;
X-ME-Sender: <xms:W7XVastoM4VJlN7cpie3kPHnb7JqjeYeW53mpYz6nnHU9E1pY7444w>
    <xme:W7XVavefwWTcyBa14Rz67EDvFn8o61Ud8xjMxsI1wxslxALwAv3bOyK1InaN3nsml
    kZho95wIWGx9LkVJEhYJ56lCZBk3PSnAb7epHlWomjGJ-MIYcFE28Q>
X-ME-Received: <xmr:W7XValb8JbqRRiPCj7bEVLa3KlrpqIbV-8ORjVO6o6FkWpcqYML2Rg>
X-ME-Proxy-Cause: dmFkZTEJi4fRGS7wTTegeyfeFasL15IjUZ02aaYWexyMKBHVNvf1vOEi/+0MblSc9iPN/O
    hxP2jb3Yx9X7rEJ4EKZ7jZCGb3xwf6J5RYdGV2qexbEwmA6/NKwNpQupoyAPxjXgqV5PDc
    9rpZ+CKKgGbnkfWdX75oz/xOQ56TFIOXuZU2aI0rCfJm9O+jX4oJ2fpqvp9KmOjOhcaNGZ
    7h/U2KO1hw5WvjxGcqU6ejAGcD9IZGZvqyo/A3a4HHrLL7VgbihBdJwUqx5qkM9p0SYw6l
    MHDa8tw6PzpPJWT2fTgeAuF9gUtK5KYMOW0VmKFRlYs9WQZ2+nQRKRKjYRI+bhTvCU4eGp
    FWVNYUeTCi3cSxv9HrfKoMOKJ7qhydMocs8M1hSpA2fFmlLST2mNS2tY2I+5GYOu3NA0Gd
    kP4aFfHfB27TG2RT0veatLk18hq3Qa4Rr4U8nkN1i4qx6wC86pKDjR+1RK+Iqdl/qXeTD+
    JPjVyLXI6e6rMNUUx2RqfAdT0KCzHb22zbWsLXdQ+AX92JyJF0AvZ+CqDen6t4PwMWMVH/
    Jy1Th/0Jn9NJ3+PoDFnb6owWmjfL//le1p5et/d84m3ly7VbG1o8LFxMf3G07FcsSwfGk7
    Af4Qb9iEY//c4KqyZ6cf6TAvLJ46aEZJTaCXjh2Wk9O2wVW1suif+lDjqvfw
X-ME-Proxy: <xmx:W7XVaqX9A75Lf3qqVCazEZ61H1RlbMGwcssqkT07_5pwSeBnGFDfLA>
    <xmx:W7XVavi6d1E_d10fJQQvUcRCXB74ifTleLW5cnEib3IdJ_6-Q0viBA>
    <xmx:W7XVagVXLUzqdwQLToMVWZ772ioHp6qFxevrQaqjz6PgqNdUq4M6fg>
    <xmx:W7XVauM9rZUCUOagc9re9TC2q-32Z4y4hhr0YkdqSWMEWKT4Pp9Ehg>
    <xmx:W7XVane4XnsjpM92ul-XYMFi2Iza7BH1c8EgkXvAkTUyqlt-yGO-TXbU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 02:14:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 70984226 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 06:14:49 +0000 (UTC)
Date: Mon, 19 Oct 2026 08:14:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] object-file: explicitly write ".keep" lockfile
Message-ID: <atW1Vh0b406cxCZJ@pks.im>
References: <20261016022901.3838402-1-jltobler@gmail.com>
 <20261016213716.593278-1-jltobler@gmail.com>
 <20261016213716.593278-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016213716.593278-4-jltobler@gmail.com>

On Fri, Oct 16, 2026 at 04:37:15PM -0500, Justin Tobler wrote:
> diff --git a/object-file.c b/object-file.c
> index 210984f825..07a61c610a 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1256,6 +1256,47 @@ int read_loose_object(struct repository *repo,
>  	return ret;
>  }
>  
> +static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
> +			       const char *keep_msg)
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
> +	if (fd < 0) {
> +		error_errno(_("unable to create '%s'"), lock_path.buf);

Right, `safe_create_file_with_leading_directories()` guarantees that
open(3p) was the last function that was called when returning, so we
know that `errno` would be properly set.

> +		goto out;
> +	}
> +
> +	if (write_in_full(fd, contents.buf, contents.len) < 0) {
> +		error_errno(_("unable to write '%s'"), lock_path.buf);
> +		close(fd);
> +		unlink(lock_path.buf);
> +		goto out;
> +	}
> +
> +	if (close(fd) < 0) {
> +		error_errno(_("unable to close '%s'"), lock_path.buf);
> +		unlink(lock_path.buf);
> +		goto out;
> +	}

Nit: now that all error paths call `error_errno()` I would have
preferred to keep `ret` uninitialized and then assign the return value
of `error_errno()` to it. But that's a minor detail only that does not
warrant a reroll.

> @@ -1424,34 +1464,58 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
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
>  		close(child.out);
>  
>  		status = finish_command(&child);
>  		if (status) {
>  			strbuf_addstr(err_msg, "index-pack abnormal exit");
> -			return -1;
> +			goto out;
> +		}
> +
> +		if (ret) {
> +			strbuf_addstr(err_msg, "index-pack failed to report pack name");
> +			goto out;
>  		}
>  
> +		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
> +			    (uintmax_t)getpid(), hostname);
> +
> +		if (write_pack_lockfile(transaction->quarantine, pack_name.buf,
> +					keep_msg.buf)) {
> +			strbuf_addstr(err_msg, "lockfile write failed");
> +			goto out;
> +		}
> +
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
> +
>  		odb_source_prepare(transaction->quarantine,
>  				   ODB_PREPARE_FLUSH_CACHES);
> +

Nit: empty newline before curly brace.

>  	}
>  
> -	return 0;
> +	ret = 0;
> +
> +out:
> +	strbuf_release(&final_path);
> +	strbuf_release(&pack_name);
> +	strbuf_release(&keep_msg);
> +
> +	return ret;
>  }

This reads a lot better now with the unified exit path, thanks!

Patrick
