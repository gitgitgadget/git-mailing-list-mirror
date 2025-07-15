Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B222186E2E
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598197; cv=none; b=E4X+TPkmu4mZgQCZ3txUBtr+YFQBIY46QUq5pXz0QidEFFkPMJNzCXqyoKYX0j6GXbMsIwxdb331md4Qvbn+uAxy98/iJlchBLytO/Oa1BI6HZ7qnupNwe6TU1AnZyafAGLE2wcOa0HPCIoWEh6ARdz5DgV06YgQa4gaiNBlupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598197; c=relaxed/simple;
	bh=8aS9kwWrYxzbtRseM+9ybPLbiWOi7miDlonJ5wF4Ank=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wvo1OFp0Mv0elRvdR7uZytcf07y0I33f7RiKLR6qGiM6hP/KdGpIY1UQ30/LpbXDPOnbxBTsP8ECnUxX4L+4Rfs5kNRc/G8wbRxk+MNkg5fms6RFVvhav9s+d0BrAdEDPBWz9lzeCuuGao1QQKyUqz0gqTWv5Dw0k064PkDgoRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WFbzrhrb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LKZcMWEb; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WFbzrhrb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LKZcMWEb"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 648AB1D002A2;
	Tue, 15 Jul 2025 12:49:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 15 Jul 2025 12:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752598194; x=1752684594; bh=YjDOZYOdB6
	WjGuGF/tJqmTbHzqBNc3a8MXOBOeRUg+k=; b=WFbzrhrbvSqMZhwlwNBxaFEYsr
	XVWJjHtYWz8IQFKrzM38a+qaqi626X5tKcjsFPvztQA6Gk6E3YsdHUEIoO/yEQm+
	oCixVLyDtnxeppkH+l/TxEjKuPc5EZYt1aZO2kKoUTosupi3PbsVE3783IezwSoB
	6gSgM/jVPaKGd2B/elrHpi8PILjuWXAxM78e91aszIQet+4P18wlVfAODIQ0fPa4
	2o2gLtIjUBWTBLQUSBUyx8gkH1BU7jr0ztnVqrpO/BfwgHwS1ZdxvslfpxQQG+8r
	GeOWlBAmwi69n++xw0J3449zwUye5YLQFl3Fx+oP1PWsWEKuLcE2DMDOBrxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752598194; x=1752684594; bh=YjDOZYOdB6WjGuGF/tJqmTbHzqBNc3a8MXO
	BOeRUg+k=; b=LKZcMWEbuTAxXNhyLUpYqnb+/bwcowJ3l+47m7LQd4uNJGXQhIw
	2lAtp3YE8MwJ6U90P2m6buQx5kYOzAqYUpnOYX8A7179O4bHvXOwneZ/MvDNPNF/
	XJa+YBscawZLTtZDYyJsc7VvQalA+mmHCmQ1vwPvJpjrA4JGIL7l4jvad+9kgy4E
	RgSTDXyYHoZcHwaqCa1nQFmlGhmSqJ6bnOdAGFcckubnGfRZCvX+gWVAkUTUD7yh
	WmmGUraDKucQANPgCVRhjz++nXMcfwHfR+lAltzAiIzw4GNcNPoJ48zaIMqIv0lu
	MRmyZDvxRxElAtSLMYpMK/Gb8v6kW+/utvw==
X-ME-Sender: <xms:sYZ2aLa4A3gHnNvVa9ze_nm5y4A71mPbPeQGa0dfcOGMaVkPCepBYA>
    <xme:sYZ2aFBZ0Q7nfls5Qt6wslSZMkM49_QHxqKGyvnV5T47ZMn5da2kGhZUbnTen4lO6
    tUT-cc1OslJPBRJ2w>
X-ME-Received: <xmr:sYZ2aD-dwixiZDerly6aqbhiBqq_dorDLia_FXtn2_X9uXGdPHfuCLUa0SSZjiYolS8sJ7OtQaYQq9CbCzVu7lu1vGL0n7Uk96b_55E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgi
    druggvpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sYZ2aBSKPklGpTZRisB9i63CuHDWaOj6X_Rd4JUer73XzRMTzM8LYQ>
    <xmx:sYZ2aHWp6nlLLxBGV-UvbPaNDl7w_W5bKKmi6XK6QiLWFrNmd0cl-g>
    <xmx:sYZ2aLR9q9556kImfj27oLdKj_qyVQuwxroenkJxLe_bnW7n24UVNw>
    <xmx:sYZ2aP0-WQykjrMbOjvpqqwVm1QY3zU0qF1fWb9CwuhmrmfTfyQMQQ>
    <xmx:soZ2aNDLHTcnVVbO7cwh0eaRR_HX1gvOi2NGqlJtjjM-5LeqnH0Bt1ea>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 12:49:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  ps@pks.im,  karthik.188@gmail.com,  ben.knoble@gmail.com,
  phillip.wood@dunelm.org.uk,  jltobler@gmail.com
Subject: Re: [GSoC RFC PATCH v4 0/4] repo: add new command for retrieving
 repository info
In-Reply-To: <aHYuwlWlbkc600Ps@ugly> (Oswald Buddenhagen's message of "Tue, 15
	Jul 2025 12:34:42 +0200")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250714235231.10137-1-lucasseikioshiro@gmail.com>
	<aHYuwlWlbkc600Ps@ugly>
Date: Tue, 15 Jul 2025 09:49:52 -0700
Message-ID: <xmqqecuhiekv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Mon, Jul 14, 2025 at 08:52:27PM -0300, Lucas Seiki Oshiro wrote:
>> - Renames the command to `repo` instead of `repo-info`. All the
>> functionality
>>  of `repo-info` will now be under `repo info`. The functionality of `survey`
>>  will be moved to another subcommand of `git repo`.
>>
> this strikes me as a bad idea, given how established the `repo` tool is.
>
> without much thinking and reading prior conversations, i'd go with
> "query", because it's a database-like metadata ... query.
> the obvious followup idea would then be "meta", but that suggests that
> it isn't only a read-only command, which i think it is supposed to
> remain?

"git repository query"
"git repository stat"
...?
