Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F62E5429
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 05:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413400; cv=none; b=iwjQ2cvGI8ji9rDa5UqOrMyhbyirIJj7/kMjAoolnFx9S1tj2b16UuJokVx12uQ+v0xyFD729PZ1zPHaDoiocvCf/MSOzCsRZYVX3Z+dTMYTadEp2p7jliI9MCrR+E1noUlSzz8IWXlfdAZc+U2qX1zzTwq4knLPMN9PkNyFlnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413400; c=relaxed/simple;
	bh=yFiQsY1nKpHn2gipZvpumFtPwjlhw7bMouQ9hewg6yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQBBN3XZTLyHpGTaeOZsiN32y0Hc6ofS+y58L+VT/U6ZuRFWbImV46f92KFs9vXFq1fheAXuUofEsJURNKje7dvblprfDymq7Ley4DRAWH7QofrBfs9EqNydisYGWovQrNXgXpNf/JFQXlkvqEUy1YATxxUxFYJeH2BwHbXukPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GBI5xrOt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MLSuXAaZ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GBI5xrOt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MLSuXAaZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A47C77A0100;
	Thu,  3 Sep 2026 01:29:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 03 Sep 2026 01:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788413397; x=1788499797; bh=UKH3mASQJ5
	pJdY46DjzkQQ6oHa5Jwpzdf/6r+KowR50=; b=GBI5xrOtr4Vd0A1zOO5JIoOgJH
	unhUNmuuCGMsYIDo92QQUmezuA2R53yN05zfHiNQ06R0cBlnUEDqtVJLanXACfIw
	O7dtAaRSoY7aZXSRLW3cOoNupoxVQ/QnzmKLm3KsqvMYZxKhQUTf6eQdCjQzdvMi
	B2hzJIK3yFXFEqsCUUiAVWuAWbrM0R/ajrv3DJ1x6vnbZ0a4B00Qo3PDzSTotonO
	tO8CFeNsf6NaHtDo/OshXgzoZYOrcFXQBKeNavGzvxmLoR7k7NDzXP8xQtXwGdOW
	MeN64H9FeaCKz1l6OWpGFvDRSWEWmfjKWO4mnjTqMJzdaoMxuB3oPOd1Wx9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788413397; x=1788499797; bh=UKH3mASQJ5pJdY46DjzkQQ6oHa5Jwpzdf/6
	r+KowR50=; b=MLSuXAaZDkLa8giaNt9dHhvARCSw1wykvyaITQfeU96XFE2x2uo
	8Qpc0tUPL+MWJMNeicUxRf4jXEEyEcWRiC4wJi4rrSaw3pKdSdIunDcUBU3688V/
	0UKWqZ9nMmtULAe3ZHspIgYAkLxw8GSmhWsWEmc0+XlhZdX4xJmx0IdYcKPixy27
	B9WZVd452+7/WJVgWrKQ4JOTH7GkdG53y5qe0Ovl46+wDAibOiA/hOCHwpvQeGJC
	bldyJ3lymZUHaBJUVHlOrkYOPa2oAboaUwHcq/jgomBcBQuJSYu+63LEK+R5Gmq+
	Bx6sbsof/Bw+c4rqJj3GlubM0hjE64UuHmw==
X-ME-Sender: <xms:1QWZasP_KoGFXBkaqknkyDM7XinSjUrQznJB1wWPPh55Ck1eK6-PLw>
    <xme:1QWZaqYPrjSAEIg3w1Ubhn1xbidglqJoHj_gpXzHqxzuGGYOPflM7w_JjP0OwV5Eb
    g1SPdxX-rwVkiH1qkTVAe1lMqeInFxZrVW0Y0XVoRfWo25ihD2EKyA>
X-ME-Received: <xmr:1QWZagrWsWWyVTEn5EotuPmsmCWtxpYTY5yYb6jo9ub99bToTGGGDA>
X-ME-Proxy-Cause: dmFkZTEQoU7KhaLizCGnZUBZsVFdCnaSKMymJNI5YXd8qwyi2k78AjcEZYkSQkdqTcQZJn
    JrLkkrS94rdBbaztgsaf+vWmhBdkmLrMeP49Zdk2a1a7piAQTmhA/aFmLB8y9hqEUJWBJF
    MKseqQ6jflRZo+iJhuZO5BvzZi5uaMZlUWfSsIJcYIo+F0FlhmE8fdFopw4hZR7cdDiRx6
    oH51ajg9qlpoUEIZyIJ5/Z9Pwndaak2lr1MGSdRjxTMsl5yRXrwER/qbWksRkhewB//pXY
    mP6O7uCWfQ4Hf7fSxIcfz71ivwhLFeHkqjQO/VH5RsGvtriBpjAirbTLdFgm4Bf0tH2yY0
    +PsyyqoYjstHFXQgkHwTpLG8e+YRnbCo9QPuq/xHXAy49m4qWg0MNJXLHobhE25lni2n4x
    U9NcBviBHXvI8vscySoBVk2Eq4612frxqVmc+Cklik3NC9N8QXex2xJ+V7iW9ZNxEVGYqV
    60RyM5kkMuJOa8QXtNIwGkKmB0cBq2C1/k3gMGq1It7TfCw4PosjwjDct+rt1pQadpnxGr
    exCaRAW/zFoVPCOBYQdx9Ol7FcBhtTVaASe0j+8Z3djTMyl+nhv5vPgtZOrUMP9W0TCcRd
    yRALDnizFFCht03tthOM8v4V3rglvdttxFr4x3F+v24b6Hdhi7PmDF6ORj2g
X-ME-Proxy: <xmx:1QWZauahB_ndimZhXB3fLqt3wPXMl5_uFj8LlBhzV15CUUdvbQuscQ>
    <xmx:1QWZaoQOHgIKC3hAvxGf2rwxYr9ttaVW6peSXqvKY9wd8ArwOJWToA>
    <xmx:1QWZal5HGMzLdMZuMBwqp_TSSCGfho_2JkrVD8mXrqHyvo3f_53IrQ>
    <xmx:1QWZatzg73Jp10R-LeBahRIOJPEsJDZFK3snORONcm59ySiD7_ZuDA>
    <xmx:1QWZak3yL4wTPGGm0Im-XWpDpjVU-PtLlFSZNDWM-HHWooyK-k365TWv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 01:29:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad4ba4ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Sep 2026 05:29:59 +0000 (UTC)
Date: Thu, 3 Sep 2026 07:29:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v5 0/3] t/lib-httpd: make CGI test helpers
 concurrency-safe
Message-ID: <apkFyvN4hcEOadQq@pks.im>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
 <pull.2171.v5.git.1788277983.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2171.v5.git.1788277983.gitgitgadget@gmail.com>

On Tue, Sep 01, 2026 at 03:53:00PM +0000, Michael Montalbo via GitGitGadget wrote:
> Changes since v4:
> 
>  * Reword advice about chaining (&&) atomic operations like rm so it refers
>    to chaining with "the logic guarded by the marker" instead of "the logic
>    that claims the marker" since the latter is circular and inaccurate
>    (atomic operations like rm are the logic that claims markers).

This version looks good to me. Thanks!

Patrick
