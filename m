Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BB22AD35
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 04:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784520077; cv=none; b=a9GRzQGPJcUwzoeHK8vUJoClq24AU0LWhQxLluRPI12ZchDLC99rN5eRtGLBbYjBAireyJZv81sxPGbLZB22ghWNT4BZLbioxMmeD7P/xD9Mr/OtCrJ3BGIqUjjpLeNZjUz3KgA76Z9TBXqJePldLzhoxnCn+W1Babikg/G44Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784520077; c=relaxed/simple;
	bh=YKQnTGub8B59E82vl3Z7kBdlsyYL9Iim4lkw6+VS8oM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d7/IMwQ6llKpAWp+blQfh2oPj4wu71cAQ3APVtr3loJEVKR18A4GUqQwoXFOOM6DgSxa2DvNp/4rfYbrCUzIYd96zQ+6UTxKxl5kPb+G1vNhXhwSXf50MAEPDWKbQtRQXdjH7TxNqBZ2yHNMzS9QPgLJhndIWBealqwbw5sdlGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dyH8iSZk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ogHAP6nq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dyH8iSZk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ogHAP6nq"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 00ADF1D0004A;
	Mon, 20 Jul 2026 00:01:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 20 Jul 2026 00:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784520074; x=1784606474; bh=EGF+rgcM7b
	eYoSXNpU+1CoHUw5LsQr4iVJ6D6+G9EfY=; b=dyH8iSZkJaCkr+9DxaCIEpKJl5
	IqMqJT9OtCjbU6DUdHIyWgJuyQOe7rmNa8jFo7RYJFGX9GhwgsEieRvNc2sOT2kH
	+/p4bvZBMS9Xkc215vfNjfrcbdg0aXIoJpXBZA3lMcX7ZN3mTzzq+8dbvpCQeNPx
	6OGE5+uR5UA2m2TbOxy1pfJpiOVGkeELRCsiLFTt8lyLosU0yg2OTUlUUUFT+Pk4
	okrEs16iZvH2FbT018k89VYMIyPHCWL00DKd5a5mO/Hf/8zgdniRqSBsLqAIx5Zs
	zFyQiAMwiz6zGNqMf7k5PL/sA0r9e5ROt/6E/wuOSrVTGkIOtrYNEPsYAPlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784520074; x=1784606474; bh=EGF+rgcM7beYoSXNpU+1CoHUw5LsQr4iVJ6
	D6+G9EfY=; b=ogHAP6nqMpRMDgEwDvJvGu7DFTsuyJ4VLVodbifynoxtisa8sXH
	YEux/m1gMBMg4eoCrB/4f7GvuWErHrDA4o0i75gYKjjgU34RFK2xu3pI+6dep/2u
	gwCVXUdGjPARhCmOxll4J79Ist43H4lE7fWJi8wOhn1jRqlr4Ctb72jpnp5fJIrb
	AEq+r6pJXeq99CqESvHRjlTz1mbkHWKD89+FJaL1ZCUV3J2x3bnfpftXrcQhsYk/
	lqn2m0sfWo438rp2n/NclgVykrkGJsagEtWYNZr55f/KcfViXouXgIfNVKCjKHu8
	owWFzR7UtJ+1+q5m/Xto9DASPNl/aMcTHSA==
X-ME-Sender: <xms:ip1datzX-8n7EFGH3m2GvRoRf0hCYzgc9JEOEJ03WOIy0zVZqlpfSg>
    <xme:ip1dakJ3JybMrgfvvoiJY7yPu8F4PDT9cP5PCM2CrwLWANv_yFxEauIYwixGQtAjW
    N1P_qDI_rBMA5nAAX_8dLob7oyRjWiElJ4pxHUeLcB4PDQKQflqxw>
