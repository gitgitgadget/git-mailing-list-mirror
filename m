Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BD13F7874
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332504; cv=none; b=thBQUKqll14gdk6jo3QMqdqfTtI6JFjTQvYvoz4u9ifIkAdChkfShzcqAVSgBNYdRJ97qOKCI4H1xI3vghtbSKdBmsSsccD6oQfIGnjSz0vuJYctFfGiwMMcInsNLiu4kV6+eDZYxpHOlECVg3RRTrvFw8pNjG36JUocBj2Mnlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332504; c=relaxed/simple;
	bh=ckbg2tb6MY5eY1n2vq/A7rlTFpGesA7Atctaj/1QFaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xs7qYC8TZjbgZZxyHvbrqRqD1NWJ5vPOh174BoW2hYr1NM3acMAiucLxc26cd+B8EC4tWyYAv3UmKAA3TE07taXHWQMSjWdQ0ks6zeSV6A6zhnQ+vlS5SVZcb+cJlPXAbqGa2BZeFtGISLdpcW14cLbyWJ341lqYLe0MCK5l0fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hvw7Zl9M; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvw7Zl9M"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493d3135e9bso9580285e9.2
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 03:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783332501; x=1783937301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4HewG7zdNlZku0pCitBj59gNpBaPhR86ZakrIEkJ3qQ=;
        b=Hvw7Zl9MsaBQ4ahUyo4Cj5roHDXoLKamPdqPNR/cw7aiamGNvmgURhpMjvXafbZ8y3
         cm1Vd9mA/s5hpnCO/tvzPEsW2yw46N4cr+w8RSxJ+GhDMxVVkNv29Q080WnPa/Ubh3t8
         OmWKsqENpIjxM60qzCsHPCrnAzmW7dIFUGfQ3ivVp4rf7GlKKkO/R5RUeGnV9ERVy9G2
         dz/ojRKqNsqWBonMIM6mE0UH5+licuANGn/hIhkFs6c1WnJeKWWMxpwF4AfC/PN07V7V
         nEk3kg7CnyMoiAeAUOvlms88zp4eWuCYNYjinKDO8UeSNtbbTR9MqAImFE4PGkc207D3
         jNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783332501; x=1783937301;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4HewG7zdNlZku0pCitBj59gNpBaPhR86ZakrIEkJ3qQ=;
        b=TtkI4PB7FMh+9+ypsbRFj7AJMP1JFNp03ojOv8/qC0yOuqvPM+bmA1PCUxrNUOsaT8
         EXEMUk0aMJNUVRyMh6DoYK4jFawCAvmc8cC7Y5AeBhWup5n2XEwlARbLUfa91G+seX6i
         30IQS5gML7tvRUlMd2Ntp5zEIfeoFdPvRopecF+QxZIZzj8nGhzYA7XH2b1iiauIhx/i
         eTmloRqwkffgEfIoXPIjGyrx4POR/ge/gSGNya6iD5cA9+GH39Pu/G8eUCH80r+KOg+4
         3GAEXTEKXTjdcegVVbkQkKnFpQePUfGipCCeOGwyGsbQCcATj1YjDZYVKKQ5TN2S27Yr
         KaSg==
X-Gm-Message-State: AOJu0Yw7N+l1/9hR+l2C/UcqHLs4Ml5GkhzL/6ptZxdNkZJan+am3EM8
	/CusImvCwC9cykNNhW9RjRcENpyuijNkRcQ1JmVclAivDtuOD/hYdZNRo3QTFw==
X-Gm-Gg: AfdE7cmi9tl53BiZtRdNkNay985Vtv0/geLYZZXd7bqEer9XkBBtNFkK8iNDIdEIZqg
	aiZ9kyJr+FVKZIoCxVLS4s90taS1utT4zjz9SlwHBcdLIurnACmdxsG9W6xNW93b8gKtiiYCgKB
	6MqZ+JZip8X0eJmutiX8jHwqEVn3uRdEbes6jfg7GyRtS3P3JRBOVavi69lRE04satPsZQM5V0M
	A9uAIkPZR24GJ+PuiS/Y6QROBfvnqK1OQAFZJaSQ+QqatMNJ1Qa6CUGLdbzHoj2IG8+3RqM+z+O
	bsVCEE63lhgRumVdylxumZslnMJkj/MvhnA4anP05lFwfvdyUcQ8sRhoP24z7M1qc2Z7K38Bemc
	46cqYoO+2wo2gdTPhlg+KxlwzNUrM6nsE0mlCqBguD9gTEDSXL5FKvdAH34UYnYFUzsRHE2zfLu
	3zyx5XzMCNp3ekk90cnA7XYrNSAx3WQH6J1/CpjlgiNxmc1MDBOvTZbXgJnD/IOFSL6x5k8Q==
