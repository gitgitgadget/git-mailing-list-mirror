Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9FC39794A
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133915; cv=none; b=hO19zP59asQOjl7PpMeEjJo83Iu8m3pHTGLoWBDzqQErEdMsrtmh0fegagD1S+mthp5343HGduskesSVWz8tFwjwhDwchpq1W5GHKnPcIEJTV9ikkY20sXLg8qBQnuCrH37/8/SrT9c5b7g2gnDWLID3JxtsNZz82BHdpLffQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133915; c=relaxed/simple;
	bh=l3TjV3pOO4wyWAJhnC+uLw/9hy3o3Dibdc7lxOL8Jo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0CBACaVT6P4jOfhgSMEIk0Rzg92KNVumrdux8CTyB2WYvSxfZ3vArx1guiMThTPd355ZiKt6HXSyDfS5tbYmiDHW1CMsMvTjNmNLNb5vxX7yyn/GEIpnOXF3FjUPELAFvBGpkqcDbHmkmekV3ywG3dGARBjQWi33zCeDXlMyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OOSwvDnD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GgMPKIsa; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OOSwvDnD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GgMPKIsa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E413BEC00B8
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 02:58:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 16 Oct 2026 02:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792133912; x=1792220312; bh=mMecyhLSvo
	w5R9BYww7Bat7k4Z3VImSKmbnsC0BBcLE=; b=OOSwvDnDv8UCkooZ1oyd6bF+02
	PfrEVhckEoIiIAn/25qMo1822Ioa4T+EvYYmHjW0mqELeNWjLWK43TJv9+XGX5Aw
	jVlWYbP0T3bfcHicJC60a4z5LiVg2dI36S/Pw4lJ7Kwtos64yx/7E19yG/77lfja
	rXQOCjFKh0kq5LhhKZFcmkoiJsqa0lfDpK6VPqR4ntvfRvSHRzImqY0QXhWZE/bL
	nqKrqwIRNp/n81eEEwVY7XtGRb9xpOzyT7NJuzL/lDUd0kFWMp5VOX0SxsOp8sP2
	LttDuKpWbWEnRd/kAg4blFIgjNAPDb6TlzdMDGY0BeJO9/Vlv9x0t6rwYIIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792133912; x=1792220312; bh=mMecyhLSvow5R9BYww7Bat7k4Z3VImSKmbn
	sC0BBcLE=; b=GgMPKIsaoXaUZ7cwBKOoYJUUVEdtUJd7Z3QLXSiHCqIFSJmTxzo
	PjInGe2lfcTAQPknVKwMKrBIeVYjTlcGt32NNbez3Rn/wIS5seiucq7ok5hv7SV4
	sKKX/OfLGw4hxRcxiJtImJNgAygB5h/EmonE3ILWFunOn7tUW2Q1l+ClFegvKqbw
	5A3Z4L18l484ijJbtOK3LX55wiWrhC0M642KseQoKkRnWvB0esSLXI/bOjNv7huT
	J+JCgNJXMpAV54GvTmCgPaER6JiU1jhKvRHKTNxhaUf7Cv6rsLz8MFE0hq/Gouu+
	zUoR24GFunOPunrYZ41fiSHRy5x7+3bQSWQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792133912; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:GpVrGxlNqovScHwUzDhB84ciiH0ZYkDtUo/SDzswAo5ghrm
	IpwX58MFmt0HWu0fa6r5FrU8r0uCJ/pVFuDhbQHqExYeqgIGlHOFdQOae54qx5f/
	dnLXv7F20LDASPdEyehP20C8a21vblYRF5IakZUiWnt1YQPoPYj6KWqDBnocbXWk
	OU5t67sjMsobcpkWkMGF2oSEAC0c7qiHletirWuNR1z2UmMiiHa60R9+pwSlpRl8
	RfUlvjwDFy0dnad1hqLWHRCbzlN4iEeckHsONbP/OYW7xbpQuyu/nClKaJBZbpLE
	25p+PYUd3H9xZI3Mti0P7E6vYHxPON3zVEITszA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6ZHZrvMaGMEPZHJaqxw+iyy/9fVcDD67b5B8tVYuuvg=:l3TjV3pOO4wyWAJhnC+uLw/9hy3o3Dibdc7lxOL8Jo0=;
