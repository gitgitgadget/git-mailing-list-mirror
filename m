Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D11D8DFE
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284365; cv=none; b=PEPPDFq+0LSfN5GBwgg2+FKhXz81COCVIIHg02vbatoHWfyDrCyWxtmK/Pu9m8CeDtfBUKNULcIJV24SECd5KdwLIliQEMDvM1p1qXSBROk4JbMmafNMr9ljEIN0gC9NIm7NK8vT1fKYN70w4MZ4dFkVmbaMrDUoJlx8WIODk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284365; c=relaxed/simple;
	bh=zYIlp/P+mys4CmWfAlBmiVP6/SFMOzAeKH+ukMVtox0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nRcqpB1SWo7CSjQYPa7Xsh3qqHo0nvFc42M/bVxRVMJ1HJmz+1iXfm43imKmSbZtCKbSPIaRGlfPK9HJF7OcIwZGx/0cXs7+XeFRDIbbPE3o6+WEuwpX7TLp7MnrSh468WJbi4f0d5wRCr+eMNgpmZ6jGxJyJqQ5gl/JspivVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=R6f8Fcc2; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="R6f8Fcc2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1736284357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYIlp/P+mys4CmWfAlBmiVP6/SFMOzAeKH+ukMVtox0=;
	b=R6f8Fcc2Gf3CF5Tmo1HENgwSVcwV5RSfmUg0Le8KCj8RSH/EnEDfbeBIg1X99I0e93lSwv
	C5OEFlE0cLEbN9VtCH+wa5DVn4vs1U4I7R3ICq+rRlbNixPvBsiNhLb7ekFmAVkBY1CMkQ
	aOmiPSEE4d7QvZLOYemcZe6HJuaSpx4=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org
Subject: Re: [PATCH 00/14] Stop using `the_repository` in some trivial cases
In-Reply-To: <CAOLa=ZTn2vfmS480G2wnaMehoK6+Z7EZ3Wx=ctaaPjBetOkbcA@mail.gmail.com>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
 <CAOLa=ZTn2vfmS480G2wnaMehoK6+Z7EZ3Wx=ctaaPjBetOkbcA@mail.gmail.com>
Date: Tue, 07 Jan 2025 22:12:24 +0100
Message-ID: <87r05ejpl3.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> I went through half of the patches a week ago, but got back to reading
> through the series today.

I've also been reading through the whole series today, and the changes
are trivial and look good to me.

> The approach here is to simply bubble up the usage of `the_repository`
> to upper layers and use `the_repository` there. The alternative approach
> would be to try and resolve the dependency on the upper layers and not
> use `the_repository`. This approach seems much safer. The patches look
> good to me.

I took me a while to get into the mindset of taking this approach, but
after chatting with Patrick I've changed my mind and agree with this
approach. The goal of this series is to eliminate the use of
`the_repository` in the mentioned subsystems. Simply bubbling up the use
of that variable to the callers of those subsystems is very trivial and
safe to do.

--
Toon
