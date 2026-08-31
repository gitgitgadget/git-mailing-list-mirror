Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C53AA1B5
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156036; cv=none; b=SFOSrlzVaGFyiojAuIppaZU7Zj0Afl/Y/lCs285NGAvPsIXgTvvr1iNCUJj2EmsQ2imSxgu6T2+kGrW+lQ0fCgBxlC6XLLz05O7+dvY39e/dcc1MVwsDmgfyoKlCTp6FDwX/S2qqR84s3yjkOoRVfBugJDrRmZOoHJA0eYaFp8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156036; c=relaxed/simple;
	bh=083ghKpG8FKTHRRRBBlLeczLMqsl4ceVpSfdK3+BHnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th0FE5hdvfW/DOtj65oDr3cMYXeoinefXio776vXthRG3MNlrqyjNEI8qZjBcIHPEX8vKy6mYZhFDOzVctmxqcUVx/SPX/+qmjaagWdznKF4c1JNLDelrwMikbLFp7iNvK4DLORaUp0fbudjlKFvEdMPn8DtSwk2M8XDJkvHut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jFc1LHTt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cAd/Yj9r; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jFc1LHTt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cAd/Yj9r"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 151291D0011C;
	Mon, 31 Aug 2026 02:00:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 31 Aug 2026 02:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788156033; x=1788242433; bh=nrBjb4fz/U
	U6w/36z2/uNlmBgCyx7/5JJrQgN5Ns1W4=; b=jFc1LHTtfSDJPbQe6b/qYGlY5L
	bmAFn+DI+DeF/6IUU0VQ3T1ChZ8MtR3YM96IVimc9W9c3HYxLQCz4pl7SSMuzt0n
	yuPpaQ34BqJGRQ20Ea+c9g8S0KB/qed6zJxD4BWQp1Ug37dFIf5SnefItdW/QU0v
	PXSNHtQRPK0ieIow2ktMOqlUei3c1M7XAf7dzOrN1MikU8pwRn5uqrb4miu9GMCI
	VZfYhaI6bjLZqAw4qlSTcK2nQQMmYUN37fkzp1jCHhgtHHj3SW+nxn/Daf1a1Lt+
	UgubOJtGplg/pmMvSUKgB7BU3SLYS8lQcspqnjkt1/RvnISgJ70HRO7hW2xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788156033; x=1788242433; bh=nrBjb4fz/UU6w/36z2/uNlmBgCyx7/5JJrQ
	gN5Ns1W4=; b=cAd/Yj9rCzLQSarXOYOGOHy+AC6BaKV4JPkvk7vHgh4fWS5MmoU
	HifKQjjMgPePDrVWBcYkWaWklvbemxwOqEAGDsIUzsvEPmyEibQvmKbtGvS3U1NF
	mb6Ctr9HSkqX5crtXHRRyzj8D2lhgywdfmx4Gl4f6y7V4ni+ZzSfcw/lNJwtscTp
	HprlSTlDLdwpk1Hlhm3axlGzLMS1rH9DZ8iKrByXXC4Wg2amzlr5n/Isw/cL+WwS
	0LtbIP3FAl1ke71PYIU8hlbYqPwFs5ngIJ+qLEftDAo+bVk3IooXCAK/2AR1xs+Z
	Xm89xnkn0ZdXfOtyOENm2Kj0dyo0njDcxoQ==
X-ME-Sender: <xms:gRiVaiX5f0IzGL6KeYT5KcyUNecPpQykg33d-7rJ60zRUYedxiFFfg>
    <xme:gRiVaknyA-f2MdzTHQN21x-9ZcQ3Uk1AxYXGmXLS2ubTsDUIe_8X9Ek_GxD0qnAtA
    RlN2wIYo0UXkytRsZrx6nNAWER9EQCHUoU7zfsEopqnLflcyHzJ>
