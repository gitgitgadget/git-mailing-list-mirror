Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9E3672B5
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784391851; cv=none; b=KS3X28+rOKumB3F2elfYouCCj3P0IuL2wBWgknKV0LfJW1KN/aCBZE+kBhRKcjQzEOeJVaV9DOw82eeOCBz+/Lik9uWvG5OXMYnNdwG08a3jj/Ma2Up28TMzkxbVw7XOE2P+mK614Z+of2OYy7WS4QoEMCuvrHK2pOMSdF47blk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784391851; c=relaxed/simple;
	bh=sWe20EVQAMGSvlhfesTSeaw3+6q6xQ0BrqAzHpTd8ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/y+k8sxxrvKrPSI3FSfV6vCuVC9hbfUUYuKmIsfnJ8fckF2+aZe0cseM8EgKLNwAdxb8pte6BB4dYS72HwMKK0xtAOgI0SdSX1mT+0LvvOViEbPL8OwWyuH1YTS99p9Vf0CTnfmdgu84KxlVumw+ZqXKud1MZPAXRsZOYQ3Xyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (213-147-165-249.nat.highway.webapn.at [213.147.165.249])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4h2XCm6dszzRnPp;
	Sat, 18 Jul 2026 18:24:04 +0200 (CEST)
Message-ID: <1139ae20-f08b-4cf2-b779-42328831e13e@kdbg.org>
Date: Sat, 18 Jul 2026 18:24:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] bisect: read run output from the open descriptor
Content-Language: en-US
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
 <pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
 <0de8b12f65530497320b6a4bca395dfd0556c959.1784312854.git.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <0de8b12f65530497320b6a4bca395dfd0556c959.1784312854.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 17.07.26 um 20:27 schrieb Harald Nordgren via GitGitGadget:
> "git bisect run" redirects each step's output into BISECT_RUN, then
> prints it back by reopening the file by name. Read it from the already
> open descriptor instead; this behaves the same and no longer needs the
> file to be reachable by name.

This rings alarm bells. Why would an open file not be reachable by name
anymore? Are we already progressed sufficiently in our Windows port that
it is possible to remove open files? Because it is (was?) the case that
on Windows, open files cannot be remove, so this shouldn't happen
anywhere in the code in general.

-- Hannes

