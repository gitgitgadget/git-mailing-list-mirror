Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFBF38384
	for <git@vger.kernel.org>; Thu,  8 May 2025 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728559; cv=none; b=qyYE7aAfK42E1+O30u0/acfjYo6hSm05tsIOakpeBAHYerG1g5rZuYAS2MLcpHB6nF2cp4TPVbXUYv53eoMkkp4D0dv63mEWRKhtSQkwvcFzt/IxdLqgpSnLUIRTDNBNW5ThTgqu+EEQB3cgFrUIQa6BNvQDKaqFRXtJ3uFQaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728559; c=relaxed/simple;
	bh=ZgAArNrXozbZy567nZMnMW0WAJepcykiZ7hwbc8vUKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sZwv+yItmDhOGNJ6Yh3bgrtmkre72NWuuBDCw10yM8RfqTpLk7kbFpa+vX4txAEiJJua9Y912h0IYgsTi/Zi8bf0FrV0jfd2p5P5C0PJzbj3Y3FBVO4z+Mo/XOd1hyYHEMF6F2VchBtBvmmYNr2rFWV/WlSWUSdM4bluIIAM52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DGmwzl2J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rIhMNThB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DGmwzl2J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rIhMNThB"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3A64511400F8;
	Thu,  8 May 2025 14:22:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 08 May 2025 14:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746728556;
	 x=1746814956; bh=3zYsiYOiQ0a5P4SLkIIbCuUvRZVfeMbJoU0nBGeCoy0=; b=
	DGmwzl2JO7pCVjsTh91INR+QRu9vyCsWwDaJSu+xhylMJKzt0xELHfPAolwVbj1R
	S7EqR8rEq8qnCjBTuHJWjnivy3JnHYZ0iqYIZWQvlAVcGzeC1d0SDquHsKJD8wkL
	11W/pVasikztjYQ3YvdYY7fqENDHdbaerohXGzDxeKtzkK7pu6/8k+b76EsAVVDH
	h8YYXigabnf5meeZaMoFMfSc7gAO/DcOtHSCnpmr0cJU2O1NH1u2eGq3SVnwDSRf
	MdlwQmaYVP/TJ6VP1mcckDt3bFMWGvpFlHRq0AlW0hjKtnjQijtVbV7In1QokUQU
	KX5eECPKLXw/6qli9UZn5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746728556; x=
	1746814956; bh=3zYsiYOiQ0a5P4SLkIIbCuUvRZVfeMbJoU0nBGeCoy0=; b=r
	IhMNThBFyubYu0B1YlIwZj8DWM0jFZB9SATPr+UQ3KKtcBAGXfGxCiJk1xqZdYcT
	KTQ13JZ6u3rRrAVUi+6iIXhDNvZVWacJotmq7DirNm23AtiOK/526ZC8g5mujFgL
	MKtPcS81g7/kcCMPXHtLxSg/kZrh/RG8tO9pc38Q6x3NGVgIbaCT1nBb+uuLm+Jo
	F8ZNFSM/TAYtw5kg+19jPlptYb/YBzBjrC7GHEYHhYsXkHVZQwFWmIF1NtDgrMNP
	7igNRlmxRhpsi/QqOHU4+RZHpCCnpoof6KNdHl9huP9z3DGFAS0ELF94lmTZ1ODW
	U4aEATt9D5AzopRNo+uFg==
X-ME-Sender: <xms:a_YcaJoDT6mqK8RQ3Pt_dZ7TRFzFCzKezDixsLzzuxdAio3jWtWlEQ>
    <xme:a_YcaLoAzzm42IA5ofPQvkvoBJXLDMO7zzKIWriMdWQAj-q08Z59Ur_EH6Bl0C2eu
    GHkO-fyUpazg5_cGQ>
X-ME-Received: <xmr:a_YcaGPDooayW-qBihHE04unGTzsbLwgxDM3vKJaNG8agyybtjh_WBRhAQwQ9sJsYNBxM7HHQxM4WWTZlbY29rL6v6WmVRRiJt-r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdp
    rhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:a_YcaE6P_8xRW2bQV49nM3VxmtpwKWxpZDD_VDfpfO-p-Royp3UJcQ>
    <xmx:a_YcaI7cu98RXwCp9RoWNGxtS5dcFluqx7y3ctLhbB7SJrzkOI_ujQ>
    <xmx:a_YcaMgY8wLnCbbnrdWsSmXSwx4AertSuIMetez7wqzeAKpa39b5FA>
    <xmx:a_YcaK7OwmQsL_RL7Y2Ci2KAaSu46ykhtEpVSdLUN6Kct-f4SuqO3Q>
    <xmx:bPYcaPjD1bAQOJS9j-Y-zed-_BHa91qRkDQMzLW6G-fI1Z7pCybH_0WL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 14:22:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Christian Couder
 <christian.couder@gmail.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2025, #02; Mon, 5)
In-Reply-To: <aBsTFdAX4pqJU6Nn@pks.im> (Patrick Steinhardt's message of "Wed,
	7 May 2025 10:00:21 +0200")
References: <xmqqcycmlelr.fsf@gitster.g>
	<CAP8UFD3=SJp29+QaUZvqWhjx_53P9tOE05j9TgP-sEvNRZW-oA@mail.gmail.com>
	<CAPig+cTnxJ+ff2jygfsuigQbSa9QMdA1dWN+Wp4xXJQRXOvwOA@mail.gmail.com>
	<aBsTFdAX4pqJU6Nn@pks.im>
Date: Thu, 08 May 2025 11:22:34 -0700
Message-ID: <xmqqikmb55ed.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, May 06, 2025 at 01:50:09PM -0400, Eric Sunshine wrote:
>> On Tue, May 6, 2025 at 4:35 AM Christian Couder
>> >
>> > I am reviewing this series and it seems to me that it's possibly
>> > missing a fix for a leak that Eric Sunshine had found in a previous
>> > review round.
>> 
>> In addition to the leak[1], I also have reservations[2] about the
>> "worktree: expose function to retrieve worktree names" patch.
>
> I've addressed both of these now in v5 of this patch series. Thanks!

I guess now all of the above is cleared in the updated iteration.

Thanks, all.  
