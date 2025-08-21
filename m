Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E73813A41F
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781471; cv=pass; b=uptxJgbyby4Gkj1toMU+b+wRGZ5FwZ5pxy0yl1p/OfT7isde8+ogw7YSmhpZjxDRA//B/Oy6u6C8V4F4z6wYsyLKUZH6LtX2KYXLQnNGZOMYNJNw58lwJDt+U9MHbe3CzNaEjSN4vP0ZJA6HmjcCfDxBZZUmuvaDNNcOFdUUyg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781471; c=relaxed/simple;
	bh=lPJMRISSqPKXlz/CCRgVZlG0dZ8XLvyWZgkp1Qg2VPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tj55zO7UPvds2fIkZ8w7OvYVkdUOHaxNc4TUhOsOdQqcAQBo0vh57TfdjcacAHHIbSMP6R2hOPR01kaM+e+/vwdQITx0B6U8SwzidDPePbM4l0enA4OWZFYp2SkKzVGdVe2u0YiWWo/5KNYae2ZNVhIo3D/Yw2eFXGmUtyEn60Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=T8/8x/A2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="T8/8x/A2"
ARC-Seal: i=1; a=rsa-sha256; t=1755781450; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e22alqWbyaEy1PwMWt3L4lsU8odipwBf/jvqkBWBJEWG1kCJW2VIJszq0RxjOVc+2r4taMKulqf07rKwwmKF1/jpQh6fH0gbREC4xSQNIEqdfhPrMbjDvRVnBN/7Ub3k8dY1/zIu5/Peq3BWJE/GIe8Ykfouopu/O/gM2yx5VrY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755781450; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yaDY15M3XDp7qvN+io3AaChSrzulUp+ACkytJu0bNoQ=; 
	b=fGuGRkJvFfoBys9Hd7hqeKGMICDwXYd0V4KDDO+q7bBqnQWv4f4VEaREkO/Uh+DEjgDDvnwCvXgCrpgevg5nE7eMHCy6Ms/j1xV8h3JCvPgrke+mNQUB3+7dzHGocHhNKDL0k22ALaWV5tpZtYSFYw0GWr60fa2J1oRuXOGZKAo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755781450;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=yaDY15M3XDp7qvN+io3AaChSrzulUp+ACkytJu0bNoQ=;
	b=T8/8x/A2KMRFWhMZyI8uFHrCdk5/si2mTp2kAwpA8G+Fmiew4i7O5U1KQkfU7RMs
	Mq1WPoAIDlIrFt4u4l5yJkRNkYfoQT+qZXsLvMOIU5NFzQbvKp3wV1lwVIyKm6Bv4fM
	3Fo6RFS2xjvbFKHIkh+4oxoqj48AynBr1UGedB4Y=
Received: by mx.zohomail.com with SMTPS id 1755781447596423.62264178874295;
	Thu, 21 Aug 2025 06:04:07 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 3/9] submodule: add gitdir path config override
In-Reply-To: <3hzj6k4yxfcvpt33jkblcafljhbj5npjia2u7sprqbkfcxoxwa@6qmaqwj3x7hc>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-4-adrian.ratiu@collabora.com>
 <3hzj6k4yxfcvpt33jkblcafljhbj5npjia2u7sprqbkfcxoxwa@6qmaqwj3x7hc>
Date: Thu, 21 Aug 2025 16:04:03 +0300
Message-ID: <871pp4967w.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Wed, 20 Aug 2025, Josh Steadmon <steadmon@google.com> wrote:
> On 2025.08.17 00:36, Adrian Ratiu wrote: [snip] 
>> diff --git a/t/t7400-submodule-basic.sh 
>> b/t/t7400-submodule-basic.sh index 178c386212..f4d4fb8397 
>> 100755 --- a/t/t7400-submodule-basic.sh +++ 
>> b/t/t7400-submodule-basic.sh @@ -13,6 +13,7 @@ 
>> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main 
>>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME  . ./test-lib.sh 
>> +. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh 
>>   test_expect_success 'setup - enable local submodules' ' git 
>>  config --global protocol.file.allow always 
>> @@ -1505,4 +1506,18 @@ test_expect_success 'submodule add fails 
>> when name is reused' ' 
>>  	) '  
>> +test_expect_success 'submodule helper gitdir config overrides' 
>> ' +	verify_submodule_gitdir_path test-submodule child 
>> submodules/child && +	( +		cd test-submodule 
>> && +		git config submodule.child.gitdirpath 
>> ".git/submodules/custom-child" +	) && + 
>> verify_submodule_gitdir_path test-submodule child 
>> submodules/custom-child && +	( +		cd test-submodule 
>> && +		git config --unset submodule.child.gitdirpath +	) 
>> && +	verify_submodule_gitdir_path test-submodule child 
>> submodules/child +' + 
> 
> Rather than `( cd test-submodule && git config ... )` here, you 
> should use `test_config -C test-submodule ...` and 
> `test_unconfig -C test-submodule ...` 

ack, will do in v2.
