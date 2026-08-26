Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8929C3546E7
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787774208; cv=none; b=ZKLJWesTiPPip9s8ZpIenshnyN0wyH28Yl5piPkxucNXFj1es6EkdUUewQ2Yt5rVAa5qwh9gcmMxGCT+y4LYuhm3SB64FJb9pBKYXlDG7lLDe3Zj4QUvDviDfomAbO96R0XuiRd8mU8qdNlQx75DAim8U0gZNeB8exoKH9SXRfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787774208; c=relaxed/simple;
	bh=WtXx7iT5CuNMnKEpxpO5cpRfj1h4ZKYQ2Qp+SvtBc2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JP8H/JGI6SUaXC04y0naxsYgJ+Puas91wxY2CM8iGLWj4ugCOPxOVzkLUlrrfyTQMXmIC40IvP19ibjWiui7cdpWgdBIpWbhw23ZSm+0hk4/mUE2+OTU4HTCVaHzW3gWOeywt0j6y89JFB+aEwe5CwS4y/KQ7+mwL0PX96gu+Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hBPAbHLC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tf3YIS4E; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hBPAbHLC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tf3YIS4E"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 004FA7A006B;
	Wed, 26 Aug 2026 15:56:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 26 Aug 2026 15:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787774203; x=1787860603; bh=3+Z6OMuy/r
	4Do87lJRPUaimlbY2AavS7pEaQfE4eIB8=; b=hBPAbHLCfQEm+s+Z0I78HsMFgk
	oqiOecrAW3+liaipq9UEMD7s+hsu3EKTvrjV8xuHgQGQYgj02uaWuIaji3qylK58
	0G+a87fAUJcEboX+sYfQJ8TmoFSuAJqiYP4VEMivqMHvDYqj+VRMGYnB4YYzPFLw
	sDY72hGKku+7kdybxkVtNhVmvAZW/KsPTkX8pdG0EXsMth+sVWQDvSppPyvD6Jkw
	jmrZd4CHcQkmvW0QKaTPAxYBBxk4k3Zl937BBpUEMtrvRBlXdU9uRjk+PEtzfltx
	arnQNwL7jFscT5xGzVnmHl1zepkw7DJXcEaLzbcyrat+kGEPVceJx+jRlAoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787774203; x=1787860603; bh=3+Z6OMuy/r4Do87lJRPUaimlbY2AavS7pEa
	QfE4eIB8=; b=Tf3YIS4E+8MKTG2FH6tIwhe2KJKmapDzw/pg/LUYPb9LskKbjGX
	yRaWJbfFNy6jO2WZgE2Z7lnRMO6chF0uqx+U1tMs1Sn0PpoqaprVrTBii4cMHiUa
	rtfBH63JUHO4lBbbTF+rsIRaOkXJ0txuaJTpjyZtBp81PwZ3enBGaXElxgeCLXdV
	lLPi/M9UPiVzwFF/1EDBYKmr4btRNb9SF8lIkbeJHcXQ+5KAJhl8r3Qitajemk1P
	LocbpwUe1e0VsYDMAfMbAjGDhQcqAVoC/D+qu32GzEV67i5Jb0n1ZVGbxFzaedBu
	GWIxaUWtzL6wEWN24qDhcIvdPhJi/cdFl/g==
X-ME-Sender: <xms:-0SPalrV2v7S4ACADhG5LIr6amtDu2GArIv0WfzmbfuBcdSaHqzkgQ>
    <xme:-0SPaupzAj0Epd0Oxwxp_1DZyXJME3nj_GYE0fjASDdTFIrC_iRQL2LeFbZOYJGdY
    qkvnmZ1-PSUT2o6X3YHsYIUSr_G-KfWy2jVkqQSMo4HTl_4cPvtDg>
