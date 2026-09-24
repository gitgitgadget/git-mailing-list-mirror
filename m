Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67893423783
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 20:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282212; cv=none; b=FRh/PXKcHMUU3tXk64IMNRwDQ8s/KvKEpzzUi938eXsH6cj4Ie7cZQHp4LQkeGfiTh0tZSkXgYr8UDWnonyrf4ksaUzG9zr4XTtWDINO+Cq7a1DefIqhnihJoaifoeoVWHOy8erngZOu7xWGCcdRNhYJa+dxWSgGH8FFKGlMv08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282212; c=relaxed/simple;
	bh=WfWFTYQ55z4NDn6UvzAbx9sFySSOFrVj2DHovpiS7AE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e0+KPDJH9nK/1IW8PaAV290kqTTkVyBzh1XCjaxMV4AgCr80xBgnGbwjSANzDrMFpfCGcR0V6vNI8fQDmNkZC0L0RMNuYeALuZX95gDnrTKQNLXdcTGNnJ75szdQgI/MVZkxUzoGm3g2z14a+/wAK95e6095+ioklpwHsSlv6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mpMM/7Vf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q4HPbfHx; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mpMM/7Vf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q4HPbfHx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 83046EC00B5;
	Thu, 24 Sep 2026 16:36:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 24 Sep 2026 16:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790282209; x=1790368609; bh=itiR3C8x5D
	4kxuk3fxq5cK4p71HcTIlhfrCSfO9yqbs=; b=mpMM/7Vf8SJWrwaaT1QBEw07n0
	fSo7Fxi2qztpbOmkVewciRow17yU+UEJTCjntPK9M53LzqKVSTmNGpfgoBXXTUUw
	6DojDpyl3UR/KPq3C3z6027glA3oqmXKgzQzDMfG8sLzJ23dsDnNL6zKKY1/vJSL
	85Uq5xYdhQ2S5Hc0WrNKRqBbfluIWNaKSC/8yuaxrShIcRQASj4xVXcEtHRcB0Zh
	AoIyVRW65Vo0Y39MYSjDbCRwfAjh6wZIeeCWREbB26RzTltTZmeFZ/NJddBP0vLV
	i0I3tAbAompbvT7kvOsuzItMGX/5OuL9nS7SdkXUOfWxjrXvAKJKLAY3IYkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790282209; x=1790368609; bh=itiR3C8x5D4kxuk3fxq5cK4p71HcTIlhfrC
	SfO9yqbs=; b=q4HPbfHxmEnfOwv3+MOk9/PbYfw7Xbmx8eN8t4Yd2H+/67ic/ir
	Jt9ZqU8awHL7TtbhPEf0SuyTdlEIHEdt/lwxAH61fsHSsl97LCzt5aTeIoBS4EuB
	ev+h+7OFtNf448UG5qQjUlbjaxLVKFUqKqFMamaQSFfec6W4qTaNhxoa+B/xxdji
	4iljlCaaDNysXD4ppG8A5C0fK0JujL56RTDKdsyjP5brgpjiR/LR9+75PgZdaKRA
	vi15FzyCatu/0/9LeABJ7IvaVbk1PG/+ch67Fjtok6VGbKH1mYaqQnJzykfFqR4D
	qF9U8tYocW58y6fCgo5NkMYMOpqYWYI5TDA==
X-ME-Sender: <xms:4Ym1ahoX9R9SL1NA_xuaoj1qw0_8B38HQCXW9q8eanjHQiAbf1nqzA>
    <xme:4Ym1aqgYQcFz3X4CUProra3O35yR6l7iEBZdsPEO3azXAyj9CJZWPnK-88FjDtYmu
    cc4Fpy665DBMjY28KMzdeVD3yL61cdaZ7tl9vVhVH0rD2xn-p1QJBY>
