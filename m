Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AD21FF4A
	for <git@vger.kernel.org>; Thu, 15 May 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327040; cv=none; b=pHv32X34mNDiMyUCfdE5YMcq7MxwecgSYWR4jrmBUBpbEAqagM8CJ3iEPP7t/CLf1MH3oYipkwl4FBjO6v6HR4rz09+pPSOPSii5mbWz9fbXYEZL7KgoVUqmSG3hlAI2v27uaRv4aPly7pKw3egkfME+W3czVwLcp2lto4rq+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327040; c=relaxed/simple;
	bh=ccYxQ50bTcAR2F7newHL1BtEt8EWeNU7ja3A0PDaUfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TfcloRH+ekCig0t5FmoZCS95tZnHWhd0BAgvFAxpak/8cpOzkaOE005pJB1ILtj50Mu7gKXwSneEhGWBPItV6I2jaH+1zs1VcljlhDDLjRelYThOirGvuRHMS5g+9qKHSg3zHdp3BqKpC/aR2kquCJc6FmLuAWI+oZ23+hk8EEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E0SFuPW6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MIzi7YQ9; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E0SFuPW6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MIzi7YQ9"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 0107D1140162;
	Thu, 15 May 2025 12:37:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 15 May 2025 12:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747327036; x=1747413436; bh=VvH/h3FoXs
	UGQzo+xWov4gQXD1czZV4f5sh7VnJcXnc=; b=E0SFuPW6gmTy1PSdCABTvtE18R
	Ok+lbWHfd/Wx8eWuJ63JpTQy629UFkzCW+0T35akLKXJ1GG0530RfbTsmkh3zCQ/
	CQ0H3a5glgGLUnfUibYzH8VHGwwRLrUilJlO+cHNzmqlIX2G0e/CWsLfOo4WdSqV
	QSL2pOxTyjaw1KnNL4XhdSS2cSDg6dKGuaPin8wG92CxTOGT9jFeTb84YU2bizfS
	XwgtKrpjXKDURaEBsV26k2/sVU1dZcrGXACOmDsHj/mfjUtn59D85wcnTIX+hEv6
	+QUoWeCVQpYoM5gtzJ38LpO1kkvVqhNbPJBdFd1lYYZXbacTPv1fR1tYxX1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747327036; x=1747413436; bh=VvH/h3FoXsUGQzo+xWov4gQXD1czZV4f5sh
	7VnJcXnc=; b=MIzi7YQ9eHAFREcQMtZgip5Z7/PQaFZadH4eFKwf1ejsxlLs1Ny
	zyuBKLl58XRRmfzA+tfAFE7LX0kv0DvJ0FhiXmvfNTm+Y9m+D2RIf5Zh+n8Y44ix
	LD+DsyS26uvzUw3OIFDrv3nuM8Hc6kiLDP9ENl1MWu/55JQoIE4a8k3SI72dgnud
	mdBiv9DrQg8Fq7TJ0WIb51X7sGvu36bpluPmCS9wXdSPhQcVTZHAkqNCtbIaQvE3
	TcVo1VyRG1FDGWrjkACFSIikNGavjdsNGA+D8gf4Qwq/hHxveWIueyVi9OOCYxzf
	9P88OARadKHlKynG+rkk8qQhxcEvfUjH3nQ==
X-ME-Sender: <xms:PBgmaELO4uzyqvxXQ_beo9t4WjhXR8Rh5T2JVJCA60RO607jVcGcjA>
    <xme:PBgmaEI6r0o9qHStzC-olIVwWY7sOHS9RUVQVz3X8qG1rapFHsgMrmV1H1VF0mWPs
    B5X4dOEaQbbodfB0A>
X-ME-Received: <xmr:PBgmaEtyKyNQsLZH50EN8RFGDOUlZCVOXqp2ZeBJkf8D2MsPRECN-TDZNdsH5xVOitDBQih1h2EpWik4-PmosncJGFSb6AljLTTTlI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjhhu
    rdgvughurdgtnhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PBgmaBZ4Nq59fzzzswLteF_Y5my3SfQGLsoat1YJh_2fJigSc9utLw>
    <xmx:PBgmaLapoCG0Lo4RkD9-8z_vBQKPDUFFEcTkkItUkvGLgiMhh4X0wg>
    <xmx:PBgmaNBikHLsLMcomvJed_YCHn5F5TMAAbdcTZVFJWp7grJv5mRaYQ>
    <xmx:PBgmaBaEnmqP6S9JkRXQehdvs5UuoSpjeimgj1vlTNXyPfQwKarrmw>
    <xmx:PBgmaEB8eBXfVPFxWj040Qt2iOtKLzh5uofjKH-LzoPn2ywuqlghLgaM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 12:37:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] sequencer: fix memory leak if
 `todo_list_rearrange_squash()` failed
In-Reply-To: <52e0a717-f7f0-401d-b621-f1f6e028e595@gmail.com> (Phillip Wood's
	message of "Thu, 15 May 2025 11:08:55 +0100")
References: <pull.1965.git.git.1747230808770.gitgitgadget@gmail.com>
	<52e0a717-f7f0-401d-b621-f1f6e028e595@gmail.com>
Date: Thu, 15 May 2025 09:37:14 -0700
Message-ID: <xmqqecwp3k5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 14/05/2025 14:53, Lidong Yan via GitGitGadget wrote:
>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>> In sequencer.c:todo_list_rearrange_squash, if it fails, memory
>> allocated in `next`, `tail`, `subjects` and `subject2item` will leak.
>> Jump to cleanup label before return could fix this leak problem.
>
> You could mention that you're adding the cleanup label.
>
> I suspect reaching this condition is a bug as well because we should
> only rearrange the todo list when the rebase starts. However I'm not
> 100% sure that it is impossible to trigger this condition so lets free
> it as you suggest. The code changes look good.

I wonder if there is a way (sort of using BUG("") but not as severe
as killing the program) for us to mark "we do not expect this code
path to be taken" and ask static analysis or fuzzers to disprove
such assertions.

The message being an error(), without a silent return doing nothing,
smells like a good enough sign, at least to me, that the original
author intended not to call this helper function on a list that was
already rearranged, so turning this into BUG("") may be something we
would want to consider doing in the longer term.

>> @@ -6626,8 +6627,8 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>>   		}
>>     		if (is_fixup(item->command)) {
>> -			clear_commit_todo_item(&commit_todo);
>> -			return error(_("the script was already rearranged."));
>> +			ret = error(_("the script was already rearranged."));
>> +			goto cleanup;
>>   		}

Thanks.
