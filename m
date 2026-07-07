Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1690B2DEA93
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452351; cv=none; b=P2U7lm5ZcEvxHN3sd6hVq1v+rCrTc2xvUdcwufubdsdwMbc7GMSgZzhlq9G3X6E++aIcwvaUtBX78Svlsz4D1Texp9nOWcwmG/PYrL0Pwofs5x9B5yYgotS917mf+vFMrLAkZPj/Ae4COJsEuf5F2IE4r7rWX8LB0wYVEZWXW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452351; c=relaxed/simple;
	bh=+ZR/A+xZToQcatjo77ekdDoHDB0neryF1aCpOqyUmFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n6pRvHulvQZWyTV4Mjmmrs3L0qibkUZ+gkBOrg0F9ZvqBhfVXB7n2VMLXUf4oAOJ6CqmYR5ZSnx1eJ6J1TwTCGylHFcv0UB2vm5cv74dG+4NDfs1JhChn8zla0fIXSOcuYHg6tAiZ+T0sasgX1xbJzARpxVo6pCKc1cBLtDOF/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mMjRyhtw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bq5P/RnU; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mMjRyhtw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bq5P/RnU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 593FE140014D;
	Tue,  7 Jul 2026 15:25:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jul 2026 15:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783452349; x=1783538749; bh=OU+GRHEW4u
	iJlPwkJ9hi6dTmFHaJeoq1cFkh/20F57M=; b=mMjRyhtwO+Ed0FOoJm9E9orcIF
	aROpJyCzSZ3veCof/r1WVTD2BU4d7McGHhqeAKB+6YDHIl7DW3N7dqm+0Jh2mrmf
	T6ZDFykZcYHxF7ySVVvhaJabKDYqdSI/Iv8I7thffvBcgAHcH7gjpq2y2WLsyokm
	MkH1/BXjKNgY1p6KggcDIad8adz947rseDFdDMHSft5N/DgU5057XX8J9JX3DmLI
	GCgr94fnwHa8nsU2B+kSyLn6fHaa15Hn2UIrT5opsWT8qoXmwBkyGEkx0ElHa93k
	VGme0thmblWQsTbFZy5DmBKdY/0ZVaRUG8fhSpDm5cU8jFxOedJPrjumyJug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783452349; x=1783538749; bh=OU+GRHEW4uiJlPwkJ9hi6dTmFHaJeoq1cFk
	h/20F57M=; b=Bq5P/RnUh4HWIMQ3GE0F+mKelLv5LGK9Gmntrrgf0MG0tCREK/X
	AUeMwhJYsLLRTb2Y1Ui/FQFxDvmuha37fq+aoWnQ0brnFKBo/Kpy2UXYYO16v6f2
	nTuYo183aw+Lg/AQNVj7jVy+AGFStKZI2lRdCnZCwRAHraGWB7p6F2629MSuDvx7
	5DkONkHsZlY2Qd0XxBv8qGawbdn419CUcWUsJzdV6jwpNJjvagVDcb/eKKUaRN0c
	qXYqPv6WWYfLEZHfLpvGsXCY+SIFDyjVkUsG9uEomTjWqcpKpWo+G/uLFokwFUSI
	ZHpVrzQSxWXqhybiLgNd8WmIbdH/yGX+ahw==
X-ME-Sender: <xms:vVJNal4A4mFlhOOjfcY-nfa7TtPh2W-r0FKZxqfzGK9-EOz9yZpMMg>
    <xme:vVJNauYuSTeQmALocIWT2dgjhtFMfjnuJoSXZ-sWNof6WKC1SKijoB8e5ZceciJ7G
    Ky4yPqGGbgMI4WHxmUmxBNGNZp8Qewo670c58owRr3XKT2Du55x>
