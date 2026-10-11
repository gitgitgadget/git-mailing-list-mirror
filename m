Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F775372ECF
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791702453; cv=none; b=dTOl1ruTW0k+BiiLDT1ne8XJETjKPOs4eEuaC+ajDLU1BEuQETgqne/BoZSKmN0miPdUH5fA2NIziW3G3EQkHS/Pd8O5bM8+RitGgvSlGstZfe7QD9bIwiL0+bjLR3m9Dx+Bk0oOb2R3g/s0+whvNCWtHorHS5RDIAgFZvZDUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791702453; c=relaxed/simple;
	bh=ufxsdgBxsq9tYPQXcW++0NPQoGrzCkTBw4OG75dhhA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jjg+Yrv2JxrWHPhKliEQXNUh+oadA3vwmsYevjLrVsjGiaMWYac0iPeG/hG9b1FuiaNqaEs3F/akfij74xbxoRAArFfJTKwXGgX92NQC9Nol55NIHkFUkej77+9rQUJLvF+OQQbKOWz7B3SCv8c/dG21I2hQw0eiSPoYiVUi+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O0M605Sy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iP+IGvz6; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O0M605Sy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iP+IGvz6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9DB521D000AA
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 03:07:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 11 Oct 2026 03:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791702449; x=1791788849; bh=rC7a2tceo9
	QgaaYnMtOeIuZ9PAoxR7mORLW02mRqY+E=; b=O0M605SyuuNK7N1DuRm7GDQ9X2
	0bmI5qCCmz+29FhkZKRJ8cHlAszbOLNsFfomURDoB7g08f0qktjJWFke0LS9SulT
	wvf3Bj3i1GUJi2+Oaw58sP4ug6a7JsVeAx2mZqeA6/ds6JKhtWHMuMRll6V6vN8L
	LlOpdeJsa3R9d/XU8Qs+AaqOlzjeUYq94LWlwRiiXYf5tOa1AqGlaiQtf4H/Ad9n
	Ml5N9KmP0hEF/zhphnafYF2Hn4rAtCvavqPqTy7WJFxleZ0/nrBxqamHNINr/zH9
	vJEGUVUVdtG/ceiwU1caUZggj0PETgZi9BOUiU5kQWHTZwDDDE5sjHgLl5eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791702449; x=1791788849; bh=rC7a2tceo9QgaaYnMtOeIuZ9PAoxR7mORLW
	02mRqY+E=; b=iP+IGvz6B9bGHOGvuZZtIqBC7/Zxm8G6mxESkZ8NZZ1ADle8fqi
	QIZ+Ok/+84KtgLRjeHbWa73B6S0EW6Vr3uLYrUUiu0TueViVx8rUjZ8RdMBr+aP8
	s/SY+MCXbvSTzDXI97ST2Uatnxu19D19Rl74upuaFeD7qLBeudTq95EgjBfwg5Wg
	0k1RYHTmO+PO1cv3gyzMHf+Z0bjz4AYzlMnUtKaYbyxPp3A1NrBXwD5eN5IiW0HB
	VVcTmZxFsbrNCGpWbq8dNUjY/FXqOHE6JmoCzoc6vuTrw/bKiJOTUqXE3EB2Icj5
	nt3qijg98q+UfkoqlnZ4wxvkyXkRfIUiV8Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791702449; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hnoAiQUM2HaKZd7gf4eHGcObEM6qlwDS64xmyFAH7UbQu38
	RhB+XINvIeL38WMrRqqAO3Y8yyPfW8HKayiucNv9Zcz/DYSZn2d1U1wO15lSqfUf
	y+WXoUzJStl0gvhzocbr9QFtGVGo6z9bbCQTkPd94+1/C1MUg/F8JZkttxGht27C
	AceOwEk+cPUesmCb7CKQY1ByK06kIctImXSd7Pms8fTeGlrPELs8Su7aTO6MefCG
	REPq4Mvlj7QIrozZDK9k/Z3P80urv3L5pAiY6N3GFlpk/pLL3wXap4i5O1we3KR7
	Qht+91jw6satXhIvEAL1XtKaMPvUy5fRMLqv4iQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:vJHKYShg1jIks4yu0zZvXucfVZIDk4rQBcfoAGovVrE=:ufxsdgBxsq9tYPQXcW++0NPQoGrzCkTBw4OG75dhhA0=;
X-ME-Sender: <xms:sTXLahGUHe0-s-1kxJ67lnp2pboMvacQx2WgwyOo-nFzqWu3hvojfA>
    <xme:sTXLatUReimLEWFxBi4-GFgYdjIcKmPIdiOKJn_K-t4AhUADOdlIbGEA3fLyl2X7K
    rXGZaVZP3ldLNG_rc8XFD2JwCQyaCn_Ro87GU9Zyosyiak92oXafA>
