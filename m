Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D622D594F
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794197; cv=none; b=eYG05V9UgRqamgLKUSPChGLGGHyrLlml9AvMT2Y/G5L3yp6hSK1C/1xccGCe/MaziLbxypFmm1VpDJ52qPNC/x41w00Ns6bOzgbjP8w24qzcBXHk1yOnIM915kOvUINh2Noc3TmQ2KzpIS3y7onnurdFhuBQot7yH2uiTFmpdy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794197; c=relaxed/simple;
	bh=oFj4QnicFWACmVlPWn737f9qbHGJHxsz555Do3aEZto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rs0K96c373PlqvzN0y1g6b5GxWdJQCBRvrWzmq+GEkujv6MdSWtZORzxlpOg7DSSzG0WrrjrPFCrNUyx462Vjrve4O4MadpMQbJXDsdthyZ9CrIlKlSPVRL2Pax9J7pEQP9yM7R1HK4BK8NUrvJLw1MzVVZrFSxSKNeCekrK+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fPt2Z4uP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dXP2Y731; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fPt2Z4uP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dXP2Y731"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D020EC0209;
	Thu, 18 Jun 2026 10:49:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 18 Jun 2026 10:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781794195; x=1781880595; bh=zxKe8KuUhC
	JNo49GjY/jwtWUZJp7f47KrJhyPXCufTw=; b=fPt2Z4uPLvXQmxQIBg7IHx6EK7
	UoPCCZV9PQRquZ5UGG35VNaBsi0cjfKglGWZC0U0By39NAUORbKvkc/shY0ZkJ9J
	xRnqTdtEyyIDu2KbvjtocH4wxg4W2pcFSQQAwKeW7zkHVzttQOFkD8f1WSesWgTz
	23QbbiEeqZKXy8dOVOdZUfNAbQmM6tUQCAZ9ubqPbeVEpLzIw6M3SWTs8rbzdz72
	BSCe1Qsc31ybuN11psXLrzKHHYg/YSYptZpSL2xL/RnBJOAyjPolw9Z8KJ56wWGp
	gWlSTzJTvYDwenVnLoXswRgQBfDtZGkxec76vgCS+6cH/2Lqw0C122AwrBbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781794195; x=1781880595; bh=zxKe8KuUhCJNo49GjY/jwtWUZJp7f47KrJh
	yPXCufTw=; b=dXP2Y731QhiEByQzOKq1O+081jfovC9fasmsF/SM2ZpI9mCOIt2
	f5isTu9+RC3jcUNegLP4ZZ3/yB32ddXrr6IqowuXs/P8IcllWtX+ZNjGuWVUSdqQ
	16JeLkHFXmelxEfXKZTfmtOV2hntIWCCbmWYHduYr7+BwsSGRfGF9/rSBpqk/cLb
	c7QPbr4snG+zpQ2bkyXYnQk3MfF1HYWwtkfAzP4ahuhHPzXp5PeHAu3jJMcxU4Fz
	4kFaMaiLx/FcnCwqhRBesrtYJABj1eR90AOisYnw//hjxCVjcT0atI/bAVmoQhuG
	2QsJvmElGEFyZKt0WyRgBS97KzcA+aTBkmQ==
X-ME-Sender: <xms:kwU0atiH617kQ5L-8z5xeTFkqJ5pZH_9Fyd9y_kYQzubovJS0tXSCQ>
    <xme:kwU0aoCGCGpYXbPR5O2sL2B719wP67R9Bx3rwU1za7r1hSIqWjp_LIfF7BdWnEaAZ
    KvPELEWqE2i28UHkLEfba361gisaCT04YHu6-8SCQrrEfwNJbjFGg>
