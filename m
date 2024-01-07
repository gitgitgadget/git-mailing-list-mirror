Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB77134A1
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="FDbp2o/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202308231025; t=1704632601;
	bh=g6vI/w6lqkn5MsT99t7kA4wB+h/Ja3l2Q2jkjASzP0A=;
	h=Date:To:From:Subject:From;
	b=FDbp2o/G0nhl6+mQH4G6cH6SW96arBx4byR5XLly0CuWslfYWhtfSwRk0hmfYZBBu
	 jz6DqLwU1IKrQnzct71tNpmmoHtX5FeWumFCJTOqD+RcePqm6y0ByV+LAGXn5AKwhT
	 YbU2qnkTvaiRqoJoiEMHYVBBvHpZ1F7QBxhiHw8MtEQF4M4cPgvVeLW5WZN60u4wwy
	 L2AYj25CFTAbGVVL9f+umrdWHmV5SZuZxUOk8r9LpTyytMhU4/bAkzQI0BxdWhc1fU
	 viDYv/nutDv0qNxNzV9ZsK/5cwOBJvtUB76CUVRINavd+Whf1xBlWHG5RmUhl2Qpb+
	 IbNXNaTp3in6w==
Received: from [192.168.42.22] (254-98-142-46.pool.kielnet.net [46.142.98.254])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id A9C993C0356
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 14:03:21 +0100 (CET)
Message-ID: <8e344dee-f84e-4a2c-835a-406ee72d129b@haller-berlin.de>
Date: Sun, 7 Jan 2024 14:03:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: de-DE, en-US
From: Stefan Haller <lists@haller-berlin.de>
Subject: Storing private config files in .git directory?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

Our git client (lazygit) has a need to store per-repo config files that
override the global one, much like git itself. The easiest way to do
that is to store those in a .git/lazygit.cfg file, and I'm wondering if
there's any reason why this is a bad idea?

Another alternative would be to store the config values in .git/config
(that's the path taken by git gui, for example), but since our config
file format is yaml, this would require translation. It would be trivial
for scalar values such as int or string, but I'm not sure how well this
would work for more complex settings like lists of objects.

Any thoughts?
