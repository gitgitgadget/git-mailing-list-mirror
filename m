Received: from outbound.mr.icloud.com (p-west2-cluster4-host8-snip4-9.eps.apple.com [57.103.69.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35023A6
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.69.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754789047; cv=none; b=jcWBMmzUa05LaT8gb//D2VD36D/8WHTU82ufvzUer7C4ywbS4vick30Evc1nvnouc52gOm03qc4GpakQgQBX385VjbUCNwv2w19fQT8ehVUvXQ0fzTruwlKCsJ6sKmgeYzf8FUlxOaf875JEnwSEEpbF+t5b90vnhdtbbxrgtNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754789047; c=relaxed/simple;
	bh=OAxfx5qggMThXLnPHki5/xxwHLjG3XXp8jtf9LRWYLA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iq7x/TnNvaLZoNtsfv784fjpsL+pPEl4SAnMkyr0ftcldyi6j6/EC2ba+hGkVRJYT6ahA8Gws0mtaLR23deSaytLislWxlgUbN7bCPwy8mABbsyUw4LQHuypR/LbPmmUoYVlex00B8NPmmcQf1FA1uuSb4HYtYgW3qImRyyk40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gregoirege.is; spf=pass smtp.mailfrom=gregoirege.is; dkim=pass (2048-bit key) header.d=gregoirege.is header.i=@gregoirege.is header.b=liViQwQW; arc=none smtp.client-ip=57.103.69.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gregoirege.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gregoirege.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gregoirege.is header.i=@gregoirege.is header.b="liViQwQW"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-4 (Postfix) with ESMTPS id D739C18000BC;
	Sun, 10 Aug 2025 01:24:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gregoirege.is; s=sig1; bh=OAxfx5qggMThXLnPHki5/xxwHLjG3XXp8jtf9LRWYLA=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=liViQwQW0FQKlBtDbsPW4dNqOAgNK4YpDxpCsCVYS4GpHKR2in1UPgjCC3pgcg/ypnGJxWOXBL56Kxf1KQDW3x+5z88r+Lb2BHCRrzPnb/DTuMNKcpDVL0UuUlv1AgMnT7xyQSIgjbn9bRc0nwijVGBf7OZCLIlcDYM+g9wLRotNxWy4XJBgFt53zOJxHKnvIrvKG2Bay2zgrQ9GAoFaz9ausA67xXCSqaO+UVg0/SGI+TO+wEetH4QGOelf8F9M6EpL96W48Cfz36QRhS+fsE6gAx+g/Ns3qzcGEzsWavuaCIiPxz3NXp+gumrUK8Mb8+7GbKDFto6r0SMljtPMpA==
X-Client-IP: 118.221.50.200
Received: from smtpclient.apple (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-4 (Postfix) with ESMTPSA id AD88F1800196;
	Sun, 10 Aug 2025 01:24:02 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] diff-no-index: fix stdin path in subdirectory
From: opensource@gregoirege.is
In-Reply-To: <xmqqjz3diymi.fsf@gitster.g>
Date: Sat, 9 Aug 2025 11:12:13 +0900
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7E0AF030-2C14-4121-A2AE-A419B46EA701@gregoirege.is>
References: <20250807150613.32177-1-opensource@gregoirege.is>
 <xmqqtt2jm118.fsf@gitster.g>
 <CCF4B0E0-980D-472A-8689-7615FFFE0198@gregoirege.is>
 <xmqqjz3diymi.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Proofpoint-GUID: VNRJ5hF5fxbxGX554YFGvxFv27i7v3BD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDAwOCBTYWx0ZWRfXxeFV91YJ5f2x
 hkf1ny/D1b6GQEdaNxI6Kh6KbmNCzdDuRQjhxfiAPZm5YiUbz8NeRdOsqDzvCSu0nXAaqjYWwt2
 p2m0U5skuckhJ929aKUdQH6N4KlmpiFV2vGuqwQ21PH9RRVRRsC3NL/fg9mS2U/hhR1eRi9c2Z3
 5cggHyeOQNs0rZTazhwuQZ17yyUHA/aaS97hNp5pD/PCE5OmScaPnxwh0tZwObJz4j4DkCOy7wx
 zlMJiVQxZj40KWFNiUJB/I5+zqYJfk/Xc7p9vqAHKMTmlJFivmbwBXVjLQ9UqchW5hYJAdjGc=
X-Proofpoint-ORIG-GUID: VNRJ5hF5fxbxGX554YFGvxFv27i7v3BD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 clxscore=1030 mlxlogscore=999 suspectscore=0 phishscore=0
 bulkscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508100008

Junio C Hamano <gitster@pobox.com> wrote:

> Ah, what I meant was that I did not test the patch, so I did not
> know if it solves the problem you observed in your environment and
> with your development tools, hence I was asking you to apply it and
> test, like you did when you originally noticed the problem ;-)

Ah, I definitely should have been more explicit, sorry. I did test
your patch, and it did work where git previously encountered a buffer
overflow.

I didn't try a lot of inputs, but different combinations of `-`,
`/dev/null` and files in parent / subdirectories yield the same
outputs as before, and additionally don't trigger any buffer overflow
with ASAN.

`prove --shuffle -j8 t*-diff*.sh` also succeeded with your patch,
whereas `t4053-diff-no-index.sh` fails on current `master`. I did
skip `t4056-diff-order.sh` as it never terminates on my computer
both with and without your patch.

