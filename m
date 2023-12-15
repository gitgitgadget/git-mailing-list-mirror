Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1074D5F878
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="iq0TQZZQ"
Received: from [10.0.2.15] ([146.198.40.91])
	by smtp with ESMTPA
	id EGBErrjXuJsy1EGBFrKTJO; Fri, 15 Dec 2023 21:57:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1702677433; bh=POVUQngQE3dNVHwXnN9zFLag4O40Kqf6ntz60gbBXv4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iq0TQZZQY33b8PcW/T1jPvWM95MSor2a1449+FavreRg8fwyKccb35WziuF6lWAzC
	 wclW0j0h4Zy/4qZCt6sd7YhuSDSVkZIQjr5/p7kzMxowMaf3WN5d5iyWDDP4znU7uk
	 dTAJfUSIaVgYsixKiRTDLpQ6fFvS4He+NSI2n1es9q6qtVFCWoZIwapT5rzISExKei
	 MUSPs/mqPRy2t7aDkkOefKO/23bXx/l3HSkpz3CVJ0DZljkD3PYZRLFIp/mrASK/KW
	 Ejn+4xQOD6gXOLvLSlSuwvniw7uesZ7RkoMjiadb16CgRriFnQurzhtHznbV0xVdmd
	 5uWa/S6Jb4DSA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=AOje/3mm c=1 sm=1 tr=0 ts=657ccbb9
 a=KA9ncW3+NP+rNtcBcdh9kA==:117 a=KA9ncW3+NP+rNtcBcdh9kA==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=EWlnYHABesc_bmPxTqAA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Message-ID: <0c93d426-17c3-434c-bbd0-866c31c23f9d@ramsayjones.plus.com>
Date: Fri, 15 Dec 2023 21:57:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] git.txt: HEAD is not that special
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <20231215203245.3622299-1-gitster@pobox.com>
 <20231215203245.3622299-2-gitster@pobox.com>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20231215203245.3622299-2-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEEiBKRy8oWlL2F7sxBPPlnYHpWiHN6Y2ykSblMeUMRTqN69BFVZ3YbIAu67o7g/CkUegvQfw2BxFe0e1KGZie6V89Q0mO69RKWXoqel4rzO9BvUZgkT
 gUe234vuU1J1hMs5TZ+yuVXJeV0YUwwNTonCgPI4uIaIsUXFiQbKobUlY7WkXa/8M0gZ7bHG3XExNuNdpY23Kf/2DEPQepWYfYU=



On 15/12/2023 20:32, Junio C Hamano wrote:
> The introductory text in "git help git" that describes HEAD called
> it "a special ref".  It is special compared to the more regular refs
> like refs/heads/master and refs/tags/v1.0.0, but not that special,
> unlike truly special ones like FETCH_HEAD.
> 
> Rewrite a few sentences to also introduce the distinction between a
> regular ref that contain the object name and a symbolic ref that
> contain the name of another ref.  Update the description of HEAD
> that point at the current branch to use the more correct term, a
> "symbolic ref".
> 
> This was found as part of auditing the documentation and in-code
> comments for uses of "special ref" that refer merely a "pseudo ref".
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 2535a30194..880cdc5d7f 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -1025,10 +1025,11 @@ When first created, objects are stored in individual files, but for
>  efficiency may later be compressed together into "pack files".
>  
>  Named pointers called refs mark interesting points in history.  A ref
> -may contain the SHA-1 name of an object or the name of another ref.  Refs
> -with names beginning `ref/head/` contain the SHA-1 name of the most
> +may contain the SHA-1 name of an object or the name of another ref (the
> +latter is called a "symbolic ref").
> +Refs with names beginning `ref/head/` contain the SHA-1 name of the most

Hmm, s:ref/head:refs/heads: right?

>  recent commit (or "head") of a branch under development.  SHA-1 names of
> -tags of interest are stored under `ref/tags/`.  A special ref named
> +tags of interest are stored under `ref/tags/`.  A symbolic ref named
>  `HEAD` contains the name of the currently checked-out branch.
>  
>  The index file is initialized with a list of all paths and, for each
