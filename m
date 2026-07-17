Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4962F7F02
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305627; cv=none; b=DhpItyNrgxeql5gby/DAQptvYE1bM/u+oVr2tXc+aj6RH+UbCzgBfMTlUG6HsWD2Xlkb5GkCxWlzNuWj3smM6UoDln69DH6G67ECqkcI8cmtbL9eYeQay7IQq/sFjNW6jlAeahcYGhJ/fiwM7Ld7P0k8Xh+78RXpm420G5tDa4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305627; c=relaxed/simple;
	bh=g+1Duxa+P9T9OJPo3kM0AVfjm8OK5UlPMOsIXgmpCWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s2WEaw3DVzmxYBSpxZ3GjxqNDYAvrzkspN01D0rZPLT8mxjtt7Zbz7pc/8Qszth55OPcqFAwdrcTWEyC/OVkyDwoPmXbTRt984TKKaLzGiQM2nht6n6PPOncEzOlCll29sqOGBcyYJry2YyPZQBcI7FmapzQT4gSeLp3oLKi6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JItczBeE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VNPPT4SO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JItczBeE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VNPPT4SO"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DBA0EEC01CD;
	Fri, 17 Jul 2026 12:27:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 17 Jul 2026 12:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784305624; x=1784392024; bh=LDfXnubC5u
	WSPeQsTIc6Htf4G+Pk3pIjh6gR9I2ONEs=; b=JItczBeE8lCRqLV21W+I8FgQCy
	V+EQ53NNMcMaBLmd+//b+xsYgbUPV/WCcNF52HOgvgM/Pt3tNQfaMxRyEbOv0myo
	1vKP5udoEPVoNdO5aB4pUX2aIXmu+BUcoV+kKz71jkMy4WKlkTizCgkEvJagCib/
	grOGPn4FgO+nhDMQdxRLTQ1PyCjZyuC3p5fehNFc2nreXbM9MOTcDl4A/Z/bocWx
	M5uOZlJ5mzRP8qxVqu+Vht+On/ficAg5EpSLnXS/t0eEF9zSsrlEtDBl7IvfxL+F
	4x0b/wOAC7RuBF9w2Z3uHoAltLtyK1V7wW0SRo9LMV4ua61+Me3mmYidm4jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784305624; x=1784392024; bh=LDfXnubC5uWSPeQsTIc6Htf4G+Pk3pIjh6g
	R9I2ONEs=; b=VNPPT4SOEAdsghxb+PN4AwoWQSv8HMkFF/WcFTLm5YjkqIdRa5s
	eNA4oi6f/krstE/D+nPjfCTf0QrpT6mTLy2HTca12MANauf1OujPq26ikZG4U/4o
	09JP0zUGlo9sQoQM1/YNHLE+SRrm5isH2vz09RYYEf55s/A9sbkH/D6mkVP6A4ba
	BshvXO6XqvSvsOKRnPyl7ZeF9Xs7kooSbedcWUCPZQk+lQFhSRsyZXPM3bwFgIgr
	0/YO/wYLPemjRr3GHgiUj8JStX14NTO1PzQCi6e/9b7fGLHwsP6w6mCNvFLcVpnX
	idEpUZqbl+8sPltz9ZM/IffXTPnkJs2gaKQ==
X-ME-Sender: <xms:2Fdaak6h8MWjyOB5OSxQDKYCl3OfqlJSlFEJhhMMKetG_GbEM1hiiw>
    <xme:2Fdaak-9sV6T4rPYupfVpxPbBnGtHuFacS57MS4I2tBD05ArPpY02qweZe97uEIMo
    h2b032nSjk7DBwoCjDRBoGuoFb7uMzk-K1DHznHAEBY7UvmogHQ>
X-ME-Received: <xmr:2FdaappSI5yTF79GcX968jeXy60T8mBBM0XBeC9p_C0BDJ3g469kClp-wdHcXQblaQb-VcEBvsdr7O9Pf0qpO_ztuOv_FafEbprgL-8>
X-ME-Proxy-Cause: dmFkZTGxpINHbQD7RSUjd9ChlDlkXn2I7tE/Gzt/3DSS3h0jeuwp9UL/w3xSN0x7j2XCrT
    xSH57AeYEhKlrmHH0W5luzck4aOZX/+8+nyt2vxeP3ktu2jAADAeuOst1F0vQiVOLXbYP/
    yOs/jvbGB408rBz1wXCs4/iF6sf59WI5g6uq9F/tJEZFp9xU9Sbdz30V7ikogWovogp/S+
    4ibf56Un5A6wXmHkdQgtJVwWuHfG6tH24ttDiT7+ymy+cvNo7sqbMPA5zWwDpzVJzH1/xE
    yCeoS1UK1qODXXM1YcYO4I+0RFZFNELqZbkWQ6XeXAPNyK+SnARN/pYCZsYO4aqH3Uuery
    HeCFVk3knO7AZK1e1lGUnpnyCWDcvfG/HYfmRLsjquj9xQQfQKIw15GuTsPwVvz7xE7hTt
    eZPZj4kBbJi4vD5Fjidtz2TeOSSWz+rejtWMdYz5VuhwCd1pimSzcFzfKlWkQfTQ9D+DHi
    4Js1XE5kXDtZLnwHCMsOy4eDe6mCR+pkeytzh2ksBkB5PDWvXR7WpX/vQ+A0WqukygooBM
    MzwJKEnn7DRVRSvJk5dixITHifBS3hltHewms9Cj5RTgifNppypnXCtP45yK4ZJRadCOD1
    5s/n4/7D4efHAu85vQru0fH6Hd/ft7nVf/bVktHQFwCmbhURjdbuhzHz+C1Q
X-ME-Proxy: <xmx:2FdaalqlIV6ILn-7QzxSLraz_UxOmZac8qNAiN34qZO6NWpgLugAmg>
    <xmx:2Fdaas3RGPLt9V4CF80FPfSPKp3JhzVAw2Q2pBIaFb0V49KlPE_8ew>
    <xmx:2FdaajGAw3Bash4rKKCYIJki49_kiVh1rbKB-Z441QhGJGOJ4n9vfw>
    <xmx:2FdaanHrWNadqEC3UnotSiu0AmRIC19hC9SjONxK1SZeQXhOBdJbyw>
    <xmx:2FdaarSAI_T893r4-svacwgwTI69TqknTdIMAyNcugTo77uc2BzfvhTL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 12:27:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  Johannes Sixt <j6t@kdbg.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  "Scott L. Burson" <Scott@sympoiesis.com>
Subject: Re: [PATCH] userdiff: add support for Swift
In-Reply-To: <20260717140232.6722-1-diy2903@gmail.com> (Shlok Kulshreshtha's
	message of "Fri, 17 Jul 2026 19:32:29 +0530")
References: <20260717140232.6722-1-diy2903@gmail.com>
Date: Fri, 17 Jul 2026 09:27:02 -0700
Message-ID: <xmqqy0f94m5l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shlok Kulshreshtha <diy2903@gmail.com> writes:

> Add a built-in userdiff driver for the Swift programming language so that
> diff hunk headers and word diffs work out of the box for ".swift" files.

I do not work with this language myself, so I have no idea how well
the pattern proposed here matches real-world code.  Will queue, but
it needs reviews and validaion from active Swift users before it can
advance to 'next' and eventually to a future Git release.

Thanks.