X-ME-Received: <xmr:4Ym1amgC0dLaEiP2PNx0dRLUVsHdo1y-GoMnW2ljt0g5avROWVVSjzGPtIpVRrXbiDtyunbU69IRzKl4cn1Uo_z-vXLHgYwAhlr4>
X-ME-Proxy-Cause: dmFkZTE872kc0hnmi67QlA0OEDWchfwzXYeU1hImKJVxC82DKw1YXWCbBhkT4IQMSBL1WD
    kseO+PpaG5zQhejtFXh73O3nxtYG2c+yCZDftmECehkEC6Xfku1ZsZDbR1sm6b/K0ZUzDm
    g9nLGygOBQ9avPmvUjEeLpWKGh6J+UCgcXrrothZkQwo9U8h8+Wf+Hi6NZfiQmivi6DYNs
    gAygkMBuyZSkT7cDbUwmkCsNeRjNdharqiFAj15ZbfDAX9pejlPEhC9D3ydB7WJfETHwk6
    JsCAL5rC2Xq0SV3h3q7fiQ6BrgJxKSDKIg5ggHpMpfT/dIak95b93gA/px4vrK65pxhPhx
    E83rdqMSquysebd1gmnZCLcK0HvezWE1qfmd+M2mAEHOhCVqUWg5RLta9jPe6WGXOfCKn0
    1QIzBqXy8NcgaQtxoDs/BRI7S9NsmjK0K9xX2G8VGTv73KFy8u8vZRi85B+cJb//6CcWpJ
    G4gh5GR/yq0HCU7YzcsL0JcGbCXj+k6kZy8yzeaYM6k9QkiK/1jOWsMvxH483XNCpK6H9F
    iCzWDFTMuMyri6v7DVX9N//C5om0UUi3E3YaYFWArOis5hp53jW5Y//nCaRJApBmyDq7vb
    HNmmta9I9Wzo6UoZli0a3dN4Pjpwkh7i9+XtOJvm9m6WAO5Xl0/BVcffXw7g
X-ME-Proxy: <xmx:4Ym1aoigqHhrBZ0VBCr7WbwqXkl_AZeomNJGLRwbbbDO_EOhYeOQLg>
    <xmx:4Ym1auJGfALSAiXhHFrzByYWSAQX782QJDC7h3bBFyxftM56FmkgRA>
    <xmx:4Ym1avGT7Q7aF2sLDDkZ20hDChYV8LRZXXoNeomgDcxZIzr5v84fRQ>
    <xmx:4Ym1aqTLd4Rm5DjAPmSc_6jrbdLlctiR9awAK6icIKA8gcqaZTu5-w>
    <xmx:4Ym1arz8GVsskyGZJqbY7zpfk0RNisPLJNHuDvr-FgOA_HksgftBN8kv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 16:36:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 1/7] [doc] Add new gitmergeconflicts man page
In-Reply-To: <ad4853dc36cdb883c9a8dc6bda747a5ea318e7a8.1790261062.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Thu, 24 Sep 2026 14:44:16
	+0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<ad4853dc36cdb883c9a8dc6bda747a5ea318e7a8.1790261062.git.gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 13:36:47 -0700
Message-ID: <xmqqa4p61j4w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  Documentation/Makefile               |   1 +
>  Documentation/gitmergeconflicts.adoc | 294 +++++++++++++++++++++++++++
>  Documentation/meson.build            |   1 +
>  3 files changed, 296 insertions(+)
>  create mode 100644 Documentation/gitmergeconflicts.adoc
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index f8dea4b395..bc49641dda 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -58,6 +58,7 @@ MAN7_TXT += gitdiffcore.adoc
>  MAN7_TXT += giteveryday.adoc
>  MAN7_TXT += gitfaq.adoc
>  MAN7_TXT += gitglossary.adoc
> +MAN7_TXT += gitmergeconflicts.adoc

This unfortunately needs to be accompanied with a matching change to
help the other build system.

You probably want to move your change to set conflict-marker-size
for this new file to this step, not at the end as if an
afterthought.


 Documentation/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git c/Documentation/meson.build w/Documentation/meson.build
index 51647957e0..10b0637991 100644
--- c/Documentation/meson.build
+++ w/Documentation/meson.build
@@ -201,6 +201,7 @@ manpages = {
   'giteveryday.adoc' : 7,
   'gitfaq.adoc' : 7,
   'gitglossary.adoc' : 7,
+  'gitmergeconflicts.adoc' : 7,
   'gitpacking.adoc' : 7,
   'gitmergeconflicts.adoc' : 7,
   'gitnamespaces.adoc' : 7,