X-ME-Received: <xmr:gRiVakC18MVEfYraPKS8udZmjDNdQobXVMJxHkJgJOEWhCloKZ4IOdqHBnahl0UozxgbqQ>
X-ME-Proxy-Cause: dmFkZTGRrc/w/LyLEw89uV9Ke3SE18xmG6iVlp9uMrMUKG9EAZ2dTprR/goEVcwWww0Ik3
    gfm9nhxM2s62kdcZ/4RQhfzNhH1xrd/zBzH+bYztHVou4a3z3q1JICSnoRb5BdpqB5Noyx
    W7zstf8dqNUYLSWljObupyy4bOUyBD2oScZowgwrYUAHqRfANmvUwfUzpA4QeH/opuZ9iF
    ir1JEUPapFQ9Fy9AltuUsrnGDwl9rBaHV59h5+OuMyfix7/wHYc6fOB/z30cECA6x89KCm
    ANULxC+IaSbngYJUCAh7uyNy0RJL/OFaWO8XOnlY4bo2beuiclvyW8B6NqXbnw0XVwFhPJ
    GJeChNBGx3TfDH9TQv/hIMK+IPjoQHsSHMIzQfGz7runEsCI2gzvOSBZggSs1Qxcao5Z4Z
    FcDe5K5XlUtlu3ts8nSaCACHG2F7G3AYdYMcll757Mc+OGFtcdvjDTBcx3L7eO3qUfYnHg
    CZKJX5iLMPviIYM+7he+K6m6XEJkAkmrBkrcRr8J7yBhvJI8eoICu2vkzYMu4ZLnAP9gWc
    /do4msNUldcMTRV00C6yjvaolBKkw+A9MVAm2ErzE8lxwetid+ZBT7FXYMrWgQXvv/nFYL
    NREWQ4ts3VOW07ca6AYfRK4+/qhI/sBzFRtiDlHHLCf/RSISy+AhV9heuk2A
X-ME-Proxy: <xmx:gRiVakf1LknOs8Aljjgv2pVNKyCYThZGg2pyq_ZO8WwM9M7CYeEEYQ>
    <xmx:gRiVavK2lvKPZvmXR9x0hlOFZQ7kY_m_lv9XhBIuS85-OACXZb_mYw>
    <xmx:gRiVanc8OdPnLGFOTIpr9mVKVn2nDpoSCJIlSCf66vjP3h6_QmJcqg>
    <xmx:gRiVam1b-iYUa9E-d3S7TEM-wD7n0BOLlD6OaoPO52FHV3gWcIdHXQ>
    <xmx:gRiVanE-446XjSlMmXwIiSofIDAqYlW8QoLDDveu0SVQDLeHM1LB0DUH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:00:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 15096450 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:00:35 +0000 (UTC)
Date: Mon, 31 Aug 2026 08:00:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/10] builtin/fsck: use `fsck_obj_buffer()` when
 checking loose objects
Message-ID: <apUYeK7IvIfaxdtf@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
 <20260825-pks-odb-source-fsck-v1-1-b756de0bf24f@pks.im>
 <CAOLa=ZQyGk65qhF2uRV6Q48c_F948XuTWOdHOTwenfGestLxWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQyGk65qhF2uRV6Q48c_F948XuTWOdHOTwenfGestLxWw@mail.gmail.com>

On Thu, Aug 27, 2026 at 06:00:37AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When checking loose objects we manually parse the object buffer we have
> > read from the on-disk file, mark the object and then call `fsck_obj()`.
> > Almost the exact same steps are also performed by `fsck_obj_buffer()`.
> >
> 
> I was wondering what the difference was, there seems to be none, nit:
> perhaps we can drop 'Almost'.

I actually didn't have the "almost" initially but added it later, but
there isn't really much of a reason why specifically I did so. I'll drop
it again.

> > diff --git a/builtin/fsck.c b/builtin/fsck.c
> > index 892c5661d9..3c4127f4d8 100644
> > --- a/builtin/fsck.c
> > +++ b/builtin/fsck.c
> > @@ -751,21 +750,7 @@ static int fsck_loose(const struct object_id *oid, const char *path,
> >  	if (!contents && type != OBJ_BLOB)
> >  		BUG("read_loose_object streamed a non-blob");
> >
> > -	obj = parse_object_buffer(data->repo, oid, type, size,
> > -				  contents, &eaten);
> > -
> > -	if (!obj) {
> > -		errors_found |= ERROR_OBJECT;
> > -		error(_("%s: object could not be parsed: %s"),
> > -		      oid_to_hex(oid), path);
> > -		if (!eaten)
> > -			free(contents);
> 
> This is now moved to the bottom below fsck_obj_buffer() call. So that's
> okay.
> 
> > -		return 0; /* keep checking other objects */
> > -	}
> > -
> > -	obj->flags &= ~(REACHABLE | SEEN);
> > -	obj->flags |= HAS_OBJ;
> > -	if (fsck_obj(data->repo, obj, contents, size))
> > +	if (fsck_obj_buffer(oid, type, size, contents, &eaten, data->repo))
> >  		errors_found |= ERROR_OBJECT;
> >
> 
> I see `fsck_obj_buffer()` also sets adds the `ERROR_OBJECT` flag, but
> that's okay.

Yeah. We could just drop this, but then it'd feel a tiny bit weird as we
call the function without checking its return value at all. So I decided
to just keep this as-is.

Patrick
