Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE2F37B027
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591561; cv=none; b=VdmTGOoccKPIlpuH/ly54nfuIP7muZN0pbXNOlO4imO5NX8lOAw5QignaQccpUy5B1MaWEg8uqhH5W4/9Fwn2qtFVD9vXQT9ilNJ2n/Uaoe9xMqTcOqb8V6aveK45Xvc/3tI2kT6uQyPqSOmJsvzxR4+NXauGaSzFqiBfboQHg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591561; c=relaxed/simple;
	bh=nOHA2HLos3VIG6lHaizAtpPxINUcPIMfZzwnUN6X/EU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HMcbsd21WZ4oaU189NzLpaTmmHEWn2wFr7k6GDdiQA/KZWlW5lLbfcYfgz+b3CjNvv6M3qgg1z0Fev5xHJHMjZnjlQBw9sx6KNP8IZsndAUMHcPTsK1p/hOAgRYK8Ibj7EBgI8QPJyxVxVSt/GVajmopLaiuw4KO+x9PtwiQx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=zc3NaXek; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="zc3NaXek"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783591557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ad9sFLmS72rSGSmOBu0Sn7v79nA4n3Odoa/p0ZrF76I=;
	b=zc3NaXekqlF03dkcK1u18lzP409Aqj4Aty/ZBDjRPOPAiPqR/JITs7jQEbAi3gdKuXAGEg
	2kw0KKuji2iNvCKa/M8fTmIWm/T/Chkf8CixzlmxxjQOJQ/7fHUKJnvuktul1lZ1I/X4Nc
	bO/ZNP/iqcHvGAqC+dqS2wV2seFB0Us=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/5] builtin/refs: add "create" subcommand
In-Reply-To: <87zf00mqv1.fsf@emacs.iotcl.com>
References: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
 <20260630-pks-refs-writing-subcommands-v3-4-deb04de1ecef@pks.im>
 <87qzlk2m0h.fsf@emacs.iotcl.com> <aktVdaB2xRk-iI_8@pks.im>
 <87zf00mqv1.fsf@emacs.iotcl.com>
Date: Thu, 09 Jul 2026 12:05:51 +0200
Message-ID: <87wlv4mq9s.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Toon Claes <toon@iotcl.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:

>> This flag is somewhat weird. Having it is probably a sensible think to
>> do, but now that I think about it I wonder whether the default makes all
>> that much sense in the first place. That being said, _if_ we want to
>> change it then we should change it for all subcommands.
>
> Not sure how to make it better, so let's leave it like this.

Well, we could drop the `--no-deref` completely? If you want to modify a
ref, use git-ref(1). If you pass that command a symref, it always
dereferences down to the ref. If you want to modify a symref, use
git-symbolic-ref(1).

-- 
Cheers,
Toon
