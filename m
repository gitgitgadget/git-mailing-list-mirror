Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4F14266BF
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759540; cv=none; b=SN/LEEGemc9cScEpZ1eK7P3dNfXmkSDZ2MxJsLuGxxNCQasqsVpTjrlSTvwUKAEoTLlDS77PjPBk2cV94t0TNn/vT6vAnKN+HQlICJNdWfTuHiPC/XE7YFPPEaT51zshrJPuJm1kb1wNE1jHQGrVsiiFCQhMfPKttypQnsEDJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759540; c=relaxed/simple;
	bh=FoubZQoSIPXLbbu6PUaedeE4QVNMVpD3Ix0ukYdcV9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1EPrrZSKiLHq9yoYkWe90NNVjCGMAL39tmqkepCdloUCmSe1C/6H5aMRs0NenvM8IwnkXpzsYHs9ofaxoaVSlNBLN/DyXklwHF/dnKLOZDQKOdBJGN5XCIz2xauZG7Mplgi1XXHIhJ4gLbRryMLAXTfkVPFzFNKZierXO8fLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLKfhbTB; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLKfhbTB"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9ccbb7aa3so1321212a34.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782759538; x=1783364338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GSFVgXQRRzZxNYx8GJVYof8CBf6tpVkc1GQy6ZgXu2A=;
        b=aLKfhbTBsKHKkSy2JyGmii16+0MqvVdbqv7gHN/MrgdVTVeIBDvhBX+5hGvlRppeTa
         Onysh0R40J6MU6TrXGntMtXa/OGrZEmm5BOSaPtyYh/LVQrvYG1LXdCeUp8AuW0oMked
         +z9Vf4kQNJdk+gaFmBk8aBWlb+8wr9k/v8UwEXIj5Jbh2gq5Wzwjjamk70cXVo2UBA2x
         movYcDvrtV/Z0biFFNWBv/a2+4WetA5IVcTLgCdOf/zC/ecHO12n5HcfD7VG0kcP8MxH
         O36EvuJpGJLWz2O9VsryaornCT+lCBDNsc56TrKeXkr2PU39zS1hlrGHgaoa76EZ8gv/
         RKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782759538; x=1783364338;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GSFVgXQRRzZxNYx8GJVYof8CBf6tpVkc1GQy6ZgXu2A=;
        b=pJpFKrhIiwOUiMoKsBMSlB383NdEwSXa3dKIy0BsdtePCnzMskUiWwCvd9yP/lp09b
         r9QWt6LlRzKVLZ07DBChbaMk3XTw3NeMGHkNMJPOBAd+vIUqQN0g2ol2MI1c0+uHn2NH
         d+PASrBCmH3/A0rcX7fzSmYLQHCTFMbBI853UvLPlxbXCrElgMoYlSSlqWnFwBwVisWk
         SXs8vFpTqPO+jccFdkplYwLbaEHSoKCqcFwJTPqYCGJvlwMuhS4SaSPJl3RrS69Iz919
         mAwu0ZRHaCWxZmaPJ8NaSnjUkMLA2YzBMkv8ppk6A6y+jLxnjMcQaieSe/p7CXGkAonu
         KIRQ==
X-Gm-Message-State: AOJu0YxZca+QVIggMxafhh/nTvtyei0pqeQ4JFlArnsp7DtATCe3ndM1
	X3Gm6F/56ykA/UHDDR0APRTVGyuHQCgWZdrDbWhHEIF4ytwRTR5tXwEE4flPkw==