X-Received: by 2002:a05:600c:3491:b0:493:b8dd:9d68 with SMTP id 5b1f17b1804b1-493d11d7b19mr118046775e9.10.1783332500788;
        Mon, 06 Jul 2026 03:08:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:33f4:2760:38a0:c4f? ([2a0a:ef40:69a:b801:33f4:2760:38a0:c4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960af0sm21679666f8f.30.2026.07.06.03.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:08:19 -0700 (PDT)
Message-ID: <5d238e0d-18ba-429a-a9a4-a3988b00e1e1@gmail.com>
Date: Mon, 6 Jul 2026 11:08:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rebase -i: introduce `pick -x` to add "cherry picked from
 commit ..."
To: Jeff King <peff@peff.net>, Trevor Gross <tg@trevorgross.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Stefan Haller <lists@haller-berlin.de>, Derrick Stolee <stolee@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260705140931.98262-2-tg@trevorgross.com>
 <20260706002415.GC2301945@coredump.intra.peff.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260706002415.GC2301945@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/07/2026 01:24, Jeff King wrote:
> On Sun, Jul 05, 2026 at 02:09:06PM +0000, Trevor Gross wrote:
> 
>> It is sometimes useful to do cherry picks via rebases when there is a
>> sequence of picks or other git operations to combine. However, there is
>> no interactive rebase equivalent to the cherry-pick `-x` flag, which
>> adds a line to the commit body indicating the original commit.
>>
>> Using `exec git cherry-pick ... -x` does work, but is not as nice
>> because it interrupts rebase flow; after resolving a conflict, both `git
>> cherry-pick --continue` and `git rebase --continue` must be run.
> 
> To me this feels like you're approaching the problem backwards. Mostly
> because rebase and cherry-pick are _kind of_ the same operation.
> 
> Usually a rebase is about rewriting the commits on a new base so that
> you can throw away the old ones. And that's why git-rebase generally
> rewrites the branch you're on, and replaces those old commits. So adding
> a "cherry-picked from..." annotation doesn't make sense there; nobody
> would have those old commits!

Exactly

> And so while cherry-pick is doing roughly the same thing under the hood,
> it has different defaults: you specify a read-only source from which to
> pick the commits (and "-x" may or may not make sense).
> 
> So I can see why you might use git-rebase to do what is essentially a
> cherry-pick, porting options from cherry-pick to rebase feels weird. Why
> can't we fix the problems in cherry-pick that make you want to use
> rebase instead?

I think that would be a better solution. Trevor - what is missing from 
"git cherry-pick" that means you end up using "git rebase" instead?

> So what I'm wondering specifically: have we done 99% of the work to have
> interactive cherry-pick, and we just need to add a "-i" option to let
> the user edit that todo file before we start executing it?
> 
> To be clear, I don't know the answer. It's been ages since I've looked
> at sequencer code, so there might be more gotchas. That's just my gut
> feeling from a high level after reading your message.

I don't think it would be much work. The code that edits the todo list 
is rebase specific because it deals with rebase.missingCommitsCheck but 
it shouldn't be too difficult to generalize it. I do wonder though if it 
makes sense to support all of the usual commands when cherry-picking 
especially with `-x`. In particular I'm not sure about adding support 
for `edit -x`, or for `pick -x` followed by `fixup` - what does the 
trailer mean when the commit has been edited or fixed up? (though if 
you're back-porting bug fixes I guess some degree of editing is inevitable)

On a slight tangent I've sometimes wanted to be able to do

	git cherry-pick --exec 'make test' some commits

>> To improve this, introduce `-x` to the pick, reword, and edit todo
>> rebase commands.  This uses the same logic as cherry-pick to add a
>> "(cherry picked from commit ...)" note to the commit body.
> 
> There is one thing that differs here from how cherry-pick works. Even
> though cherry-pick is using the sequencer under the hood, it does not
> allow individual "pick -x" commands, but instead records it as an option
> for the whole operation. So if you add "-x" to the conflicting
> cherry-pick above, you can see:
> 
>    $ cat .git/sequencer/opts
>    [options]
> 	record-origin = true
> 
> That's less flexible, since you can't have per-pick "-x" behavior. If
> that's important to you, I think it might be reasonable to support the
> "-x" option for those sequencer commands, and have "cherry-pick -x" just
> add it automatically to each line (rather than record the global
> option).

Yes, if we're adding a per-commit flag to record the origin it would be 
much nicer just to set that flag when we build the todo list rather than 
having to do

	if (opt->record_origin || (item->flags &  TODO_RECORD_ORIGIN))

to see whether we need to add the trailer.

>> Of note is that rebase will fastforward wherever possible, meaning the
>> check for TODO_RECORD_ORIGIN doesn't get hit and the message will not
>> get amended. This differs from the cherry-pick logic, which will add
>> "cherry picked from ..." even if a rewrite isn't otherwise necessary.
> 
> This sounds like another case where cherry-pick and rebase have subtly
> different behaviors, even though the core functionality is still "pick
> these commits". So being able to stick to the cherry-pick command for
> cherry-picking may be preferable.

I think that is a consequence of the way this patch is implemented - it 
adds the new per-commit flag but does not change the conditions for 
preventing a fast-forward in do_pick_commit() or skip_unnecessary_picks().

Thanks

Phillip

