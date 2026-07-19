Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1734F24A
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784454667; cv=none; b=qKrG97Qwpr22g5eHl2HrDziiyhPG126LRBPvEZUMMKuXFSDcgsdtPpardv6Q2ITjuri9f7P/frx56LC4nrAaMDBAJoysNm2LJpW8hMfqNZjLH1r/EKCvPR3kP5/2fySxv27TLm1AbgtkrVsJt5qkZNbwH0A2gaMJ/a4HlhiWa9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784454667; c=relaxed/simple;
	bh=YDVCLPvLsGXIyPSVJSWRyi5veF9KT79M1tGGSSJ7PUY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PQiU1Ot8SkWBgir6ZQQAVsKoavj0iEAFN2eDBZdiAB0vXzZ1w7qbE+AkAlvEjCRQpu31rp999F8UwfVjaMZW7R9qeiCUgIsMHuDAUR5mTpE25pU/1OBuK9PV9dgiDHD3ertkOB5Q2XFG+VbOBmAfl2Nuede18LcNUr5MKaY2RN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgkyUweM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgkyUweM"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so9008275e9.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2026 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784454664; x=1785059464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RraSrL0O6+FECA+S6JywPzpXl46Ov52vInVI0sKCBXk=;
        b=PgkyUweMGObzRaWHxXx1MpEH6IOMMVUZj5a/alQnuzXKxZjQyfw7oIBZJZwoydrbW+
         oyFCOnoAs0Vi03o8sZwL+7cQBcQa2T1pR84Qj/qPWRIwgL4ZJ5qdcpCtLdi3uVGhdrDp
         XYIWn8n7NtP1XPNh3QBK4raNulidww5xRjz1NhldIX9ahvrzgxGM84I5XUtTgjN+2f1S
         6iCQtVHqVZXAbpsSPIK0CjU7tDEEe3ZCdN+3U28hqB/G1eCT5ewgQCgKyYLfn3Cv6b41
         ExLfe9JhUyGvmfC8Qt/ujiP6excKP7dLqF1KVsmKyVekJKgPS+Ld+QZcMN5LNlDE0Sre
         Aldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784454664; x=1785059464;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RraSrL0O6+FECA+S6JywPzpXl46Ov52vInVI0sKCBXk=;
        b=etusTnPjfZgZwa1bypNzCktx6yxYml/SNlVSDW23MQBPnFVkPAl7oOgquWYO0E1oNF
         moYKLIbCmDvyG6W1E90IYw6Zhja6yffCDPPsIAd9KvzsMdP4oJV9tmbk7BOCoNx6ADUi
         Ga/poo2A26OvRedownK6iFWxtj265/rke00hqPvwpuSnBfF/E5Do2w4vmODwJ7o79BCr
         L9RsJybYY0Q7bdSp+Yp/YE6Fg9gNrFLc7v92pZUIGTq2xYyrKusEfWYsK6NQbaxnIsoB
         EwUtXhwMt0XJwBDJZTMqsl0e2YH8MdMNY3Zj4ZOZwNjw6cTYiStdxgRNuVVc1zMBt104
         9Naw==
X-Forwarded-Encrypted: i=1; AHgh+RpSWa4k0VlUl6x0pmK6evJBlfwiPOARh8W5lbeqf0q83PZPcWaRH9x5s0YGuZwWWKDf93E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2qbcaKVu+Ffy1iMbLKoB1+BayTTgfRQe2i6kCDLxBe+f+VKH
	2qRb3Po/gdCMCOUY1H/AwNjih1d1TKSo6sKdVfL3yjcP355tFlP1mDAL
X-Gm-Gg: AfdE7clGZmHQW6F3rendiETowx2rzKWG38MuLJo3iMLM6mYq2eyCFXKTXYWTLmUUnwR
	GUgC7jtXN/qhNDBVKIMcm76fNKm4KxX4aLbkH2/RhUofQVhdgkcI3DR62/GFcHr7cspnwB5Pa1/
	mVO7tkp/S9TA8CcReilZ8SS+h2Lbp83RFHIlkdW3aCOkjIqBJQpnuIdHQSEtSYBcGBFNDsGPW/o
	3t9YT1L1Yu1O1ffW9t8B3ilZJ5de8X4GIYgdsTyrvlcS+cile6eMAZgSBVZ6JjQQosVrumW9KUG
	PgKxzsUQGMwedAoPnF/Kwfw8V92oiuR6AFpXaTpY3gGKAuIP1ZQJtnUCp7/Gq6hzM3ryuvj8fmn
	ixtB+SVPylRmhim2alPqzC8IU4KmZx2R9BORfgvtdY7H4Rmy/jAhP2wHf0+5sDFAoCwXf7aShNW
	w61Ht19/5uCpAc/XFBegjfLPt/9bCmCjOQalSBL/MfZd3wBVU7F9iVghwO
