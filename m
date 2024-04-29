Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B75D81745
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406964; cv=none; b=b0RyGzbM5yo03vKgY7O523JSvuyODdmt0/Zyg8gsMmLQwJrijpnUxxHvZvOAVWfRUOBG2PAshw2T6+RlAwLZic2hycRXOEbqCcXgle6xIudq44KXTW4mmNv27DhZUD8ytXfWBDcHB5NHVP7kV2Yr8kk7czAoP4DU1AexgzgbTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406964; c=relaxed/simple;
	bh=MMvWPodLLcxTNaXgX55vujCkOh5E4fgqsdIPgl4NS6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sp4YEPuOzKEkf1b0X/h7woiJNq4dCD0fmW8YdJAEd9/djSCY8mKfGeDgBn/SR4prLCQ1MjorLAC6zafA/zY+xVLMBZDEWwRJSTmTDNVfe7EXLG+tE0Tr3z77MIMGd31zqLTj2j1pbWFCxMJCsEoX77uodXKxd7i7OM2FmNko2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NYjwR4NF; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NYjwR4NF"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A01433E5BD;
	Mon, 29 Apr 2024 12:09:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MMvWPodLLcxTNaXgX55vujCkOh5E4fgqsdIPgl
	4NS6g=; b=NYjwR4NF1uAn0Q1a6gy0oLLvW309/iJsGFQJ0AntfzrVsn2CzoTEkE
	wFHedZP/VL4iKtEpIi1uJGOys4KnWBYCOVbyYZWpCl2YxVfwt8C605URRnnkT/BL
	1zKTKowRMSB/l1iIBV0iEdi7tnz72VHtekoRIrvQdTJWcBAVbfBZg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 976493E5BC;
	Mon, 29 Apr 2024 12:09:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AAB703E5BA;
	Mon, 29 Apr 2024 12:09:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v4] add-patch: response to unknown command
In-Reply-To: <33bb69ad-ec79-4863-97b7-51605b94c9c5@gmail.com> (Phillip Wood's
	message of "Mon, 29 Apr 2024 10:48:13 +0100")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
	<db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
	<b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
	<xmqqv849xups.fsf@gitster.g>
	<41d23496-0bd3-47c7-a470-39334588f520@gmail.com>
	<xmqqfrva22py.fsf@gitster.g>
	<33bb69ad-ec79-4863-97b7-51605b94c9c5@gmail.com>
Date: Mon, 29 Apr 2024 09:09:09 -0700
Message-ID: <xmqqttjkxiai.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D114595A-0642-11EF-B92E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> There is also a practical argument against using "git diff" to
> generate the expected output as it only works if the diff contains a
> single hunk. If the diff contains more than one hunk "add -p" displays
> them separately.

True, but spliting the output from "git diff" at @@ hunk boundary
lines would allow you to hardcode the assumption that "add -p" shows
each hunk exactly as "git diff" would.  So if we really wanted to
have the convenience that the tests' expectation automatically
follow what "git diff" of the day happens to produce, it is still a
viable approach to use "git diff" output with some post-processing.

Thanks.





