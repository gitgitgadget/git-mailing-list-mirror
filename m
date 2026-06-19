Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2AD1F30BB
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888533; cv=none; b=bKSHWGQKs2Kd8umIOKa57g0B2Wn9Y3B8Epu2ymXHlCIFc4KQ3rX2obbBeRbXgP+grhKntWBvtrlhmLUvCOXUw7d5LG0Xky/qlYgr2N8/54/wsinnL+5MGA12OM7u9HiAExrAlCHYtjRUAwrgOeiH817CrlKlJNlsuQA2+SJES6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888533; c=relaxed/simple;
	bh=efNpeBvEkDHr4Z+nqVvPxabKLUbJGF/tNNp4ZP/V4a4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p/rICOFe1zjljiWTSfWNt/+5o/C8bHAe6j+/PMS0b2LZwgLDWx+jFlpkf7NgXTGFByhGlq1/zJUOGShFhAWK8ocY7nUGlVwEQEdJo2yC/Sx/qcVpsg535zH/9GY1c/WtOSlhRA4/1HMuPe8/BoWcmad0D7uodCjLK7TsrI9jKdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aP2vnboc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XdoHWHl7; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aP2vnboc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XdoHWHl7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 759FE7A00C1;
	Fri, 19 Jun 2026 13:02:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 19 Jun 2026 13:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781888531; x=1781974931; bh=1EODCcpNDC
	c5xrcYalNLafGQ90d/0sl7aIgCnHfALv8=; b=aP2vnbocxa2YyNP5nFUnQfJXEF
	fAisHJ8NnQgo8pmfK26dLBSMmzu5ZCe45omrcjuhhcAVQdaawDgYhROBADYPBUCZ
	8lJl2QyhctnlGrh2h4JKE3araCX7iqXmr5swExAy5ZYitCn66kd4/6bwn+FQUkcX
	3LeNQciDnPcNjsmt0gFfLuOaxbGgCHieEuAW6KPTuyyPdjIgY8xmjX2udYOyDUXz
	HvxH7zdvu/o3NobZ8cb7qDMFSKbk2+5QaNsI7nxr+Vdwjo6xxurzjIkJ3cBHz8xQ
	MFnjgcQzYPnswGl6s0Hlulmw8qeLscjJT0MXwp7ByqfLi8UXlJ8URSAN8Stg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781888531; x=1781974931; bh=1EODCcpNDCc5xrcYalNLafGQ90d/0sl7aIg
	CnHfALv8=; b=XdoHWHl7pNVHhjyjwezTkSDokdwKofpoXcvhHxXySq00mS5F2CD
	QZJqImX1XgYKaFzS+qg3d1PNYOkeHhwH6i1iEChwUznHIDt6znG194sGOKtBgEcu
	Qm3n+e87SonJcN82DtBro51xiCkYsRgRHjK/uy5PZIk4A4RoTY0mR3RESa9YsP27
	ho+eWMmK+oL16Iv5aGht2rzX3ITE9e9amX46RvfLSPWkxEPBfe4UwIcHmnflJE7t
	CzBAgPETjYJjAf/PLQr5P1wNKyPYypB1YO5WiIQbxHGbH82EROuEZIr69EoVrEWe
	4P2j58s+to8UL3MAbfrEASNg0+wFPwYABPw==
X-ME-Sender: <xms:E3Y1akWrjbV71UiL8IErAGnU1Yc24wxym6udr6YA2VsbIcmnP5D58A>
    <xme:E3Y1agDinwA1xpzkHq1lJsH7a3hLSp-xfKz0qUw8lyhjmIx56IejziJY56xgAkO1n
    lCoAwrlQoV36zwg5ExpXCeEyCXBvJ3DUcRgVaBVHJZrSFdUrZBT>
X-ME-Received: <xmr:E3Y1alxCnXUFTQjcamXLUzF5lApws6pL7Q69gbLadSHeGCMLErPNrlWuCw0DEFlFPm_bZfitOGzDzz8jalY-rFPFyQnhHsDO_r8d>
X-ME-Proxy-Cause: dmFkZTG4UUFRZUQid/oRl3AiaNYFveWO7CPgHwxmRdJ3Hg/1JZdKQl3rkBo1seR6zeFa4I
    13hmn8u0qNIp4WDkJo0//0Gu07nyPkmF4fbAbh+wvDHX/v5NGNm0R+sQAGlkOWwu9u8fp0
    TxRGEG9zbKH5rZI2ksczKGQa3yl7TF1b80tt+EzsyXbJMHbjZ/WGPnr3+VCII7hA5xkvCe
    DwIbXfDQLVTQXboLdtXWGN7ZudaGOUklJYXtY7FwK5NjsU4kyfRfSLJouzMRm0GBvJLXDe
    JhPLc6lURguun7bzundeGLK486i4ODhhNz+K8S2j6HvZOBsqeVJ847S+24/6oUkHQUFgah
    BhyrY42KD6BpjpJ7gyOQThcScECllYIWRkF8XQAhQlG51wBPpIU/YWIcjvCCVbcqkH6ip9
    XpudKIsidzs3x4Mz6+IUQNlwsTU0HABL2B7tKllCUf1aU+9ha2WmOQ1k6cZ5SYVjvS7CiU
    vx+WXgMAclLAAKmmZgfQrRbskHAf4PO1c0jRbJJ1zOCjSvZoIHfrlW+psL4nNBg276/c3s
    fv0XV9tu6x3IxtkLIafteQ4rNkrsz1iL5O0THx+f8XhbOiHuPP/uGWGDMPB81PCo7LqpAx
    0QRLJII/u3o6lKm7ivG4sHO7ovEKCLCX92kw0WBwEP6Jc/6mHJCiKtoZkewA
X-ME-Proxy: <xmx:E3Y1atBsLjvFf--AVFqLPZpthCXoKeMdH7JVqdCWmfIYLI20vwMfNw>
    <xmx:E3Y1aiawqAKCuwHivA6uVHG9GYdT8tzUjwtY57yxytu9ujp0ojU-RQ>
    <xmx:E3Y1alilrhHbua3oWwf1wz64j_LzB8BXUymBtMOl19BCbp-wPsWLhg>
    <xmx:E3Y1ak6A3JpGU48no9E-g8go0c1HLKvJxtt2x7FX2PYZCdCqllFtGA>
    <xmx:E3Y1arshdgzpARccJUq0eGY1yMqw94TfmQevl951IMrJ8Nn-opOsAatg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 13:02:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Vincent Lefevre <vincent@vinc17.net>
Cc: git@vger.kernel.org
Subject: Re: Strange behavior of "git log" with file argument
In-Reply-To: <20260619154448.GA769454@qaa.vinc17.org> (Vincent Lefevre's
	message of "Fri, 19 Jun 2026 17:44:48 +0200")
References: <20260619154448.GA769454@qaa.vinc17.org>
Date: Fri, 19 Jun 2026 10:02:09 -0700
Message-ID: <xmqqwlvujwfi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vincent Lefevre <vincent@vinc17.net> writes:

> "git log git-gui/git-gui--askyesno.sh" outputs nothing. To get logs, I
> can add the -m option. In particular, this shows 3 non-merge commits.

This is a known joy of subtree-merge hack.

You could probably do 

    $ git log -- git-gui/git-gui--askyesno.sh git-gui--askyesno.sh

The thing is, in git-gui project, git-gui--askyesno.sh script is at
the root level of its working tree, and we are subtree-merging it in
a subdirectory.  Once the history traversal realizes that a change
to the script came from git-gui history, it would need to be told
that it needs to pay attention to git-gui--askyesno.sh at the root
tree as well.
