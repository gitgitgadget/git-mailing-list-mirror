Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3F94229CF
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948722; cv=none; b=aqReqm9+f2afGIymRkCJ1qTlVt5MqU1aYRo7rRysQ47tj7P213W9eBfm+ZXKokfzSEMckVt72XCEY1K0Pei3ZJ1D19bTjrvMDfbBMA5xhj6kaE6Qm8fQ1qhV/YHAfrssixYZ3qBff9D7Sx1hZCr92zmXcf4GsfpjxUX7AU6WT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948722; c=relaxed/simple;
	bh=wyfy2pzcqOVzGcaSAs3g4f9VYNFDGfa2KiwQCapVTjA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ovOIUkZdRxMQi1U8mNXHtMeP9pTP33Hd6X5DbNmITG3jChXNGDh4sZWay9Eh/WsL01zVm7aHhZUznWetMWPxU/roFp8pRMSukS+EUc3L7lk9MMmOXtwQfMGVPEQTyjhFGNHnd00h+JaxZ1cE043/ypx6BoxgvWMIjGW1CI5lGro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWB0q0eB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWB0q0eB"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69c5fda04a8so4151065a12.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948720; x=1784553520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YEnv++11IEepc76LF8yWQUhgF/7/Lywm1mJViHWCYhc=;
        b=SWB0q0eBfmEq+osdXX2Jrmj+2t3qqHl4rqu8gMGdwSWY/a5uZvqnIim9CzVObD+WSp
         +98CKgIGvg1GrH3XRmAiIyQf4MqZMR7T9GlsCkbNCZ6rFfB0k8BGmASbi0d1XEUUOG+5
         2/T0yQ88roW7dZhURgwjaAdw8QGSrdGC30b9Kv3Ro7LHW1oIpyVbEXDyo5Xam7LwDKqD
         lPH5Hnq0EDCx4dALJonY2nq77Y1ADNyFaHpIpsfIT42zbYAmZYTEahTdisXPCrvc9nLA
         Oo47EuCwic/Sn+TtzgdLxsfBRBLX+flzCP/2FAuAMW0qojQ+KhDEvNXqtHL0/LtM0K85
         2aLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948720; x=1784553520;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YEnv++11IEepc76LF8yWQUhgF/7/Lywm1mJViHWCYhc=;
        b=eaNm8fQozB2KyvWqN4jzNm8+83LeXSSWsNObUIBzK/fCe+LZGr/6fgaBIiqO3qo7cx
         1EhCbfv6kUrn+bPysA9eJXlHgWR9T0ypZCvOhflhxoAK8MLUTRccaspkkOmwLxi4dGI4
         cFNy9DoJZj4NRo3Ei8+xco8yvDbbWJNF67Q4PSQeVGB03qhulC+AQxll18vnKqaBc8PP
         ScHa81zr+jCuAsPYBENxsKFt/suqodQuU/t6/LbojXAsbpI1BgP2JMobZEZzCLZiGPtF
         9jq0SSQMadO1oSKv4kwjjt+fL0hwLzAYubxqRLtjzaO1rIoeafaBFZS5gVPe5RRjKDqQ
         bE3g==
X-Gm-Message-State: AOJu0YyokkzBAYVlLLcb1VEjSHG9UB/mSQTdFQTt5T0Y5O7JVPEDs5Lf
	OOK3Avz1sQineFIvHq2VvQnVYI8Or2p73t1li3Wt4ehUfZO0t1ZvZyum
X-Gm-Gg: AfdE7ckgXucfDYbknlom8ysdq3dyw8gCkfSRA/VGjoRXqyOMQ3WozTDKOrhad4EAi1M
	ja50Id3U07efKckJONLX2OHMz3IZM3Dik/vtC0vdLqH4m91TA4JKIcltHvEDsYv5Fy57a7+NAA5
	WHmyS+nI0CsbTf1DoDPE4wwirDGaehWc1r8xBZCaJ+kItpCsQ63QzLTvb3qg5R5y3iTrHiBrNgG
	y2VSjnH8HZCDJAlqxjHwJG8PyXNQDAqsSaZdmDmFqDlTpAQd0Rdcj+ul4ZMLAWdbocQGxUa41T+
	Zfz41yKo8FYBE74e9QANfvEiMHUdbD8HQfQfujMHliO15GBFCZgr6h9kBBPwUkR7Ls0FWLTLSvt
	SUIYl+MwnAYi5GebhGbtcgjmu/png/Ms4lFxryzIW7zrNZ/cJFwSk6OqTAiChg8ZBRSGZyOz4bh
	gUevuIUWwwxGTXkkmDmWRKn+wOdbeVJkxwDpPNwG8e1p4/l2wTYk5duasnnvFe9/pKteE=
X-Received: by 2002:a05:6402:3586:b0:69a:a827:7477 with SMTP id 4fb4d7f45d1cf-69c5f247ea7mr3750275a12.39.1783948719518;
        Mon, 13 Jul 2026 06:18:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19d799dfsm16637693a12.17.2026.07.13.06.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 06:18:39 -0700 (PDT)
Message-ID: <7a1e5111-185e-4390-afa1-c19908c9bd86@gmail.com>
Date: Mon, 13 Jul 2026 14:18:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] sequencer: honor --empty when a fixup!/squash! empties
 its target
To: Junio C Hamano <gitster@pobox.com>,
 Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <20260711-fz-autosquash-empty-v3-1-d227b63eb511@gmail.com>
 <xmqqh5m494yh.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqh5m494yh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/07/2026 06:01, Junio C Hamano wrote:
> Farid Zakaria <farid.m.zakaria@gmail.com> writes:
> 
>> When "git rebase --autosquash" melds a "fixup!" or "squash!" commit into
>> its target, the result can be a commit that no longer changes anything
>> relative to its parent, for example when the melded change reverts the
>> target.  Rather than dropping or keeping this empty commit, the rebase
>> stops with
>>
>> 	You asked to amend the most recent commit, but doing so would
>> 	make it empty. ...
>>
>> and the "--empty" option has no effect on it.  This makes backing a
>> change out of a series awkward: reverting a commit as a "fixup!" and
>> running "git rebase --autosquash --empty=drop" ought to remove both the
>> commit and its revert, but it halts instead.
>> ...
>> Changes in v3:
>>   * Switch the new tests' assertions from grep to test_grep for better
>>     diagnostics (per review).
>>   * Link to v2: https://lore.kernel.org/r/20260710-fz-autosquash-empty-v2-1-fa1e277e05f8@gmail.com
> 
> I see you are already working well with Phillip, which is great.
> 
> This topic, when merged to 'seen', seems to have quite a lot of
> overlaps with his pw/rebase-drop-notes-with-commit topic.

Oh, I should have thought of that

> We are
> expecting the topic to be rerolled, and I was under the impression
> that the remaining issues in that topic were all minor (Phillip,
> correct me if I am wrong) and hopefully we will see it in 'next'
> not in so distant future.

I've just sent a new version and cc'd Farid, I'll try and take look at 
this patch tomorrow

> So it might make sense for you to coordinate with Phillip, and wait
> for his topic to be merged to 'next'.  After that happens, you would
> prepare a merge commit of the other branch into f85a7e6620 (Start
> Git 2.56 cycle, 2026-07-06) or some other stable point, and rebuild
> this patch on top of it.  That way, it will be much less likely that
> I'd make stupid and unnecessary mismerges when attempting to
> integrate this topic into my tree.

That makes sense, assuming no-one has any more comments on 
'pw/rebase-drop-notes-with-commit' it should in be 'next' fairly soon.

Thanks

Phillip
