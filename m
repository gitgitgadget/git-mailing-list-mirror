Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF23828506A
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316385; cv=pass; b=c7FYJvmsn7R9W2l4G+RX/HQjtmr5ahNGAa4+s35MfILCiHhwCGq0aOJhne5ph9GxCI/xNaghDuUbYRUjr4AwvIOM8U7Se6saaOZK07xXzpgJ744c/M2d9cw6BfOyvZcst7eSfHAwHi/+aV7gZW5kpB8wwE394OiDiMSgrCr94/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316385; c=relaxed/simple;
	bh=MnrLTtnxMCRT2RmgbPTHezx4lW5mEgu0+tfdcSNOSxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CP/DNZxU8X88v1g0yLo9j3BMr0nAESIogxIlbw8FzAx9DGWeaYLzJf55JW2oD7cNiZdmcv5L4A3mhSQqHoH0DB+Ae4nrktPva0dkGYrgHXI0glDkCP1HGq5eOOcvwXrVxQk+8pvBKip56RARnbWUB4ZNaY0NjUznGjX+iDE2JZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Vkh6DiW8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Vkh6DiW8"
ARC-Seal: i=1; a=rsa-sha256; t=1768316370; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Jw0wlLiwaC25yVpzdBdeG03R3YeIG8tc5jlgJ8IZxrYCMOzSEDU6ARYx7ZDXoa5XsOSTQNl3EjNtbAQABLRedxU1ozgvjBUri08Ef3duQ/ZaKTXY7Y8MiZuW1MCLxUY0nENrIKrlLKPsA6UbVZI9+3OInv67fyh4QLxN+h5YLCY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768316370; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=790aJOHt7FxgUgVVmZ4LoxImdX+pkyD2qv9DRwyulpM=; 
	b=jvTJ8YeLhQq6G7G6HpOTwMNJaUYVgTIr0kGoeExgdJRaRHmTMNrffYjMOU7/XQRV12LAcnxrbDhUj21lIZkAJqnl+YAhLVgNgtK4LYBvtS79dqeJ5FV6Tht88nBaN/DlroyKWhDtmt52Edt5vmqcYH1QA6UkuqtqrRJOvJdGTkQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768316370;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=790aJOHt7FxgUgVVmZ4LoxImdX+pkyD2qv9DRwyulpM=;
	b=Vkh6DiW8Pn2bsCnUpnUCtoDbCdvIwcpT2O5E7clR10iK60BzBiGVYE30R/Jgb2Do
	meLb+sgju7L9KFBNC3Y0cmaK00GLrCn7qp27UDoSskAPygCxCmdj9PShsy7cSAO1kvo
	A8QZGX6giHIgmfg8eqq6aoF2Jn82RhukPQDm4CJI=
Received: by mx.zohomail.com with SMTPS id 176831636715510.707882414080132;
	Tue, 13 Jan 2026 06:59:27 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Emily Shaffer
 <emilyshaffer@google.com>, Chris Darroch <chrisd@apache.org>, "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] hook: make stdout_to_stderr optional
In-Reply-To: <xmqqzf6hk3ox.fsf@gitster.g>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <xmqq7btlliip.fsf@gitster.g> <xmqqzf6hk3ox.fsf@gitster.g>
Date: Tue, 13 Jan 2026 16:59:23 +0200
Message-ID: <87h5spimno.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 13 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> What was the previous behaviour of code paths that ran other hooks?
>> Was pre-push the only one that didn't divert standard output to
>> standard error?  This patch does look like a proper regression fix
>> in that case.  I browsed "git log -p 1627809eef..c65f26fca4" (i.e.,
>> the change for "Merge branch 'ar/run-command-hook'") and random
>> sampling (like run_receive_hook() that used run_and_feed_hook(),
>> which set stdout_to_stderr to 1) seems to indicate that it is the
>> case.
>
> By the way, if stdout_to_stderr is by default set to true, but tnis
> regression fix allows specific callers to opt out of it, then the
> title "make stdout_to_stderr optional" is a bit misleaing.  It makes
> it sound as if it is false by default and optionally turned on.
>
> Perhaps like "hook: allow stdout_to_stderr optionally off" or
> something?

Ack. Will rename in v2.

Please wait for v2 because, while writing the tests, I noticed pre-push
needs 1 additional line (ungroup output) to function as before.
