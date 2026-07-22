Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922A384CE8
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753591; cv=none; b=fjJNDP8eo19BeFa0s9josvKuiX3pso4+xEjwFcEtCD7ZEozrTgVe+UmIlDdIHEPZeDF7IUzeLNEPefxRD5Vs54bzYT3Au1UfXfSj9TvMdfqehxlQa1OicU8vrKZaTVA7087DFH9qxfN4mRphvrNFuYyPcx8IkUbuM4+DHyN8lqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753591; c=relaxed/simple;
	bh=zTBD9L+hj2uTZGgZnjOkjod/+xLdYK2/vS356uQc7Ts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lePa+tI0rr4WL3hNsRU2JqOW1AmNDPcDa3r8oWnu8meyf3cfiV+LCq+ptbcbNkB6PNrrjn21gn3S27Sd++oNwT02uBjQlLj/OTtITZLqF5BZqdvzKEAx155ldjkB7pparwzRmyHELKtNwW/O7VF72Eae4b1ew8FLQx6/YEf0hcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rb/j9Kqo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pnlV8LzJ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rb/j9Kqo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pnlV8LzJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7EB13EC00EA;
	Wed, 22 Jul 2026 16:53:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 22 Jul 2026 16:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784753588; x=1784839988; bh=1iVZOz4/nn
	88umtxu7JttKMYkqx63JaRiFbCmDaFv+I=; b=rb/j9Kqomgkx/ZE29/y/EzUu2i
	3nF3F6Dx95UUFnt5lIeh7hMHaQ6FIgkmAqmXyvpX+nTZ8Na/MN7AVMI463P+kDnh
	x4EyfnA+baejwOvDSG71qJycUKLoVxLdJp8mKXJqcy2AUq6PVbcEkpmeJxaBl/2n
	zpjdLFS2BNtKeG/fqwi3x31WZeYMj3x+DmV31avXuyVxuRnbcaZZvpc30+I68kFH
	ef8+7vNKHga+eSiiixbqQVicy0wkttRKcNs+L0aq5Q7yt+8tofYIv0K3bi8cCmSu
	TBDh0J/BJ/0nskmq0q/Rg14TUtmcjQIKgQsYtM/2q4msXvNSS/lklQ17ltgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784753588; x=1784839988; bh=1iVZOz4/nn88umtxu7JttKMYkqx63JaRiFb
	CmDaFv+I=; b=pnlV8LzJAoDp9DHt01pOjK+EuxRa10Q9Y5HQbrrP/F7QYygXFrr
	fmhnGoxUonsqHcFeLA6YScsmpNRVP5PHOH8ycGqqNKmpPRSFTQeY3m1U4gSfIj2Y
	7AK73cvKFFCPaEkUL36NnLtKgTGKQnDf2Itu/OlD5wXjpNo3vY2k1W1/c+33gZ5n
	vZk6ox9dd1H7zePmxe3XfBTiKJPzYO68KQLq53uS8Yioat9BWl0U7Z6PKVQa+aZK
	YmRmL1FNFnYRp2YBnz0tbymPRF3AIpNRl9ZK5ryxDqqAVdPuaz4qb3U3V9gfM4ZV
	iVBG/eyK6ihDXfecZqsoZw3GgC0ACdm6zAQ==
X-ME-Sender: <xms:tC1hatwhTLr4X0EoROfo0doWvwy32pk3nsC1nEVQkisFhAKZBxQx3g>
    <xme:tC1haksKeGlRQcF4lwfer6dC8xp9__BluNv1RrmidIaCgBSNGdz7OsIFSeodGPxU9
    K5vCUe5eBDbL4PG5wvh1C4oHoQEQxazaLFMGtuA99GGNcE2Bap-2Q>
