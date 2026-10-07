Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9349B5A2
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381464; cv=none; b=reT5nYpCzqu5ETkHS6bpP/7PSJ8iZBi6d28AftNzSc3H8gojtyGyQVdANLdZZnUQCw/9xUuULcivRgWFUSByHustEwWUq2bFh9MZVLNw82pS9hDk7zvvhMI4zvxioGdFo+SsAO9jv/I/9avAJzwVU2u32xiyB9+F3DPCWaIDbpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381464; c=relaxed/simple;
	bh=5hj2iOyvPObv3XRY+xltzYmTJygntC4QnuccLqr3/XQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MSbNGIWmuNKvma/EHnsfFQoM5P1o6TRam4TEqAMjtUkAfECjYqc31O6acpWS+Pf4Au6Wo2LEZOOxdX3ElG9G3vq48VuctFCquFElTwKdZ/VlZ8KGVNijzO/8nkFNxCJGoLp2xVV6Ksl0bi08v3xK64yPcmeux53+dovGdvQIT9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=WJwanzQJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tfTnNq0O; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="WJwanzQJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tfTnNq0O"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9115A7A0154
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 09:57:36 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Wed, 07 Oct 2026 09:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791381455;
	 x=1791467855; bh=bnMCE9hq5KLIvFupexr205xz+rFTalllWM+zFFa4ceE=; b=
	WJwanzQJFwOTNUnPOvxDa3PHSYOP/Ls90IPJ1wr+CdbCBmUkOeHx5Hy+5/4lkCSf
	t49QvaCQoBktYetfsbz4Jfcz95YcCWs2IBLe4hAD6QkCEl6zl9f2aENNa/V3YB6z
	0GIIo9h015nYkEvUTk67vkS396zeIBmVXnYcf3xoaTitlLDBuSXZBrsvSKQ7oa4+
	oGiCDHaavExTBmaGzfDTebW6mknxwVwPRqQvp9uGCd1viNmX2XcksVbtheCKeUCC
	wCWU5MqEBdy7TjaQUHChEwE0T5Zmac1IlONY9mku89c/wgP4hqg0p21pp+Xv9odX
	0vfjaEbEZVP1DolUOsLi3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791381455; x=
	1791467855; bh=bnMCE9hq5KLIvFupexr205xz+rFTalllWM+zFFa4ceE=; b=t
	fTnNq0OuuvjXI+Y9v5j6+dyzLeybhD5V+vloptnDgOBCL72p6roZ0fM/SHP9NUCr
	C9sUU6JNWmmDYIpib+gcVxE2E0wd5lhgNdTRc8XDeLaq6ryyd7iHmtJpfWoEBZnh
	t0gy6pZ71uDf4K72yaXy5TIcIK2S4XaD2D7/yxJcs70u/LDzZa8oumBFEAPQ+bXm
	xK6wtGt7b7akmd4rEKPhS5AJIBE4jXbue/aiS6AhZKY2QhaY00oPfCbLHV09iB0X
	c1Cv34tU+eYH039EcYslh6ULix41xNH0im8/EQZAKzAD5i5b/MH8r88Js/KNM8dE
	N3tBPJ8T7HQfWiF3GgD3A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791381455; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MwSb4zzCjPL7QBYJ60HqI8atlCPcvu81XrUZbPk/zM7jSIa
	anKMasb3remX2pPMtfRjF3BbTKy5NP6bgzssaMZNw/B+iEijhbLNavBMSHiEWtoX
	Ln1/2ib5550VTggcti56Ajxpww1YJh81kvCbuqK2klAxWfBX3PV9N1mkPhYsPBSw
	RJFNTDtSIKyxSXYcUF3eEZqJCtPRpIKkDeUVbCt7IMaIfvCN59UhVtiMA6Bpc9U1
	WBkJmiJN2APTeGIEy07MZVBnA7T+dBKL5QuxqTxrH+MuZwM6SCiS+TOABGaiOF+e
	/OK/ag/S0VFDnwVH1G60jHuZ5J+9fsWBp1/koIA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DyVdDeaepBs1KiN75vuo0zNAoy6dz4uM/u20FWyoWas=:5hj2iOyvPObv3XRY+xltzYmTJygntC4QnuccLqr3/XQ=;
