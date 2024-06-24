Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895791B28D
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719208896; cv=none; b=Oqr2cr0hYyTZYEsMFLcSLbrC5b5sO+gmQynJnxCAJa5JPclSVEBkApr1r2BkQN7rHhG06tgyEfhTiPiAzvx/0h588qtN93gaKBcGpZnopf1niofEZEByksfyH1uTldI9wYURmoZzu2EpkEQ+dLFE1XtmL00gTL9eAggbTjGP7ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719208896; c=relaxed/simple;
	bh=Jf5jk9Wwk+YpDKDQ0Qb74J6UDPLZDPn0GQeLQj5TsE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DIcY23OAQmOR9dxM61OmbFS/RJuPUZo3bNKJV5+An5ocEDGa5UkKW+t9n6HXSGl+OiTyaBsHQOUY3bZFCgTxhu+1yBX1XSK26vVvbo8wWPxXBbnKyYSzL17qnf+jP2giWYXhYv5DB0eV2kgTMEpsASj0rNFew/zGD88jg0Vinfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baxters.nz; spf=pass smtp.mailfrom=baxters.nz; dkim=pass (2048-bit key) header.d=baxters.nz header.i=@baxters.nz header.b=VqgpjD6J; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baxters.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baxters.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baxters.nz header.i=@baxters.nz header.b="VqgpjD6J"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baxters.nz; s=key1;
	t=1719208890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fw6rRvhNw7hpW9Y+VG06sPYWVSlHHG0w3Dk7cgX82IE=;
	b=VqgpjD6JIMOmmD5XvrZAES2seSAJpMtq16EYd+WMM6G/G4Niy7OSyoTRd/WFH6OsiJmLjg
	g1lkTtoHULIRRESXwpYuhSXd/DDRHAVykwvpc0lun2kNUmVPs9tNKGzXLj1IH7czinMJ9M
	HxOdZ5Z7auUenlBm4UxKrwCzQ+exw3whr9xqqjlq9O1R0LeCHYx/6iPXEZtec/TOYBgLc2
	KFVa19kHed+JC3JssFrzFDzBVQ1gEfSXzdMDr5Cs/+fHUnW0cVtdi1ni1ftHj536pYnYmi
	1aTSS4zak4k7t58cVKwspoPPcnl5mdeK17gexMwPRCa1jIrfJesII1lQnHt6pg==
X-Envelope-To: sandals@crustytoothpaste.net
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jeremy Baxter <jeremy@baxters.nz>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: git send-email SMTP password command
In-Reply-To: <Zm-ByA09z3jhij6u@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 17 Jun 2024 00:22:32 +0000")
References: <87ed8w33l8.fsf@baxters.nz>
	<Zm-ByA09z3jhij6u@tapette.crustytoothpaste.net>
Date: Mon, 24 Jun 2024 18:01:25 +1200
Message-ID: <87bk3qc216.fsf@baxters.nz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

"brian m. carlson" <sandals@crustytoothpaste.net> writes:
> You can use a credential helper, and that can be a shell command.  For
> example, you can do this:
>
>   git -c credential.helper= \
>       -c credential.helper='!f(){ echo username="$USER"; echo password="$PASS";};f' send-email ...
>
> This resets the list of credential helpers (with the empty value) to
> remove any you may have already set, and then uses that shell script to
> read the credentials from the environment.  The documentation on the
> protocol is in git-credentials(1) and gitcredentials(7).
>
> You can also use your regular credential helper to store the
> credentials, in which case you need not set any -c options at all.

Excellent, that's working for me now. Thanks a lot!

Jeremy
