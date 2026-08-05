Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7EA48382F
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947446; cv=none; b=a54VblNPmyAUztfcSwYkL+VkZNB9vcr68fVW1DUt2Pv1lsDBryS6fky8LhqX9ZOgJ7h73FADHHZN2+7zdvYmYv3cjwBFPydLF9DidKKXERR5L47al1TaaFe7TiPLckq5p5QmfKzgcT5WZk4t7D7BrphpIFx+XuSRphusec0TuAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947446; c=relaxed/simple;
	bh=iqfkNhwk5+oUcWbYLey3d4WWQWsqqkWOVF8XXhR4y8U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=vBTDrKRmqtWx6dk2fRmVF3PDS967htJYH3rpe/54E0yaexzUWqarNp1yYWNixllz/BPqJ8yUFLf2vfvFsGCfpWfSqnKmpR0Mr3ntkwePB4Bj3hT2UHbZApdwalDS0qPqveAayh3LdEqYvfoG05kbh3+8qhmaUtV3zlwXKLRtRbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTbON8PT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTbON8PT"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso8096315e9.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 09:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785947442; x=1786552242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:reply-to:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eh1NE+vmTc1RQaUk94iOB6IZNKjgw4+1c4QfYO13/kw=;
        b=aTbON8PThpcm2gkKv+aCS7PC295m1LMWlvdvHzLFRiBtIKJu0/EF7KPNpwa1ZtiBYr
         K7IEyDHT/YNqPt01XASKx90rNpG5gMjULMkYrjuHUlGU04grfAmhY2LYccdodoYesLnV
         Fz18xUyzB7alQ8DS97DlURMbEuPG6ovixEYBZod7n0PZGKxThQ10k12wmRU9emA9nL5E
         tjjisL5oeJYiggjoosyGwAeqH0xdAIDwpNv+vXkqTr7S4v8SMpYoTi14PF757InE+uQz
         Y+eZhEfEFuUTj6GAWjC/rCBb431WkkT2B4TaL9vNRFm6iqSTg6BGDbk44Ri8P80NC1Sf
         uv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785947442; x=1786552242;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:reply-to:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eh1NE+vmTc1RQaUk94iOB6IZNKjgw4+1c4QfYO13/kw=;
        b=AbBVFsV4OLVBowrNEv55hHmY3JF7XiMtzBFFb7g27CZrFzC6OXu7vdcVHbpilDIDkg
         2NElaYm3xutDNzebwAGgrZAY80S1l4ORpJ0BKwxX6nZZsywLCc8GrCNtSXlu2VPB9vr1
         Cu0h+FYSY/EeUyvbquNr0Eqlmuot77585R8iUjzr3zEw0x8gmREP9n+wDi5lp+m9yusT
         qHBwOXRFpV2+cU+I0mIdvaei/iL+KbVGotKo/+ldPju/hq3rC5ORuhnEvuKlTlLofBPB
         HGUBs1RoDx1yCIzGFSSOIbcDCX2WqUjYDdD2e/jMq2+K9yEwM9mFHJ0W8N02ysAcGHGk
         4b3Q==
X-Forwarded-Encrypted: i=1; AHgh+RqxwhXiLXpj8WFdENv6ZCbwCsBJwX1uXI0DkKOZTQyWAtnTVlIKbwTm9EJsSMps/twX4V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOjKJf71LL8f3yDAOmxwZkVdFxaSEgbb2gEr4TpCsPdrv+n+ur
	B0d7MND48jKHOg3wdGEpQ/JazrjnL3cMBUGSNRuGFNys3jkm3ZNSC9Sr
X-Gm-Gg: AR+sD11CbFUVlmbOLzHQmEaOSQ4L/tgx2GxBAzZzq7+pNY3ZgeAaNOQUJ7KB1MAq4Ea
	oALD8/De5AuG0gg2ZpCmWbQpQiOzc5mTXQWgN81s7lPBVGYrJsrdKwqypKgkN1NTaaMOdD6OudR
	1kVJshGTvGBY/KvEwCi4PXPg+sHnyEEiU2xED5nCIAujDX9B1RLjbrHU38L/sEls7hqRVaZkVLH
	k/gVk370fpKox3rGgflQhFB/1+iAtY+AVMJsPd7UDWuV9sr4rcco/pFCsL6WKZmT0DFyMSyugZp
	6lYfrhDAkJTVRskfEVy70MC15ZYxzRU1yBQhxjZqU2Q8EZ/0lxWnWtXnckUm5UCnIRG6b7MEY8d
	A1PYO9/BOxuljFaePOQNgDLcasQv2/0QRZZVUlq2U+40gGJGQMulAmZnswd2S/g3RtJbiPviwZL
	JabnY1VpGk9U4ydrmQXDTpiP+urnkICNce/H3rJIGZlISS9gmjQL9QvmyigwZBSOTyy8PL1PxDb
	i0ZSIOF4OZOO//wYsjLDjTmRjHoJ5lVGkJQulHHNlBwjMbw
