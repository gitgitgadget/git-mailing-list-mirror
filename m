Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04122348C4C
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977753; cv=none; b=TWzKEZpMJjJ10DMgUMC64mrzzM1yE9ydT13fjOFbPA2xhMRGeaKw1ILWedqUSY+Lf9HAlyYeqd+D10NZf2+n1Z2nkuzvYgXK9Pd46pipRV0kdQEo03UE4GHvjjrNiJGHARL0KIiIgYF8gFEgiXk2+klI3aMGrvfeubcfbMNQIa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977753; c=relaxed/simple;
	bh=s1LJRbXkmzpBMhD0UcPgPCRo37NwoDngEq3W+2hmGcs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=baatr74MJo6BaWAu+4DmweJDvoCzwVvcvzp7HU6OK8+9RVmIDa/KtWsDjQZvEvbZz4T1ewDD1CDaOVaL6SvNGRWluWaK7u02fYWtmeOBcOEsQXEA6A+xG3ivgoo6/rZ6G09PwjnHpzLZkEmKttT6D58QIoBiJWriQdTnrIV3AyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AVOsAyMY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S3zs/NZg; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AVOsAyMY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S3zs/NZg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 34137EC00D8;
	Wed,  9 Sep 2026 14:15:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 09 Sep 2026 14:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788977751; x=1789064151; bh=2g+OSWuKo+
	iwn+1MV8R+OU06/6Y5qc28IFLTBrKVJ/c=; b=AVOsAyMY9WVGVQsLAu4GDg3fO8
	gTwtNWxdkqqNoee4lQEO5IVWaXZ2b7RY70KdxtlL0CvCNtatHH29SBSTMd9DfFb4
	Rn/5lUlEFmY5mWmurRY+F5Ww9xikV5Qo2PbBVDn7OBNfdzLtIXXmiUqZliazi9nU
	ilq6eAw/ykzrlEBcdoWfwHT/tSAQJgO6BPYa/1OTD35C6nsTqd1P5gGBrl62N9Yn
	jKvNAeyAtMsGTO+JdiwUif9VASWtsnqKQlBHSwHaG984c+4D8MIQVf4pxhDCbe1s
	Gg5hY1bttIm2sa6Do49eq028+A+FX6sHZPn6dcjWtM0zWTbpJAV5Raxm8lkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788977751; x=1789064151; bh=2g+OSWuKo+iwn+1MV8R+OU06/6Y5qc28IFL
	TBrKVJ/c=; b=S3zs/NZg6QYQfiXdWfxHnFtMfS1iKBV/j7HPKnBc3xeglrq01r3
	RO4V7toSTnVLl99qG6FqJV2GicRLa6+6wDSNa8N+ryLQK/vgEzV/6NDTARkCYeXE
	lOToeq5t7SApQzj9EM5j+BvSuEEjjwErf4o3d4SdbWee9rWypsZVsQs++wpxd140
	PVyd9ADe1EGdqPSeD9ocd+R3kIwE5f5zFynI2DHkhWJkx/0i2iMd6mne6hNY6Ix3
	t2XxLaQ5Mk6mhZW6FMJxAE9jdg+kw/WeguZxIBYRKfd5HpdEnOCZcVzSNneM0+wN
	PWH3da5UiVDezCbPhAtqfoooowSZtMI0aPw==
X-ME-Sender: <xms:V6KhajGtx6NztaDLEDS3MAfmTFZRSkfrlLqmFwUHZxjvNJLHoojkAg>
    <xme:V6Khany7nPrshIuQLoxVJy48ExTVAv-Y7tRp3AOxvHGZf0X6TeIMIMyiDl5WoHoBt
    Iu8llRhmpK40RRRDZCSNdHxLZxk_qG4YV9lf5yiTfazXmcVTcRdQSM>
