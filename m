Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B55305962
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420236; cv=none; b=QJrILPtEQAcNs36nOJEVfxWZKY+M8i86YKmMiPqxLD3NBb0oDI5TWi5kint3ry/ZhIzE0KbLRG/2Z9nANyoMaaMz+6qEA0dLR0jEnIpBY1ttENuDn3lrXt9xGaO4CoqZ8mxYskm9Fqsbv5Jt7uDSXTcCX2rSDLBeO69+HGjvFMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420236; c=relaxed/simple;
	bh=cS5acPWbWfhazj/9+KzeJUiGDTSY/LHctFIloBpC/JI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lIUoBH5d3b/gtBwpakRA8QWUjT9s2pNBYxeNIH3+TEdASD+BqKM4A2cy/mHw2KbWiv52OBy78lZTGQDxFATLfEjF7aPv0Eh/5FkrYCthQDTYLgpHtvfO7t2VEX85X5eqbQWKA3WF6SqQuepWL7D5Q3YZKkEC5kTHxZ7+8BIKsbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHlcaZ89; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHlcaZ89"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so2871752f8f.0
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 01:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769420233; x=1770025033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jEfNKICi1ogB8DWc3MISXqkTjmFDtlgO5b2s/hu1p80=;
        b=FHlcaZ89rZNseRZArKfYAHtOWWNMAlE5dR8boGQjmlrCUG6N2gOL5Gm+ZnAhcE6/mv
         o3An//bd+GWkGFR37HSfhc1ptEDCjJUQmHAV1UAVnAhaMoVSfZS3Ro89TuL36WXI9Qeb
         CpXaYUjJDmzu/bEzS44Bjzyvwyxa8YeHZvwQ8JCftLQprMXg38PvgYoG+iESG3XjqGE/
         b6BlNG7TqNPEs9h/pMED6Vd/dVYxIUj10aIi9jxRQeFrTygyvp7WI8B/H8NwM4BW/eEr
         6SxFAUZRHC0kmF3SSEajC6krsU7u6HgESphY2Hv1qERJSH3uS1RIJy4weGxeM1Z3KWAC
         wMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420233; x=1770025033;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEfNKICi1ogB8DWc3MISXqkTjmFDtlgO5b2s/hu1p80=;
        b=aSB9lvwPQ3UiTsYjeaMNercKDiSuYuuDy/Cu7WRPz5FUjxPNb14uHqYb+6DL3KgvKA
         jc1beZXsEx7YZN81/RJI73xnTdtu8JcL1tcQ9x39YkOGet3nZsPGUgBavInkAR0ddAlK
         z9EHF+iMiC2em70d7qAwxhw50LFA7okBN6WNgMTgFXrpUnHhva9Z9vgKnQngV7nmCUfa
         4o/80MMojpjCWyrhWJEJCG0C80baKypYo40gSbukXhdzNEBTr1UqSXidDhRvOfH0s5Sp
         zn5yKKKk2QiIyslpw6PP0+NYORVaNABcHFSAIl++A98davY8Z4BdwL8csAgPLpv4DdDF
         KTOA==
X-Forwarded-Encrypted: i=1; AJvYcCW3q7fNUaOA2MBEHkU2CKYc4ptSKstFEHYgEPQvrfymuGkn4VIPUp5TR8ihVhdQn90z72E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1PcnOMJEAr+cb/ZQSxv+Rsxm5oXJjooTp8yjABAWdFsfAPNCt
	Bl7eWrdCw/KkOTQPpc6fjcSDctNJ2ne41Ho1AP9IWIgi0BAYTHmG/EKi
X-Gm-Gg: AZuq6aJis1yA8ACHI+xo/ySReDT/zexELohTweXbh5tK7ZbkZFrBB0xGaDHPvLWMLD/
	NxmF4bV7SYoxncjvN+llOlScEhp3yBFSPZBHKEJht+EH3v4x+FxKLg6qCt9j02c4dGLzfMxQdCp
	4TzGx0qSZt7dLpcwbz0bKe4uyOevva5IgHgFKdgpNUemoLY79mVavYY841DACsWIszSdtHY7HjP
	setmi5+jgB2TQ1TVqkXJZsWdoDDdo4svNxCtIO28qWbic9xfLz5mS2ZIT4y0NjOY1FFuGjK07wc
	ixpkICwwpkiLKXwaIJPhR/XUUJGwsr0ZCyJIK5yK7FqFQme1Aj/dytbVUMqC7LOZU5HChLos8/+
	sd0eu9A+u0/+EenaGW6lAr6LaCdbZ0tFCkicHuYq0JiXM+BocQFleyRIZ4J+mx3I/cnm1fVc6Cv
	3wvtHGdhYRh8sB3hYrYiuWuj95KKZcRLfFdZCBp1jCc3YYvOyZOwB7KBozmVfsr+iHRA==
