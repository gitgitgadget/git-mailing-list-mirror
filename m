Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0424499BA
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571798; cv=none; b=AQuK9WKS92gwn7wA7Q0bcncsZ0tXHlJEpKf1jWA2tDXDWuhPnJnD/slAPt2yBQqjkWuNBjjWDZK5qMFvW4DMR+CHwk+0M7ljaeV1VLW/Yf3crIALBWICE6lzw6jja5/0993uz+XRp+emMQtejykGNSqJHTSrgm9cPBNrgrhvksY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571798; c=relaxed/simple;
	bh=5PIDNwKRfX/6uqS0dxnBWNw627XuKQxshjxIFKMMD4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b4TeBydztugSVtxR31ov+l2u4Go0mYTV/TE9tipv6/NSDwl5dGpy/rkUMbo6svfDLKdHFcYKAWv4eC4ZZk2bHXvzjd6zKxd7AVd5r2bX7Tu7dtQgLiZbkc9dsnAgZijKroi5qJLMidFFLkz5bhCbylcKKt0PNf9Sdn9/LAhv2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y5moHFBa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qr1fGIki; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y5moHFBa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qr1fGIki"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CFD237A0119;
	Mon, 20 Jul 2026 14:23:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 20 Jul 2026 14:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784571792; x=1784658192; bh=DVswgq8/aP
	gRDTfoG0shX68XHYSc96Da+3hAn74//BQ=; b=Y5moHFBazRb6xUkROl4B41GnGX
	MxCeLBTHeO+5gew277slWUah4SNPd2PK+uWVjObuQcvJBwih+PuEVVomjPz4fUjw
	kYah4dCOHX7VriplfDamtBHutWf16Wdmoh+ZIpaKXcdqPMg6i0bhejM0aIA8xsMe
	r8qHw7mCSGhYU4QExBc4M8SH1UFitvotxyKzWijW0pEYu3SWPpwjsH4VHPbYaB2D
	n7WsdcyJGkLptQXNueHOevnKvaPN3XP8po/pp0t1Rh9aIY36p7T/fuP4Qf2cwn97
	s4/N4vQwaQQQdeH1T1GFkdc4mjmR1EECSIz3Tp2vhsax/S+61xCQGOdUZJgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784571792; x=1784658192; bh=DVswgq8/aPgRDTfoG0shX68XHYSc96Da+3h
	An74//BQ=; b=Qr1fGIkiSLbU0NNykKm+HOXETyGssKymJUb0rJUxTcMHfrzxAxe
	kx9utqTrb1oNLOktpznO+UyUGJdU2nkzXYqwnM4DcICMiRbQCgnn0IyRm1MhYOQ/
	HnssCCN+7BzUvm6tDE8Y0FnNiRcNI2WkN10/XRqtvvBvuWZ3sFQSYTJSkdM7zdZd
	3LGvNKowjWXrrb1i832ilA23B4686r67C5PJrlrcrLyk48ClaBoxaBDLHG4Y7ry6
	c044bGx749zz6Q7dheNLAEM3Ut/AEFCvcem2Hbmi/fQZwjl8XGoU267WtB6t72SJ
	hAfgRZBp1u58a+gTRyQB8VZDLmMg1djtAZQ==
X-ME-Sender: <xms:kGdeasTSBJq02eGu5YoVHxxwD4rtqSM4ziM9j0pV2mtHhH2B1JxjFQ>
    <xme:kGdeagyWSJEhmph7k0sZYZwdpnls8UP-6UNsKg-gDv9LSel7mw5-WVurE4Gb4xvQS
    mdz8WEfBFZCRzVkHSRVBL4b5uYdgLRpAO5j0HZEphQQe57cQaRG3g>
X-ME-Received: <xmr:kGdeau24sDssvOrx1j-G2RZIONPUnwtXGKTDvwbe3VMS6zH2VBGEmHdgHj-vqjYZzDV4EZUKI1txykkaMtRAdqxMp_tUOhctHw>
X-ME-Proxy-Cause: dmFkZTEbQzH3IuFwS40VvK6jGS4bYft4upnpvqFTEunTc33P+4nLmOM46emc9I72tuMKGD
    iw/tOR5goI1OtKIUU37+Cm+bRRb/Pg9QAJUeQwn6HmOQwvpFQSRhkyqVIkut09ibUSLO6/
    /DL1lqrZxX2S0e3NKPWTRttTk22vqTbsJtra0TMGk0+cU05QHS3lkHrIbWjmy3ETlwvMQt
    eD+EuHVeA4SSQo3na3bD5ouxUESdHYEIjmcvVf26do14UmfQblf0wnnVzMh9oe7VOLcLOG
    6IdGlzmU4l9jMHZB8YKAmCVEuBPN9KhxqjSsg7j3GeuSpLbpeRT77ptK60kEQdXOJaBQKp
    eu0yF3kSnyygQEeaD9orGH5cpjxfGy7c6KWmFyH3Zmj4mj2XJTIWkz5kTepiqMz3andpmX
    Vt6SQVBqw6jOGdKQK6b5NiP4+8t3/qilWLdB90w7qVIpa2ncX4g1HiDGSc0WzUnUwlKm3z
    7upyMSSZdPxzBMi88HUSddei4njCiLw0F6y6P2wieVzk+ud3n2MQN3yfEdeHF4TltcjI6T
    tJuN204e+FxslhQ+RQKEu4SXW80GztMXo11i8GH4rIzzm4fzTRpDs8KV8r+9h/aRg1xP5K
    7wX0YWbAu6jPsjfX8/g/Wp9ujUjaVCDptRh/5kH5YAfB1GxYHEo2dlxXg2sw
