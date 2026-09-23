Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7C563FDC
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790193009; cv=none; b=N+JsEh9NjY3AxyOkAFS5uLLk5956xVt/CIus+Oc55O3+Wv2z81DwEB2yobWRSNjLXixE/6nfpFt9vI7DevQQFOLhvEl53z1YjtetyZ3dLf5LkLq5x5yc4f6NkfgrcryL+Iwn93vZMsQM8JYqlt/cuSMdtxhXCgKygK3SL1TPdkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790193009; c=relaxed/simple;
	bh=/lavn9YK33CZ0Ur/OnNc8LtQOJ7XyaJSJ9qrP1zzz84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lRxGG7og+QHtLeKeI5Jj7qk4Cj2ybaeb90Xv6fuYQ0hTWST/z10Zxkb1NJ6d5zAc8ungdIk8LA4d9JGKn3lAHXfxy5/yoVyyPxKP0LV44HjNsX1z2EHraCDeAX0Qk6jL3ulI4qA/UVHGameZtQXktZQnXsYv938+8n0S/Ile6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c4sPTlsm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j3qmJfpk; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c4sPTlsm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j3qmJfpk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C7FA81400024;
	Wed, 23 Sep 2026 15:50:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 23 Sep 2026 15:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790193004; x=1790279404; bh=04R3JC+wTt
	/YtHTsgwLjQNL3JuvTm5iqgLhTj9U8cRE=; b=c4sPTlsm1vEXoD+mheX+O9b4I2
	jeeNbk1Q/GWb/jDbjqmJl/DbijKMyEaSBS9BzaDvH9XkG1RmSCnfUFtvFuz6gsaL
	+FjurRD6hxuFNOJbL/c/l2OJnJ1xEf1/rBjyaza2dYzq9vcxevlFwPIyKmB+PZ+q
	UTrXjZ/54jCcG3fhQnEQ2Wu/bc2xGN9Yp37/Gxku9sb7THT7GiDXmfsPi+o/adOg
	v5gbaIGZISMQeQJvP03ghqycWd+r1IfKfNnzo1D6WJQaB0SvhUl0P3/XcaWWqzN7
	qKidY9ySfZiUb+IXLpOSwALSocINRME4xDoJO4LJ5VhYKv02G/JB6+ycjvqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790193004; x=1790279404; bh=04R3JC+wTt/YtHTsgwLjQNL3JuvTm5iqgLh
	Tj9U8cRE=; b=j3qmJfpkXo4AUA8ZqqVYyazouNEMrIHzuMZocfHfqfVuZH1u2OY
	ZFKqrtS2+ZvKM224UHwHpHUqRQui5oxCB/dWLcVCIkY8Rad8nOad3cA/dRYf9C00
	hpLtj5DrdDCBilDRlTC+01C1+RDx1HI3gtp7l0r0vs3ecMmApWR186SfsEli9qph
	1C4PpCPkaPbBpyOjUyCsM5MvXNAGQwL5Re3fYq5Gfs8mKTt4SpSIiMJsZsM9jJuR
	VlRv7/0yWl1fIHM/Y6U/NxHJ35ofKQ8ABXzzT6vVnIYdAiNtIAm1YcmZPFNbnVCv
	GOsFqy1CitNJBX3Exse3pHj4bWgdGljRoyg==
X-ME-Sender: <xms:bC20avWh4icuGHBB0UXvvk-ktybaTvuZt5dN0RbTyf9FRq9q2m-l6A>
    <xme:bC20arRUTlTIP634mDJxsvA7oUFSGrwJXDMrAIrslssDRGFgxbZwcxXyl3e21zgiZ
    DsWafpEXVJ8I09HODi9eWrGq8_qwArUxhkCe7i5DguFHMyD3H2oOw>
