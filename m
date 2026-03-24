Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563372C0F84
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378818; cv=pass; b=jIXzaj5ObYeYXq0I/KL6nKIL8Za9F1dpFVYLG/sZKOJZHjXdQRGPMzW/faqFaq56+6j0d3jpuTHi7CeI2odRyDC7q8yQIesIW02VGU+Tj34aeUDNhftgNpDqhVVYvmSFCe7CpVZFqX6j49fLVntVuTVPR22e4mzpi7QRFO35YPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378818; c=relaxed/simple;
	bh=HbnCY6GydCKRfIF6edDtHI74fbpjhs9YvX5CFwoZ3dU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gPyUV63eoQsT66Su8lvybolmM2WMeGLFtFC8cX5tzSL5lixIPlXtPQ1MUECEF+VifbMK4yienvHC2JFQsPcKmP2OdNx87t9BVt31JVrD34TdSvS7s4PFSAjbRI6klejoSMX21x7mqFWQPi/8wFD1GzPs/n31/sz66c/zhw4kGek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=jawBjCRH; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="jawBjCRH"
ARC-Seal: i=1; a=rsa-sha256; t=1774378791; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WPRLFfwyWxh7YYfjPo7J2RSkBws/RMjZGlUyA745ovR+BbV03Np24aIsJCyzfwPBBAq6pxJitLGu/9d11aZmVCUa3WfT2ZeNFQxaewJj2TdZkqeFadD9cYKEFTzA48EsqAdN+9r62fZpNSpvyO7TfkzCcLrij/gnxELSZVGfBCM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774378791; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iSwN7dZAnWHQf8yMBoGp8+9azY279Cpn2e7tBvF45bs=; 
	b=CZWu+ngWkA5svM56kMtbTwOcLa1Du0zQ05K09LBJKf95r2hePnvS490M+Vw7LQzKOBkbt7UGK4JcGltQDkyaQvPfGwnYG17ZZAEM9R8ZslhSr3+OI09lk2xrOMM2ixTRiCIOXi07KStcnOvYh/AjFKUKH34MCUIx+5rYrG0TnQE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774378791;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=iSwN7dZAnWHQf8yMBoGp8+9azY279Cpn2e7tBvF45bs=;
	b=jawBjCRHK0zzoH/ZQ/TqGRmOrkjJvOyyguS+12cljMiw7mpw28aSYxSTHRPl9hQ5
	ExfgJwoo1IVppmyqWnat21ikYaRTBwePW7ehCyoYhZnw2M4qAP+uR9y7+dUvRLmm0Cv
	zapDbPslF0Yrq3Kh//Qyj0tWK6ujPLWVYRbipQis=
Received: by mx.zohomail.com with SMTPS id 1774378789208366.24402326982283;
	Tue, 24 Mar 2026 11:59:49 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Junio C Hamano <gitster@pobox.com>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 2/9] hook: parse the hook.jobs config
In-Reply-To: <acJUXq7cMKG6KExe@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-3-adrian.ratiu@collabora.com>
 <acJUXq7cMKG6KExe@pks.im>
Date: Tue, 24 Mar 2026 20:59:45 +0200
Message-ID: <87jyv1cau6.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 24 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, Mar 20, 2026 at 03:53:04PM +0200, Adrian Ratiu wrote:
>> diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
>> index 9e78f26439..b7847f9338 100644
>> --- a/Documentation/config/hook.adoc
>> +++ b/Documentation/config/hook.adoc
>> @@ -22,3 +22,7 @@ hook.<friendly-name>.enabled::
>>  	configuration. This is particularly useful when a hook is defined
>>  	in a system or global config file and needs to be disabled for a
>>  	specific repository. See linkgit:git-hook[1].
>> +
>> +hook.jobs::
>> +	Specifies how many hooks can be run simultaneously during parallelized
>> +	hook execution. If unspecified, defaults to 1 (serial execution).
>
> I was wondering whether we also want to allow -1 as a way to say "use as
> many jobs as I have CPU cores". We also do this in some other places.
>
> Totally fine to ignore this for now though, we can still add it at a
> later point in time once somebody complains.

Yes, we can do this.

I already had the "use as many cpu cores as availble" logic in v1,
within a different context which I dropped, so it shouldn't be too hard
to add it back when hook.jobs == -1.

This is actually much cleaner than what we had in v1.

I'll do this in the next re-roll. Thanks!
