Received: from steward.aerusso.net (steward.aerusso.net [208.87.133.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62514600C
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.87.133.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897871; cv=none; b=pBUfviW/Ivyi/hzBEXriVhtimSS/RMuVPLnRNufOJhWLPV88A8eiQZAV8p7GIzloTS4fgK41ptLu4PzlCvLiClLXg15gOEufLhHO6cuYVlFvJZq7W5NVpW4jFk5uqZ8olK0aqh05P0GmxBjVVYeis0l48d1F6herCTOPzg02TN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897871; c=relaxed/simple;
	bh=TrkGZwav+IWCJen8qBQvF2vhDgPOUEsDGEvRCeqjn0E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ACh3AMXz6cghxRykCIP4TtWdwKiKUHwZXB/aGUibYQXdjihLDXmMX/jhZ+Ktk17qapllsVkHzU1vYDDXK6yfUKeO4UyUDh2ggyiu8P50SechkN7keF2DPUrdPL0UEhqsF3azGOScBFkfR25CcGdoecy9Fb4jOFnO6qKn/yMzuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerusso.net; spf=pass smtp.mailfrom=aerusso.net; dkim=pass (2048-bit key) header.d=aerusso.net header.i=@aerusso.net header.b=NHCW8OXF; arc=none smtp.client-ip=208.87.133.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerusso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerusso.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aerusso.net header.i=@aerusso.net header.b="NHCW8OXF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aerusso.net; s=default;
	t=1732897502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mbXvfkTcazLaCf88VOCOgDB2VK3zD+W72slQW7yS0go=;
	b=NHCW8OXFXufuU+gWD/1ZZwlyQ5Iz8NT2DkWfEeJIWx8oZLGCnEmaiS1icpR42hVmog0fNc
	w6EhSFZhk6n0XPGMSySC+Xm3h0KzjfgVB+JMzno5VFqVC7QV+gCJRMDDlBzvo5n9AoI0AY
	/GbPd+/khiDgWJhqfFLSMpeJRXWSTUjxZCPHGeXSO77oqyuSig3mHKU90t+LhU6b3Za88Y
	WZ+zcU/Cxyu3h7/0mKrwZXDnbZEFv6O1XIcX9O5Lxq4utxcwvdsnL0ATpAscCoNc5w8B0L
	uA6/JrUlnZuBXB9Tfy/S13eIxuSLiazrH+DvUhEnw0eGIB2Md5AATjoi3IwgUg==
Message-ID: <c99248d4-777f-461b-b4ab-4cc8df3f09a3@aerusso.net>
Date: Fri, 29 Nov 2024 09:24:58 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: git@vger.kernel.org
From: Antonio Russo <aerusso@aerusso.net>
Subject: FEATURE/QUESTION: git fetch only commit objects, but not tree/file
 objects
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

Sometimes I'd like to investigate the commit history of a (large) git repository,
but I don't actually (yet) care about the actual files in the repository. I know
about shallow clones, but it covers kind of the opposite problem: a person may
just want the files, but not the history.

1. Is there a way to download only the git commit objects, and not the
corresponding tree (or file) blobs?

2. Is this a use case that anyone else cares about?  I suppose a ton of code
assumes it can follow any references, so implementing this as a feature means a
ton of code would need to be adapted to handle the reference-not-locally-present
case.  Maybe it might be interesting, but would make the git code-base way too
complicated?

I don't really know what keywords to look for, and man git-fetch did not
superficially seem to answer this, so I apologize if I wasn't able to find this
feature in the documentation.

Best,
Antonio