X-ME-Sender: <xms:z0_GauLB5pZoemI7wT37jomel30dPWZe9iIW6AKhfPAw9QAoAIFrQA>
    <xme:z0_Gag9tWCb5VbdbVbamycDc0jfPCO9U3wSXRWLkZn3MhJiMWcMQbhT_UsQSmCQUH
    PBhz4iquP3f0agIyianv-OIfg5vlN1Y7CExfqUICM-6wm_sIR8fVDFu>
X-ME-Proxy-Cause: dmFkZTESr6N1v5sqEuF5dC9jFSqO/cJ0Z/BR/v2t+hW+mUusmE1NR1MgpHUUu5H4aaOL5Q
    P4fgWQSNzg2riqgvGTl1q2yGElyZgBCOIJvJftSe+vixoo64e6GnOwVhTj73gO6rgUd9qd
    2b86Opd4IbIBjoFSIjV63Wlh8nSVvowGVoB03thtXj/pFyOCzPzVvda+vR00toTJjhofVm
    adhggh8m9Ths4JGJS0ExKk/dS7ROhVtFx3jqgOadyBgGSRE9Q1/hlxIehPiWOwVtPhiEPm
    JvIalMqmKXEhi+ZJq6GMOC+GUQ++w9sk0eTeBlD9xKVtptXJndNhrERREtZZ1xt107uFgw
    xOCJObtJLpGrjqLrHNLecP56LUe5ZoJb52i3ylN+7m/W3uM7DWSj23dmHBIowh6bRe3E+3
    Yv7l47C2mByovE5ngBMr/6OnCO76e4X0gxhsWflAC3s3+Jia9COYLF3+qyHnZnHD+aRndR
    NCD5ennHNt4nQ4YkNke92oyhLl7bDZ3AcFa7nP+QhwFLwnByB9QD2/z8YnKDz+Rtplsyh9
    wEKVJcpfqSva2iUnwOX0x/gnDZ8f5awtGh5n0xr19AmUJnT9wukHNOCdC4IbCOLlBIccfj
    wWOJuQa88suMpBfTi9HJZcGfHQWX0EUCNTvYaG+cTUA39Jd0To4jYCoyXdbg
X-ME-Proxy: <xmx:z0_GagOXUZTOARcenoNLL33ejq-oGF6a7DPnRO7Hx2xkeYOpTCw7OA>
    <xmx:z0_Gaocoz8pRwqrF5lALadt6cf-Q9ROgZNNgYXxGt71B-lpqsaCMHw>
    <xmx:z0_GanVIJxw7wBwkIBQNI4WISfyuR1zfNND3USV-ZL7cjsWjp0VMEw>
    <xmx:z0_GaohRq41aq2n_emIWgqQk9RDKIfAlCfjOXMJSqGIV72nXo5DTbw>
    <xmx:z0_GanvZW0bJ5EBVv6a-e_5QHrQmRiUYj3MUjdUC7yJhpnYv8b7Z3TUM>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AAE38780070; Wed,  7 Oct 2026 09:57:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKh1_XIvpk3w
Date: Wed, 07 Oct 2026 09:57:15 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "Julia Evans" <gitgitgadget@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <2ef42736-8879-4399-bbe9-3ba09522373d@app.fastmail.com>
In-Reply-To: <xmqqv77dbp1e.fsf@gitster.g>
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
 <pull.2242.v2.git.1791317163584.gitgitgadget@gmail.com>
 <ea29fe74-7f76-440c-9597-fdbc173be90f@app.fastmail.com>
 <99bc9624-47a5-469d-bcae-8daa9b01581a@app.fastmail.com>
 <xmqqv77dbp1e.fsf@gitster.g>
Subject: Re: [PATCH v2] doc: use `man git` to teach users how to navigate the docs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026, at 9:47 AM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>>> Nitpick: Okay, but with the current commit message I don=E2=80=99t r=
eally
>>> understand why the git.github.io link is gone. I have to guess that =
it
>>> is an effective duplicate of git-scm or something since git-scm does
>>> remain after this change.
>>
>> Yep! It has the same content as https://git-scm.com as far as I know,
>
> Correct.  That is direct rendition of what we ship.  git-scm.com has
> some fruff around it (grouping and other meaningful usability
> improvements besides coloring and fonts), but I do not know how
> up-to-date the contents or the grouping is and how they are kept
> synchronized to the originals at git.github.io/htmldocs/git.html.

Yeah, the grouping at https://git-scm.com/docs is a bit out of date.
I'm not sure how to fix it in a satisfactory way.
