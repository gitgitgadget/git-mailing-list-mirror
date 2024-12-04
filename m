Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB5213258
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332891; cv=none; b=ny+Z5K725AnUpfwMCQFpY8/xjPe+0NVSCq8bv2DhOw8PpsMNlR1p0CuojVf2+nPWcTqcp8TzZnIYtd8sQzPvB1ECUjL3xY9f416vyX11FkR7u7R23FWYNdr6iA+bKDcDOoPgUYe0uhRv4848XVAPY5t2h4TNmPDmfdDgKV583yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332891; c=relaxed/simple;
	bh=ZBhOBQeQJusffpq5uT9AWJq8vEcAUQWgBG5liDFmY7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+V1YFMZLrvNnCiZeA0WRknaQQFD+amoqiOK+ti0MO4iiu2WMFPk2KNGKjTZteI/dJ0hJJZiSEIyLmDy5wulQg2JTppJVmfYhnkKx1P2aGuPxR/8LcK3RNC4xmEomkE3YZ3a422gNm63ZZLL3DPBXYwikyGmadfqur4fJauQiiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTYpW/yf; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTYpW/yf"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2967af48248so39096fac.2
        for <git@vger.kernel.org>; Wed, 04 Dec 2024 09:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733332889; x=1733937689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=99c0uL+LXEP+C3XgzJ74KD/ABcKLFDGmzxhRNjMA7DA=;
        b=MTYpW/yf+HHMRvr+lsnCx2JPRi9GMH+6vtHBvWg7Cm39yJkJGSBrJ1hmFJQDuk+kVi
         tQDg3PmAI1nH8haqZ4gALxpSpcAzCnpsGiCiBqu6piOb1CRkVytUMLwAQZ2ChUomdO7j
         j3/Mq1L95Az9A6mijqroU6+GOTIzS8fFj16AuYOEcR+JsW4FTZdznnjkBfWLGe7l5RWp
         wd6nnqVq/2f4SYnxGNL4Ms5F65gKkH00prSNdM1tayXMTknSQeDwFtx+WwEf9YGAspU3
         5QTKwqU8v+M+B7FUvdTjDZmxKvsBhBn84/roJuyHjzgUepVVn3NyEMC+WGpiQu8Fmjve
         W+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332889; x=1733937689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99c0uL+LXEP+C3XgzJ74KD/ABcKLFDGmzxhRNjMA7DA=;
        b=Bex+cpeKioWpiKFnz2MIpadCulkjHsKiKDJj4BdcS/gMXh2xxJ83rsDiBDKZtmo8dy
         bRncPb29FXsvNlWoTFN6ZYvftt6W8fn3dr+Y1H/ht6E+uDEvQwVc8sfl2vQ/W+fC2yIX
         eYaoAFKYCqpxJRHDnYFyIxrQUJY9ODhrxQ57h9odqLJ5VXityfZPANDRxcMVmpi2yzhS
         1lsv3kAyt2mzu7NfJpOJDMaZn5FfTSjwM49awm+Mq9FRfAKQ4lwM4ok29+k+uFdT8c0w
         AbMP7p1GwzLEGCieaQCQ455PvcTZgPHg86W4ERBK52r51lAQbAnMHY7WyTZb0TtMZBKZ
         CPRA==
X-Gm-Message-State: AOJu0Yz9xUBa9ATJMfDgkXWbsJDI/yClJ4sYgEC14WfzwudLalgKsPB+
	/J5a1dbQpUsIAqlQclRS1omVD5lW3I7sLSzmaE9bC2P24jO0NoAv
X-Gm-Gg: ASbGncs7cm/kI1hqK0fi9wNfX29gDrgXfUzmPOiHNChL9GXeY2ThX8P0YcT+y9Jn+2z
	qfV57yrkH0o4waJzSQVRmJK8tpPLyqyaCgaGANWIxywRE71GQM6CqCGseoxiNvKKbwBHXoH5y0i
	DeIR7w2KtoDYnkPYd4shG8vDSi0SVBUA95ZZCaEm+AWjFsoPNFd1vW4+MOpv31TeBY/m4fRn11O
	/iPypWj3zYUeNkmdvLebpKQuvarvKEZP6X5glnYAMI=
X-Google-Smtp-Source: AGHT+IEa4byt2TqiImurYt8o+lxOEsHEDsdCdGXQjXniU39R0Xuucc/lae4p1QaI1w0FxTaKTCecQQ==
X-Received: by 2002:a05:6871:e70a:b0:29e:53cc:a6c1 with SMTP id 586e51a60fabf-29e9b08bf6dmr3484844fac.6.1733332889350;
        Wed, 04 Dec 2024 09:21:29 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29e9d3dcebbsm698481fac.20.2024.12.04.09.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:21:28 -0800 (PST)
Date: Wed, 4 Dec 2024 11:19:24 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Heba Waly <heba.waly@gmail.com>, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] advice: suggest using subcommand "git config set"
Message-ID: <fsqe37ibvarrsjugc4r2cairndr37cmyc64jneaqzhkq4qiiqd@6rskou37aqat>
References: <20241204130928.1059851-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204130928.1059851-1-bence@ferdinandy.com>

On 24/12/04 02:08PM, Bence Ferdinandy wrote:
> The advice message currently suggests using "git config advice..." to
> disable advice messages, but since 00bbdde141f we have the "set"

When referencing an existing commit, I think there is a preference to
use the output of:

  $ git show -s --format=reference 00bbdde141f
  00bbdde141 (builtin/config: introduce "set" subcommand, 2024-05-06)

> subcommand for config. Change the disable advice message to use the
> subcommand instead. Change all uses of "git config advice" in the tests
> to use the subcommand.

Both "git config <config> <value>" and "git config set <config> <value>"
are functionally the same operation. So the motivation for this seems to
be to push/promote usage of the new "set" subcommand. I find the newer
interface to be more intuitive and in line with modern command
interfaces so updating the advice turn off messages here seems
reasonable to me.

There does appear to be other instances where the the advice turn off
instructions are open-coded and thus retain the prior format. This does
result in some inconsistency, which may not be a big deal, but maybe it
would make sense to also adjust those sites as part of this series as
also. Otherwise the changes in this patch look correct.

-Justin