X-Gm-Gg: AfdE7ck4UiO2Y88BhYHwR3sISZ844buJeHQ3tIaOX5TwZKkHoBmSfoHA0IxodD9gjQj
	MTRyeu0qWDnyGZp78yKCHBRo0AixYbSooscAE1lzcZ2KIK3gFfmNZjwo7vDnA0puNXzepr69Nwl
	8lasf0FpMv6Z/LUzuurNN70MKeLi4bU5BmYxGRKBAZOPYtqhfDeKb4h7beQ/8jsD4UrqDC0Sk43
	Wxcgre/58vvFJiYq/Xkj/Ec/G8xA9xsAWSoDic3arrirWDUyvsv0FaGjIP8Nqsq1pW86DbFZ6O9
	3agfO7MEyZdPNDMtBtZn3B3EsNQ7u+VFwoYVUPM7L9HpzQ637gmM3txQiFS15YCequhdEid0kLH
	R+o4R2NkMs+qa1qOOfX5puTsIan5JIE2YbRnK1ZfF/wF6UwgOxx6JW2DkJVIROu1MqMr0rJVWTD
	zJcyeccG/RhE29lceL
X-Received: by 2002:a05:6830:411b:b0:7e6:fdea:7ab1 with SMTP id 46e09a7af769-7e9ec5dc55bmr536342a34.8.1782759538002;
        Mon, 29 Jun 2026 11:58:58 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ebaab674sm501184a34.0.2026.06.29.11.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:58:57 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:58:54 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] object-file: propagate files transaction errors
Message-ID: <akK1roQJknYstX0u@denethor>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-3-jltobler@gmail.com>
 <aju-7Z-ecJG_ORow@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aju-7Z-ecJG_ORow@pks.im>

On 26/06/24 01:26PM, Patrick Steinhardt wrote:
> On Tue, Jun 23, 2026 at 11:19:16PM -0500, Justin Tobler wrote:
> > The "files" transaction backend may encounter errors related to managing
> > the temporary directory used to stage objects, but silently ignores
> > these errors. Instead return errors encountered in the
> > `odb_transaction_files_{prepare,begin,commit}()` interfaces to allow
> > callers to handle as needed.
> 
> Missing a then? "to handle as needed" -> "to handle them as needed"

Will fix.