X-Received: by 2002:a05:600c:4688:b0:495:6bc9:62b0 with SMTP id 5b1f17b1804b1-4994e7d1487mr103883915e9.17.1785947442194;
        Wed, 05 Aug 2026 09:30:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:6dc7:af50:9cd:3275? ([2a0a:ef40:17bb:9901:6dc7:af50:9cd:3275])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994dfcc84dsm95648435e9.2.2026.08.05.09.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 09:30:41 -0700 (PDT)
Message-ID: <de96a0de-a0a3-4e3e-b44e-8991f8ae87d3@gmail.com>
Date: Wed, 5 Aug 2026 17:31:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_BUG=3F_git_rebase_-x_=22git_commit_--amend_?=
 =?UTF-8?Q?=E2=80=A6=22_loses_notes?=
From: Phillip Wood <phillip.wood123@gmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
Reply-To: phillip.wood@dunelm.org.uk
References: <CALnO6CDh6kbL5KH=Nt00ksZCaDbJAnjbepU_tyRTcbGekSyeMg@mail.gmail.com>
 <307abaeb-b033-4c55-8edf-1ea765199dce@gmail.com>
Content-Language: en-US
In-Reply-To: <307abaeb-b033-4c55-8edf-1ea765199dce@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/08/2026 14:42, Phillip Wood wrote:
> On 05/08/2026 14:13, D. Ben Knoble wrote:
>> Sigh… I haven't minimized a reproduction case here yet, but maybe
>> someone can tell me how I'm holding it wrong.
>>
>> I have a local branch with notes in refs/notes/benknoble/commits (in
>> particular, the tip commit has a note). I forgot to adjust my author
>> email before creating some of these commits, and I wanted to adjust it
>> to match the mailmap patch I just sent out, so I ran
>>
>>      git rebase -x "git commit --no-verify --no-edit --amend
>> --author='$(git config get user.name) <$(git config get user.email)>'"
>>
>> Upon checking (much) later, I discovered the note was missing! It had
>> not been rewritten. And yet:
> 
> I suspect the note was rewritten to the un-amended commit (i.e. the 
> commit created by rebase before it ran the exec command). The way the 
> note writing works is that as rebase picks commits it remembers the new 
> object id of each commit and after all the commits have been rebased 
> passes a list of "old-oid new-oid" pairs to "git notes copy". If a 
> commit gets amended by an exec command then we don't record the new 
> object id correctly. I have some old, half finished, patches that try to 
> fix that by making "git commit --amend" update the file where rebase 
> stores the list of rewritten commits. I think it worked for exec 
> commands that run "git commit amend", but the effort got bogged down 
> trying to improve the way we handle commits that are edited. I've just 
> pushed them to [1] if anyone is interested (though the commit messages 
> are dreadful so I don't know how much help the patches will be).

Another approach would be to copy the notes before we stop for an "exec" 
or "edit" command (the latter is complicated by the fact it might have 
conflicts) so that "git commit --amend" could just copy them to the 
amended commit. If we did that we'd want to copy the notes in-process 
rather than forking "git notes copy" before each "exec" command.

Thanks

Phillip

> Thanks
> 
> Phillip
> 
> [1] https://github.com/phillipwood/git/commits/wip/rebase-update-rewritten
> 
>>      git config get --all --regexp --show-names --show-scope notes | 
>> column -t
>>      global  format.notes      true
>>      global  notes.rewriteref  refs/notes/commits
>>      local   core.notesref     refs/notes/benknoble/commits
>>      local   notes.rewriteref  refs/notes/benknoble/commits
>>      local   notes.displayref  refs/notes/origin/amlog
>>
>> So I would have expected the notes to get rewritten?
>>
>> - Running "git commit … --amend …" (author change and all) rewrites 
>> the notes
>> - Running "git rebase -x echo" rewrites the notes (well, it has
>> nothing to do right now, so it doesn't modify anything; however, I'm
>> 99.9% convinced that when I did a plain rebase earlier today the notes
>> were preserved, just like they are all the time)
>>
>> It's just the combination that loses them :/
>>
> 

