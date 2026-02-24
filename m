Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A5D16F288
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924185; cv=none; b=XnvU0eEuxbQYhkxu0zZUGoTp8KH29cPrhRorz9qxaGnbbT6WnEwCKIdlWpClespPHhm6GmWeQjPUkn5O9aoSOHKcatLssUOf2FMwJDE9Ciwm7QFxpCnRU4XqU3HL7qoKQNK/Jr3geAvocfbD4twbs6b3EuOLHrSEnUg39JbvBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924185; c=relaxed/simple;
	bh=K7u8h27iYwJQoBG6PVEMXkeo6UuU/K+pdP34cRPEyCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSAXZmDRV4fT/TAomYSEpk4CgR5AKWEOrw46S05N1z6hSZfIOXhc8tPREvEXBW3LUn6qxc3fJPKdlzb50l96cNxYVMG7XvMhwSshCwQBEaLmfE2+Db1np7/e5uh/zSdO97pnH4fn9lzTObCEyhTnCmixmnkgbNqOdi2qnNVaGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=W6Kl6er4; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="W6Kl6er4"
Date: Tue, 24 Feb 2026 10:09:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771924181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K7u8h27iYwJQoBG6PVEMXkeo6UuU/K+pdP34cRPEyCA=;
	b=W6Kl6er4dUG1QYqQxNA9auyS9DJlCb37hO1hiPhs/NmRNFp2zZQon6Xhm+wo2K1JozbxQp
	5xX1vAmqLVETHn1u7t+EThE/EvaezcGZLj2VKPMix+CWfWCNBoAJ4X6rOHRpGnPyumCHWd
	vjQmbq5V7yKYwjGwDQ5gFZPukL9p99SVWwU0mk7RMQWC4GIFZgAXdiMflwpHEhWqFrG2bQ
	b24ZPVrBNK/1bxn6Pm0WC+LEcl7syWiF9g2KA0pNazzDThocR9S5PoP6pt226r0fwenOfA
	nhfGA4F1qkBKHhbnL0rwxvnbQQqmFAyjoIZq/c4IXL5+wBQq4WenDLl0sCGZnA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH 2/3] format-patch: add ability to use alt cover format
Message-ID: <aZ1qLtteLECvnY4R@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=333; i=mroik@delayed.space;
 h=from:subject:message-id; bh=K7u8h27iYwJQoBG6PVEMXkeo6UuU/K+pdP34cRPEyCA=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpnWq6waTKwtSaLGinex4+7aoTV4/UsRBMfPilK
 /ZSV+tInoqJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZ1qugAKCRBIeX6hnBm+
 0YBfD/0VBh/IgPB1BPVxsu58dsbXAQkgIuUewYDGxE2+bI0WbdgL6fX6hhPSAtqRIdCyqvfh+fp
 nyW1KfIwQQHFcx0X+x2UYNXSk80/uJZs/dG5t24J1sd7O5e80IX/8nvWjQAfScKIvoujN9pKt0w
 InVtD0KTkgT2B8b61KpovJkyHdCuhnEw2a5RJMd8q3D+m6BxbkpuIHiq+y5JdtF0KjmfI+PXN1Y
 qDdvhii+nF3J2bdE9azCzTLpfpBfo1mVcKJ86YbcFQ3O5dGDw5HJs5bEOzlnh2J2zoQS170fBBn
 3k8AhA/lcNaxiT1yLNDK/BKC5/P0RNGrX2EaLTQF+qTFLdvLlAK/i5dbnsxVqEYRIrFPItRebVB
 2maySskYyGu1idk9TvgGzGXMUu/yFdZpxvTcVxzinZtqoVHPlXMIcpc2Kih1WOq8UDgXr3XaJ67
 r3koisCEhLzdYuUNctZ/RinenPzIlyhQfrMEVlR5OnMuGL3ZwgEaOIDcGo6jaTc+ZHC+vQv20Nl
 ahHV6Ne6bIqb8MsTvB/LSkZxeh2AkwXc2mKXNj0M0JK7LVRAxsBModDNytKAAV63rdegwdw24sO
 epIaZ9MyqF9Wsv5G0Z3o19ZWuo5ux26g2drmlqMUp42L1mSyZRevocxSKEtjhZKwJtJV3FXaxX8
 ZTbMgihg9/a6E/w==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260220230633.132213-1-mroik@delayed.space>
 <20260224040400.751247-3-mroik@delayed.space>
 <20260224090207.GB986367@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224090207.GB986367@coredump.intra.peff.net>
X-Spamd-Bar: --

Thank you for taking time to explain more in depth. I'm sorry for having
CC'd you for such a trivial matter, I just didn't realise it was
possible for an empty string to make it there, I assumed it would've
been checked earlier.

Now I understand what Junio was trying to say. I'll apply the changes
and drop the first patch.
