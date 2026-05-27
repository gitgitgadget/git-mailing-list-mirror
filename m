Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF436728C
	for <git@vger.kernel.org>; Wed, 27 May 2026 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897147; cv=none; b=nSeLwgZc2yMXaUeUhTujrZlabmQTGKnXlqB4TVOPkCkp5abllocJCcK+AYYBKs1JuF8+y0AIhZbBiAwhSxRHQvgiGdlGoVpmhry1m5gnDob6ROUkkTHEUpp2hFiMTWZwIzA/hzsy/0gpExLVRMEdx6anqEgC21HJgL3lYLJq1Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897147; c=relaxed/simple;
	bh=Jse63f6/8OAoAz9N+gJRi26LH7xwLuYuTQPRzgh5yc8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=oIFDlFHK7BOZog6tsxeBkQrkPw9DSNeOsQ9DukruEb3bSCLxKn8LYMmInwoUd029EahwW1mEa4XOox3BxtgDaJRA5KY6U1rmWXldVdJmNKbH8zMEUpgrpevS+MoF7N71V4Qt88uFRH5VS+mjguUsvryeEGXJPkbtd3dpfzDKvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=CJZEcfd3; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="CJZEcfd3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1779897138; x=1780501938; i=l.s.r@web.de;
	bh=m0qKyD1xVlxUfdW5YnJN/VW1Vy0424lfgM0y99iSve0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CJZEcfd3w4zIVxrQAxCBOtaLbnKaWVPgBFcu/1IeiOSdhzB/LzSX/MHfgQmO/bHP
	 sHj07eiwWkOcQVl8dF1pa6r2NzQerL/vXEapRkXKakjUQaF0vP+g2iQhnVdZ5J5Gv
	 IMyTm41bZhtTbCo3hPUm37FWz/N/Kyg8rFuXB3p8lZk/unpfcudH602r0q7pT8iGZ
	 grtJb9aQEGOfXbks9Y79npjsOhxbbrL/SSbG56oHLKttInhG+WgX0l0vyBtM46Po2
	 bWRFSMvZc0YUR53RdojELULfsA8xP/V8HIvsm6Wq5uV4cjPMKBy2zs1dVxC4VTKTf
	 zQT2ASRYsKnWQHRS/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyNwk-1xFxvS18ma-00zYAW for
 <git@vger.kernel.org>; Wed, 27 May 2026 17:52:18 +0200
Message-ID: <450163b0-82c8-4b57-baab-a269efe430aa@web.de>
Date: Wed, 27 May 2026 17:52:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] commit-reach: stop sorting in paint_down_to_common()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0TFuypL5D88HzMogEnybZyYFTMe3uc/jhU3gRFHLgWGZKwWhtMc
 yXR7zE0FdBF1qsA2tyUalKeIQN58Mbtt12B4oOxFsGTfWnTdSMb6GStXuQ/zsXuTCpuQqK0
 PVSTGRofrGT9rnyO4ZgJ7Oz4PSYQxzRmItn4lyVKyYR9s3iOsNBWb8EN3hxzMrqyDZxA2Tl
 4HNn2A/YRj6W0hoWqm3KQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o/9B+J7GxSY=;n7pzJz+7mGP6cbO3OChSkpdfcVF
 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
 H7MrEbhh+brfV2jtYz7ehC/CkIAb13GvF3Ks=

None of the three callers of paint_down_to_common() care about the order
of its result list: merge_bases_many() sorts it again after removing
stale items, remove_redundant_no_gen() and repo_in_merge_bases_many()
throw the list away without even looking at it.  So drop the unnecessary
commit_list_sort_by_date() call.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit-reach.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/commit-reach.c b/commit-reach.c
index 5a52be90a6..056a7ed8d8 100644
=2D-- a/commit-reach.c
+++ b/commit-reach.c
@@ -137,7 +137,6 @@ static int paint_down_to_common(struct repository *r,
 	}
=20
 	clear_prio_queue(&queue);
-	commit_list_sort_by_date(result);
 	return 0;
 }
=20
=2D-=20
2.54.0
