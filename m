Received: from smtp-out-01.rz.uni-jena.de (smtp-out-01.rz.uni-jena.de [141.35.104.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA241ADC93
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.35.104.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029877; cv=none; b=plA4+QnE/pvOWgnwigc4F1Nq8h3A/Et7T2khQBcdNP9eP42/dbyox1FGgCVs3nMKSZkmNFbm+JuI46XlPLx+cItgf8AXib/xzxhiRi81e6MMzgCvGoeOstSdzYtUQOWwpo5JVKIZTEXAgJy21Gx4swZXAz4gQRT0PFO5cYrXIfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029877; c=relaxed/simple;
	bh=Pc/k40PjdAymugPuO0/YtzY71FbkNZDUyieuQ6t+G1g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=hwvvUj5a9iXGdACzrk6/LCi/SEwkP+jMxUwmzwyT5fZxYGMbwLMhzumfDFU2UN33+JqIPutChwI7ZzKtTZeLmGjC+rx830Ojnmzqq65fhEuFFzc0cElNmrH88MWNOi46KnHjdBb5CZSo6mVZ89tNeLNSOkRdtTlTnNHKf1E7dwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-jena.de; spf=pass smtp.mailfrom=uni-jena.de; dkim=pass (2048-bit key) header.d=uni-jena.de header.i=@uni-jena.de header.b=QFz/PdxS; arc=none smtp.client-ip=141.35.104.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-jena.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uni-jena.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-jena.de header.i=@uni-jena.de header.b="QFz/PdxS"
Received: from smtp-intra-01.rz.uni-jena.de (smtp-intra-01.rz.uni-jena.de [10.138.192.40])
	by smtp-out-01.rz.uni-jena.de (Postfix) with ESMTPS id 4Znhvy3Lwqz9rcD
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 18:09:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uni-jena.de;
	s=opendkim-2020; t=1746029374;
	bh=Pc/k40PjdAymugPuO0/YtzY71FbkNZDUyieuQ6t+G1g=;
	h=Date:From:Subject:To:From;
	b=QFz/PdxSwl52QppcZ+n54I93ZSeNMe9IN/d3vL4fgYNqVmEaM5ycNWYtotDU5CFmE
	 PhoolZ9ir2bM9FrV8yttV9NkzHRYUcLzmO2wHZkXDFKGTYwUwuRHjGhc1CKg/Qn4rw
	 54qX/S6fyeU6dorDUl/m+4smmocj3ZAtQ/DT17Ym4sMgxpn04JDiTSFLLk4k1mBwI6
	 fWD7mkUxoD6wal4bRj6R9mLGg5CXPU+InEbdJjeZS2r7IXjn3WflipAVKMbe158FbC
	 kees1+Q4Fb/zolWdtExlFtrXkxgTgOzTYdperagl4FmDQrfAs1qIZvv6rhjP5hiR+Z
	 PsvrQ9KVw24MQ==
Received: from [10.148.27.234] (unknown [10.148.27.234])
	by smtp-intra-01.rz.uni-jena.de (Postfix) with ESMTPSA id 4Znhvy2T65z2wwF
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 18:09:34 +0200 (CEST)
Message-ID: <fb842b0e-3666-4b78-bf00-c7d11a42dd25@uni-jena.de>
Date: Wed, 30 Apr 2025 18:09:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Lino Haupt <linojossfidel.haupt@uni-jena.de>
Subject: doc: git-clone: Improve discoverability of --no-single-branch flag
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Git developers,

this is a minor usability suggestion

git version: 2.47.2 (NixOS)
and https://git-scm.com/docs/git-clone

Short Explanation:
`git clone --help` shows `--no-single-branch` only inside the
`--depth` paragraph.  The canonical option paragraph
`--[no]-single-branch` is hard to find when searching for the
exact forms `--single-branch` or `--no-single-branch`.

Extended Explanation:
This reduces discoverability for users who quickly try to search
or grep those options. I myself was confused by this.
The search term '--[no]-single-branch' is not intuitive.
Of course, searching 'single-branch' finds the option paragraph,
but maybe only a secondary / tertiary choice.
A second issue is that one has to deduce what exactly the 'no'
shall negate. This is not complicated but may leave inexperience
users unsure of the expected behavior.

Suggestion:
Below is a drop-in replacement that (a) places both variants in their
own paragraph and (b) spells out the negated form explicitly,
removing the need to deduce what the “no-” prefix negates.

--single-branch
Clone only the history leading to the tip of a single branch, either
specified by the --branch option or the primary branch remote’s
HEAD points at. Further fetches into the resulting repository will
only update the remote-tracking branch for the branch this option
was used for the initial cloning. If the HEAD at the remote did not
point at any branch when --single-branch clone was made, no
remote-tracking branch is created.

--no-single branch
Opposite of --single-branch: clone histories leading to the the tips of
all branches.


Thanks for all the great work on Git!


Best regards,
Lino Haupt

