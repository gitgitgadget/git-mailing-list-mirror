Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3737336AB50
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 20:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867473; cv=none; b=WKq573zNRbtEw85LxIvTYNY6JVzp00NYDnNcntXLhGPcpCKrAomp5tEH0NFeLY7tbOSEYL+1rfCSfcoRwk5hX0A6NTdSk9EdwgJDZB2jPqyvS7giGOCyczt5nqh0JZC8sE9k70jtrvIDSr/7btrWe82RmaLAUgrpEk0t07m84J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867473; c=relaxed/simple;
	bh=qEBtfp9wtA9ODJrXjKP1kgPLCst2m0m9EgG8SG0VWto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ebc4rNdCmmayL0kgrCYyi90CWTG8ivNtOTIOeiVRX+QlcOlmLqPj22aaU1RfsDwLP2SkumKNQM/WK/PrtlCDctaW4TqJ3DuT5Lh3FV9m61Q76M0DDkOdzJ9waP6NRMHkcXYBgIu6akW6Vb7yKIPjI8CdotEZKuGk+lov8eip7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SS8RceMY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b6YEuI4n; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SS8RceMY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b6YEuI4n"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DACD97A0023;
	Wed, 18 Mar 2026 16:57:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 18 Mar 2026 16:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773867470;
	 x=1773953870; bh=RosuH2f/ShLy7WT2EcMoHaS2oVjv5qI5Kj9GKkBcs10=; b=
	SS8RceMYXto3Wy0c+l6Vi6ujvPTADN4bEFuD8EjR32npNa9lbQ7W3XGs9hSG7hIc
	fRiSQjL8B/rFv9f5IlD3dI9P4MXqAgDgcYE6T3nhKsM4bOXE3icK5L+/gpaLxgZT
	164Nsfd3ORBIt/1eMinBt+bvDYzc2i2er3Pc9xxzspgZZnPsiuHvgD9IAts3/JUy
	+IwSqvM0oitBKFK07Ye9FisF8MSthytSgvgfjpKy6Z4U11N1PR4qZQLw22eL4Q1J
	jXW86aYb4AiXddh4cRxpVQ5cu5nofIZSyg1r661Lpk7a7UrxZEc+pEFWAmwPW2jk
	dQ9QEI9qhJrx+r8LyGBgEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773867470; x=
	1773953870; bh=RosuH2f/ShLy7WT2EcMoHaS2oVjv5qI5Kj9GKkBcs10=; b=b
	6YEuI4nd0JshPQItqjtMMzds3BFKONrKlrSAvRtZRU3Lhx30CgKhHQaXsIf8ane8
	Hve90J5K4GJ7ZSilYG1WHbaKmlN386lO6Zist13zvDsL4yBsA0uvqQSOgUUaCMFB
	saZ2ebmTlOQyJYLzbcPHAgDM9xmX/rmopVV+kjF4Ci/BKfWFpLg2ynlEJTUw2JFU
	qWPcNeVFH3RixzNNBL8h/Jc7NxwIN5IPXwDvSsw0eKMJZTi0urg99S9vgSsCDf9z
	5B6Okkr6bdJNwL7UqdKG2R7JQE/wGvFd8aY0XiqW0zNypncA17rmsEzGSYxrmMQO
	6FJdjcBcOajLZYMtWEZww==
X-ME-Sender: <xms:zhG7aRDJ_epCS75iig5XO7AI4OFPI_Rn8UuOPC6LbZxgRPlq0FGtPA>
    <xme:zhG7aRwAQUrYBjzD9Uu5hFG6yvLO9v5XlNRrme6EGk6rdG_pucHaso2fyunLO1voP
    hS1z9wMpxWSeMGQoLzZZCUKFjSBgzv9PQtXMLjhz90elLgjugTKiA>
