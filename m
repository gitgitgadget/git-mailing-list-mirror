Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD13502A9
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605518; cv=none; b=gSaR/9QSHZ8E3I3GWFg9VTZbwutNoz2BxcXhr09KwyBeaJvtIgQVMd2xAsx2rHi7F2MJMfDnvqDPiYS+8sHQ7Yx195QjBQ7R7kXJiXH44yWQ+2vxFcL9yjgDfXhpbxMFPkNKrvZJrHAN1+mhfG/ayIMEpMfkf30mX0TD3onrZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605518; c=relaxed/simple;
	bh=RQTIfKWDjkdEdqnvX1wwhqGCbibIz1kREH6sAOIjtlA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uTwGM1V9w5e0LWUdEkowFK7DKrr1qOO7RTvFhJ127ElYgdHr+loBsyond/2F1nWTD92t9XHDz6ORxSrv+0iIJ490kzlzK85Qmop0GZ/bGt246JFRb/gADnsD3cABwQsMVwS6Hypoz/JnjXIX4I0qGSroxmiUZIXScfkH2BDivT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jR+RKfeV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GcYGhY40; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jR+RKfeV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GcYGhY40"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 435BB7A00BE;
	Thu,  4 Jun 2026 16:38:36 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 04 Jun 2026 16:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780605516;
	 x=1780691916; bh=AjHzjng5iSxwduZv3blzofVKOqP7EcrGQtXB85k1WRo=; b=
	jR+RKfeVV0KOxkezlZadmugytXUeo7bbTA5qAo0QACxVJD/pODNGR7ZfuNsUIo0c
	b85XzfJ6037lqZ42lAd9ZL4j7holtG6CPp+3CSWgoHWGkoRZ+YLUt5i+WY6fXpMm
	p8MLr+HvwMUZ4cM2OUvcPzmwFtdxGr7+Y7Y2YQEIG2XbkNYCTIb38/mFJVmLI5/r
	Snbgtll4dvOEi1OHDK9c96bUiIl68TbI8G2GU+nV4pSuhfsbdMrftM4BwjqI/+o8
	bTVauYO4MObsDvagjZ6HAuzx8+CNz1d/Co+knrvzDAtUcVwNbsLVM6MXQKOqc0bB
	NqsA5STowpjzP5QAsdHRgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780605516; x=
	1780691916; bh=AjHzjng5iSxwduZv3blzofVKOqP7EcrGQtXB85k1WRo=; b=G
	cYGhY40wiqqYr7CTPfSXeAwM6nAPF3AclZDpOJMVq2FhvRA2/0pyvpxxFyol2SUu
	h8c0Z6o9rKVtHLwfxS6qI1p1GXfoYd8dDClIfev3fs4AmIHm4hS+dk34naztZHM/
	oRKntPdB0DYrJs+30UZmvWrjNIyGcV9XkGx4B9tKyPqhdN+PpfAzciMLaw6XJQIq
	0G7RkyERii4QoYJjw9zUq/P6e+SBNm4T/L8HVND20LqHI8YPTnDu2clm44SwhEEk
	+8V+mA+i8y8g0ITadYri5WUsJ+9388NFvyOVQfPxjswOXcku3E7amhGMBlvrKZ8V
	ouUGnSXjDXlhcjXzrgysQ==
X-ME-Sender: <xms:TOIham81m-apt3SiWesjlY64aC-0AlLndPg91nmzyYvzP8HQLQWiUCI>
    <xme:TOIhahhO-gHb5hmCjS9xLAOUBL7NjPJcQqJB8K7ttbL6WE3IMw-r8vovxMwZ1Jfir
    8dH3V90DOSS6fMRXHrWbYGZAgLydU6b22hGR3dhRoEMkHxFFsd5>