X-ME-Proxy: <xmx:kGdeau64_wnwIK27wneGMTe2B3LbhbHY5OT1HPcWCeeu-nggBKUrLA>
    <xmx:kGdeahXHsI78K7RlCXKazeSHMGB9j1kd1LZ0aDfK2sH2VDfw8PDLLA>
    <xmx:kGdeatDvE6CEdMjMFzcBKZJG355mCqt8hKhcyoWXcw7uxr17LMXF9w>
    <xmx:kGdeag4PnQ0qVnxsBKHNw9drMBeVzmK4lX1VR1zjiXkmzXBiVGB-hA>
    <xmx:kGdeajgcKKpKCrTjeWSNCjbX0tbKULsYWf8547-YKUuJYss7oIhyRIEK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 14:23:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 1/2] remote: pass repository to push tracking helper
In-Reply-To: <fc70895732f406ecdbaea7a5b9a3fda4fb03df67.1784538618.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Mon, 20 Jul 2026
	09:10:17 +0000")
References: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com>
	<fc70895732f406ecdbaea7a5b9a3fda4fb03df67.1784538618.git.gitgitgadget@gmail.com>
Date: Mon, 20 Jul 2026 11:23:10 -0700
Message-ID: <xmqqfr1dcygh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> The push tracking helper currently only needs the push remote. However,
> resolving a URL-valued remote requires access to the repository's list
> of configured remotes.

It is unclear to me what 'resolving a URL-valued remote' means.
Could you describe what you are trying to achieve, without relying
on unexplained terms like 'to resolve' and 'URL-valued remote',
which seem to carry specialized meanings in this context?

Thanks.

> Pass the repository through the existing callers and mark the parameter
> as unused for now. This prepares the helper for that lookup without
> changing its behavior.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  remote.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index e6c52c850c..89d0f9e2d8 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1887,7 +1887,8 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
>  	return branch->merge[0]->dst;
>  }
>  
> -static char *tracking_for_push_dest(struct remote *remote,
> +static char *tracking_for_push_dest(struct repository *repo UNUSED,
> +				    struct remote *remote,
>  				    const char *refname,
>  				    struct strbuf *err)
>  {
> @@ -1925,13 +1926,13 @@ static char *branch_get_push_1(struct repository *repo,
>  					 _("push refspecs for '%s' do not include '%s'"),
>  					 remote->name, branch->name);
>  
> -		ret = tracking_for_push_dest(remote, dst, err);
> +		ret = tracking_for_push_dest(repo, remote, dst, err);
>  		free(dst);
>  		return ret;
>  	}
>  
>  	if (remote->mirror)
> -		return tracking_for_push_dest(remote, branch->refname, err);
> +		return tracking_for_push_dest(repo, remote, branch->refname, err);
>  
>  	switch (push_default) {
>  	case PUSH_DEFAULT_NOTHING:
> @@ -1939,7 +1940,7 @@ static char *branch_get_push_1(struct repository *repo,
>  
>  	case PUSH_DEFAULT_MATCHING:
>  	case PUSH_DEFAULT_CURRENT:
> -		return tracking_for_push_dest(remote, branch->refname, err);
> +		return tracking_for_push_dest(repo, remote, branch->refname, err);
>  
>  	case PUSH_DEFAULT_UPSTREAM:
>  		return xstrdup_or_null(branch_get_upstream(branch, err));
> @@ -1953,7 +1954,7 @@ static char *branch_get_push_1(struct repository *repo,
>  			up = branch_get_upstream(branch, err);
>  			if (!up)
>  				return NULL;
> -			cur = tracking_for_push_dest(remote, branch->refname, err);
> +			cur = tracking_for_push_dest(repo, remote, branch->refname, err);
>  			if (!cur)
>  				return NULL;
>  			if (strcmp(cur, up)) {
