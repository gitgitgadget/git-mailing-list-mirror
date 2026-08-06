Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968BC38B150
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037542; cv=none; b=MWI95JP0oWFz83byIVngK6rjUv2N3SMQ0+11AG5LR2X2BQjq9/buj+lO7mFtKbGA8x3Kw+Pg8XAcrYzADv2r+4WCLTla6MMUIfVczG6dGg01UUrRyoyM38S+3selFH71ftBitGck0G9zVPYep77Iuk8ZpozdalH8+TY3Mi8vqsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037542; c=relaxed/simple;
	bh=NzBC2zlJ1dKeby4MQRWk2VcAGcBP4e6IT6RYVwGxhuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iLzf2ZhBt7DSYPEgsmzDVIFEaF/VlIniEFUjXKD1TP/hsfT1gvX5h0VXRNOocpMWQ3s1qx2pwdIyQMLcRTw+BowyO5qyHjmDMpA2jHXs8/+yDMgm2JuIfl3ObCbdsnxluYqIuLbK9p0EDwNldFW6ByFoDF8azTS1Sp5vQxVdCfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pj77JVoe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y4SL6D3q; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pj77JVoe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y4SL6D3q"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B5C1C7A00AC;
	Thu,  6 Aug 2026 13:32:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 06 Aug 2026 13:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786037540;
	 x=1786123940; bh=qVz0VPoNXtpZ7kMjnyN8e3rcNaYFIAthwkER9WakHts=; b=
	Pj77JVoe8WuLJNPkoe/7XFX/M8Lx80jdPnDxNI0Boh+84xocvHkjM0w+iTGGg0OP
	BlP6tBhXZD846MW/NlvxjX7POWD82nchCy82reLsdXfjBp7NHCDQhpqcHoz/lwe5
	U59SuZrZBDb5oR501xVG3zry/Bn4/wovwbOvu8Of5s+JVtQD5ulGffBQGwgzVbRO
	Sq7mkbn4aspXpSYpWxL7vtyxtpRB3AnY/a9pp0u1GEWKneSuQBx29rwy0e0A7D6L
	uU1/YB+S3C7DLci0moUaWOETvYTR932m2IcWFbPsJF1E3skmqf/OO/fg69HKeHjK
	33/k+crNcwqsTfmkVqYqCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786037540; x=
	1786123940; bh=qVz0VPoNXtpZ7kMjnyN8e3rcNaYFIAthwkER9WakHts=; b=Y
	4SL6D3qYrwvBHnlVCw0viUMevSAwCsir0Rz8VHAxB750uO7xHB+trBpZqQVl/Q97
	zoL0Z6Rw1lEM9YvpizhlT3xUA6j2gRfVKx5p7+WGc3NyAHxjwQYvmCwLU+NKwObD
	PZ7D+G7MZkkpL2g9tLjExX1qQ94JzxJ56MJqsTkxFVc52GNGs4CFn48ZKgWZ5eD3
	YikGOuReUy2F9twIpHFReC4XO0cY8verOEx6QXFtS3+spWkyedOvYzt85qOnRkk6
	B+6zMwNlHeM0A5JfCx9liRI37jpfvQAwCb1aGKTT9KazwxiQ1pOfvHdMv+Ok2O7n
	UoAkPNtM1hX8STn+STrFA==
X-ME-Sender: <xms:JMV0arWyYvivBiIa29jERhOWtoQhGGbDV9Fn4Rwqf6BmOT5Pkr770g>
    <xme:JMV0anT24Rocjfm_fVjPS8M0gE5PUiK7WK_BgJqpNmtB89zdbxuJMIc9cm5gaj2d8
    Te3O1T-n645aT7kgnvPoHrm0NFJknV2l7oZnhhrITOjLnpJbSHL7hc>
X-ME-Received: <xmr:JMV0ahOCVYmGdDEnEERpP5pwvW31xNMYdALDzAnG8nK3sbdeVMB-0g9kXg9B4drk74SEX9IrTanAHcZeg2uw_Ay1fwrGGlHEdA>
X-ME-Proxy-Cause: dmFkZTGlkujTt6kzPBwgxckXqVhBdC06nevTKcxzfsOuJfim8yyzdxjG8mUphWjgD2AoM+
    PRGEQkf39SmdIWy/oMcU1OY5banmpbNv1cu+5+DpjXLt9zB0piiGjqQjswdrHuNrcLjQmc
    iI4pMVbslTmHt4QOGPqK7KcLSd9LOlLrdg8CJOee0OWf3lWASO+3Y/UyH20XOZqFNyRDmC
    Ado1nB5t15QuYFjm9odYmEoBi5uPvPZ0L71KgoT3dJK1+8N3SOB9W29KF2hJVkkkM7BiCS
    0nR98dA5nhzZi6nZBGV89UlwaeL/VBAgeIM1Vy5ynQuAZb5myICZgfmCqVcuYYQw83UIRH
    rElz9aQzqsWvfKHbF2WUHg+4Fp9p1XgvTAJG/yjKosn/7zZc0U3FCi6U4xIYP5n1ZNZcna
    R6xx70BNx0c25D6cxySPWc6E5ZTCGrjFXKc7LVLpRTLW1ZyT15v1cEkxazrtiYXgc0q5y3
    Tl4xcw/kbtkhrZkeh+g1ccmTWvAsJFMr1Uuqw1Jkb7hP7xfK2Q+/F6pBr7lcve38HQ0Hoh
    3C3Z0m54PSPoBVC9B3vmsDFWodngVXEZcnbx+HfJY4abkviIKUCi4AFX9vyhiDYOIeEGpb
    Hv2vDeBx0ejyBCG9KcwpeWVHGNuuD1CMzvXBRABl2ls+nrjDDFCrMJ588FMQ
X-ME-Proxy: <xmx:JMV0atTjtpPZmAtLAqkXD6DuNFAo1QFGU9ZaeOiIi4zOxA2nobxiSQ>
    <xmx:JMV0anhIdXt-3JCQ5Yz_tMUS5jQM8-qLdITzPntPlznbePGAcZ-oDA>
    <xmx:JMV0au_J212VnYI1o0s9o99csfeyVq9tLG8_ESL510PjY8AiZKU1VQ>
    <xmx:JMV0amErXuZ0tBXbxvLZzlbzOvgr3Q7eYHZDPNrPlvC-RA_q3ipDHQ>
    <xmx:JMV0ap4yCZmurRwLkU8M5uVkzqbwKPJRmgFGSxu_GL8t5AdT7gcUmhSx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 13:32:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/2] doc: refs: put ref migration warning under the
 command
In-Reply-To: <anQYWlv3UhpS3iE7@pks.im> (Patrick Steinhardt's message of "Thu,
	6 Aug 2026 07:15:06 +0200")
References: <CV_git_ref_migration_warning.b09@msgid.xyz>
	<V2_CV_git_ref_migration_warning.b20@msgid.xyz>
	<anQYWlv3UhpS3iE7@pks.im>
Date: Thu, 06 Aug 2026 10:32:19 -0700
Message-ID: <xmqqpkzvjgt8.fsf@gitster.g>
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

> On Wed, Aug 05, 2026 at 09:02:34PM +0200, kristofferhaugsbakk@fastmail.com wrote:
>> § Changes in v2
>> 
>> • Patch 1/2: Use Warning admonition instead of Caution
>> • Patch 2/2: Add Ack
>
> Thanks, I'm happy with this version!
>
> Patrick

Thanks, both.  Let me mark the topic for 'next', then.
