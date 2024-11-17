Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A1AC2ED
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731856895; cv=none; b=ItAzzspoAck17KBDYkjARsxFaxFh6/WDYBPx6Sma5D0qcC0mSFggh3gg1u5JtFdRb1LbtXFeDJaZ2skZWKxDymR1OVGpz/fTzrwfoPpWChEIdL2mYTmtLYpc0oIY+xHA6x3n2nu0ivj10XyrOPdFUfeVm7gGsVtF2cXk1NBjKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731856895; c=relaxed/simple;
	bh=Z98NJTNJpmCBzkpZFoYW2jAQYN3NdXrfoqYlQX95R7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWED6JcSgP8Z1P8Ju+T7SXFlxdN5s+bmd6bs9Uo+rmrIVhoVwjWHgMYNkaoNtXPbR2IKtuBtDD4vvC22m+khr7zZbm7Wzl41/4i3Q/c9HpjEDb5tv2DwPjg6bPe0SKCK1x6wNEmwDRuMlmuGYvqgnOT/NCo0ZTGc0ZvOmoL9Y64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqhyU4Ar; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqhyU4Ar"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso11031055e9.0
        for <git@vger.kernel.org>; Sun, 17 Nov 2024 07:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731856892; x=1732461692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r7BGd1d4d+QpF54o9VcpshHtsrrWX3IhnHp1d2Qk2Dg=;
        b=PqhyU4ArnhaBQXW0kBq5M5VO/sFk8qjJO97rcHh3U/1ZSc5Sb0bWuNRLJcDA+78g59
         +rTkr6z1kRKFn5B2aGXDN+4ghW2bn9qutYhqkq94Zn+xZJ67IijYCJ2Ga9H73aU3x1fw
         KDtKCPSDt+MmdCYZjZM62vrAvOWOkNxpM06p8oQ3G2QOP6n+YwAux+irwIdsyeH/5ak1
         tVtC9rkw4xpu/EXUjESoML4iGg1M3TZOEA4fpnWVhmlZuWAerZL3noTDjdeZB8ocgNnt
         PD9dvTfiLezSK9F0v7uuwiouC0iw6A0ccsqCc9Y5p2pRlnorWx9OFlE4AWVTEBT1NNTC
         NbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731856892; x=1732461692;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7BGd1d4d+QpF54o9VcpshHtsrrWX3IhnHp1d2Qk2Dg=;
        b=vYCF+6/QJ+ckWq+EmqPVVFkvrsEXCYIBeFhhaxIiF0MAcOGyuUwvn24OaYWBkHmeOF
         5h5+13wH38fcbvusaUDmd/017HbxBKEPe5iX4N3WQ50pSb3PYUydzh0e26fBChW25cUC
         I6h/9gj87HzE2X+uGEUwe+2tDYcYwnjd799w7K45/hiC5hjzevvQK7YFqr++Vb2ZsPpy
         9WTBJqyoJiD6OXPd4JlNvvQLI+7Z7fM/U0I79FVrekWN0t9KMuYyhtZX6X+l1jw8kCwy
         FbDosCXx54ZA9sMS2CyedBNdbI8hbvaQmpEWc+GWVOir/XwxXNG6lyrt0TLllWho1bZr
         bgNg==
X-Gm-Message-State: AOJu0YyxjS2BEWFtAiJyVml6DPsIJo4hOlyNuNTCQDX75pl0FdXy3DiT
	KfU/tTuebwS7kU5ekyGJPSsNwmq6pxZyiYvBcSUPUkgTmXabRYAh
X-Google-Smtp-Source: AGHT+IGQekTJVXuaeZkWTnTPigqLdpiud/FJEByr7H6Ixbj5bnn63PBsI9bDsDFFSjR8feifAbFUHA==
X-Received: by 2002:a05:600c:474e:b0:431:518a:683b with SMTP id 5b1f17b1804b1-432df74f2c1mr75376125e9.18.1731856891735;
        Sun, 17 Nov 2024 07:21:31 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823ade6c73sm3855879f8f.30.2024.11.17.07.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 07:21:31 -0800 (PST)