X-ME-Received: <xmr:bC20alMjJ7wyBYwNsT04h2bi2K83VODP07sOeuel_BrG-tDhImQOncoJupTyZ4c_2tf0Nh4mNoZNJiiRbM8ILUP51TIOU1XsqCnR>
X-ME-Proxy-Cause: dmFkZTFP5/c2RWc6DjbbyLb+2/dMjLYa66htXFSH+mABxWBpfZ0OG0IRAjtSSV+2xPUHke
    5nVy4b6b8AqaR5q1k7jvf1p2TkaJQ/Opt3+aDtIBngBvaiC/Dzo8CeOgL+OZS9uYWH9WLX
    x7ndNE/qzvBQkW1H1SwNlhQmQSIu6Asx9SMm0g0nSRNksh75Q2Hg2U/bzCBjnd2amm88jz
    ECfAYQZczNSzC7hc/ZV07bO1UYKBCWRqLhRqiAcXeZdwoMR1gagBT6ZoBwmSGPysoR9EGc
    ztwnUcMzVPp4oprRYVBB9EO2SgKf0fkSWrYY5HnZoKsf9FAByaekgaK0GZQTOJT4xiycUU
    GZh04ElFLk1xqvBmsHfMLCrcyHX5i/vZxU6uXIbKDjDrZ9n2d3xDo7hvLz6cbMQ748yYrP
    faAWXLiCTfdPa6Fvy+Hyp1CtQ+AhL/egohEjtB+im5xgD/e67l9KgWkf6/Q3YBGfankRAO
    lqVbibntkCTM8HUXUwmxKr8ad+72TsUEGq2L+8ba9jEKPu3+6Ch7YqAu/eDXBzsVmJNfQD
    pFrylxolmZPcuJHcvl1/7aMKibrH/mYpUCAoMhKBUzrtKsICGt+yulDbeTs5suro/mu2vd
    fMHWZzYovObUBPNxMxGiC07W0WleXmWiOHzlKBCzDInrREWFEmDnpVxsJT9A
X-ME-Proxy: <xmx:bC20ahQM2LQK9Qk9bjcrJpTDRmdcsYiCXqSlMqyoWz-8WHoim4MOAQ>
    <xmx:bC20arjrvPtDTZMMOA_vsTLW2-abpaO6VmOjlF3tTcaHJA_NyO8DkA>
    <xmx:bC20ai_MB1j80XbEa45rx95sdYIsm6snXQ2jYhiQzvOgRs96NtyYmg>
    <xmx:bC20aqGgIIiiMvh34bAFEb_pOw9qhTGxj08Oy8_SSazpPNE0C2_Vmg>
    <xmx:bC20at5lxTafgGYgYBjdT1SCYGqp3GstQPdcvVmBDsAhy0Knt6Th1KiD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 15:50:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] fetch: add config to avoid fetching every branch in
 shallow repo
In-Reply-To: <CALnO6CA2DXvyOO+fu04sozg2=E0JoymAqyhs_heHzExgRSEzVw@mail.gmail.com>
	(D. Ben Knoble's message of "Wed, 23 Sep 2026 12:55:07 -0400")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com>
	<xmqqh5jhfbyw.fsf@gitster.g>
	<05d0e6e0-e156-4a2a-95a0-4986ab18ef49@gmail.com>
	<xmqq5wzwc76w.fsf@gitster.g>
	<CALnO6CA2DXvyOO+fu04sozg2=E0JoymAqyhs_heHzExgRSEzVw@mail.gmail.com>
Date: Wed, 23 Sep 2026 12:50:01 -0700
Message-ID: <xmqqbj9nagt2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>>     $ git fetch second main:refs/remotes/second/main
>
> I've wanted something similar for notes, so allow me to interject from
> the sidelines: it would be even nicer to still have the ability to map
> fetches (so that "git fetch second main" did the right thing, creating

The thing is, the command line

    $ git fetch second main

has been used for the past 20 years as a "single-shot fetch" syntax
that expresses that the user does not intend to keep interacting
with the same 'main' branch or even the same 'second' repository,
and for the "single-shot fetch", it is absolutely the wrong thing to
create a remote-tracking branch.

It would be even worse if we created a remote 'second' and
remote-tracking branch 'refs/remotes/second/main' when you ran

    $ git fetch https://ho.st/second main

Having said that, I suspect that the fact that you have the
shorthand 'second' (i.e., you have "[remote "second"] url = ..."
defined) may be a good enough sign that you expect to keep
interacting with that repository, and some people might appreciate
it if

    $ git fetch second main

created a remote-tracking branch "refs/remotes/second/main"
automatically.

But we cannot suddenly start doing so without breaking people's
expectations, and without a good transition plan.  We need at least
an escape hatch for users to say "No, this is a single-shot fetch;
do not write the object anywhere other than FETCH_HEAD as we have
always done".