X-ME-Proxy-Cause: dmFkZTEIe1DIO1aXL6hRc8iFxR17xW6a17c1C78ZBbf/SL5HV2A8TAmNiOLx50/oxVfKxU
    kRNeUftWAzA3QPpuE8ZgNYhKmNMXMHEFkVMiGU2LJl//nnjVLN7s5b3zWmJaWj5Nru6PZF
    m56VtOwl/Nu41fOZx1vwuyrq9c7z/SMrEUa/rmMwc19dgNPyI0+HWxhD79z6doir/yvJ9Z
    LLqRfsZar/2DQ+vNx6MyxdipzEpcujYGf3EGpVOKI4cyRl4JGcVfjhN2WOltQFJ6Meox8s
    de01lsJNyFmp09eS47usmas/LzK/feq841V/qGvukdWeijO1iaH3pys58J3AEF9tI5M/F0
    l0xYJbloThOVYIPOdM0IKOuYhQAeGAq+s4HdOSqOrK042foBB/RctV+kDW8OpNX40UHOVx
    adRcntDb51k8fGUHOy7JS37vBIg2zdGLGlrf6pNA70lLvtTbC2Oe4EHTvRsEHJRcJ6yblN
    nHNLj0HgM6aKWlzJv8adT27j1oxNS6afy+XYQnQ0n4T3VsnCJTMWU/hQ/QKQAJenjZ3WgF
    DqOL5rWCFMzWVz7w96RNQvNxDcfI0V5OaavD6469PIUcJqDTtJRcdqwXJXjr2s3n2LI6u9
    hu8je/l+1scCbm1jVB18w/GTgj7jfZtrh/UznVZsGmfD3bE8d3r9hh5+Sa3w
X-ME-Proxy: <xmx:TOIhag475kAwDQVRMLD9tWYWwnZKJetnt_0OkJxGfKi39WFCjZlIZQ>
    <xmx:TOIhapo8yPjScsEqhzMBUP5-pPQa_mywsMWp7LWyGB8FWS7tUP-mtA>
    <xmx:TOIhaiilDagNlMYT5ovIt_4oikJ5uM8o35HieyBjuOVP_VYgMMZErw>
    <xmx:TOIhajLDosu5COyu2xM5k2mlnvQzw338LcfyRjG8G0H4-3IPnq6IQg>
    <xmx:TOIhah1vBIfmX1TDnRYbm9W8C2CJGswihlc7SLwuDt1CQpT1A1B59nMV>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E98393020094; Thu,  4 Jun 2026 16:38:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1vySG76hBlV
Date: Thu, 04 Jun 2026 22:38:15 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Siddharth Asthana" <siddharthasthana31@gmail.com>
Message-Id: <13b1ac2e-3790-4553-8e55-5ea2adf8f46a@app.fastmail.com>
In-Reply-To: <xmqqse78fsn2.fsf@gitster.g>
References: <CV_doc_replay_config.709@msgid.xyz>
 <doc_replay_link_config.70a@msgid.xyz> <xmqqse78fsn2.fsf@gitster.g>
Subject: Re: [PATCH 1/4] doc: link to config for git-replay(1)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026, at 00:18, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> This config doc was added in 336ac90c (replay: add replay.refAction
>> config option, 2025-11-06) but never included anywhere. Include it in
>> git-replay(1) and git-config(1).
>>
>> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>> ---
>>  Documentation/config.adoc     | 2 ++
>>  Documentation/git-replay.adoc | 4 ++++
>>  2 files changed, 6 insertions(+)
>
> It is always nice to see documentation gaps filled.
>
> The `replay.refAction` configuration variable was indeed left
> dangling without a proper link from the main command documentation,
> which is embarrassing.  I wonder if we can add simple "doc-lint"
> rule or two to prevent similar mistakes from happening again?

For what it=E2=80=99s worth this is how I found it.

I was working on the kh/doc-hook topic and noticed that my changes
didn=E2=80=99t trigger any `doc-diff` changes for git-config(1). So I ch=
ecked
the file and nope, it wasn=E2=80=99t included. Then I massaged the file =
includes
and diffed it with `Documentation/config/`. The only missing ones were:

=E2=80=A2 replay
=E2=80=A2 fmt-merge-msg

And `fmt-merge-msg` turned out to be a false positive since it is
included via `merge` or something.

>
>> diff --git a/Documentation/config.adoc b/Documentation/config.adoc
>> index 62eebe7c545..51fabecb9b0 100644
>> --- a/Documentation/config.adoc
>> +++ b/Documentation/config.adoc
>> @@ -511,6 +511,8 @@ include::config/remotes.adoc[]
>>[snip]