X-ME-Received: <xmr:kwU0aqs6wQAJUw7vK6q2s_m8fh2NpWveOgLrS1ky_7puM9bkHwVeJdYaF2BhL1n-c6lZueDsNj3xc4X-oquTYt0-oGz07XP9T2CpJz-YHVYkgt56oiIA4NI>
X-ME-Proxy-Cause: dmFkZTG03XrAOjzOGBxxMrQofWQQ5JKRugsFaywEmN1S2V7M+hSROGpM1FtpHHmx3PLX9x
    JkxfrYgm96/xhdRnsGg7dkQM9kNX1OBn0etbQtXnnf+GJn4oBDLo77s2SPwUFbqESSaALb
    SiCDTRjikaQ5MCN5uO+AQQGFVvU21WsUdvxIjghJtCbmAkpcrmlVr3+V86ZUkpRGJLSIOi
    kOLiaEEz/jFz8DTS2JLG67/q6K7TVFYKpBONamJyNBWhmBtoFaKlb4aazLtOPC+j45SAH7
    CfXHgWl0mXgy3Y0uSVAzHkchFcbwAj3Wi+0AgCQedit0wt2C2/Vdt7rXZ2xGAQ37gbf+ai
    6s6kVGmCUSY+B3S7tcm5bU+UpOlqGuiYI6pPJL6qeN/meRS+mcyN8qZtOEiX+SRBO3NnpF
    lTS4Rbs5hOXaYvtTsGXT1KINLiFQ55miD8nGanoGOuHIZ59PH8mtwuQL/qQJThVYwF7+vR
    Jaffz1+OeN/nOt6l0zOBRN0iDdLqZOc5WcbZwTvhkbz4W4m8Hfz+uV6rwXoUTHASomAFtt
    QwYQmYqPWkmTB7nLkub/XjiCN5zsMq/4ylDdjGjMdcf4M40rsEPfTI3k+h2lLhzuwP7LVj
    6Ttrrnz0YDUReBXPB0GeckPm/9pzM47L6l6lG039+jshqqIzK7CQD8LBMPVQ
X-ME-Proxy: <xmx:kwU0atbleXRBIK3A4vEJWxtS8ujyKRqmOlk9ZQfbMiktgYcSkgfmZg>
    <xmx:kwU0atWdc3uDEhubDil4INLNYWJQBVIGp7VnUBX89v0GQ_6O0Ro9xg>
    <xmx:kwU0ah59-0OLr8qJiwvbMY4UuV_H9tZFY7Pcagn4xyU6R1eImpTzWg>
    <xmx:kwU0aojsuRvUWygDqzp9hKS8O5ZR9XSUs2enx6UliLXR5-16KtJMHg>
    <xmx:kwU0agksb3E7PrgV6PNFgVj580CCAMk8D8VUeI0i1rd4T1BbsvFM1Tfj>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 10:49:54 -0400 (EDT)
Date: Thu, 18 Jun 2026 10:49:53 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Matthew John Cheetham <mjcheetham@outlook.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: t5563-simple-http-auth failures with v2.55.0-rc0
Message-ID: <20260618144953.l6Ng-dvv@teonanacatl.net>
References: <20260611210456.XYfhytSL@teonanacatl.net>
 <VI0PR03MB1163416D5C66FAB25AECAAE21C0182@VI0PR03MB11634.eurprd03.prod.outlook.com>
 <20260612180203.s2qSgDUs@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612180203.s2qSgDUs@teonanacatl.net>

Hi,

I wrote:
> Matthew John Cheetham wrote:
>> Thanks for the report. The failure is not in Git, it is a libcurl
>> behaviour change, and there is already an open upstream issue:
>> 
>>   https://github.com/curl/curl/issues/21943
>>   "Negotiate ignored with --anyauth" (Dan Fandrich, 2026-06-10)
>> 
>> Dan also bisected it to the same commit I had locally,
>> `8f71d0fde515` ("creds: hold credentials", curl PR #21548).
> [...]
>> Daniel Stenberg has acknowledged the curl issue but has not yet
>> posted a fix. I will follow curl#21943 and, if the upstream answer
>> is "the new behaviour is intended", come back here with a proposal
>> for what Git should do about `http.emptyAuth` and test 18.
> 
> Excellent.  This is it good hands all around.
[...]
> 
> If there is a curl update, I imagine it will be picked up
> reasonably quickly in Fedora (and elsewhere that was testing
> 8.21.0 release candidates) and there will hopefully be no
> strong need to make any changes on the git side.

I saw Fedora picked up curl-8.21.0-rc3 this morning and
confirmed it resolves the git test failures.  Someone else
has already commented on the upstream curl issue to note
that.

Thanks,

-- 
Todd
