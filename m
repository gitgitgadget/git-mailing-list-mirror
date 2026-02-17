Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8D28CF6F
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771364487; cv=none; b=M9q6BtELWgTGVap4VACr53J2dlLmkmn1QI3GnGqtWsr4b5SEblQfaVFEA4PhjgjIAEtiRjuTBvqcNu6ZXH7/lbY8ezq1Z3NEl60qde3MX/ryIAPAX2tZ1SC1P86mHKHGNNrEiIsY+7BhXQ1APkCpTG4evLvGIRvaY8YI9Am35f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771364487; c=relaxed/simple;
	bh=NBHdQjXtVfe/cyGxP1ju9jWTxLojYxOxLPpPfDqJxPo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P0286RbAm/hQDQoT/tCc4lMn2a/gU1BSf1dD5lQEDnAUPW+kXe/6NqFaepM84jDLhmtw120iGDNSIBX9S0DXsxJ3VrF8sWWWS9XxnQNd4o2DgxjjArCA+60sQd/XDO6k4srhlkj2X6bpdamfEomtXlM34CV44bOpR/xzlMbeI2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Cw8UM2Qy; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Cw8UM2Qy"
Date: Tue, 17 Feb 2026 22:41:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771364484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=A6w45k929ySuUKGA/eZgx1MnDLYiZx5HV6CM5nbJ+6o=;
	b=Cw8UM2QyrVC/WwY79llNguvyZNPeYA9KJVJuqqrNAWoXI3E2ZNRIcG7pB6jFFZWWidUpi4
	CtpiVOgV5aj9Hq+qxTnmRMJYReMpgWkDlzLu6OFiEq7XbS0wTbsmheyPQvhhQsVSG+wn3Q
	YSoItSvRgZ9Y+SWO+3nORFi2y0qMHvmuzF0NT9vUQr7RXdZXDTzszt+Hq2aqmJeVbCG+n0
	r9togtviFbLnzUwQInUwicZqYx2QUZWpNEZm5UWiDGwHpckNpWvZ4aQQjByrgXE6zp6+1q
	yeQjtbI5dz0aErJ9G5huWiIChurq6jctlSQdIVbv0FV/847XCFYvX7lT0uswIQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
	git@vger.kernel.org
Subject: Re: [PATCH v2] format-patch: fix From header in cover letter
Message-ID: <aZTeLDzxSRRS4JAo@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=544; i=mroik@delayed.space;
 h=from:subject:message-id; bh=NBHdQjXtVfe/cyGxP1ju9jWTxLojYxOxLPpPfDqJxPo=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBplOBise7z0xBs4eLEvOjhvOAUOhy2+RNU3/P0s
 tZui6T+60mJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZTgYgAKCRBIeX6hnBm+
 0SRJEACJkdifAnA39XnYi7pST6s6z+WRElqfD0t6frN6ISbCa9sjylXsY4uONOm7GyHP54YvcEe
 AMYtgipBpAuLq8cgeFODgk5pShi+ytZw4vK2ySGo6u8d2EvWshu/kEZsiWbMcjCWj9X+GCRxah9
 uT++hfq5JB0j3aWuzC6y1lR1I02Ga0eEYC/lOg0hCq6O7/s58iV/0m/wB5TjLNflJla5rm0Dxsq
 YSJ6rpx/yBFyE1vE5CloxvF7imTe+Lst7y8Vycipxp+wl5oADpPHcjuqpSxrOYxn6ctf2tj/ovu
 Lz7H1XB/U5XDkVMSvGnk/izpG7UsWT3paxKt9N9sxWABTkfg1k20HGU/xXBeyCGIM9X/8vQyR46
 qE4kd5nFV5ToT0C12QR/gWE1INL88WTRWjtOMRAFN3edjVXhCY9BpfCu/F009NS2K9JYA1G80vP
 H4dJcFixkApTPdx6Rs1sC6WPNfqSVvxGRCWGF6WMkPE78WxgenIczCxEcy5/rot5l9kr+z75Ov1
 O6wvpRaD3H1Gm994paMDVadnikpEfyBpeslbSEnsT43lNjXIRykG13twOIdoCvdXdKC76IEq8gm
 nEyKDoUnoQ7rKDRo12/JreK+sBeAhdvZYtpMy6As+8eazJHtn6tlLfrtLrNCWUvuBLPXeBdUOlx
 PShKce+v7JBGVVQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Bar: -

On Tue, Feb 17, 2026 at 07:22:33AM -0800, Junio C Hamano wrote:
> Yes.  It does make sense to document the change in thinking in the
> proposed log message and in documentation.

As I said to Patrick, I don't think anyone would reasonably expect
"--from" to not apply to the cover letter as well. Given this, I'm not
sure we should refer to this as a change in thinking in the commit
message, it should be treated as a bug as if it should've always been
this way.

I will edit the documentation to remove any ambiguity.

Thank you
