Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A5220E035
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522574; cv=none; b=sN9Z07Fsf+Y5Zn0uugt8LQPL52ZtG/lRtyxNE3PoBSc6EbVri8jToE7LGkCyojb8tfb1IVN9CW+aOj70iMACd8X7H2DAFV2c3BPExrnH42Yq1vNKJXRYRqv2KQt/Owbj71oCHao8DTn9W7AGJ6hOg7hkqwtzV4U37iBMLMMwwgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522574; c=relaxed/simple;
	bh=u2EjU+uo5OvAwMJoUeUYpsim7SloEvFLe4MsdJZL/Is=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ng2ZFdAyM14Edg1vHx0fVe8VdNAoyAIi4YYHE1fMNA7cpe7nHafwUsK4VfYbIFhZ1aG1MRye6KCRGZBclUDAnjFJofYd9LnRx65EisQmZiIhBddnmZUktYeLsqnJIx6SrZi/Do/5wf8rgTVz6NY8fkiyu1QsWlFsWLAETyw4ptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DxOTicii; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ne8TW4VO; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DxOTicii";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ne8TW4VO"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A6A79114015B;
	Fri, 10 Jan 2025 10:22:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 10 Jan 2025 10:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736522570;
	 x=1736608970; bh=hyt2Z9Np8xqJaxcO4Xx83t4KIAvf0FdYqAYx61CXdAs=; b=
	DxOTiciisKI6KsDt3eevdCoDmSCBY5eu4OGv0Qc0D1zmlOQRFxXouqcdI3WA4eOz
	3nVcaOIYRCGaeOxdmsyHXDMaU11fQGBs1YgeU0+3D8RIePXe1j/Zu8rP/whLFa85
	17vQoOCvR8s/mtpwpN4HzaJHBkn7DVGeg8qu8hLZMVArGn9riH4/xv8zx9iOBY7V
	zt2TzKh8Qi+S4xzxaqtqezZ/LM1hC7fv+yDi23apHQrTPLOZNPy00J7waeX4S5DS
	z68NpEDfytDs26SaL8FMUR7+eMFLVg7PRwoaNUxQJQMVY18cx5vFt0BU4zQioJyZ
	PzQvELoWO9ZayuG9Avk4vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736522570; x=
	1736608970; bh=hyt2Z9Np8xqJaxcO4Xx83t4KIAvf0FdYqAYx61CXdAs=; b=N
	e8TW4VOwbIctmLdpML30hU7HZn3Y2dy3aVx8hXhoNiz3Vfbw4k5Uk81kDuQ3k+Cj
	d12g9WbxCY+QhstvKhoZ3hocUpPHRyz0l3z7UjA77cZHxYWY2oc+C6qPI9vC7rM2
	mNL2rbIam89jbkNkIvIQnBdaLoL195GLFzFS9Tf1xLBS9A23sDGawAlxJegqsO05
	6AWRh/WX8GjUn0TaW8GTj/+w77kjuMiGOGZ4BwYnewnpQBwjj1aU3hdU2go+6/7+
	zrJ7xdzT7N0RDvam8mKYb7ABsjm675mFpFldVhVSd1CfGlenXCyzr1ctMGWWpjqp
	cpcVgaJA40GHpC1uI4ZcA==
X-ME-Sender: <xms:SjuBZ_byyuM_cuSIUNA8Zb6alUJyaWPmMwWftQNBLm5l8sJA8Q4dZg>
    <xme:SjuBZ-aScOqz2I84hxlz6kZX_hlcqT1J8KEHr5K8kZg8Q9-kKrHuD4G_53FdF6nqz
    v4wsUgamPpMUgplpw>