X-ME-Received: <xmr:-0SPanOk0WP2rnuWp_xFLH38UuM2JskvDuya0urLe0mWcdF0DfnC9J-hgdtS6j8UngtHFbiXSd_vs3U25qouS_tovfbiEbpqWw>
X-ME-Proxy-Cause: dmFkZTFWwjxxauAa2yUij9GpdBGdP6jxKto4niHHAfgpCI95Lal62Ee6e+mOpCSt3THxuI
    QuVGvbSUVL1uGOfeoai6kYwnlgHgWrbXnrcfpttV2gxU2AF1QWEzPzaBGrMPZlayWOcm/M
    qDUR8F+8Cm1op25PFFnhAmI7MDz4rEJt79PE+vu9xdF3Foyv6/daT+pjpi7Zl265iXkZxS
    wvd402+CLE5SBvpDOM94XiGjeYd3ZBWlMKQtFJhBvoYcRcHdZyOw2PbERO6ieJsvY9dmlQ
    8jA2vtz/w2ZRxUGvi/8ezX++V4TThimVkOn4dx29hZy1GnMnunYOOo4cNuLk0WtF+NTzNR
    NVseZXBwbNIy0r+dFHqBveAJCLc1MHwHmrdePvsUiYJcsaZXuxYRtAOkUI77QoW4vZ5M1y
    nnwtMtU6rTK9WkLneJk9KoRKvf/PILhrdvFKl88MzZJeL7vuhE5vg5wT9kmU2nwrs3Fc89
    ChDT4VCgO4riSN8sQubAnH04cF8L4F6AXJevLECDV7kcYD/7XGNgHbWShhL7uOzurnGq2F
    Fm/49ZzLjj+t7cdSpzmouENVIR5bPnoKlzJ9yvIoD8elFuMa5V6dcrPGJD4qX8QQBbyNo8
    bgcoI/kgai0eDNdZ0PW2PlrqgyMARPVQmW+q6d5hDMVX9QYleOIYqDLQye0g
X-ME-Proxy: <xmx:-0SPavxkJge46_dYpmv-Xku1I1CPMoMFi6Zp5o7yHADHJOkTD4N3Tg>
    <xmx:-0SPagudpNca94IU6MaQArQdStMxDava8Mz9t19Lt7vOmz15s7VNrw>
    <xmx:-0SPao4N6VTKqi6UXcA_cmKRoMsl1ZrT0qDejcg8cC54tAIxfn05og>
    <xmx:-0SPavRsO7Sd8egYLdNSw4OjjeW5XDx_WnNN6B6qUpAk_JBD91ODfA>
    <xmx:-0SPalzMdlkIb1ik61mAG32xIoWQO40HIeR_pbWudFNNv7_D558BnNLl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 15:56:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/3] environment: clean up repository config handling
In-Reply-To: <anlmwaEtwcCPse1N@pks.im> (Patrick Steinhardt's message of "Mon,
	10 Aug 2026 07:50:57 +0200")
References: <20260805115342.3939931-1-cat@malon.dev>
	<20260807085932.3958759-1-cat@malon.dev> <anW7wHfUxYj9cj0P@pks.im>
	<xmqq1pc9eivn.fsf@gitster.g> <anlmwaEtwcCPse1N@pks.im>
Date: Wed, 26 Aug 2026 12:56:42 -0700
Message-ID: <xmqq5x0wfyf9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Aug 07, 2026 at 02:11:08PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > On Fri, Aug 07, 2026 at 04:59:29PM +0800, Tian Yuchen wrote:
>> >> Hi all,
>> >> 
>> >> This series contains several cleanup patches for repository configuration
>> >> handling.
>> >> 
>> >> No functional changes are intended. The patches make the related code
>> >> more consistent and easier to maintain by improving documentation,
>> >> formatting, and the organization of repo_config_values.
>> >> 
>> >> RFC:
>> >> If there are other small cleanups in this area that would be useful to
>> >> include, suggestions are welcome.
>> >
>> > Somewhat unrelated to this patch series, but I was wondering whether you
>> > plan to drop the limitation in `repo_config_values()` that requires that
>> > the passed-in repository is `the_repository`. This limitation is
>> > starting to create problems as more and more of our infrastructure is
>> > migrating into `struct repo_config_values`, so using a different repo
>> > than `the_repository` is starting to become harder and harder in our
>> > codebase.
>> >
>> > Thanks!
>> >
>> > Patrick
>> 
>> Hmph, that is an interesting point.  What is our plan to really
>> ...
> Yeah, this split is adding to the confusion indeed. I think that we
> should make it a goal to unify those going forward.
> ...
> The last part about not modifying that structure could be quite a bit
> painful though, as it would mean that we might have to adapt call chains
> to pass down a `struct git_config_values` instead of a `struct
> repository`. But arguably, that's the right thing to do anyway for at
> least some subsystems that are independent of repositories.
>
> As you say though, none of this is really related to this patch series
> at hand, and I don't think we need to resolve this discussion before we
> can merge it. I just want to make sure that we have a plan for how to
> get rid of `the_repository` instead of only shuffling stuff around.

Well, after this sort-of offtopic exchange, the thread went dark.

Is anybody interested in reviewing these patches and move the topic
forward?

Thanks.