X-Received: by 2002:a5d:588d:0:b0:431:764:c25d with SMTP id ffacd0b85a97d-435ca1a702emr6595030f8f.35.1769420233308;
        Mon, 26 Jan 2026 01:37:13 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c01783sm29666464f8f.3.2026.01.26.01.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 01:37:12 -0800 (PST)
Message-ID: <3aeb49dd-8618-42e0-b9f9-6a4fb8065793@gmail.com>
Date: Mon, 26 Jan 2026 09:37:03 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] xdiff: re-diff shifted change groups when using histogram
 algorithm
To: Junio C Hamano <gitster@pobox.com>
Cc: Yee Cheng Chin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Yee Cheng Chin <ychin.git@gmail.com>
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
 <xmqqikcusn8p.fsf@gitster.g> <4fa413ae-f2a4-4de2-a2fb-0b1db379750b@gmail.com>
 <xmqqy0llk33y.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqy0llk33y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/01/2026 17:34, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 21/01/2026 20:51, Junio C Hamano wrote:
>>> "Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>> @@ -915,6 +919,45 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>>>    			}
>>>>    		}
>>>>    
>>>> +		/*
>>>> +		 * If this has a matching group from the other file, it could
>>>> +		 * either be the original match from the diff algorithm, or
>>>> +		 * arrived at by shifting and joining groups. When it's the
>>>> +		 * latter, it's possible for the two newly joined sides to have
>>>> +		 * matching lines. Re-diff the group to mark these matching
>>>> +		 * lines as unchanged and remove from the diff output.
> 
> Also, after reading the first paragraph of the big comment again, it
> makes me wonder if it is saying the same thing as "When histogram is
> being used, we shouldn't bother shifting up and down to join groups,
> as the result will always worse than the fallback", but is it that
> bad?

Looking at the example in the commit message the result of shifting up 
and down and then calling the fallback is better than either the 
unshifted diff or shifting without the fallback, so I don't think just 
disabling shifting improves things. It would also stop us coalescing 
changed lines, for example

-A             A
  A     ->     -A
-B            -B

The indent heuristic seems to assume that we've shifted down as far as 
possible before trying it so that would probably get messed up as well. 
To me the problem is that the histogram diff does not always generate 
particularly good diffs (maybe I'm biased - whenever I've tried 
switching the default to "histogram" I've always switched back 
"patience" fairly quickly after being presented with a diff that I found 
hard to comprehend)

Thanks

Phillip

>>>> +		if (end_matching_other != -1 &&
>>>> +				XDF_DIFF_ALG(flags) == XDF_HISTOGRAM_DIFF &&
>>>> +				(g.start != g_orig.start ||
>>>> +				 g.end != g_orig.end ||
>>>> +				 go.start != go_orig.start ||
>>>> +				 go.end != go_orig.end)) {
>>>
>>> So the idea is to remember the original values in g and go (the
>>> location of the group in the file and the other file) and if
>>> shifting up and down changed any one of the four ends from the
>>> original locations, we always take the fall-back route (if we are
>>> doing histogram)?
>>
>> I'm a bit confused why we need to check both groups. I think they're
>> supposed to move together (if we move "g" by n context lines we also
>> move "go" by n context lines) so I can't see how we can have
>>
>> 	g.start == g_orig.start && g.end == g_orig.end
>>
>> when
>>
>> 	go.start != go.orig.start || go.end != go_orig.end
> 
> Interesting.
> 
>>> By the way, this appears after the if/else if/ cascade that has:
>>>
>>> 	if (g.end == earliest_end) {
>>> 		... do nothing case (case #1)
>>> 	} else if (end_matching_other != -1) {
>>> 		... do the slide-up thing (case #2)
>>> 	} else if (flags & XDF_INDENT_HEIRISTIC) {
>>> 		... do the indent heuristic thing (case #3)
>>> 	}
>>>
>>> Am I reading the code correctly that, even though this new block
>>> appears as if it is a post-clean-up phase that is independent from
>>> which one of the three choices are taken in the previous if/elseif
>>> cascade, it only is relevant to the second case?  I am wondering if
>>> it would make it easier to follow if the new code were made into a
>>> small helper function that is called from the (case #2) arm of the
>>> existing if/else if cascade.
>>
>> That's a good point
>>
>>>> +			xpparam_t xpp;
>>>> +			xdfenv_t xe;
>>>> +
>>>> +			memset(&xpp, 0, sizeof(xpp));
>>>> +			xpp.flags = flags & ~XDF_DIFF_ALGORITHM_MASK;
>>>> +
>>>> +			memcpy(&xe.xdf1, xdf, sizeof(xdfile_t));
>>>> +			memcpy(&xe.xdf2, xdfo, sizeof(xdfile_t));
>>
>> These would be safer as "xe.xdf1 = *xdf" so we don't have to worry about
>> getting the size correct (sizeof(*xdf) would also be safer but there is
>> no need for memcpy() here).
> 
> Very good readability enhancement suggestion.
> 
> Thanks.