X-ME-Received: <xmr:zhG7ae0P2lDn1Jc69M6sKtGbrNXYnREvxTOlXr4Fnifqnz56Tl1OJkbi3COgm_JvhF09Wg5vqz99LSGv4lV_ixzdi6Xus9W_sQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zhG7aRwkUxoYX-TYd0_wcvT5q73nKxIcyx7DhVzHzBz7CcyzFKs1YA>
    <xmx:zhG7aVFcXMGmJF9zqJY8_zLewoXSIM98hp-W9zvC53GZLJIinXCVPw>
    <xmx:zhG7aUZ0Pfr1FQf5Wk3y7sgBXKL13CCmWHoWuugiCVwgt29rtYDWjw>
    <xmx:zhG7aXDBAxsw9Gy7kO_XiUuCj0vP-9dy_dhC-UrTXHTiPgSINxIHfg>
    <xmx:zhG7abPUy2_NF7FfC1E01wqnZjyXzgy4KhDCwGiX9d6o4gjRe6jKNIMH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 16:57:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  me@ttaylorr.com,
  phillip.wood123@gmail.com,  ps@pks.im
Subject: Re: [RFC PATCH v2 2/2] push: support pushing to a remote group
In-Reply-To: <20260318204028.1010487-3-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Thu, 19 Mar 2026 02:10:28 +0530")
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
	<20260318204028.1010487-1-usmanakinyemi202@gmail.com>
	<20260318204028.1010487-3-usmanakinyemi202@gmail.com>
Date: Wed, 18 Mar 2026 13:57:48 -0700
Message-ID: <xmqqpl50q2ib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> A known interaction: push.default = simple will die when the current
> branch has no upstream configured, because setup_default_push_refspecs()
> requires an upstream for that mode. Users pushing to a group should set
> push.default = current or supply explicit refspecs. This is consistent
> with how fetch handles default refspec resolution per remote.

Even if you are not pushing to a group but to a single remote,
default=simple would die when the current branch has no upstream
configured, so I do not know what the point of singling
"default=simple" out is in the above paragraph.  For that matter, is
"default=current" so special and would it be the only way, other
than giving an explicit refspec, to make the push succeed?  Wouldn't
default=matching, for example, work equally well?

> +When a group name is given as the `<repository>` argument, the push is
> +performed to each member remote in turn.  The defining principle is:
> +
> +	git push <options> all-remotes <args>
> +
> +is exactly equivalent to:
> +
> +	git push <options> r1 <args>
> +	git push <options> r2 <args>
> +	...
> +	git push <options> rN <args>
> +
> +where r1, r2, ..., rN are the members of `all-remotes`.  No special
> +behaviour is added or removed — the group is purely a shorthand for
> +running the same push command against each member remote individually.

One thing this does not make it clear is if we abort upon the first
failure, or even after some fail we still attempt to push to the
rest of the remotes in the group.

> +Similarly, if `--force-with-lease` is given without an explicit expected
> +commit, Git will guess the expected commit for each remote independently
> +from that remote's own remote-tracking branch, the same way it would if
> +each push were run separately.

Understandable (even though it would be obvious from the "exactly
equivalent to" above).

> If an explicit commit is given with
> +`--force-with-lease=<refname>:<expect>`, that same value is forwarded
> +to every member remote, as if each of
> +`git push --force-with-lease=<refname>:<expect> r1`,
> +`git push --force-with-lease=<refname>:<expect> r2`, ...,
> +`git push --force-with-lease=<refname>:<expect> rN` had been invoked.

Understandable (ditto).

> diff --git a/builtin/push.c b/builtin/push.c
> index 5b6cebbb85..33de769a33 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -542,7 +542,6 @@ static int git_push_config(const char *k, const char *v,
>  
>  	return git_default_config(k, v, ctx, NULL);
>  }
> -
>  int cmd_push(int argc,
>  	     const char **argv,
>  	     const char *prefix,

You didn't want to include this hunk, I presume?

Thanks.