X-ME-Sender: <xms:GMvRamv2-gO0oDOr7NkNVhmvysfm4Mm-aMPH2WQVLS5yO8OHKsF8qA>
    <xme:GMvRai4FtdHcySQBIyeo9hMUWVlsUlIx_gQ1LW1z_TMZYsjkS1eFxp7Qcx7fPwXlS
    kxcePG1RNk54u_SwWjYiYK2xI-cGqPNxiHv_YYrV1r0SGIOKPUWRJAa>
X-ME-Received: <xmr:GMvRavKQoMuPnUEb8AjftT21AyPIPj9M72lnG5S0g1KebCHJncptVw>
X-ME-Proxy-Cause: dmFkZTGHvgxDFnImlGop40KwU3bRUSEKLoiD9eWJihBrXakBN0JANQyDupg8Xzey+84UHk
    h883Q17uBUpUMnn9Bbs/1azxo0H1cSpzf78CQLuS//jnYD/0zXqeiHQ/Wpwyu5fHrGvP68
    OucZEj6H02rkDN4++14y1zlW4m/DmQutB2EXmK5GxDIdCeNN3Wtse+lxFWOz0/Xidf71IX
    xb5KYj+XTph1yy1yx3tlt5DMrM3eSUAqnMVmR0aEHUnXsTM0ZVdcQ5gYoT4eMEB2JfG+mF
    77IKjdc/1pSDxuIJuL+uwSa6RHMx4cIlOVxzvMzY04qx8TugEcIYa4s9bhbpZGvCqYtpAx
    J1nNXbV4RkBamAR/egN2zopZ7e3d9cPoz1qUP9oql7WGJZ05QvrfNp6Z7pfW9GeBP4cOml
    end85wweSuP+Hc3ynnrHiskkUCj77Pjy8kfOpu4OPnaZGqKqTonMv+l7zt0ewx15LKXfnf
    0yx0e1PvmcNE+B3t6dVM+aWgLgQdMVyGRF86ZcPmtXOufsybKypGPq1gzOXeLJwiyYRzXm
    oV/VGvoLf0myhulPWLdE8+em+IO5ng04eArKRBcc/OFoKlFWltBD816W6Zq7Ktur1/7wNS
    EfUNXLmSZNkpTtSQ21kfC816jL//crq+8eS4y78sO/EE0t2brJMAN95paYOQ
X-ME-Proxy: <xmx:GMvRaq6meVnugk_tcmN5RLlAndqQlVAO15znBzMkLj-El4b7kUW9pw>
    <xmx:GMvRaqzHVVtmlkzLLtmY287NsUmBdcKhq1UitPSgaEFMdcAcYUfWwg>
    <xmx:GMvRamYNDDqIK5zUKnunol-NXGHPVNWds7Ht41pyTGMUucvi0NF28A>
    <xmx:GMvRakRiBscwkBzlNisvlQYc_yiYfnxHg9dBh4IQLA_H0meBN-Fgfw>
    <xmx:GMvRaouFUu0-KccWMkNXY8tmvsau0uGiXzYhn18gVkt0GfH_9a-UWKr6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 02:58:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3dc90190 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Oct 2026 06:58:31 +0000 (UTC)
Date: Fri, 16 Oct 2026 08:58:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Qin ShiCheng <qeesung@live.com>
Subject: Re: [PATCH 3/3] object-file: write ".keep" lockfiles during
 transaction commit
Message-ID: <atHLFIp8MI729ZkP@pks.im>
References: <20261016022901.3838402-1-jltobler@gmail.com>
 <20261016022901.3838402-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016022901.3838402-4-jltobler@gmail.com>

On Thu, Oct 15, 2026 at 09:29:01PM -0500, Justin Tobler wrote:
> The "files" ODB backend writes a ".keep" lockfile into the transaction
> quarantine directory via `odb_transaction_files_write_pack()`. When the
> ODB transaction is committed, the ".keep" lockfile is migrated to the
> primary ODB alongside its packfile. Writing the temporary lockfile in
> this manner has a couple of downsides:
> 
>   - Failing to migrate the lockfile during transaction commit due to a
>     concurrent process already acquiring the same lock still allows the
>     rest of the transaction to be migrated into the primary ODB. This
>     dirties the primary ODB with new objects even though no references
>     were updated and the operation failed.

