Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E628EA72
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768348517; cv=pass; b=mLUNA64U4iw+yMQJq95CVby0C6iub5eSqyolSOc4GDEbaxBzZKQMkOGTq0XXvC0crj+ovFft7sO1xr4RS6LwagGJCAxV6MDdBo0Gev1R7ObE67zYSXsZCkEEPsRpjLSTrdgZ3YNvyzSt6uB1ej4ARwuJWvN9H5bytCaoPL58Hwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768348517; c=relaxed/simple;
	bh=tdjd4H43RgEmmy9863j+drGoxEoRi8UCEqxC1ZRzEZo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RJKrnmzW8pePfBVjfr0oIRZOI09A5IJ4qqEBEuAA6QeC3MWkg3aSG1FbwU1ZNCA8SR1+6kPj3I0fnulpR68cz9faidLAT+URI+7fvY9fYJSf8MtI42fS1fMf8oAsoOEdSVh/H8Feat+dX3kPkLF7vKXgZC5bOAI/gJ3ZYF2yznU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=cnsC+2EF; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="cnsC+2EF"
ARC-Seal: i=1; a=rsa-sha256; t=1768348512; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NntEUxYYBJm8v2o2c/OkXhC3XjdNebojZ8QR7JvVYEnLHPMIWfXrNWiJRTukhByt/1QI5xS7CVR3MhjeBy0D17mQD4maBe+rliW1CHwQrpbvitV3rUrkLaHqLaTFIxZgQqMKMnet6FAZVMhl7veepaUNpwBpFINzbRtvmYqRyao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768348512; h=Content-Type:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=PndRgmkvZWmoxCfJU1lknw4WsZ7/UsS8Jmf+arOrn7Y=; 
	b=V5osunM7v5M4Bhdt8AnMfOW85xuyNOw657jAt11Ba9q5XJkJ06Q6mMKovirO8UIuIanQH72GJ0XwnxYCtCRkTZtB/5rlYhg8cPcU9W6ozhhN522QuPPe8FktBsYgRnHySM3UEo7pxid/nvMoIzZi+ehkIQ6Ds1557nBon3JZbvw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768348512;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To:Cc;
	bh=PndRgmkvZWmoxCfJU1lknw4WsZ7/UsS8Jmf+arOrn7Y=;
	b=cnsC+2EFvwZCF3wm68ZjCfPY/eSyFAY/i6TqCNTANSfQlX1F796G2c+qDh1V+6j3
	tjyB+IZeDs1Ry8ZeblMKF1fHPrn1KUMFjFSZR8mTUHnVWL6YULXiuMCQ6WIZvHHb9MQ
	TTYGK8MzmaWbsS25grF8e+dN01En0FHZjPz9A7LU=
Received: by mx.zohomail.com with SMTPS id 1768348510927665.520662002863;
	Tue, 13 Jan 2026 15:55:10 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Subject: Re: [BUG] push: pre-push hook that waits for stdin is slow
In-Reply-To: <249f08d1-4457-4a41-8dbe-9725c0c392de@app.fastmail.com>
References: <249f08d1-4457-4a41-8dbe-9725c0c392de@app.fastmail.com>
Date: Wed, 14 Jan 2026 01:55:08 +0200
Message-ID: <87ecntqd9f.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 13 Jan 2026, "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> wrote:
>   Thank you for filling out a Git bug report!
>   Please answer the following questions to help us understand your issue.
>
>   What did you do before the bug happened? (Steps to reproduce your issue)
>
> Used `git push` with a pre-push hook which included a loop over standard
> input (stdin):

Hi Kristoffer,

Would you be able to test v2 of this patch, to confirm if it fixes your
reported issue?

https://lore.kernel.org/git/87jyxlioup.fsf@collabora.com/T/#ma48af377cb4a8f3932d2502e9662a0847ee6bf9b

Many thanks,
Adrian