X-ME-Received: <xmr:SjuBZx-IUc1HP-LOXL_m2uxZLNvGRX4GFDCqqdNVVyP1xmZtCnYkM_ddHdoyHAvEZ4fAG9PbdMiTiX4aEV2C4qQhc9UKcxULn1PU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirg
    hnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SjuBZ1o7ek_R0IfWlNdV7bNdKAFoL3E8ZBBS47fnkKHtKJP0K5etTg>
    <xmx:SjuBZ6rlmadxp5H29mOfG1qD7SxLaOe7i9-ssUSXHmgf-H5L-2YeXA>
    <xmx:SjuBZ7QhfEbILcjs7ubAxMtafcx7eSu3-dpnu8bO-pq_yEwaxbG0bA>
    <xmx:SjuBZyqjryVUyoj50cx8-NkQfO_uw5-akMuD4wttK1xXC00McSCOvQ>
    <xmx:SjuBZ7cBU2-ZR0XlTJABCJWkL2Zx42ME4oYCpY8DkhW9hhE_zhYVHbJl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 10:22:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,
  karthik.188@gmail.com
Subject: Re: [PATCH v2 1/2] rev-list: add --missing-info to print missing
 object path
In-Reply-To: <CAP8UFD2Cfriv4puPe8agaTZOpLHr-=4CkK-yrzw8fH-k5mPkAA@mail.gmail.com>
	(Christian Couder's message of "Fri, 10 Jan 2025 09:47:08 +0100")
References: <20250108034012.211043-1-jltobler@gmail.com>
	<20250110053417.2602109-3-jltobler@gmail.com>
	<CAP8UFD2Cfriv4puPe8agaTZOpLHr-=4CkK-yrzw8fH-k5mPkAA@mail.gmail.com>
Date: Fri, 10 Jan 2025 07:22:48 -0800
Message-ID: <xmqqtta68zhz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Jan 10, 2025 at 6:38 AM Justin Tobler <jltobler@gmail.com> wrote:
>
>> +--missing-info::
>> +       Only useful with `--missing=print`; prints any additional information
>> +       about the missing object inferred from its containing object. The
>> +       information is all printed on the same line with the missing object ID
>> +       in the form: `?<oid> [<token>=<value>]...`. Additional attributes are
>> +       each separated by a SP.
>
> Nit: I'd rather say "The `<token>=<value>` pairs containing additional
> information are separated from each other by a SP." to avoid
> introducing "attributes" which might not be very clear.

Excellent.

>> Any value containing a SP or special character
>> +       is enclosed in double-quotes in the C style as needed. Each
>> +       `<token>=<value>` may be one of the following:
>
> It might be a bit better to decide for each token-value pair how the
> value is encoded, instead of deciding in advance for all of them.

I strongly advise against it.

Declaring the syntax we will use for forseeable future for new
attributes upfront would allow the receiving end, the scripts that
interpret our output, to be written in a futureproof way.

An alternative is "value is encoded in token specific fashion, but
one thing that is common across these future encodings is that SP or
LF contained in value will be represented in such a way that the
resulting encoded value will not have either of these two
problematic bytes".

>> +       if (entry->path && *entry->path) {
>> +               strbuf_addstr(&sb, " path=");
>> +
>> +               if (quote_c_style(entry->path, NULL, NULL, 0))
>> +                       quote_c_style(entry->path, &sb, NULL, 0);
>> +               else if (strchr(entry->path, ' '))
>> +                       strbuf_addf(&sb, "\"%s\"", entry->path);
>> +               else
>> +                       strbuf_addstr(&sb, entry->path);
>
> I think the above code paragraph could be simplified to just:
>
>             quote_c_style(entry->path, &sb, NULL, 0);

Hmph, you two may be both wrong ;-)  It is unfortunate that you
cannot easily configure what is considered "must be quoted" bytes
per invocation of the quote_c_style() function.  Most problematic
is that in the cq_lookup[] table, SP and "!" are treated the same
way, i.e., <a b c> does not need to be quoted.  This comes from the
fact that quote_c_style() was written for the sole purpose of
showing the pathnames on the header lines of "git diff" output.

We may be able to (ab)use quote_path() with QUOTE_PATH_QUOTE_SP
bit set for this purpose, though, to work around the above.

cq_must_quote() also is affected by core.quotepath, which is not a
desirable feature here---we want our machine readable program output
stable regardless of end-user preference.

By the way, perhaps we should propose to make the default value for
core.quotepath to "no" at Git 3.0 boundary?

Thanks.
