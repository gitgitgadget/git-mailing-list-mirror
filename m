Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F721A38F9
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391668; cv=none; b=OdOvcSkJEvmyHdaU1H28Onxxr/Mmf8NBxb9Lst5F9Z7azpsTmr/1/dM8BG+CWyqQef4oPO9ZAWxvpIe8EpRtRYjYP0orHBvxzPHHiJ/W3jF0Lg9+NkD3Q5zWk5HXroPyBJoJ7IQm11i8fNskCaF7DSVUN+AyzBJOJocmKniAFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391668; c=relaxed/simple;
	bh=mmzSBoCFBYmpFkwxS2jbfcx79xw2KadmeibD8OHH61g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoVeGrkpc8O5tQHqvyq8NIAqXyaw0uJHH25l3U+2HA0EhD87xEsUfOpiPVil0RHwmCj8xEaB2RYQbzg5BagjOwIXi5opDS/dkG3Kuvibv5U5hTulhV5hKOHf0qjehsC3qVfOrHR9xaibc4+Dlx/19wFk50DZe54KuulbbbvuV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoDt30pC; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoDt30pC"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6aea94f96c4so1305617eaf.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786391666; x=1786996466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z89RZFK/EiiaD47kLgunTfC4ATToKUuqcIYC9IyVVCo=;
        b=OoDt30pCNvMZuEm3Td0vAE2SsNKeEajry7nxGyiRUtpaTeTnVROvfY7uOVg00ToTGs
         GUtA5Ys2WQ/OjTIKuAbGfsDbI9fal8mp67aDo+jwwkKH6iNQjGAeIpKNRyFH+AYZmVrV
         t0PG0pLcW8/9QWWsgy2YVtMXjBglVp4ebOM06iPTTDPNcLXmAWN09fFoojvx0u/hr9GP
         JloYWBveR3aCIy4w7dGd/mCInZU2/2Gv4XIEbC3y0oLW/DKI38DcJzCOY7GMmJjjpn48
         1y2dqYJwqyb48mDSY12oYvDt5FHfqmJQcLkZ2b0Dgxtlee4VqORD2RF6HO/TBN+HyXvA
         5kXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786391666; x=1786996466;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z89RZFK/EiiaD47kLgunTfC4ATToKUuqcIYC9IyVVCo=;
        b=rB5OqlKMCJpX1lMEvCMBkrSGuZQQKyT6yDq1NLXwH2uqPegs/wrt7baeuaXiyfzorR
         jsWR9/zmtma/VobP1ie0Udu3d64wajo7fzkDLRmUZ+rFhPECGgRQMpCwrIyuah+Lbn+9
         EwSoEoRt4pIPvtZg1tJVv1Jq0P3cb8xfo0xNCf+lFt0ckrXtzrKJYXYoGAxvLLM0ukcb
         gDte9/UaBF0Tx3ioukx5Eyilj7UmFqpQPwVQ9L+6uLAyUowqDbEz2Fcv96BWpHTfjPRT
         qabEx/3AGUhOhG/xdF5Hfl0LX17ULZWeiCq+BeTtcTR8M2TswK2bIqeckBYRsrWFy8ez
         cuOQ==
X-Gm-Message-State: AOJu0YxT8X/Mu4pUKfoWIIKz538JTOYIR60IKqW5qxR9zPW1PL4Nhrco
	WkkjJ5dA86Gbk+7/XhkOJU6SNgwZMhrm/cIboeuTx0yVhsCoJstPdJ1NdQKguQ==
X-Gm-Gg: AR+sD10JpJCirTQlMT1G//FMBpbKVPKI53B30cMWxQAZPfcV44P7pGicGE6IPK85mbs
	S4DF3YedGjeQRH5EN3WkiuC9RmSvjZCYhAt/klF+oNEWqFA5SsDWv/HPppTLV4ZK8nGva9aVbB5
	+w6XLp8V9NzZ4wos93FcaqJB38XpgEV6Xi6Yb6Bt/TGT/43Boszq/WRFNlECnwH/RuOFcfAve9g
	3wXbpFGmzxMMtRf5fTzdk5FrYCUgk7c6b6yJQGaiM2ElBnK29HlcZTh8XLhWHWlge1LtMaQDYBy
	fVY9TY3lL1S9MmygRYP2TvMS/0OlQmhpA8x4SKrM3WDDqw0VbNsGU1zskh5dgijcjt3xhhFdNoc
	/Cz0pgK8fnG7cX9vqjqdkVThhVoflX+oie3u2xrGXpjS2Ir+jDVnD4kLVKpt/Fwz89ThqE2cEAy
	VR9UIpjvpdlW2Kgk2/zKwBRT8rjVzwgx0yhuRYiHMlVFVkaiXxAsI0rQ==