X-Received: by 2002:a05:600c:4e8b:b0:495:501a:fcf8 with SMTP id 5b1f17b1804b1-495501afdc8mr61103025e9.9.1784454663649;
        Sun, 19 Jul 2026 02:51:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2b074csm202896815e9.6.2026.07.19.02.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2026 02:51:02 -0700 (PDT)
Message-ID: <03a332e0-afaa-4562-a503-2ff8a8f9f2ac@gmail.com>
Date: Sun, 19 Jul 2026 10:50:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] branch: report kind of checkout when rejecting delete
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>
Cc: Toon Claes <toon@iotcl.com>, Patrick Steinhardt <ps@pks.im>,
 Git List <git@vger.kernel.org>, stsp <stsp2@yandex.ru>
References: <9865fc6b-e3fe-4614-9ffe-71af776e1796@web.de>
 <xmqqjyqsqk1a.fsf@gitster.g> <c7357faf-3d2b-46c6-99e7-88d3e2c72a77@web.de>
 <xmqqa4roq7a8.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqa4roq7a8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/07/2026 23:09, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
>>>> +				switch (kind) {
>>>> +				case BRANCH_CHECKOUT_KIND_CHECKOUT:
>>>> +					error(_("cannot delete branch '%s' "
>>>> +						"used by worktree at '%s'"),
>>>> +					      bname.buf, path);
>>>> +					break;
>>>
>>> We may want to be more explicit and say "cannot delete
>>> branch 'frotz' checked out in worktree at '/tmp/nitfol'"
>>> instead.  Unless this is a catch-all entry for states that
>>> are neither 'rebase', 'bisect', nor 'rebase-merges' but are
>>> somehow otherwise in use, that is.

That's a great suggestion, I don't think there are any other cases so it 
should be fine to say "checked out".
>>>> +				case BRANCH_CHECKOUT_KIND_UPDATE_REF:
>>>> +					error(_("cannot delete branch '%s' "
>>>> +						"used by worktree at '%s' "
>>>> +						"for update-ref"),
>>>> +					      bname.buf, path);
>>>> +					break;
>>>
>>> I was quite lost when searching for cases where this 'update-ref'
>>> state might be encountered, and I still lack confidence.  Can
>>> we make the diagnostic message a bit friendlier to our users?
>>>
>>> For instance, something like: 'You are rebasing a history with
>>> merges in that other worktree, and the tip of this branch will
>>> be updated when that process completes, so you cannot delete
>>> it from here.'  (Naturally, I may have misidentified the exact
>>> nature of the error, but this illustrates the level of detail and
>>> user-facing clarity I hope to see.)
>>
>> That's quite long.  Would it make sense to throw that update-ref
>> case into the rebase bin, i.e. only distinguish between checkout,
>> bisect and rebase?

I also wondered whether we should fold this into the rebase case. My 
concern is that if the user sees

     cannot delete branch 'feature' because it is being rebased in the
     worktree '../feature'

and then they do

     cd ../feature
     git status

they'll see a different branch name in the status output which is 
confusing. So I think we either need to improve the status output to 
show all the branches that are being rewritten (which to my mind is the 
better option, it is more work but shouldn't be too difficult as it 
already parses "rebase-merge/git-rebase-todo" and "rebase-merge/done"), 
or  say something like

     cannot delete branch 'feature' because it is being updated by a
     rebase running in '../feature' which is updating multiple branches.

for the update-refs case.

Thanks for working on this, it is a nice usability improvement.

Phillip



> Shortening a quite long expression down to digestable pieces is left
> as an exercise for those with this particular itch to scratch ;-).
> I do not personally mind if it ends up indistinguishable from other
> "rebase" case (or unified the "kind" enum into one), but others may
> have ideas to shorten the message to fit in the pattern we see
> above.
> 
> Thanks.

