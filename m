Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D4C35C69D
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974459; cv=none; b=lapPVkU+yT4ybSVNOVp4Wt1h0zlTQ77JxX0Plnl1MXbjlFHZye9n0F7syYjRJoskGwG463U2pKq9fB1MJ6f87sw6f39OZGa0iaaqKMxS9Ozk8Y5IvrHVn35HmsMfK9G7Qircf9XWhxvPkrDMaL//AT0EtqXtjz99n1KqH6Qb+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974459; c=relaxed/simple;
	bh=KG4g1/j3yxUKJ0DIQRBVvbSAXLlnwhKNPQSV16Ts8Ng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kcu6MJAhrGbt1LgJnHGfrPRYVajP5xAJKvaAMAJB74XswmTAwyPetd2quVprjxxrmzVV+VpXuwMlgl7yJ2/gLiILQEz3FeI/7ztrzxKq7EYD+8qXaYYGqX3UxuEtnWmI7MJgqOWdNc2kRdDejMMQYhNAKLXEH7PvN3WGImkd8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a5FC1yYe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V9jLaFt/; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a5FC1yYe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V9jLaFt/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2E395EC0223;
	Wed,  9 Sep 2026 13:20:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 09 Sep 2026 13:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788974457; x=1789060857; bh=tUc5uq+Rwf
	MQcBZKJkpA+rU86gLEykgUWjzMr2GRRis=; b=a5FC1yYenkChK63MmQFXiDSw8a
	OcF2KVXKGlDbA+u7B2jhduA/xg6EcG4FML1RtYVrHLJbw10NySWzB1Vprc9d+8Mi
	1qJn1OO39qizVuBkcm66r9cHc1lou2mCTYlV+8EzTnHY8peh0mZrWr51YsLPGjAz
	rsh9com+e7gzPfzXHEUNQvQoWFUKLVr5gBh0i32SLyPhtY2IRaXMYq/HnM/VUmH8
	kxtoCWwGURaw2u39e8QkZ+pTOs9g7w86yD4sqP0/wAyLfoyguIv4EKrEsWv58EVq
	A+KxrZz5SkcBcTd/eDE4LsO9HF1F5NK/Pq185Ajd5J1hkPsUqYyNWCzSNxLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788974457; x=1789060857; bh=tUc5uq+RwfMQcBZKJkpA+rU86gLEykgUWjz
	Mr2GRRis=; b=V9jLaFt/KMtiUxne9mkdmsfVrJ13Jil8SbvBNIdEqKfKmiakpbs
	poG1ApDT9wsMC3b0H4ALUo8SJCwG+h5LUlMcsZNyNS6i3p/QRwARZHvHCSDc48Pc
	t2VTS7YgRa5Xa2gn1qFkOISXqPi/KKaltnK4rLwR6XhlwbdXnaJ5q5kd6FCoZluB
	2eZO4TZm+ar9CQznYIqJEqoS5bcPZRPuE7dlt3J2VPPUuBAOAlbjE4i7qyc2uhp7
	QaskY2Ki4bdglpqrl+bzhgT08vMisawnali/RmHq7BsBiw4v2MQ4qei68M4Euzu8
	WkDTv39ZNjyOsAsStIdDxrupotJSPJ5P4fg==
X-ME-Sender: <xms:eJWhapLC-nNPUUs9vd-_li2FCo_FL0oQRw9zqkziBFJXlKU9ooWOVQ>
    <xme:eJWhal1y2zV4vTjQd4zhPYLwVGNCCNy0-TeWTJth3DNJ7Rm4l82j_K_0k73Xx6wbl
    UoYFAMifFQb7rcEaBQCp8l_cAw-ZRIcrSOypkcqQd0IZZu8pJUewBg>
X-ME-Received: <xmr:eJWhav4ToHKoSbYn6RCdw78UoiJF4IYNCBpyJEOPwcevU7CDY6YY2ua409_q-h8tvjuUaN87m22pVVAzzpFtKjcVDVrH-bHd2w2B>
X-ME-Proxy-Cause: dmFkZTE5GTlbSt3FTnAgCL164pon7nlhZReFB1mx4kJatuFphkM0xkmEHq49wrMDGwdVKh
    7JCuFxpq7u5YB1vBAgIJvU+k4wOdjlav+MYAk2tczagnNb4J80F7B+OZdlZIO8xPV8A4rG
    uKCt8QuPMxiQGZTwpaouFRH1LXl0AfQfEFt9iHpUicKhP4Zao//SbAOVjqNexZXjFuStGv
    Rlp+3F4Z0ZR5sLTMnxstWwvyjzt4LLONj2RM4z+tErTgVVigaPN3yWsLxlWbZTeA2Vgpyl
    Vw9FNZ6lnhqjm0+y7ywckU3BO+fhOqf/R6Hh/eguzaPKjDmh5oUgO8lD8VtG5bl/gzdHoC
    1ACPT2rxbnOGnIt4SnD1PT866h2osTPG8+hZ04No/+J+hYTtZroOcIUe9/FaNmY/YatM+m
    TJ6iLVWGBcGdyQotttRg6u6Y9+vC/ZyRE4HJjDIu8t1LGEFw8iLoD1gsz7duiZ+HYwaJwg
    bLd8WKW0Rg3udPLBlfD4P36XyoiEOdToiFAATsckfi3SwtYaGzTHFAIs+AADWYtGC49T0o
    75nREJiUGjVOf/Pbwn8TOf7pia0sNYwKnOABwLJcTHMDJdMLfY8NfTw/51akdW1R1eYrB1
    8NHiBjD3ZezPVNQT8jcDDF/PCZPkf7aJtYeSk8eegLiDCYq8+Bm7rxOBFR5w
X-ME-Proxy: <xmx:eJWhau8WlKTNAassetlF6wW20jVlyZkINXaQyEcwi_Lo-1uzU4B1Bw>
    <xmx:eJWhamXZ1vmwUW9MdloFfuEF4UB9e7QMEFyYynsvUxlRng4hBm27Ow>
    <xmx:eJWhahpJUPWjMTAzdfXL3k-PGjz-C3Lq4ga4GkgYmaY_CulpvrMt-w>
    <xmx:eJWhagk6YRj1KQGgDrJf3dke4daOskCQvatzA7HHTiOvXJTHsmljdg>
    <xmx:eZWhaiH_Vqup-QtOVZDb6_5yqy_ochLf8Tvb4DTzfX-e8mXwdCPeqKyn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 13:20:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com,  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v9 0/4] hook: introduce the receive-report hook
In-Reply-To: <aqF0mbWgYU5rMR-f@pks.im> (Patrick Steinhardt's message of "Wed,
	9 Sep 2026 17:00:41 +0200")
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
	<20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
	<aqF0mbWgYU5rMR-f@pks.im>
Date: Wed, 09 Sep 2026 10:20:54 -0700
Message-ID: <xmqqh5jys5mx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Sep 09, 2026 at 04:51:35PM +0200, Karthik Nayak wrote:
>> Changes in v9:
>> - Fix a bug where we were causing a BUG() when no report was requested.
>>   It is perfectly valid for clients to skip the report and we shouldn't
>>   fail when they do so. Thanks Junio!
>
> It's curious that nothing has failed because of this. Are we lacking
> tests here?

The "send-pack" client we have will ask for report if the server
side advertises report-status or report-status-v2 capabilities, and
there is no way to disable it nor there is no practical need to give
a way to do so, so unless we are willing to write a custom client,
or a configuration to disable server capability advertisement, such
a test is a bit impractical to write.