X-ME-Received: <xmr:sTXLaoIDRek8yYVCaWd8k6dFtwCYwvLd73bN4SAXPoE6r4xfuC_njZai_prq3rJ-fLlS1COZlQpR7tDttFNFh9m4qdAyMMiarbPa>
X-ME-Proxy-Cause: dmFkZTGZgFqgz0xuAUC0sq6K9GHM+qZVbkZBw66p+tq1cKzqS5/oL28vgOZ4PVRKar3aD+
    J1PLD6DWKeCEhif5AlyM2tRdXq3Pm4BEI/MhawjG8keaOStjF99bn3oQ9Mi8dedxu1gDI9
    3rgJ0ELav4OdoTA+e14d84jOt/6O5ewDy6l3MVxp3Li8jDjvDRLmHZaMASMqdqg8VVo0zm
    a1h5gdYkLbw0AAb5hWLbQhUyv5hMERymtx+V4a+q2bbamwIgRqnk9Kuwd4sxfDfXhqsAbF
    wP+rD7tl8lofhYmAWOZFd5ZSFNe2r5qddfQzGKOOMvX7L0zLM/wp78wPPb9j2c/REBlTqQ
    PyDIhJtN55Rzkm0r/XWzoHXt/X7nvKqQDlUji3YyqNU2YANGQ1iuBV6mPirTL6cB6w5TkK
    zXQASJbvFUJ5Mw9gqiSEHAMrw7b4dqt4DyGEGwo+FYywLtKm7NYiwGhBfrksNyM5N7ZR8c
    yrqLbe4JjoKqMhddy8aNT7i1tbCIh64YgyvSR+Lms1jtPVaQyHtfBcw0wvaIL8MNFwYFed
    taJaSyLQ5WzS+kZZeuOb3HHscdGwtjexWVqC8Hh94HYn/+hWOQlr0RPN6M1KQO3a3RpAkZ
    /OnvVslh6nChCRM/BX5SRYI7Vpb4RjazCkPwRDYJV7rgi2XWXMlHsfq5U3bA
X-ME-Proxy: <xmx:sTXLal9YgSRyoK-oiaDh0HrHXvmInKqZDKGizapzc5wh_at9fVpFSw>
    <xmx:sTXLajIwTUfEbqHw6qQlmAT8eT9LhXyg2bgObBMDaeY32Ly8o0kwvA>
    <xmx:sTXLaim_2M2B3-fhPMn74O6AWTBmOzj-Oa57ANgjYBYWdvCVEXKJiw>
    <xmx:sTXLavNNv7DTFfHGj0mHTlIynSXafMrYHvW1AWJZfGDcD_5i3k-o0Q>
    <xmx:sTXLajrgPLIHpRUvr8hpDz8HsTpSsaZWJvZ8mbiwyLsAQBkGblWIgLbx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Oct 2026 03:07:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Muhammed Dilshad A <dilsheddilu123@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 1/4] mergesort: move sorting tests to Clar
In-Reply-To: <21f46a2c9046d1da68233467bafb4b69226f35e6.1791556668.git.dilsheddilu123@gmail.com>
	(Muhammed Dilshad A.'s message of "Fri, 9 Oct 2026 20:38:47 +0530")
References: <cover.1791365181.git.dilsheddilu123@gmail.com>
	<cover.1791556668.git.dilsheddilu123@gmail.com>
	<21f46a2c9046d1da68233467bafb4b69226f35e6.1791556668.git.dilsheddilu123@gmail.com>
Date: Sun, 11 Oct 2026 00:07:27 -0700
Message-ID: <xmqqy0c4emvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Muhammed Dilshad A <dilsheddilu123@gmail.com> writes:

> The numeric sorting tests only use mergesort.h. Move them from test-tool
> to Clar, keeping the same inputs and checks for sorted order, stable
> ordering of equal values, and list length.

The above I can parse, I know what these words mean, yet I do not
think I understand what the sentences want to say.  What is the
point of saying the first sentence, for example?  Is it the reason
why "Move them ... to Clar" is a good idea?  Is it what allows us to
"Move them ... to Clar" (in other words, if the tests used more than
just mergesort.h, moving to Clar would have been impossible)?

> Store the list items in an array so cleanup can free them even if the
> sort leaves the links broken.
>
> Remove t0071 and the helper's generate and test commands. Keep the sort
> command for p0071 for now.
>
> Suggested-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Muhammed Dilshad A <dilsheddilu123@gmail.com>
