Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F26126B08F
	for <git@vger.kernel.org>; Sat,  9 May 2026 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778307421; cv=none; b=bELMr5WMVFj1SpJtnH/vY2mS3UAYL7NJEODyj2I1Oq4O2s8YpdEaGAIlc4g0+6BQ6jLKfcgPKAhGa9luHf4tIkWIz8I9ttZnY2ejgzkMGZi7cUBDEUT/woSeGwPZseT2e5/Y22jNQve4Wr49g2a8+MEPkl69z97xWbPuUw0iPx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778307421; c=relaxed/simple;
	bh=CoI68+7z6kO/2BYdmWECNSZ+V2VdaqG04rJsnn3M6RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUOlBP85dZ8J4I5380CLKcy0o/KTqr9FNxwcn7lryfLSsIPGjT8FTbJuqOylVxKHmmjQgswTzH7sTWK9wM8cjq70FOFi0R+fTbX38kslHWIAAW2n/Byyz5dm1pOF0FdJzHEcjyYLCO79b299aK4FKUXgmpopgploY+hXXWKxOME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4gCG3P2BNyzRmcC;
	Sat,  9 May 2026 08:16:49 +0200 (CEST)
Message-ID: <cb359a26-2878-41a0-a554-9bcd28c7404c@kdbg.org>
Date: Sat, 9 May 2026 08:16:48 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
To: Vincent Lefevre <vincent@vinc17.net>
Cc: git@vger.kernel.org
References: <20260506010927.GE5260@qaa.vinc17.org>
 <7cedf86c-5db7-45ef-b8d4-034b792f0def@kdbg.org>
 <20260508213943.GP5260@qaa.vinc17.org>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260508213943.GP5260@qaa.vinc17.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 08.05.26 um 23:39 schrieb Vincent Lefevre:
> On 2026-05-08 14:48:01 +0200, Johannes Sixt wrote:
>> This is expected behavior.
>>
>> git diff --word-diff is not agnostic to whitespace; if you drop
>> --word-diff, you see the line-diff that the word-diff is based on. If
>> you want whitespace-agnostic word-diff, you have to add -w.
> 
> This is not how it is documented. Even when using "git diff" without
> --word-diff, but with GNU wdiff instead, the output is fine:
> 
> $ git diff file1 file2 | wdiff -d
> diff --git a/file1 b/file2
> index da04344..0074613 100644
> [--- a/file1-]
> {+++ b/file2+}
> @@ -1,5 +1,5 @@
> 1
>  2
>  3
>  2
>  4

It would have helped if you had pointed to, or cited, the documentation.
I cannot find documentation from which I can derive that the above
*must* be the correct output. In particular, I don't find any mention
that --word-diff operates exactly like GNU wdiff.

-- Hannes