X-ME-Received: <xmr:ip1davql3YMQ09Z0_Pg5klfIeVa9XucIDR27QCG88A4o7oZtb1480izfKyOqHcQoGJEQKYr-oGpJSqg2QDoaGYUE7YYDBCMfYQ>
X-ME-Proxy-Cause: dmFkZTGxoQwbe1ZtuWefCwpc27vZBHSwoj4z35HfG4kxADqxBWmjt/Zg5kJUadQV931cs7
    xwlxayDCaw9FZeb1SHBKf32M/BqrL16Ucj3Xwq+rmrSem6PTG0HmOiYRB8knz2/k7MeVrZ
    simRt4HP8eiEc9no5+2oA9+Kv4pFSeUhwMjfVwlcwZgaxzJWeAcNBZmk1a8/uWtu0q4c96
    N7ikjC/WZ/185Oq1XWNUSm24f5eTDPzrML6qr2It2mFfcZ26ePxvD/kUO5u1UQQho9lGtE
    nENp3Tjczq+kdxQFPTTWsyPHlVNj6Qrx57mJEmbu5L/xPAQyZ+O99zdXfO3xLDguse3UhD
    F7OHEeGo3LY5CEDv+0h4zMhr87JLpIc9uhbv+XyoVhzvCx4dXjHlShYgHDFhPTlTpsP3NL
    L9qYs4IswRHFn3ZjpA6+FfLDdAb2HeY/QD/3kHwKZMyRLj6jH8HHjqmtEeeQVhkRJeogOf
    zwvfTS5pTm0ix71AlR+HZqKxJmWP+cVlg8CB2NK+Vy6RI0Og/93gTg8cMRvCAufJ5H+yJE
    dlFwexDnZ5bqNaAFirrglldU2c8kHwhezlUW0KtYkI8fg8RkUaSVdNFFMkz+JoC7AYSp4Y
    KDMpRleEjSEK24QeL23zhHvCN2/aoLwURkotc7f6wc36NFplD1tqynYe9SyQ
X-ME-Proxy: <xmx:ip1darJxl5yzWNHRmf3etyVYurRNGQu-eAYAhA2bcc_UB2iywe4x_A>
    <xmx:ip1dasQRzx0YOAN1vgkHV4J6ONy7YGOjOqtbcfPksWN716z8RFwZ7Q>
    <xmx:ip1daisCzRe4a2nijdwi9Sjik1BI-aiiD60vTSLxJYnDGTgT9-7IMg>
    <xmx:ip1dalbWGfL7LjDA-1TDa-o27HcodyMzPTLSaJ20OfkwJFtwyt4ExA>
    <xmx:ip1damYm4I_WhnvY1_eUokpVVo5bgc3wWJ7vIGRFwp18TYpdF3ESEcNe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 00:01:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com
Subject: Re: [GSoC Patch v2 6/7] repo: add path.grafts with absolute and
 relative suffix formatting
In-Reply-To: <DB49CF15-4980-4213-8463-4C0FE2EC8438@gmail.com> (Lucas Seiki
	Oshiro's message of "Sun, 19 Jul 2026 21:20:22 -0300")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20260717133015.32040-1-jayatheerthkulkarni2005@gmail.com>
	<20260717133015.32040-7-jayatheerthkulkarni2005@gmail.com>
	<DB49CF15-4980-4213-8463-4C0FE2EC8438@gmail.com>
Date: Sun, 19 Jul 2026 21:01:12 -0700
Message-ID: <xmqq33xejomv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>> Introduce `path.grafts.absolute` and `path.grafts.relative` keys to
>> `git repo info`. This allows scripting layers to query the active grafts
>> context cleanly while scaling transparently with active `GIT_GRAFT_FILE`
>> environment variable overrides.
>
> I ran `git repo info path.grafts.relative` in a repository with no
> `grafts` file, and it returned `.git/info/grafts`, which obviously
> doesn't exist.
>
> Wouldn't it be better if we check if that file exists before
> returning this value?

That is an interesting question, but I think it depends on who is
querying and for what purpose.

If a script is asking where to write the file, then the author wants
to know where the file is supposed to be, even if no such file
exists yet.  Since the file format is public, they are free to write
their own tools to manipulate it.

Thanks.
