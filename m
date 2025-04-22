Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C782BF3EF
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745354039; cv=none; b=mPr6VuyIz1Ubph0yAkNJOCTKJIP+zHbr23SUX+72lzRLHsKBn6c+OJ1cKhebXG+pSG8wfo5sCnY4DGTe0dR0GwaR7I0jCF8yfhlWM1O4rk1ZJ7NKshWFV9sjvkr5P4iuqMD2kfAkcoMzcR9XjfkGlSUMLuW5McmNnh9zKgEe5UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745354039; c=relaxed/simple;
	bh=24jAAkPGmhS4RYecjCX/vpvgdvMf/oBkAVgXLGvUUTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=RIL6uHcJ4T2mqNFBVsMFuieWj8DBKCKszJBuK4hj0FyQpEqrBUsosnuK1AvcxyNdSh2swwSHy0jK5Uzsa8RgN0w4RM4iiApXJkNyaKkiifNdr+RfNWf+Ex4sk5t9bjbK+FOFDAEn865Q33VOSLBOoG+3JbUYC8n7qKInoGmYoXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4ZhtLd0m1Kz7QWpL
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 21:57:29 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4ZhtLT0Bb2zRnmF;
	Tue, 22 Apr 2025 21:57:20 +0200 (CEST)
Message-ID: <a736beec-2e9b-4ae2-a611-2a1187042bcf@kdbg.org>
Date: Tue, 22 Apr 2025 21:57:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Verifying data integrity of two git repositories
To: Akash S <akashs@commvault.com>
References: <SA1PR19MB7013FAD97E5E89B56AD7BF04C0BB2@SA1PR19MB7013.namprd19.prod.outlook.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <SA1PR19MB7013FAD97E5E89B56AD7BF04C0BB2@SA1PR19MB7013.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 22.04.25 um 09:19 schrieb Akash S:
> ii) There is only 1 branch master in both repos and the last commit
> id of both master branches are matching (read an article that data
> integrity can be checked like this also since git also works like
> Blockchain)
> 
> 	iii) git fsck --full in both repos,  both gave the same output: 
> 
> 		Checking object directories: 100% (256/256), done.
> 		Checking objects: 100% (10793794/10793794), done.
> 		Checking connectivity: 10793794, done.

The facts that no errors were reported and that the commit ids are
identical are sufficient evidence that both repositories are identical.

> But original repo on disk had this extra line in the end (which the
> remote bare on disk did not display)
> 
> 		Verifying commits in commit graph: 100% (1351940/1351940), done.

A commit graph is an optional data structure. Its absence doesn't
invalidate the repository.

> Why is there a change in size? Also how do I validate if two repos
> are the same or not?
Most likely, the two repositories have been packed in different manners.
This has no bearing on the validity of the repository at all as long as
`git fsck --full` reports no error. The different sizes should not worry
you.

-- Hannes

