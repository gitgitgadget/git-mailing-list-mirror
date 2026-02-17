Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E40371050
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345997; cv=none; b=DTXkogozj5UP7Tb7ZUubFdUJFhrHb6nq1NR6A4cKWLjI+3iJso0a271miMXPQ71EGaVohp6tyiuXvOXOidZ9W7D8fHvL2e2rQiTf1nVaBK1fowoGH+UFkGseIiytyqq//WV9Baa9HEn5rWxfVWJia3yFEMtMhTPb9YXfgqYPkqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345997; c=relaxed/simple;
	bh=GoZpxvm/S7DZ6WT3jzBwV8GXywUtMLrWSLttdicUw2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uWlgWla62c0CLPpm8Ljzfvt71XZWuB4Q2W4KAh09xlefI8S1XT0QudnNMjvUDD38Neoi9rw7EpqzMel5ys8EdK3ntkuqP+3qAXXj2/gnjN8kWRRMUyxmFQUP9nFmafDLoq4OoLStRXRqM3Y4XUmdTFVhPmgz67QtLGELsqf1O20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VN3RU57w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PNNDhdu2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VN3RU57w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PNNDhdu2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 920CE1400040;
	Tue, 17 Feb 2026 11:33:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 17 Feb 2026 11:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771345995; x=1771432395; bh=LLaZMxQTGg
	3yxgEQaVWh6XtiIGCcmRjo2n3nmA+ju0s=; b=VN3RU57wJBj7ML/lOBxbEKsXHK
	OkZQfO6z36dy8hT3KHoSjtoqYjY3ADzGxEbz01BkIEZrdBxNP/TpxSkYj/obrBPd
	70LdYE9qm9SLJlJBs6IuxiDkIewYGcb47J/gWef/gwkUCKYFLQEkdIIO5YxMLYjE
	r0v3NDiovy8DhjZiiiAh/s6zfBl0aZenrjCPXJ4GU+B5EAjceZCNY/YZ8+b+xRQd
	7A4QG56IfF36xhkm5HO2L3o4BXjycYEf6+1n2k9CdNa2/AnobxkH28FGLhqx6Kd6
	JPD9I8NNXQBlmFciFZ7G2kmswLqRILJGkllykVNgPQm6ew3povUoe/oMRTRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771345995; x=1771432395; bh=LLaZMxQTGg3yxgEQaVWh6XtiIGCcmRjo2n3
	nmA+ju0s=; b=PNNDhdu2SI8qD9wb5wq+C5TxmlE5Qcd07EOwyzE9r9DGA3HNrji
	dxe/8tBjAixMFbVv703gXtBzKVrVdRkY3ToCQ1tTBbDMUfJXXkbw3lfi5/Yw0plx
	jITgxIhrFx7xR+7e8hycM0QWgQq8gkL8hYJHJeIDDPq3NZPThyynnOP70jKCXWLx
	L+RffsfbIFC7oMCAsHI7XcLdzhYtkN11ApbnHEiiJ37dtaC0MRWj7kA2Uy/knRCE
	/e4usza5PCFRtEDhzYHY0bURcD2ZU7SODtULel9hfF5w7XBnq9sqplV0qeIMgHGy
	cVS3YRDD7qIQ/B0ia2r55ccKZGmrcOiC/XA==
X-ME-Sender: <xms:S5iUaQV2aCJ2TcmcfW_tQ0sWaS5tnl-_U96ndLdPJO9IyOoOH2rxRg>
    <xme:S5iUacC18FTaXYZHQkfrFYrol_knW7lc970RD-O6EsXuQUIfuqw29CQYiJyawRQpa
    7104ic1TMNfny6N82PtbccvVWUrPrkBaICZGfT5sAEeWfLcrQ30yA>
X-ME-Received: <xmr:S5iUaRzrRa9ZNOnUxHvgj02QqulQPae5yILK0dnANDj6YvaE8XAIP2WEA9yNBB-CBcxqB52KAl0U-Ue-MDSUkhmEWVWC7wIuvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:S5iUaZDGmmD78X9aNyggJDmnpjadbzfoMWvkxO75Yi6q-_M7PFp82A>
    <xmx:S5iUaeZmbYe1NFwaockbYtZ6h-enxjR-Gi0hGtgmixETDJkj_xE2EQ>
    <xmx:S5iUaRj1oE5J3RsvUCjm10QMXnifJDZe64kZmLCc4DzSvQXZIuCh5g>
    <xmx:S5iUaQ71rkbDSvDoDkoR-yY_lpeHlif7GXU6fZFF28u8p_dZ_5Gphg>
    <xmx:S5iUaQAQM6kcfXwNKmhN2oCVjuD5b0Zv0EMXweQraorG7JJpL9dlnEGQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 11:33:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: ds/revision-maximal-only (was Re: What's cooking in git.git
 (Feb 2026, #05))
In-Reply-To: <966fe2a3-1565-4bc6-ab4e-433fd4ff517f@gmail.com> (Derrick
	Stolee's message of "Sat, 14 Feb 2026 16:17:36 -0500")
References: <xmqq4inkhymy.fsf@gitster.g>
	<966fe2a3-1565-4bc6-ab4e-433fd4ff517f@gmail.com>
Date: Tue, 17 Feb 2026 08:33:14 -0800
Message-ID: <xmqqzf57cotx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 2/13/26 9:01 PM, Junio C Hamano wrote:
>
>> * ds/revision-maximal-only (2026-01-22) 1 commit
>>   - revision: add --maximal-only option
>> 
>>   "git rev-list" and friends learn "--maximal-only" to show only the
>>   commits that are not reachable by other commits.
>> 
>>   Will merge to 'next'?
>>   source: <pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com>
>
> This has been stable for a few weeks, so I think it's ready for
> 'next'.

I am not 100% sure if "stable" is the most appropriate word to
describe the topic, or if it is "dormant".  Let's merge it down.

Thanks.


