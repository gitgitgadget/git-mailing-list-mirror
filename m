Received: from mail.carneios.de (mail.carneios.de [5.9.149.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2202B4A6CDD
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.9.149.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789485728; cv=none; b=SK/MMzFeBWzpFDjkEi9jD3xjnqBBeJjVHlEMtqHVukQHYBmC39NWmU/feEGVLu4DmtgeszW6OWhBd3kHEz96m3GAl8rCFQvtLiSUBDdWGgCUYku42vcATnl7C14vTZm9DMSCsg0sAWHlekwomPb/yLgq2pS8yR7VIzSS9akP1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789485728; c=relaxed/simple;
	bh=LskOV7EW6ci05O6x0S2T8dK+xiZ6nQv/R9w6m9kFm6A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=aSop4Gbd8bJkpnwd3PkhDHPg0HuPbIZxl3INpibFdWx6FF+l6RSUHA0xogCvTv46MGWK5ao6ugCS6hU8CSZVM2PwWFWEuKiiYZX0ZKsldTMQnp5j3+KUUReqnFZdmkCkHvtLNgFwK1Q4DWY/L7NQ8Kw1VSfQhwVNuBRXGZTsB4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carneios.de; spf=pass smtp.mailfrom=carneios.de; arc=none smtp.client-ip=5.9.149.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carneios.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carneios.de
X-Footer: Y2FybmVpb3MuZGU=
Received: from [192.168.178.28] ([79.140.117.8])
	(authenticated user akiessling@carneios.de)
	by mail.carneios.de with ESMTPSA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	for git@vger.kernel.org;
	Tue, 15 Sep 2026 17:06:53 +0200
Message-ID: <1bcb043e-e744-4e01-8569-4da5669d25fc@carneios.de>
Date: Tue, 15 Sep 2026 17:06:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: de-DE
From: =?UTF-8?Q?Andr=C3=A9_Kie=C3=9Fling?= <akiessling@carneios.de>
Subject: Bug!?: Refspec '+' should be same as '--force' but is not
Organization: Carneios GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi there, think I found a bug...

In https://git-scm.com/docs/git-push I find:
 > The + is optional and does the same thing as --force.

The fetch documentation refers to push for the details of <refspec> so I 
assume, the statement also holds for fetch refspecs.
However, this is not true:
When I run `git fetch origin --tags --force` it will force update tags 
that changed on remote (as expected) but will NOT delete local tags.
When I run `git fetch origin` with config set to `remote.origin.fetch = 
+refs/tags/*:refs/tags/*` it will delete my local tags as if prune was set.

I'm using Git 2.54.0.windows.1





Carneios GmbH

Am Borsigturm 64
13507 Berlin

Tel. +49 30 2332035-0
Fax +49 30 2332035-99

https://www.carneios.de
info@carneios.de

Geschäftsführer: Michael Giersch
Handelsregister: Charlottenburg HRB 138285
USt.-ID: DE 280 745 293


