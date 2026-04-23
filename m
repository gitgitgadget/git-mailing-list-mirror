Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C15E25A2C9
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960514; cv=none; b=QMONlIblpvLFhiIPPmJl51JH9bqX67GqjZUz04SNwLo4uP46lUc7Iw3bBCZh9+9mVYHnJat7tf1rS6dwjCqkWIkh1dqFa+gdUvtYj+ovwybVgQ6YYg3mKI7/p8PJ3u3tfoU+5I7AaZuRae2sxM5Hur77bB7ngRlAObz6ft1hvLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960514; c=relaxed/simple;
	bh=8vKd3Gszvew5nj2UnmFYgHZA6qJE1bkvR7+miwvj7oc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=p2DHuvtxaHVA7Go3Iqi0456IhOyXVQVPvyjWEIUMMdyyrtrvoenZHyWRsXs5LIDThgrQ4I1JjzAjH/jMBWfvPKTwznw3XlGQQ5qFL3EtmmrGyT4VWRvUdg/bX5ZFI74JEnr2I89BTKmCQ1KycWjvonKWCorewNvYxAdvTDuHdDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=jHE0v9Rb; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="jHE0v9Rb"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id FwYJwKghJe3PcFwYKwcGlp; Thu, 23 Apr 2026 17:05:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1776960321; bh=SjYJFwVjF5/azs4EpNjaEb/7GnGTryellzf5oZtAXWw=;
	h=Date:To:Cc:From:Subject;
	b=jHE0v9Rb+dP2re0uyFd2TOzq/BsVPzk9WSq3VzblnaXA8Wvcq3UsVC9f5ldDEPOWh
	 J+0eSSvBbnK57fTRRz8Od1+4czzSHPi0UWJhdyBwx5bft7KvMmxeiy1GKjIJfOaWyy
	 TfL5NgI7E67uCZ5F4fqbWnlhRbjMn34poAkFr1cE4rFUywCkYhDKhv3z5etX30QqyN
	 CfNarROpEav0WW1an9rgxjAYLOAD3Si+uA3Hdz4kwMYx5tOFeQJ3Sa2sNSHKqcu/7p
	 Elz6PMRAfl0AfbkCLZc69VDWt4/NXWXD8kMO1MQ1tKYUidcG1hrh0Kqe8RKBpMju8r
	 Qh0fCQPzisbYg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FMy4xPos c=1 sm=1 tr=0 ts=69ea4341
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=RJX83gC1Z-ZOO3_vwE8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <7aac2206-8b60-484f-a5f6-4943348ad3f6@ramsayjones.plus.com>
Date: Thu, 23 Apr 2026 17:05:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jiamu Sun <39@barroit.sh>
Cc: GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] parse-options: fix sparse 'plain integer as NULL pointer'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOAtoaJpynrARieXoP8ljcGocWj+npoXnBggX3xYJQU5MF2MsVwJoqZeFXxnTLAjXhBJAOYOMg6kD/aZh9vbQuUvIIRzqnwMqoRTiHHJaYPwczwcZuRs
 shXsk+Wu5qHftdqAx3ZMrWq837vuDbvaDqjvPL80NdJgR5782p6LqQiTSWK3+QiLEidSIVoy7tfKOY9RPR28L+B739t6c485xGI=


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jiamu Sun,

If you need to re-roll your 'js/parseopt-subcommand-autocorrection'
branch, could you please squash this into the patch corresponding
to commit b9e6a2d30a ("parseopt: autocorrect mistyped subcommands",
2026-04-23).

Thanks.

ATB,
Ramsay Jones

 parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index d60e7bd3c9..14f3f385eb 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -658,7 +658,7 @@ static const char *autocorrect_subcommand(const char *cmd,
 
 	for_each_string_list_item(cand, cmds) {
 		if (starts_with(cand->string, cmd)) {
-			cand->util = 0;
+			cand->util = NULL;
 		} else {
 			int edit = levenshtein(cmd, cand->string,
 					       0, 2, 1, 3) + 1;
-- 
2.54.0