X-Received: by 2002:a05:6820:4b89:b0:6ac:8e23:3078 with SMTP id 006d021491bc7-6b0904c0cdamr2393180eaf.5.1786391666099;
        Mon, 10 Aug 2026 12:54:26 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b7c4ba7sm8081639a34.23.2026.08.10.12.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:54:25 -0700 (PDT)
Date: Mon, 10 Aug 2026 14:54:22 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2 7/7] odb/transaction: add transaction interface to
 write packfiles
Message-ID: <anomr5jpSGlrTX2m@denethor>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260809190106.1565882-1-jltobler@gmail.com>
 <20260809190106.1565882-8-jltobler@gmail.com>
 <xmqqwlty7hdz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwlty7hdz.fsf@gitster.g>

On 26/08/09 09:02PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > .... Note that a packfile
> > written via git-index-pack(1) is kept in place by a ".keep" lockfile
> > that must be retained until references are updated. To faciliate this in
> > an ODB backend agnostic manner, the "files" transaction backend takes
> > ownership of these lockfiles and removes them post-commit through its
> > release callback.
> 
> The above is confusing and I am lost.  Care to explain a bit more?

It should say "finalize callback" instead of "release callback". The
idea here though is that ".keep" files are likely an implementation
detail of the "files" backend, but we still need a way to clean them up
after a transaction is committed and reference updates have been
performed via the generic ODB transaction interface.

So after `odb_transaction_commit()`, the ".keep" files are tracked by
the "files" transaction and only removed once
`odb_transaction_finalize()` is invoked. It would be up to callers to
ensure that reference updates are performed as required prior to
finalize being invoked.

I'll try to explain this better in the next version.

> > +		status = start_command(&child);
> > +		if (status) {
> > +			strbuf_addstr(err_msg, "index-pack fork failed");
> > +			return -1;
> > +		}
> > +
> > +		lockfile = index_pack_lockfile(repo, child.out, NULL);
> > +		if (lockfile) {
> > +			ALLOC_GROW(transaction->pack_lockfiles,
> > +				   transaction->pack_lockfiles_nr + 1,
> > +				   transaction->pack_lockfiles_alloc);
> > +			transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
> > +				register_tempfile(lockfile);
> > +			free(lockfile);
> > +		}
> 
> Here we add the .keep file to the list of lockfiles.  We have
> finalization step laer in odb_transaction_files_finalize() that
> deletes the tempfiles when we are done, which comes after
> the transaction is committed.
> 
> But isn't the odb_transaction_files_commit() where the migration of
> tmp_objdir_migrate() happens?  Everything in the quarantine directory
> including these .keep files are "migrated" (either link-to-the-new
> followed by unlink-of-the-old, or rename-old-to-new) there.
> 
> And then ...
> 
> > +static int odb_transaction_files_finalize(struct odb_transaction *base)
> > +{
> > +	struct odb_transaction_files *transaction =
> > +		container_of(base, struct odb_transaction_files, base);
> > +	int ret = 0;
> > +
> > +	for (size_t i = 0; i < transaction->pack_lockfiles_nr; i++)
> > +		ret |= delete_tempfile(&transaction->pack_lockfiles[i]);
> > +
> > +	free(transaction->pack_lockfiles);
> > +
> > +	return ret;
> > +}
> 
> ... we do the deletion of tempfile but has anybody migrated the path
> to these files recorded in the lockfile structure?  How are we
> removing the .keep files that were "migrated" when the transaction
> was committed?

The filepath recorded by the ".keep" tempfile structure is _supposed_ to
be the final path of the ".keep" file post-commit that way it knows its
location after its been migrated and can remove it. The path is
generated by `index_pack_lockfile()` and is supposed to use the real ODB
source path and not the transaction ODB source path... but this is not
happening anymore now that we are using ODB transactions in
git-receive-pack(1) which reorders the ODB source list order when the
transaction is applied...

This is a bug and needs to be fixed. The fix itself should be fairly
straightforward, we just need to tell `index_pack_lockfile()` the
correct ODB source it should be using. I'll send a patch later today
correct this.

Thanks,
-Justin