Message-ID: <5f401732-9b3d-4c45-88a8-a9e3d9d14fd9@gmail.com>
Date: Sun, 17 Nov 2024 15:21:30 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What is the diff between a --soft and a blank reset
To: A bughunter <A_bughunter@proton.me>, Chris Torek <chris.torek@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
References: <myxdTw4K7jcrlKX-HC0edNKB3mgkjGJPAejkxWTcab03uT9uROZlO28zjhmnogOvGCJkag5q_Zvbok0VUyVjlkw5Goz3Gwe3l636lCYnGic=@proton.me>
 <CAPx1GvfT1iNnpJ0Jv0vhdHrwD-pDOK81MnUW2-Fk_zcJkW9PUQ@mail.gmail.com>
 <82f3cj_ASv_HNkdAe-1doxp6Vii0saBTB2wYbcwCEC3vDJpiwXvN6a6Agw7qNhKsGpBD8EbDC2u4VipTDJNr19nYcVV4BqV4GgNG9ysr5y4=@proton.me>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <82f3cj_ASv_HNkdAe-1doxp6Vii0saBTB2wYbcwCEC3vDJpiwXvN6a6Agw7qNhKsGpBD8EbDC2u4VipTDJNr19nYcVV4BqV4GgNG9ysr5y4=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/11/2024 08:54, A bughunter wrote:
> My reply to Chris.

Messages on this list are expected to be constructive and respectful to 
others. I strongly recommend that you read the code of conduct [1] and 
urge you to remember to be constructive and give others the benefit of 
the doubt when posting here in the future. If you are using an LLM or 
translation tool then I would suggest that you try a different one and 
get someone to check your message before sending it.

[1] https://github.com/git/git/blob/master/CODE_OF_CONDUCT.md

> On Sunday, November 17th, 2024 at 02:57, Chris Torek <chris.torek@gmail.com> wrote:
> 
>> * With `--mixed`, `git reset` adjusts `HEAD` as before --
>> it's usually wisest to not have it adjust anything for
>> this case, in my opinion -- and then goes on to copy the
>> files from the `HEAD` commit into the index.
> 
> I didn't give any case: What are you talking about?

I think you have misunderstood what Chris was saying. My reading of this 
is that he is taking about the general case of a user running "git reset 
--mixed".

> It look's as though you are pasting a custom manpage for git-reset
 > based on keyword matching. Essentially spamming the mailing list
 > based on a keyword match.

Please remember that the person you are replying to is trying to help 
and has given up their time to do so. I think that rather than copy and 
pasting a manpage Chris has taken the time to write some bullet points 
to try and explain the different reset modes.

 > Yet another manpage being written by a thirdparty when having
 > conflicting and scattered jargon makes it to where the user cannot
 > communicate in a meaningful way about using the software.

Whether you like it or not understanding terms like "the index" and 
"HEAD" is necessary if you're going to be able to communicate clearly 
with others about git. I cannot see any non-standard terminology in 
Chris' reply.

 > You vaguely show the difference (e.g. soft means job #1 and mixed
 > means job #1 & #2) however not fully answering my pinpointed question
 > "Does this from --soft: "leaves all your changed files "Changes to be
 > committed", as git status would put it.'"

"git status" lists the files that differ between the worktree and the 
index as "Changes not staged for commit" and those that differ between 
the index and HEAD as "Changes to be committed". As "git reset --soft" 
changes HEAD but not the index then it may change the list of "Changes 
to be committed" because HEAD has changed, but the content of those 
files in the index is not changed. It will not change the list of 
"Changes not staged for commit" because the index is unchanged. As "git 
reset --mixed" changes both HEAD and the index then it may change both 
lists show by "git status".

 > mean soft leaves the adds indexed but
 > before the adds were commit and without commit whereas --mixed would
 > erase the index having adds ready to commit?" conscerning what the
 > difference means in pragma. We and you need to learn English or get>
 > off of mailing lists: stop spamming. I say we because you are not
 > alone.

Telling someone that they need to learn English or get off the mailing 
list is completely unacceptable.

Best Wishes

Phillip