X-ME-Received: <xmr:vVJNai7G9H-KuBQwTVKdZrZzFsKYxTqU0tkLy9BPysKVBSjXU1Lmvec9_qri2NoRxchCZzOeEEzD-Eu0kxhB80d6mgHaBd1a5ut8PUM>
X-ME-Proxy-Cause: dmFkZTFcmUrMzV6O4tDKbWwRkxqn618Ah/BQPAYl1jKqz1WrlFErb/dVmvEmd5WPcmiMAT
    Z0HRfUj+HSXbJnMhqtPXTTyu5TAMQirYwHDWAXqNoLlcENacgzjj1BMvefXKDxvBBb0QBO
    oAK7xF2Kc9CF7I22k8fc6x/A6g4h1+2LE8gBwsFkAMkMDYVivkuTVWt79E8xp2Df58u7N3
    2YeCqHtZd2iP1UkiP8Qku193qHLx7jUbRIp1YtVe1/MnZy3NYamn5tadUrQRfAjbmPDv3T
    +ykzh51iCqi+RVL0rNZ343Zw3a4nvBoJEzAjFuM5s1oYAZtJZP3sRzFBiEFoUAnaco+/hL
    4nWKKVhfhsSdB87uiRhNv5lWT7cSnWxQ1B2yw0ws7pZWGluVqzva8O1MQQI1Edq4ePBhOf
    4p70AQ4KbRvP85diuKaBEvjJpfBB73lEQ7jU8m+uHQ7GETTdZ0RAHBbFwygoIK+HzSaIqG
    uWl+pxy83gSZKG4Hgk7km226Io7aJnDRy+u6oSSOIVOfmQlAq2jEApbyEbrEF5gU2MiaqW
    hOv+uXHff96aHm7h8UyxVd42tKyzWYdbkBRF61d5631nRjSmCZzPsve1aD81Ewr+wrPaAp
    DeR996bejRhnRwu5rwLhCeURhvr6i7upFJjs5dYiAP+Zko9iScHYsxrRqrkg
X-ME-Proxy: <xmx:vVJNapBywzAw4K6Pvr-93BErLYcrllHg7vypnbCyuWfq2XvFcl3W8A>
    <xmx:vVJNageB4dzmR_xSF8d28WAFRlNE4z0ArArsx20HbeSr5b9hfBO0Sg>
    <xmx:vVJNagKCnQCryE2bc8wqJx_7Yf801rS5p-oy0w3q_sN-yw-c-NFo8g>
    <xmx:vVJNaj1oJ1MPlkw1NM4n32ZBSS_jvGFoHLgvZ5FM5ImvjCEaPwGpCQ>
    <xmx:vVJNagfpoeHFPOGIP90HMUDOq06IThY0ZbYf8tDemlpfMA2cL42Q5tEl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 15:25:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,
  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/12] coverity: fix leaks and error paths
In-Reply-To: <ak0hj9em1agVr4rj@pks.im> (Patrick Steinhardt's message of "Tue,
	7 Jul 2026 17:55:59 +0200")
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
	<pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
	<ak0hj9em1agVr4rj@pks.im>
Date: Tue, 07 Jul 2026 12:25:47 -0700
Message-ID: <xmqqa4s238lg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Jul 05, 2026 at 08:24:17AM +0000, Johannes Schindelin via GitGitGadget wrote:
>> I wanted to whittle down the many issues reported by Coverity in the Git for
>> Windows project. Turns out: The vast majority of the issues are false
>> positives. Most of the remaining issues are in core Git proper.
>> 
>> This effort was forced on pause while Coverity was down from May 16
>> [https://web.archive.org/web/20260516152422/https://scan.coverity.com/] to
>> June 22
>> [https://web.archive.org/web/20260622182153/https://scan.coverity.com/]).
>> 
>> Here is a first batch of fixes for those issues.
>> 
>> Changes since v1:
>> 
>>  * Edited the commit messages to put function names in backticks, and
>>    reflowed the messages afterwards.
>>  * Took Junio's suggestion to avoid (ab-)using errno to determine the return
>>    value of load_one_loose_object_map().
>>  * Dropped the obsolete patch "run_diff_files: avoid memory leak".
>>  * Rewrote the commit message of "dir: free allocations on parse-error paths
>>    in read_one_dir()" to clarify ownership of the allocated untracked/dirs
>>    buffers.
>>  * Changed "submodule: fix cwd leak in get_superproject_working_tree()" to
>>    reduce the cognitive load on the reader (i.e. to make it a lot easier to
>>    reason about the correctness of the patch).
>
> Thanks. The reflow of the commit messages made the range-diff somewhat
> hard to read, but from all I could see the changes all make sense.

Yup, this round looks good to me, too.  Thanks, both.