X-ME-Received: <xmr:tC1hakvM_XzXosc3dWDDB2hAEh2VqbRTajKA4W2cMCBKkDASf8pQCSSnQsatsBRDvetIIcuw_kUnaCguaWT2bWba3zzJZ1wrYQ>
X-ME-Proxy-Cause: dmFkZTF9hzVJ0peq5JToljH/9q7hxwPlJA8ICJhGFD+H+uiT/6CXqBZEXG1cKcWNHgDJ/7
    deJ6UfulK93bhQrjujK9ZjKeiOSp95pnFTadoixHj4Lvcrn7GSJ/mVFSqF5EWWb7WO6Jgx
    VFWs+eua2NdLCwT/3ifu+ZV5X+avLtCfRpljr6ISUNb7Wme/SgY5QBWbrxVyjDrSbjGV8n
    pQoP8aQOcjm2NVYXlMCv4/auke56jNOqBoWMLLOnzfOCJlmLv9Sc4FBf7WmFwI7zktY+zY
    6L+LYJs3K4kTgzb2HsDYgZsHO9NbbDnGnBNIULjaIqDnCRQJN3zr6sJfLctiBuwKh/TQuG
    f90HjJxNlHYZx1gxMRWYU3+n/VHPASaeAu3lpK+yBgMnIq/VXZmEfPuJ3ifOnY4wuUtpe/
    YDGpJzNLyr0aQJilaurbx9RTZZRW3Wx0lUqWw486QwHuAlEZvEny6aAAP+QUF2wk7IiJzU
    xqTTxV8Q9VWK+GmDCt7cmNnSFhEZ2hqV1QL34Sac4i0qydjGl/egLqvHtsVVI8hz7Qzx9j
    9SQvR9Btui6pFllHKSw26YfhYjSjoQvhXCe6nX95TJTt8ldSUnAx+5pbDq/aNjwsIhGG1l
    1HPeT1u4TQUqT2sTsSkKOsCeM4/2OYEm+yblXZ8tJcCfJBM3Wi5vac/IvaOw
X-ME-Proxy: <xmx:tC1hapPhiYXDxAWMk2knLteR0D52ozefdvRGX7waryJe_Sx_lh9bCA>
    <xmx:tC1hai2ZRJTyaGWRxkclGbN7oTuH31Yu7Mj4JMK-_JyOyztT5Rvkrg>
    <xmx:tC1halMn4Qh08NeRN3DEWtRfaBiwJ4OYCh1BOtpJpdzRz_ywexOzzg>
    <xmx:tC1hai1aiblTLmTv7JF2gFWRXLZJOo_mB2vi_dFoWpPMvP1WLURdvw>
    <xmx:tC1haktgEo_nGpDTPpyaOSiXKH1SF87i0wG5bye7bK-tZzAZQbkekCzJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 16:53:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: hardikxk <hardikxk@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] Extract only the message body from git commit.
In-Reply-To: <20260722083836.744338-2-hardikxk@gmail.com>
	(hardikxk@gmail.com's message of "Wed, 22 Jul 2026 14:08:36 +0530")
References: <20260722083836.744338-1-hardikxk@gmail.com>
	<20260722083836.744338-2-hardikxk@gmail.com>
Date: Wed, 22 Jul 2026 13:53:06 -0700
Message-ID: <xmqqtspqn3v1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


hardikxk <hardikxk@gmail.com> writes:

> Subject: Re: [PATCH 1/1] Extract only the message body from git commit.

Please see Documentation/SubmittingPatches[[describe-changes]].

> The patch fixes the `extractLogMessageFromGitCommit` function to skip all the metada of the commit object and only return back the message body.

Line-wrap overly long lines like this one.

> Previously the function would return the entire data of the objects
> including authors tree and SHAs. This patch fixes that to skip over all
> that and just return the body of the log message.

Please see Documentation/SubmittingPatches[[meaningful-message]].
The observation on how the current code behaves should not be
described as "Previously X did Y".  Just say "X does Y" instead.
There are other rules on how to write proposed commit log messages
explained there.

> Signed-off-by: hardikxk <hardikxk@gmail.com>

Please see Documentation/SubmittingPatches[[real-name]].

> ---
>  git-p4.py | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Thanks.

> diff --git a/git-p4.py b/git-p4.py
> index c0ca7be..589efcd 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1003,12 +1003,18 @@ def branchExists(ref):
>  def extractLogMessageFromGitCommit(commit):
>      logMessage = ""
>  
> -    # fixme: title is first line of commit, not 1st paragraph.
> +    foundNewLine = False
>      foundTitle = False
>      for log in read_pipe_lines(["git", "cat-file", "commit", commit]):
> -        if not foundTitle:
> +        if not foundNewLine:
> +            # skip anything that is not the commit message
>              if len(log) == 1:
> -                foundTitle = True
> +                foundNewLine = True
> +            continue
> +
> +        # everything from here is the commit message
> +        if not foundTitle:
> +            foundTitle = True
>              continue
>  
>          logMessage += log

