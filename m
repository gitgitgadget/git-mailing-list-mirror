Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F00C205511
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110544; cv=none; b=hAW/Ef7kp4RFqRzLWQUCn6rIASDn/DweWbgcwoBqqSYKDawO6zlzleQsB+54EIFVQrB07r1g0tMqPkySAlNvpHpflu3fEZfEnWypFAt9Y3R+9sA3Sj1EQaW+M21TJnJPq83M2A8VBfHuUJhtRsIrbA1Xhc/hoYR2DgfHprgKndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110544; c=relaxed/simple;
	bh=6+Si7m3ReEDKA1i6ji0r+9NTWhkJta+XKvxeT0LuDbw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IkdXOu6gUVV9Z192ZoMG2ajzNqPTRglsMm7R5JAL0d9drYdVYBFml2vQmo6iScs21Qtpmu+Lkp65tIEZFFb1QfX8g2dhtxyDOd8dmLOaytuTIt2TFTeSEY4ncxa/FwJdjLz1sywFNZOHz8yHoQhif4OhatSNtPN12qdhg38XaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oqFtK5rC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QVNSukZy; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oqFtK5rC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QVNSukZy"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2FF9F114022F;
	Tue,  4 Mar 2025 12:49:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 04 Mar 2025 12:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741110542;
	 x=1741196942; bh=/SoMy2s4Q923k2lhVUKFAh4MSKtXMavMdBWSs+bOaZ0=; b=
	oqFtK5rCtnLcT20jhyrZFoJAejyndf4tRyUdMIzDERw/vXxE0WvgX5QEDHhIb/h5
	0dSOmCowWfhgpjxde6Fx5pfTsREh/G+Hv/kDqVjg+CTkfd39eSbj0oww2tME9d81
	46axWKtymJqz4GEndqq4JedMjq1yDoyX+ZBIfu9AGDYWMN6L9qd/+RJHu+M3tEjP
	5EPDhRXjzXnxwUg2mdEpfysxKQtNi/cY2EOff86XX979GzNOS29icqLj1YrVGCzT
	ydsdMAD4dyDhTTwVxMYuztvXs8WA3r0/9EXH66H5Rh73DOsC/XOV4XlEbkqAjM+W
	MGHMxNMN5Y32QvXNsPUeZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741110542; x=
	1741196942; bh=/SoMy2s4Q923k2lhVUKFAh4MSKtXMavMdBWSs+bOaZ0=; b=Q
	VNSukZyLD4O30JZlqLyQ5j/0UEkebUVv+hXHxvYt4YH6VDAlAkSKf/BmlNE3LMHx
	ndajsJEPjDdV5QX5slRVbspImNqbjp6eeoX7pY2P87bxr5ZGwEYCFsfyV9nPnEy8
	zACevT2lh+ObrSw1cGhU0cnrbwIxVkNLmTVUD1y2GcaUjpN8dVhmeNCyKFvD3xp4
	Kraq3sbSaoRSpCfXYFRPqyDQ1uyLzCi4Cd6pLpL7ZtwgC7XiHTlOSWqByRSHLyO7
	Yn9VC8EdeGdMHpemVPSq1VOS+hnqGGDgsTjsG57ljtm+0v3UPRSXgO/QX926LPBf
	FG51kjW+yowE/nZ5Z+Hug==
X-ME-Sender: <xms:DT3HZ2Mi8vBfqp4qMqQSRBra2YfhOpXIRimak9SmkI6eaGdN5Ncdlg>
    <xme:DT3HZ0-yN_etChhnN66PfqWm1ywj8lvfTbrrmo3CHNhmkUZ_UKwJsZDx48ssx5Sjo
    exonVvj23suZDbz3g>
X-ME-Received: <xmr:DT3HZ9Q9HieBd30ApKlq5jDsvSKO-e4asInTX2DlQIPxpIPDP7gOyITTyWxkSVGyoINbDo2AHedmUIrOB9zOkztDqxmn-9AhT92C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepuggrnhhimhgrhhgvnhgu
    rhgrtdeltdegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DT3HZ2s3wO_3OhKNht1HvHEhSmc-fdLAz55mpunyuXl2QGk8t9UEgA>
    <xmx:DT3HZ-d-ieOMqvYtdQ_hJwv0DsWXFfCKhyJzVS2m-PXBhObe0L5euQ>
    <xmx:DT3HZ60uaTnCSrxEgLSlVzcJ0SBKbOTJTmj0fjghO3fZl-d3BTe_Dg>
    <xmx:DT3HZy_f0XHiwSp417sV9WUs4Ptu9Yjdo6zNdJFrq4b-S4hR84Z1wg>
    <xmx:Dj3HZ7H80JHg8ar-xgTvsL3nhVq9bdiM1Hp7CdxsxlQhscbsIikYGnGZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 12:49:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Mahendra Dani <danimahendra0904@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 1/1] t1403: prefer test_path_exists helper function
In-Reply-To: <CAPig+cQ275qBWzaYmMXydiA_8+CTx3FhAAY+o8ro+hD03wzu0g@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 4 Mar 2025 12:35:43 -0500")
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
	<20250301105838.1481-2-danimahendra0904@gmail.com>
	<Z8WD2MeHpOH7Ni8A@pks.im>
	<CABGrwBB1-UiiPEOptN9csVP1WYg2X=SWeMxxiyDfz02VmDp1vA@mail.gmail.com>
	<xmqqldtlt304.fsf@gitster.g>
	<CAPig+cQ275qBWzaYmMXydiA_8+CTx3FhAAY+o8ro+hD03wzu0g@mail.gmail.com>
Date: Tue, 04 Mar 2025 09:49:00 -0800
Message-ID: <xmqqcyewr8j7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Mar 4, 2025 at 7:05 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Mahendra Dani <danimahendra0904@gmail.com> writes:
>> >> >       remove_object() {
>> >> >               file=$(sha1_file "$*") &&
>> >> > -             test -e "$file" &&
>> >> > +             test_path_exists "$file" &&
>> >> >               rm -f "$file"
>> >> >       } &&
> That's a good question to ask, but isn't the implied suggestion of
> dropping "-f" going in the wrong direction? If I'm reading
> remove_object() correctly, `test -e` is being used as control flow,
> *not* as an assertion that the file exists.

If sha1_file says the loose object must be at path $file, and the
call to test -e "$file" returns false, two things happen in this
function:

 (1) control stops and "rm -f" does not trigger
 (2) the function returns non-zero status to the caller

If you omit the check and say rm "$file" instead, under the same
scenario, (1) "rm" is attempted, but there is nothing to remove so
the command returns non-zero status, and (2) the function returns
that non-zero status to the caller

If the file does exist, both will remove the file, and give the
caller zero status return.

So?
