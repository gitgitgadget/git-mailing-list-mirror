Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C823142A83
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746579608; cv=none; b=Up5AhE3ffV+LaDM5zUUbQZbO5rUnF0GIlpRb5ktNufCqWB2NQpe2pE7pd0/fY23nqTVaPkXYAA/jXCDW1eS1oMneQHd6zVYw8UudVFhZhWGWFH7+b7MGFSGOdCDEKDQMmwKy9HOK4zcr1oQj4MUPRBOVepwJjWpMJaozgCBR4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746579608; c=relaxed/simple;
	bh=M3MYTbYyR3acfel9GOmrBDmw5VOEQJM3usaSZKXYXRc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=lr+Mj8rojSsOpvwY5iHyqwNtUfP7xRT5S6fq4PhBD9n6+0HCCyqfOYuLKHIaWTB3UuMPxPMMDtxqlfSQw1pR1nMD8kvnvF8a5/HkCnD9R9pQ3EWeoMGKuyo3uGYpx9JOeIDRigy1Yeu3PRLGS5eXR1cQmG+83+htCZV0RpUa0JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajU+GPl4; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajU+GPl4"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7081165a238so45554007b3.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746579605; x=1747184405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDnfNV0+o+PdsHnZO+zQ0rD8pUwnYSw69vDaknZ6Aj4=;
        b=ajU+GPl4WZ1eKvUpOD8sYqWDDV7NXo6lAn9/kls6oHUZ1hv69VGae4wf4dbjvGdNZ4
         6sZ5XvDG7ekgDCkdkLZ6KTAr9mkan33VoNMjVPaAGrjHX6sVjzPZFA9U1RwyVLYWBG75
         9em38Sjb7/gzL5aWpH41R+7obQYlQTz97SaKDJSsWqyGgce5SUGMuA6H0G5LaL7VcTa3
         3p2u1qr3VVZcUMTrbqwlKQ8wZX4ZdMe4GNBctsjcbP+mHhnVhN/UnmALELhhkHVhcTUZ
         KBu2d2YQDrzWwxYKeckvCJtXNqlelxfPYvsZdpFwytM5bEmDFafFKnRjq8Y1bA0EFlew
         0QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746579605; x=1747184405;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDnfNV0+o+PdsHnZO+zQ0rD8pUwnYSw69vDaknZ6Aj4=;
        b=KP2HiiynAwumx8HmK9iDaqjCN0vnN5qEP6JtlrM1lHqv2Gq/ywxJ5/i5YPOZBvQAZj
         JLVrkHK818S6MfzBk+1BBrN6ucFdhF3j5GzJ2oPRFchL5jbv11kb11fAjSoj0sjnxjv6
         SiKUSdKHsJqbVLuYXfYACsytfvEvyV9fCiqanfiYqfdOUsSz5R1LBzPmulDflZNbb6jK
         Fw8kdvbjEzIdIApYZ+wR/3obnhOxIbD2/0sJov+yy+5lSLaNvzrc8Q1k9TCgJxCxYstZ
         7h7GKP0FtxMi/uMTTcLi3lAmoxyeHEKrx3FlR/eqqSJljCeVJ86IMAzAEfkzb5mJi6RW
         GF1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbwgcKJUwNEXbZPG7CLAZKmUyaPoWSbHWBAx1blmLBkdyL/r0htehdbVnzRDwM3lcBUks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl/3plSWZGxuGErMeqrQcZ/IGrqdm7fUW9o1VygdJYOurimZew
	UxAA+1eKtCuOkzCwPAXBvAca65Y16cILicGQXSVPoK8V4hhzfLKfM0nEOg==
X-Gm-Gg: ASbGncs/thmOWQV8vbVFD1xIVWSmycnEiFqHd3UW/9X+dtIHTOxIZMP+OxZ9yjA5wqS
	RORQWiFTZ3bdnj9B6wetFN0vOK9aMuo9Cr7TIJS9S+ID6ENNsnl5+wSfxzJv5fouchytTsh9kTZ
	/8WYSptIPhjQKeRnTpRpVYg/Bo7imL9mH7BjILnWKiQJL5L868bMZy2AdrQbe/Kjya5y18O+4uw
	OX1OqptNsBagXYTNmWLV22xOY3bshAhCEJmqc/Q5DSHnGAyRE5S0ltcLmS4U9bv6g5q1wHZxPMB
	5m3PAlMrOxM73YJDGxTfLJvFSiKTW+mo3gukUXdqQ6XzEK8AiwyocTkAWU39XTFRlrL6ZXO8Ssj
	Y/lqX6hsR4xOPXIC7xtGc1uYJ61Ix
X-Google-Smtp-Source: AGHT+IEPl/egKKqxWjfL3unVm4gApfgz7HaqeQ5lWdnzjWkNCigm4jPOpSVwh5oHNAS6puPVoKZGnw==
X-Received: by 2002:a05:690c:338a:b0:708:b7fd:bb03 with SMTP id 00721157ae682-70a1da08f52mr21881967b3.13.1746579605447;
        Tue, 06 May 2025 18:00:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cc2e:477b:d336:3346? ([2600:1700:60ba:9810:cc2e:477b:d336:3346])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708c3f3d67esm29879007b3.35.2025.05.06.18.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 18:00:05 -0700 (PDT)
Message-ID: <41f4a9f0-e758-49e5-8e88-4659966547c1@gmail.com>
Date: Tue, 6 May 2025 21:00:04 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] object-store: rename `object_directory` to
 `odb_backend`
From: Derrick Stolee <stolee@gmail.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-2-c05b82e7b126@pks.im>
 <e23e7e63-1d66-4a5c-8c4e-19b5078a75ad@gmail.com>
Content-Language: en-US
In-Reply-To: <e23e7e63-1d66-4a5c-8c4e-19b5078a75ad@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/6/25 8:51 PM, Derrick Stolee wrote:
> On 5/6/25 7:09 AM, Patrick Steinhardt wrote:

>> Let's preempt this by renaming the structure to `odb_backend` now
>> already. This name is agnostic of how exactly objects are stored and
>> allows us to easily introduce e.g. a `files_odb_backend` and other
>> specific implementations over time.
> 
> But here's where I'll get a little nitpicky and say that these are
> "odb"s not "odb_backend"s.
> 
> * odb: a single object database. A repo can have multiple, currently
>    only one that is read/write and multiple read-only alternates.
> 
> * odb backend: an _implementation_ of an object database. This would
>    be the structure that containts a vtable of implementation methods.
>    Each individual 'odb' would point to a single backend describing
>    how to access the data in it.
> 
> Does that make sense? If we are going through the effort of renaming
> things, I think it's worth being a little more future-proof here.
And immediately upon sending this message, I went and looked at
another patch and realized that the rename in Patch 1 would be
confusing with 'struct object_database' containing a list of
'struct odb's.

Perhaps in my head I was thinking that each repository has an
"object store" which is an abstraction over possibly multiple
"odb"s which each are interacted with via one "odb backend"
(and there may be multiple potential odb backends in the future,
but only one right now).

If we want to keep the 'object_database' name from patch 1 (or
replace it with 'odb' for brevity) then we might want a different
name for each sub-odb. Perhaps 'odb_shard'? 'odb_slice'? Do any
of these sound better?

Thanks,
-Stolee

