Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D315E90
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891519; cv=none; b=D0lSdzXfEmj7OPWZbXCFxvlcWy/huIrURvl1QcqOtrjnLb3QJg2CT3NwhoFDtkT7W2uzl4VehYgwZ+L3ihsxHkpWT6VTEn7xuHMDnTUZ9JhvXRwzvNgzFr/EuhweOl/mUfiTd4MLXsuoVMLWUfqwsd0y6ruRoXtUOnD8Pzo2LuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891519; c=relaxed/simple;
	bh=njZvEN2elAmA2+NQvHiv31pG1lXRwi4jLsF1vJN5lxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmJNQpHWSs3MCdGU9Hu4J3LD31MnJPDW+LlE4SLdj//4nD+73JEmFeNMIhgbVo22Wrz2YWxbWNLQMLIA8jE8WoE/aYlEOcyFQnwnSOjnwJjQqpxcn/eqRKcabUnbDXnaeGAo3OdpTMKaJBPpVH2msXwB3f6zc3WPhMCeMIyApl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX2kIFuu; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX2kIFuu"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74382027898so1157855a34.3
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755891516; x=1756496316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DT//uHmRITUo3GzmEKTh3ty8LAD0Dp+lhnAfqbZZxMo=;
        b=YX2kIFuufGcoQjBJum+skHTVLjfriyJSCxuicsCaaERFXlIvTxiuClwH4n2c1WD/S1
         sTeSW/n4KEXUX56QTsdjOuMbNHGMRVl9QvNYBOND1eV1r4xi2O3EAx2G9bzfketwwPE6
         74L0tZomUPsBDbUKa/w7w+eEjBCRxnKMC2btCGGqzrdn3zu1A0VQHz4IK13zSSdph81y
         aGfsKhWnZwq7VPfTItRTpc3P9dVSuleTlIEABPgTzRrUvrDq4L3/TVVNgsUIz5nAjkk8
         6l5OWnIbU5CtYjglMr/jdmUBgcVgWtAM6qw4cicnmMjht6iaEOZReRz1j3wFqwe3AFiV
         QR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755891516; x=1756496316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DT//uHmRITUo3GzmEKTh3ty8LAD0Dp+lhnAfqbZZxMo=;
        b=GJTOdlNQDAduaZxlh2Whvnx6BciIE+S8/vxkuMXAuvr+zI6JUOvJwCI0FcEWiKsrWZ
         U0YCCYmwVy58SLHi5B1sv9SWzuuSzHnOpRgQ1rUR6/IbmcqwmfvQg2tz2FGcYjawPBoR
         0RGq86Oq8bSLBen9wTVQmFOV0pGZz9CnTS6KEcgshr4aHoognbYOz39Y0yMtSWMoXx5f
         mb0ZgdbZ1vpGIYU8u/724Kput8G0SCnOaf4CC+bvJKDwT+qedANOlsW2te5UHj+meLEL
         /nLWDrKdu9MS+oDrf4oLjGRxMJStJ+mHTW1c9WV8llvQa4hMBcZ3hsSwwewthauqRdNI
         94Ug==
X-Gm-Message-State: AOJu0YyR7rIhGoz4eOVA8PSxrwckO/UToeEd+jzGl4T796bPnmGa6MAR
	qzqoll4vHbYKnnvcEDiXyCRMzLg9MvC/NC5Ve0ooiHQ4bt0FO5EBc6fvPTYwWxZ6
X-Gm-Gg: ASbGncvhHOidEnOwvnYeuys71Ibqt4Bzpm+NqPjsDdfWAlfks7R3O+qwW5N49V+E81G
	9nSvWvoxYz1Udpu/NPCgEnQpLek46OtT9omrHT/+lVmhggqzWSB6xL7/6XCk+IFebuQZAQZkRFX
	EpahpP2CP3MkybiVxMrGcqz82Y6pgH2fI25qmea4v7PN95nbZTDbY49XiNA3RQazCOG5RjJSFm9
	x6hg+en/x8W3HjKKzleH54VCwrB9ktjQRmQocAXDmw5VGDXolQ01sDmlFWiyEJFyF0cNz4+95Zt
	qGz6JA5wra3DdEUIENM/ss615NSrj6Bf0USdazZpioI2VVPz9UOnpSNntDpV/IHNmdWYbYq13hb
	J0j5IM+FuxClYJIka
X-Google-Smtp-Source: AGHT+IHOWnqyGPsKRhKH9kYV4PTlBOn5etxhdbDpqBxx9E6NLc+Dypy22jXX80H/BaYtsVGtftBH2w==
X-Received: by 2002:a05:6808:1394:b0:437:75ea:6c9b with SMTP id 5614622812f47-437852bb9b5mr2014126b6e.48.1755891515734;
        Fri, 22 Aug 2025 12:38:35 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-437967be68bsm72021b6e.4.2025.08.22.12.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:38:35 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:38:34 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2 4/4] bulk-checkin: use repository variable from
 transaction
Message-ID: <jd667c3ef7gkxxju5vhrwnibj4guwi5nee2o6bdtc5htgbthxd@ycyasrwbkz6r>
References: <20250820225531.1212935-1-jltobler@gmail.com>
 <20250821232249.319427-1-jltobler@gmail.com>
 <20250821232249.319427-5-jltobler@gmail.com>
 <xmqqjz2vxp98.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjz2vxp98.fsf@gitster.g>

On 25/08/22 10:03AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > The bulk-checkin subsystem depends on `the_repository`. Adapt functions
> > and call sites to access the repository through `struct odb_transaction`
> > instead. The `USE_THE_REPOSITORY_VARIBALE` is still required as the
> > `pack_compression_level` and `pack_size_limit_cfg` globals are still
> > used.
> 
> Also we grab the details of the new packfile the bulk-checkin
> machinery is building out of the transaction, which made some
> redundant parameters functions take go away, ...

I'll mention this in the commit message in the next version.

> > @@ -117,7 +118,8 @@ static void flush_batch_fsync(struct odb_transaction *transaction)
> >  	 * to ensure that the data in each new object file is durable before
> >  	 * the final name is visible.
> >  	 */
> > -	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", repo_get_object_directory(the_repository));
> > +	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
> > +		    transaction->odb->sources->path);
> 
> This is doing a lot more than a simple "the_repository" ->
> "odb->repo" replacement.  How much confidence do we have
> that the internal detail of repo_get_object_directory() will stay
> the same and our developers in the future would spot that this open
> coded copy needs to be updated if they have to change it?

That's fair. With this change we are less defensive since we are not
bugging out if the object source is not set up. There are other
instances throughout the codebase where the object directory is accessed
directly through the repository in an open coded manner instead of going
through repo_get_object_directory(). Regardless, it's probably best to
just keep using repo_get_object_directory() here anyway.

I'll update in the next version.

> > -static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
> > -				struct object_id *result_oid,
> > -				int fd, size_t size,
> > -				const char *path, unsigned flags)
> > +int index_blob_bulk_checkin(struct odb_transaction *transaction,
> > +			    struct object_id *result_oid,
> > +			    int fd, size_t size,
> > +			    const char *path, unsigned flags)
> 
> Ahh, OK, with the simplification to always take transaction, there
> is no need to have the deflate_blob_to_pack() function, which had
> only one caller, as an internal implementation detail anymore.
> 
> This change could have been in the previous step and it would have
> been less surprising; the above "Ahh, OK" is my reaction to the
> surprise ;-)

In the next version, I'll perform this in the previous step instead. :)

Thanks,
-Justin