X-ME-Received: <xmr:V6KhaihE-xfEuQA7EKK_nKdXjdPJhYItl-aa6VegKsBAzGRzEiFjNRGE5smTtFbrZlFlmhYmA-k8zv_3WF6FcQndts7Gnv5ECcAc>
X-ME-Proxy-Cause: dmFkZTFxMtnx6DzLoK9Vkw6PD3SD66hj45xkyQB0oE6+8y89KM2mVb5lI8HjlTETNO7uj/
    JE3CmYbiuOUFsBbapKMgSc/eznTpXHBOUYHoxcvRcn91B5qGZMhpnfpY2Od1MTEEqcOiWi
    lz89uLSpoUEtW+mB/Izta+JSGG5H+tamUpCn2oKd5IO8rZwG3G2MGs8gN+VK8mfMIW5p0U
    eUCK0N23Xw9abYl6gRBd1boEhumXkZVBjJ53omk6vwpdvvWdsjFp9E3fiSZuE/w2ehri63
    2wahavMYgshabh/Ydso4cnMz/AGq4snmsPPuiYaKYQp6AhGyl+JZSd0WK+HuUcnfEDJGr2
    fU5fghmWE5Ia1VkmsS5TJEs+faa4fyGGHOQ1J6PaMEdI5IEyKF+v0L9gSz0sKfW+GBf9Nw
    CB9c+yygF9xhia3jcIgh1clfrjitW0ypwXBV1JuVaAIekhq9QBAUb9rSFZNQ5Tj7B/DEak
    Hd5FgwXiMoBdbW7GgWjGAmucmlExnrprCcw29F0+TolPaIDTF7YELRC0g17E/eCznRqMwz
    E92hHDmjYo4d0R+8uqXAXkBLM1A2weY4yseHWuBWCTsyuX3vAUDJT/0WXvPv+Xa3AJZUjE
    xTb6a/igVW5pYJnYAFSJtFRi5Om4G66Ea3gEE55vAGZ9odiKPgD9oC6x03vA
X-ME-Proxy: <xmx:V6Khaqx44mLXdxVkJounufHcT47QSaz8VA_LVBzy3zNsqzPIhLCggA>
    <xmx:V6KhatJkyWMVmxWRTBMv4A0SeiI7by3nzxspBA2nBzk7FmIdvoT6TA>
    <xmx:V6KhapQafoUDQ9KdwIg0A6XRssrQhF-JQzucwyKPlXtzLOPcuRRk4A>
    <xmx:V6KhatpS1WifYTkTna9iqZ9D9fUN3sNZs43HXdWeHM9dwtO9Oj4fyw>
    <xmx:V6KhaleNVFmSOVkl8iaM3fuLpQ8yfVUEGQuH6sCF8YRhudjh3i3uzuzN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 14:15:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] command-list: add gitformat-loose(5) and gitpacking(7)
In-Reply-To: <20260909052501.8448-2-taahol@utu.fi> (Tuomas Ahola's message of
	"Wed, 9 Sep 2026 08:25:00 +0300")
References: <20260909052501.8448-1-taahol@utu.fi>
	<20260909052501.8448-2-taahol@utu.fi>
Date: Wed, 09 Sep 2026 11:15:49 -0700
Message-ID: <xmqq1pb2s33e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> Three manpages from sections 5 and 7 are not featured in
> command-list.txt as concept guides or interface manuals.
>
> As easy fixes, add gitformat-loose(5) to 'developerinterfaces'
> and make gitpacking(7) a 'guide'.
>
> That leaves only gitweb.conf(5) which could be added to
> 'userinterfaces'.  However, the manual would then appear
> as "web.conf" in `git help -a` which is just confusing.
> So, perhaps we are better off by leaving it out.
>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>  command-list.txt | 2 ++
>  1 file changed, 2 insertions(+)

Good eyes.  Thanks.

>
> diff --git a/command-list.txt b/command-list.txt
> index 63ae2a67c9..955eec6e7e 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -225,6 +225,7 @@ gitformat-bundle                        developerinterfaces
>  gitformat-chunk                         developerinterfaces
>  gitformat-commit-graph                  developerinterfaces
>  gitformat-index                         developerinterfaces
> +gitformat-loose                         developerinterfaces
>  gitformat-pack                          developerinterfaces
>  gitformat-signature                     developerinterfaces
>  gitglossary                             guide
> @@ -234,6 +235,7 @@ gitk                                    mainporcelain
>  gitmailmap                              userinterfaces
>  gitmodules                              userinterfaces
>  gitnamespaces                           guide
> +gitpacking                              guide
>  gitprotocol-capabilities                developerinterfaces
>  gitprotocol-common                      developerinterfaces
>  gitprotocol-http                        developerinterfaces
