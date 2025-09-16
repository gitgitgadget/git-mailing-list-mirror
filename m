Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E771E5B94
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036376; cv=none; b=FiWPOUr6b3C6QsO+r2ess1nmeN9/eyvc553wlclc+EQJ69/8FPKlcM/9+4zZSq8qq10W2M32o9ZfCMFpjA4cFvee4TFki3V7dTOteo/tJ6xZ4OeF4EDuYFyOu/C8jj2CtGTVkQiaYyL8Z/yVaEgKDxt++rIhJrRVDIJsnaiEvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036376; c=relaxed/simple;
	bh=MARqj54ItlGq825QraiYAxkg+OsrddSsMKmaUX67wmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k5RkHdmciosbDqRg0b0uwUeT08byzqqI8WhhKOh9XrUwmpA7bFjugRV/RLgu9TF7xd3fK2H5gB9OkNIwg7nrj7FgrKhbbmvpvRq5TdK8dASfK8wbswTFrIsvdtJnhSpa8VH4dKG2g8ISnMNCZNe+IouzbP+LD7atecOU1GHnCo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=d+XJDPA7; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="d+XJDPA7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1758036371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmRSa3RNhPdXYoNwFJeim/Dj+GUWU8s11h+HGaSAdZU=;
	b=d+XJDPA7k/l7Xhpn3uCMqRDpQYXFjXyShCjZgrzxwBVW5LxUuJDGitE38QetrG0UKxjgzZ
	MIGr704J09fpBeS1Vd8SebjV75W3Z8Hkwk0Wc63qGHNy4RZPbxq0xEjwo5QH558iMXUZmC
	QG58ESGWtUAom4Tr1QmW+zbzdUKhPaY=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] bundle-uri: ignore bundles without uri
In-Reply-To: <xmqqbjnfmvwo.fsf@gitster.g>
References: <20250912-b4-toon-bundle-uri-no-uri-v1-0-f4525a406df8@iotcl.com>
 <20250912-b4-toon-bundle-uri-no-uri-v1-1-f4525a406df8@iotcl.com>
 <5hm6qdyn5ifs2kr33nwuc67qa3vdgis6w26rlvicrdzznzazzt@uytayxq5r25n>
 <xmqqbjnfmvwo.fsf@gitster.g>
Date: Tue, 16 Sep 2025 17:25:58 +0200
Message-ID: <87bjnao1vd.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> I tend to agree.  Instead of papering over a misconfiguration, it
> would be better to let the users know, so they have a chance to
> report and/or correct such a misconfiguration.

So are you okay if I do `return error("some message")` instead of
`return -1`, or do you expect more of a change?

-- 
Cheers,
Toon
