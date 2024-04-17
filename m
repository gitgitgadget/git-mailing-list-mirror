Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF93717F7
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336187; cv=none; b=mtc2dw4y2dHlw2JNa4GXN9okJmMoUAo6volibCxVsAKXrx94SwEkfgqTM+sc1aOEz3GXltCmNTIhP4DuTj9dfi5bCFlDeT3Q4zSycOWDk844xZXcbPSK8HA0TabDVcN7lGWnM69DyAMJz+1TFlB3ptkzVXdKdTGrC2gKPfxEzKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336187; c=relaxed/simple;
	bh=knVITYSh4SA9vKmZC2pCfp19OQQFbvHfw3SQMejoD2Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PWfPMV9mgREUQk7t6sZjNavH3GIkiyf8iS8CaaMoyl8TzbdF7Sk9qZ1NQu2yciOWL+Pa4G/Q67pjPkPTMotgFEG4gpGaaWXBkYKpk9Ztk6/07mvNaOIt655S1Tj04XXeQyhGrYxiKG255neX/98JLBxigmdI+3CwkFoAvxFr+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rFjtfiww; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rFjtfiww"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713336184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pm4z6qqxz07mRR/dOrYF6Q5FO9kCZaSIVVDZp7nMMOU=;
	b=rFjtfiwwfIG8oREYT+Qu5u9Z68j77zWAgHZfYPh5C076e9ak7t7IBYgjPATcuAoVr0gKhg
	pBl7u2lvUpMH3Ry6UB/GEo7FiUZoXNwEhBMQM8iVaSx0bcvCRWHIpeM/fMQ26wbjB3WC3e
	sIaq9+m8P7xCWDp7tpGHocKriWPMigHPo5oDGHcHDCs6ietcUm3hUlG28e0uxocEa+/gMO
	FBFKhh8PdDkKYir4m3xsYoKM9mio6AaLfsdEeSQTnh33g8NNp+M5LGmgtWZN2Kux5dOJgn
	QvgXxgxYSD9Oicn42Qeln+AziQDeeZD4U/2EP5vpH2ZDOEJYAIhUBfTxizdpTw==
Date: Wed, 17 Apr 2024 08:43:03 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] format-patch: fix an option coexistence bug and add
 new --resend option
In-Reply-To: <CAPig+cRzCSO_4r02Vc-OpH3Cyz0iTWv+q4oTRg30H5Qvzz=X7g@mail.gmail.com>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <CAPig+cRkrMDkQKnwaTGY4djwgC6mGqngB-4HfGQm1TNCq4Q4+w@mail.gmail.com>
 <36c4a1e23653c2844a52fd994501287d@manjaro.org>
 <CAPig+cRzCSO_4r02Vc-OpH3Cyz0iTWv+q4oTRg30H5Qvzz=X7g@mail.gmail.com>
Message-ID: <b7568429acad91ff2d9a1574111441a3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-17 08:23, Eric Sunshine wrote:
> On Wed, Apr 17, 2024 at 2:07 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-04-17 08:02, Eric Sunshine wrote:
>> > [*] For instance, my knee-jerk reaction is that we don't want to keep
>> > piling on these special-case flags each time someone wants their new
>> > favorite word as a lead-in to "PATCH". In addition to --rfc, and
>> > --resend, the next person might want --rfd or --tbd, etc. More
>> > palatable would be a general-purpose option which lets you specify the
>> > prefix which appears in front of "PATCH", but even that can be argued
>> > as unnecessary since we already have --subject-prefix.
>> 
>> Makes sense, but in that case accepting the --rfc option, back at the
>> time, was actually some kind of a mistake, if you agree.
> 
> Possibly. It does happen that, in retrospect, some changes come to be
> viewed as mistakes. On the other hand, if --rfc existed before
> --subject-prefix was introduced, then --rfc would just be historic
> accretion rather than a mistake. (I didn't check which option came
> first.)
> 
> At any rate, we probably want to be careful about piling on more
> special-cases without considering general-purpose solutions.

Yes, but the usability should also be taken into consideration.
IOW, perhaps typing just --rfc or --resend is rather quick and
usable, instead of having to use a general-purpose solution and
type much more, or instead of having to create an alias.
