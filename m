Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E320FABC
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609171; cv=none; b=gAcwMu72sLVgUNBpG15FwiJYlrV126PXrOWXVwz0nnMZ+Fj/oYlLnQKxarejZPFBo/Rkf6q4ctvDiScPYnvv/AgoRHoz9i2OEPN939H0Xps+B1L0lgKFVfXOpCngotGhz88f8dUsrZwrs5oyIDDR3pEl+M8w79eZDclQq8AFQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609171; c=relaxed/simple;
	bh=iUMsK/w+I0kdEEhAh6cdqoifky8iRJxbyGzQPXlO4WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g51QOYNTeaoYsFDVT7tnJy32saUCMrHhw88PH7ToUKArLAbPoF1RCkRTvRn5FRICsvzgZLp4yFKeTBUZulRKzz9TT5EJu/aeWd8JBbmFC0KsVwFOLVmk9YZBLh4VLq2LkL0RTbdT0FuckMdHDLQx+ektOf+4vC6G/8mfF1tiui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lX1RVW2S; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX1RVW2S"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0b9d344d66so4426100276.1
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 07:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722609168; x=1723213968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5SuU3yVL1SdwMJiU89wpjs7a+a9FRtHYKx/s65lxZM0=;
        b=lX1RVW2S2maNQxzYjNzCUa1zRPAeWClJnUZR3ACOISlTASXphjkJirPGJm+v/dtSn7
         HqxH14TnGisXd6TBoTrrd+9xbelNsG4s0CvFsCLJ+5sLy0MERC9QAezva06S52DsTUGE
         ClZvLuPnyg6rLpuePX7O6YPH9AXSmMza0Py52bDMSQ30sMPpuhhNbz4q+WYPwBNhXdbp
         xTKas6AKD3oUxzjlvZ9OAC7Qxso/C8MdWVt/HSE5qGZkGEPdH2z6CdGCzRrMRHOclpyI
         HabmtWaVv2OdnBn8sTdPxRY2o6sYctT8j9BuwHPdoUH8ojGP5EHIVPjHxLaZI/KntHbF
         uPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722609168; x=1723213968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5SuU3yVL1SdwMJiU89wpjs7a+a9FRtHYKx/s65lxZM0=;
        b=LVCIEi6E4QFl5px1ffx/+14lgGzIQOMuHKFMMnUOr5WL8YT3HO5VGwPVLT3J6ByWxD
         ERx67RmyGdatsED3rzkJXnikc5EmodvyknA+krnh0GxixpFkV56V1KqX6oki0RUSrLu8
         OGB3ul6BLk5jhsjNugmlddtZAbXQgeNx5O4Y+vJpOJM1oxiZpKuqbsbPctncJPaZC2DD
         5xDKMnJTJDzhTIbmSN2TGqgt8jhRUiVJDVBAPpFggoa4PuuzXM9R0oTvE9x7lrRWnXE3
         tsNPTVnvP1T43ChnkHAjZzv+GCAuxCVu/FmN/LORmnEGnk5bSVDUXB6ODpgt2l9zVrXk
         ALUw==
X-Gm-Message-State: AOJu0YyNV8Qju0mQADkzlhffCQx16AFavOKMOGvqnkvP7QxjhZRu0wVA
	uXP2tk5L/2deIwpCYL8CAjbNCeAIRQnmnFaT7qyLXSrd9I3DJWoJ
X-Google-Smtp-Source: AGHT+IFiNOMpo8vwVfE6HzfiE7ezwj7sGWRgAjWXs2WhctNVBvO7IaSOMEIKFGxU+bdsT+1a/VQkHw==
X-Received: by 2002:a05:6902:1443:b0:e0b:bd79:3084 with SMTP id 3f1490d57ef6-e0bde1f6debmr4337374276.8.1722609168126;
        Fri, 02 Aug 2024 07:32:48 -0700 (PDT)
Received: from [192.168.50.16] ([67.209.31.108])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be5304667sm227956276.6.2024.08.02.07.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 07:32:47 -0700 (PDT)
Message-ID: <27f3de89-55b2-413d-b4b4-6b35f8c4bcc9@gmail.com>
Date: Fri, 2 Aug 2024 10:32:46 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] git for-each-ref: is-base atom and base branches
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, vdye@github.com
References: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
 <xmqqmslvhmgm.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqmslvhmgm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 7:06 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Derrick Stolee (3):
>>    commit-reach: add get_branch_base_for_tip
>>    for-each-ref: add 'is-base' token
>>    p1500: add is-base performance tests
>>
>>   commit-reach.c              | 118 ++++++++++++++++++++++++++++++++++++
>>   commit-reach.h              |  17 ++++++
>>   ref-filter.c                |  78 +++++++++++++++++++++++-
>>   ref-filter.h                |  15 +++++
>>   t/helper/test-reach.c       |   2 +
>>   t/perf/p1500-graph-walks.sh |  31 ++++++++++
>>   t/t6600-test-reach.sh       |  94 ++++++++++++++++++++++++++++
>>   7 files changed, 354 insertions(+), 1 deletion(-)
> 
> I was expecting to see an documentation update to for-each-ref (and
> probably branch and tag) so that what this new atom means.  Is it
> that %(is-base:<commit>) interpolates to <commit> for a ref that is an
> ancestor of <commit>, and interpolates to an empty string for a ref
> that is not, or something?

You are absolutely right that I missed this crucial detail. I will
eventually send a v2 with this oversight corrected. For now, please
consider this documentation diff, and I look forward to other review
comments that I can use to improve this series before sending v2.

diff --git a/Documentation/git-for-each-ref.txt 
b/Documentation/git-for-each-ref.txt
index c1dd12b93cf..5154ba3e2a7 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -264,6 +264,16 @@ ahead-behind:<committish>::
  	commits ahead and behind, respectively, when comparing the output
  	ref to the `<committish>` specified in the format.

+is-base:<committish>::
+	In at most one row, `(<committish>)` will appear to indicate the ref
+	that minimizes the number of commits in the first-parent history of
+	`<committish>` and not in the first-parent history of the ref. Ties
+	are broken by favoring the earliest ref in the list. Note that this
+	token will not appear if the first-parent history of `<committish>`
+	does not intersect the first-parent histories of the filtered refs.
+	This can be used as a heuristic to guess which of the filtered refs
+	was used as the base of the branch that produced `<committish>`.
+
  describe[:options]::
  	A human-readable name, like linkgit:git-describe[1];
  	empty string for undescribable commits. The `describe` string may

