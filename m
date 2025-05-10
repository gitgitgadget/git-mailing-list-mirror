Received: from korolev.univ-paris7.fr (korolev.univ-paris7.fr [194.254.61.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022821442F4
	for <git@vger.kernel.org>; Sat, 10 May 2025 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.254.61.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746893146; cv=none; b=MkodTKtxrmnLLnswS2OZh44ML3wXfnLk8Zx2sRRyt6cnu43WvVX9jjpmu3+k3YqQc14VxQmrAo4znYFFr+oP/e2XduIeTbMHOKYJAqeFQ4fNjhonSh7YLOWbXLUbvufCYAdhcYJLtYMQzrEITNXO1JSlMUnOsYK5lkl/my5tu/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746893146; c=relaxed/simple;
	bh=CDtmlBvLLCW4g38hensWDgt0gsWcDCv66l6KNT36ovE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=GHARD7BHpGOjkPOEQec90GjZqre1dQy5ltP+RfshKtUzJ1ESOi4VeIqF/mYJL+x69tjUcFcLgzlRJIaqQdvhBTDs4eqKOL/rv+Ri5leq8rYrL/rEYgmJUa1Eznl7B3wba5aLRKE3cVpc0ihBEJxDGOEel7z7Rt9RSKDb5+WpqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irif.fr; spf=pass smtp.mailfrom=irif.fr; dkim=pass (2048-bit key) header.d=irif.fr header.i=@irif.fr header.b=npSjbpuT; arc=none smtp.client-ip=194.254.61.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irif.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irif.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=irif.fr header.i=@irif.fr header.b="npSjbpuT"
Received: from potemkin.univ-paris7.fr (potemkin.univ-paris7.fr [IPv6:2001:660:3301:8000::1:1])
	by korolev.univ-paris7.fr (8.14.4/8.14.4/relay1/82085) with ESMTP id 54AFCGoZ027587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 10 May 2025 17:12:16 +0200
Received: from mailhub.math.univ-paris-diderot.fr (mailhub.math.univ-paris-diderot.fr [81.194.30.253])
	by potemkin.univ-paris7.fr (8.14.4/8.14.4/relay2/82085) with ESMTP id 54AFCGYO019817
	for <git@vger.kernel.org>; Sat, 10 May 2025 17:12:16 +0200
Received: from mailhub.math.univ-paris-diderot.fr (localhost [127.0.0.1])
	by mailhub.math.univ-paris-diderot.fr (Postfix) with ESMTP id 12D1438ADD
	for <git@vger.kernel.org>; Sat, 10 May 2025 17:12:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irif.fr; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:content-language:user-agent:mime-version:date
	:date:message-id:received:received; s=dkim-irif; t=1746889934;
	 x=1747753935; bh=CDtmlBvLLCW4g38hensWDgt0gsWcDCv66l6KNT36ovE=; b=
	npSjbpuTYBO9mmmwnn1SPBYun/l7angdAEPbv6dLgkZSGFQdb5P1HKNsROFReNYZ
	0lTtth7yQj+MxzmVrPUmXgXVIuspq0f5qOJvYHCgOmrvKiSrbJAvd2lT26mMK4sX
	9budh/1NEkNWggwAZhqrOpSlrschJfkaPB3AtZzAmWxhiBgHmKw5DPorKj8IwxEx
	QTjri6v3I1aPEDEleMeOHgNH4r9zA5gswssABYDC24txSucOF66R8gBnChDnehve
	jjGDN97ZzeLLtcPoVEpB+lYmcAzb4KOz7+syEQ/OOWzZ+ZjdtCmBzgLhH6/u34Jn
	E+8PM3Rjz248TpmV+IAFTA==
X-Virus-Scanned: amavisd-new at math.univ-paris-diderot.fr
Received: from mailhub.math.univ-paris-diderot.fr ([127.0.0.1])
	by mailhub.math.univ-paris-diderot.fr (mailhub.math.univ-paris-diderot.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id LEWouuETLBN7 for <git@vger.kernel.org>;
	Sat, 10 May 2025 17:12:14 +0200 (CEST)
Received: from [10.74.0.138] (unknown [89.207.171.155])
	(Authenticated sender: scherer)
	by mailhub.math.univ-paris-diderot.fr (Postfix) with ESMTPSA id B4A8D38B6B
	for <git@vger.kernel.org>; Sat, 10 May 2025 17:12:14 +0200 (CEST)
Message-ID: <2281c960-7750-4319-8042-dade0ddfff67@irif.fr>
Date: Sat, 10 May 2025 17:12:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Gabriel Scherer <Gabriel.Scherer@irif.fr>
Subject: sparse-checkout and symlinks?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.7 (korolev.univ-paris7.fr [IPv6:2001:660:3301:8000::1:2]); Sat, 10 May 2025 17:12:16 +0200 (CEST)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.7 (potemkin.univ-paris7.fr [194.254.61.141]); Sat, 10 May 2025 17:12:16 +0200 (CEST)
X-Miltered: at korolev with ID 681F6CD0.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-Miltered: at potemkin with ID 681F6CD0.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 681F6CD0.000 from potemkin.univ-paris7.fr/potemkin.univ-paris7.fr/null/potemkin.univ-paris7.fr/<Gabriel.Scherer@irif.fr>
X-j-chkmail-Enveloppe: 681F6CD0.000 from mailhub.math.univ-paris-diderot.fr/mailhub.math.univ-paris-diderot.fr/null/mailhub.math.univ-paris-diderot.fr/<Gabriel.Scherer@irif.fr>
X-j-chkmail-Score: MSGID : 681F6CD0.000 on korolev.univ-paris7.fr : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Score: MSGID : 681F6CD0.000 on potemkin.univ-paris7.fr : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
X-j-chkmail-Status: Ham

Dear git list,

sparse-checkout interacts badly with symlinks within a git repository: 
if b/file is a symlink to a/file, and the user asks for a 
sparse-checkout with only b/, they get a dead link (b/file points to 
nothing).

I initially assumed that replacing a file by a symlink to another file 
with the same content would not be observable by other users of the 
repository. This assumption is incorrect in presence of sparse checkouts.

I would find it natural to have sparse-checkout "follow symlinks". When 
checking b/file as the user requests, git would notice that it is a 
symlink and do one of the following:

1. if the link target a/file is not in the specified sparse checkout 
set, copy its content instead of creating a dead symlink
    (Downside: this could lead to duplication if several in-checkout 
files point to a/file.)
2. or add a/file to the sparse checkout set
    (Note: simply checking it out silently is not enough as 'reapply' 
would then drop it)

Does this sound reasonable to you? Would you have recommendations on 
what the interface for such a feature should look like?
- which of the alternatives above would you recommend?
- should this be enabled only by a new configuration or command-line 
option (to which subcommand?), how would you name it?

Thanks in advance


## More details on the use-case

I'm trying to reduce the working directory size of a gigabyte-large git 
repository ( https://github.com/typst/packages 
<https://github.com/typst/packages> ) which contains a substantial 
amount of duplicated files, by replacing duplicates by symlinks. The 
repository uses a continuous integration script to run automated tests 
on each proposed change, which uses sparse-checkout on only the 
directories listed as containing modified files.(The directories 
correspond to independent "packages" so it makes sense to check them 
separately.) This breaks when the modified directories contain symlinks 
to other, non-modified directories.