I'm not fully sure I understand this downside. Are you saying that we
fail to migrate the lockfile, then continue migrating everything else
only to then fail the whole transaction?

... skipping ahead a bit...

Oh, I get it now. You propose to first acquire all lockfiles before
migrating anything so that we cannot conflict with a concurrent process
that aims to claim the same locks.

That will of course mean that we will fail the transaction for any
concurrent process that happens to write the same packfiles. But based
on what you claim that was already the case anyway, but now we notice
early and thus won't commit parts of the transaction. Makes sense.

>   - Even more concerning, the ".keep" tempfile atexit(3) handler tries
>     to remove any lockfile of the same name regardless of whether it was
>     created by the same process. If the ".keep" lockfile of the same
>     name for a concurrent process gets deleted prematurely, its packfile
>     becomes at risk of being deleted by concurrent housekeeping.

And this is the other issue that you've already been hinting at.

> diff --git a/object-file.c b/object-file.c
> index ebe46d35de..39e6299be1 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1321,6 +1357,9 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
>  		delete_tempfile(&temp);
>  		strbuf_release(&temp_path);
>  
> +		if (write_pack_locks(transaction))
> +			return error(_("unable to lock packfiles"));

Okay, we'll now write lockfiles before migrating any of the data. So if
any of the files already happens to exist, we'll bail out here. It would
have been great to maybe also provide a proper failure message via errno
for example, but okay.

> @@ -1477,37 +1510,12 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
>  			return -1;
>  		}
>  
> -		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
> -			    (uintmax_t)getpid(), hostname);
> -
> -		if (write_pack_lock(transaction->quarantine, pack_name.buf, keep_msg.buf)) {
> -			strbuf_release(&pack_name);
> -			strbuf_release(&keep_msg);
> -			strbuf_addstr(err_msg, "lockfile write failed");
> -			return -1;
> -		}

And here we stop writing lockfiles when writing the pack.

> diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
> index 1b7097179e..cf349eee2c 100755
> --- a/t/t5547-push-quarantine.sh
> +++ b/t/t5547-push-quarantine.sh
> @@ -77,10 +77,9 @@ test_expect_success '.keep file is removed after push' '
>  	git -C keep.git config set receive.unpackLimit 0 &&
>  
>  	# While incoming objects are still quarantined, validate that the
> -	# ".keep" lockfile is present in the quarantine directory.
> +	# ".keep" lockfile is not present in the quarantine directory.
>  	test_hook -C keep.git pre-receive <<-\EOF &&
> -	keep="$(ls "$GIT_QUARANTINE_PATH"/pack/pack-*.keep)" &&
> -	test -f "$keep"
> +	test ! -e "$GIT_QUARANTINE_PATH"/pack/pack-*.keep
>  	EOF
>  
>  	# After quarantined objects are migrated, validate that the ".keep"
> @@ -101,4 +100,28 @@ test_expect_success '.keep file is removed after push' '
>  	test_path_is_missing "$keep"
>  '
>  
> +test_expect_success '.keep file created outside of process is not removed' '
> +	test_when_finished rm -rf keep.git &&
> +	git init --bare keep.git &&
> +
> +	git -C keep.git config set receive.unpackLimit 0 &&
> +
> +	# Create a ".keep" lockfile matching the packfile to simulate a
> +	# concurrent git-receive-pack(1) that was already written its lockfile.
> +	test_hook -C keep.git pre-receive <<-\EOF &&
> +	pack="$(ls "$GIT_QUARANTINE_PATH"/pack/pack-*.pack)" &&
> +	pack="${pack##*/}" &&
> +	echo "baz" >"objects/pack/${pack%.pack}.keep"
> +	EOF
> +
> +	test_commit bar &&
> +	test_must_fail git push keep.git HEAD &&
> +
> +	# The ".keep" lockfile of the concurrent git-receive-pack(1) should be
> +	# left in its place.
> +	keep="$(ls keep.git/objects/pack/pack-*.keep)" &&
> +	test_path_is_file "$keep" &&
> +	test_grep "baz" "$keep"

Also, there should be no corresponding ".pack" file, right? Do we want
to assert that, too?

Thanks!

Patrick