[snip]
> > diff --git a/object-file.c b/object-file.c
> > index a3eb8d71dd..18c2df75fb 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -499,7 +499,7 @@ struct odb_transaction_files {
> >  	struct transaction_packfile packfile;
> >  };
> >  
> > -static void odb_transaction_files_prepare(struct odb_transaction *base)
> > +static int odb_transaction_files_prepare(struct odb_transaction *base)
> >  {
> >  	struct odb_transaction_files *transaction =
> >  		container_of_or_null(base, struct odb_transaction_files, base);
> 
> By the way, is there any reason why those functions are still hosted in
> "object-file.c" instead of in "odb/source-files.c"? I should probably
> know, but I forgot.

There are currently a couple spots in the "files" object write path in
"object-file.c" that still reach into some of these transaction function
that are not part of the generic ODB transaction interface. I'm hoping
in a future followup series to detangle this a bit and be able to get
all the "files" ODB transaction related code moved into
"odb/source-files.c".

> > @@ -511,11 +511,15 @@ static void odb_transaction_files_prepare(struct odb_transaction *base)
> >  	 * added at the time they call odb_transaction_files_begin.
> >  	 */
> >  	if (!transaction || transaction->objdir)
> > -		return;
> > +		return 0;
> >  
> >  	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");
> > -	if (transaction->objdir)
> > -		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
> > +	if (!transaction->objdir)
> > +		return -1;
> 
> Huh. So previously we just didn't handle this error at all and just
> continued to tag along? Did that result in anything sensible or was this
> just YOLOing it?

Good question. Previously if there was an error, we wouldn't end up
creating any tmpdir and would instead continue to use the primary ODB to
write objects in. This change would make it a hard error if we fail to
create the temp dir. This matches the behavior that git-receive-pack(1)
expects, but I didn't consider that the existing callers could
transparently handle there being no temp dir.

I suspect we may want existing ODB transaction users to continue being
resilient in the same manner. In the next version, I'll maintain the
same behavior.

> > @@ -542,13 +546,13 @@ static void fsync_loose_object_transaction(struct odb_transaction *base,
> >  /*
> >   * Cleanup after batch-mode fsync_object_files.
> >   */
> > -static void flush_loose_object_transaction(struct odb_transaction_files *transaction)
> > +static int flush_loose_object_transaction(struct odb_transaction_files *transaction)
> 
> Feels like this function should've been renamed in the preceding commit,
> as well.

Ya I agree, will address in the next version.

> >  {
> >  	struct strbuf temp_path = STRBUF_INIT;
> >  	struct tempfile *temp;
> >  
> >  	if (!transaction->objdir)
> > -		return;
> > +		return 0;
> >  
> >  	/*
> >  	 * Issue a full hardware flush against a temporary file to ensure
> > @@ -570,8 +574,12 @@ static void flush_loose_object_transaction(struct odb_transaction_files *transac
> 
> There is a call to `xmks_tempfile()` hidden that can fail, but that
> failure is already handled in that function itself by dying.
> 
> >  	 * Make the object files visible in the primary ODB after their data is
> >  	 * fully durable.
> >  	 */
> > -	tmp_objdir_migrate(transaction->objdir);
> > +	if (tmp_objdir_migrate(transaction->objdir))
> > +		return -1;
> 
> Feels like another case of YOLOing it. The migration could have failed,
> but we just ignored that failure and never told the user about it. The
> result may be silent corruption, I assume?

Ya in this case, if the migration failed, we would just continue on
which would likely result in silent corruption.

> 
> > @@ -1670,27 +1678,34 @@ int read_loose_object(struct repository *repo,
> >  	return ret;
> >  }
> >  
> > -static void odb_transaction_files_commit(struct odb_transaction *base)
> > +static int odb_transaction_files_commit(struct odb_transaction *base)
> >  {
> >  	struct odb_transaction_files *transaction =
> >  		container_of(base, struct odb_transaction_files, base);
> >  
> > -	flush_loose_object_transaction(transaction);
> > +	if (flush_loose_object_transaction(transaction))
> > +		return -1;
> >  	flush_packfile_transaction(transaction);
> > +
> > +	return 0;
> >  }
> >  
> > -struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
> > +int odb_transaction_files_begin(struct odb_source *source,
> > +				struct odb_transaction **out)
> >  {
> >  	struct odb_transaction_files *transaction;
> >  	struct object_database *odb = source->odb;
> >  
> > -	if (odb->transaction)
> > -		return NULL;
> > +	if (odb->transaction) {
> > +		*out = NULL;
> > +		return 0;
> > +	}
> >  
> >  	transaction = xcalloc(1, sizeof(*transaction));
> >  	transaction->base.source = source;
> >  	transaction->base.commit = odb_transaction_files_commit;
> >  	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
> > +	*out = &transaction->base;
> >  
> > -	return &transaction->base;
> > +	return 0;
> >  }
> 
> It's still somewhat fishy that we have this ODB-level transaction, but
> that's a preexisting issue and thus outside the scope of this patch
> series. Ideally though, it would be possible for there to be multiple
> transactions, and it would be the caller's responsibility for juggling
> these transactions. Just as it happens with reference transactions.

I completely agree. One of the current problems preventing this is that
only a single instance of tmp_objdir is allowed and stored globally.
This is done to keep atexit() cleanup simple.

My plan is to eventually convert all existing tmp_objdir callsites to
use ODB transactions which should hopefully allow us to remove the need
for a separate tmp_objdir system. At that point, we can also work to
change how temp dir cleanup is handled at exit.

Another problem is that there are also a couple of ODB transaction
callsites that require to know if there is already a pending transaction
for the repository and the transaction has not been wired down to these
callsites. My hope is that this can be addressed though as we expand ODB
transaction usage for object writes.

> > diff --git a/odb/transaction.h b/odb/transaction.h
> > index 854fda06f5..f4c1ebfaaa 100644
> > --- a/odb/transaction.h
> > +++ b/odb/transaction.h
> > @@ -17,7 +17,7 @@ struct odb_transaction {
> >  	struct odb_source *source;
> >  
> >  	/* The ODB source specific callback invoked to commit a transaction. */
> > -	void (*commit)(struct odb_transaction *transaction);
> > +	int (*commit)(struct odb_transaction *transaction);
> 
> We might want to document the returned error code here.

Will do in the next version.

Thanks,
-Justin
