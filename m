Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3A048875F
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951486; cv=none; b=nJFnCRs+Hs4s4ks+K1PE7/q0q9LwWGYPpPgGpXHAFN6CP0MPOU7yLza5fPkV58iw+BI4k6DhOOGgAKqvGp1fTcE2Ud7DDU3M4jJVI6PGiEq2fTaPYBeSvxnjT7+N2FJSN8aNncwV92LdDvTXel+hX1253E7ARiBrh2/+J2Z5wiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951486; c=relaxed/simple;
	bh=RlS5EXP9Ee0DVsbOmUrSi86o4zYZ7Ugg1eZisDXFEsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lonhtCkYcjxvti3yMVNjjtstBgx/qlt5+Np9ULDkjGzXO+XBmkSwsnxsz2mcTiMIE9Xt6AnWS9WtKUEWMwxJgUJNpFdLBd/ojZiRoXCjNBdntKwbZ2PHkgI7JLQY4G/BFLJ6MllhEbP34OiIREKvX1GEDgVAjOyWSDXQmjLC8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RjJlkmM9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kGZVUCpu; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RjJlkmM9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kGZVUCpu"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B89027A00CA
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:31:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 02 Oct 2026 10:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790951483; x=1791037883; bh=CR4t7iwqCk
	cw9GQ7McRA3ApJ7Qbtr8BosRw80b1BWT4=; b=RjJlkmM99EfMK8stmkyZB2hKkf
	uwTlQgMkR4EbLkTj2HO1PDCRLK/PMC+6xS7BB8dnhWqB4/a3DdevgaRoxywkC2qp
	yZcRb6eE5SSrybHZgPEMZ5d2cl1GO7UoTQDcsoFkAOVHc5DXtrPm9X23adeSLnQc
	nDyr0oZq6bs7MYsX7fVM7CvIQSTTM2wtsupesdcUBMXoRyR1e5sS7ZukToqzyko7
	I6lkY7nMsOc7RyTnb12b+J1ZWwQgbSq+Z6NLODqKT8Xo58qG42t8OLOvz71WeA+C
	R8y8lA4HOpTVI+DNJSqqkAQNdSCyGzfAXZHSKW43O50OGnyV31OYCdftpRgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790951483; x=1791037883; bh=CR4t7iwqCkcw9GQ7McRA3ApJ7Qbtr8BosRw
	80b1BWT4=; b=kGZVUCpuoQtI4s4k0YVyT5RkngnbqT0J886VoVDYxFnQI4RVTzY
	ztuqnsg2jMFdenAm7FZfG75ggKBLvV8nJ78FcruoZEu5I6egG7VPjCjOVFzZy1nN
	J2f7+ULZHEw/HmAZmsRuZNPeH9APtxyXBfPLpfRRReZg2VqcVlE8rhdFC5GMfo17
	AbXXdx1dNFfO0Iwp30hrgTHyOH0f2C7tIFFRfhnOD7HgcgUAqW3Q1M97ilNu3idN
	n6Xwhm8URuv40Ono0CHREdnpgvpB88Pjy3YaFiq690nf9JfEYula+S9N3EWJ6LOg
	lzJEwsipUX2K6RKP7jHvHyqlnvLRk5F6LeQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790951483; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:gGeLbhj6MwLcZan1m2if4fH8qV30xiOTL7U9Kr7URec/Jqt
	+j5uDAXK+GK4fblUV4fvlm8ivRly8PuKWEAukKCW5WraOl/2v6Vh/tdCmfOLpfc/
	9kIVMbAfrPgzz7N0faEdPMWhlLWXrYYDWwyWwcPsqtJDXjfLfP53a5jmjc3QUpPQ
	d9KyKOEqRYQMmnBpuAAPkiDS9hW/cS1FhR5OBYaSw3SqO5UHjICb8CFDMCtcjtLm
	9JeGxXOs3MQrhfgOYff1EbkjbbEZl1G3gkvCPuF1bKG0dk3RzhAWSohSOIXlH4i8
	XvWk4DEtXJE3UKufnaD2K6KqTZtTfRXIlz1zobQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lI7H+w0avnI6vWR2RQe2SLUbKZwFIzh6nfTgPVRTTNQ=:RlS5EXP9Ee0DVsbOmUrSi86o4zYZ7Ugg1eZisDXFEsc=;
X-ME-Sender: <xms:O8C_au6casWvYTyyKbEQOsnJKcSENFxuh4OPhOq9K3QHFCFvRSVQDQ>
    <xme:O8C_au5l-Um_IiLlXPK6ghBlcSjIojELGN8oK9qPZpDQOL4S_nc2RMhiPELEV60zu
    nAiXKa84xnBIuPRKbBdR3KEY-CswdszrCoGdBgMoByp3tATcUU7vfk>
X-ME-Received: <xmr:O8C_aidIFlo7neyKuVcts_A4DCdQ1JHBC6W5GdtQnugjOXtvva8lVbbv7mA1Se-FFTD6C4pmmxxKjj2ZdI0h-pXG4QCSD-Vz4Kv->
X-ME-Proxy-Cause: dmFkZTFIyE2Lmqx4cZNb2GG8bpH+7e5khmc2FewMEBlT9gUW5Af/uQO1Z0CAQUApIxwee0
    ucbiu3sqEMo/YL9ELzfhgtabvuX53ncz3QqfsYMIyAGXIRqyRTSSvbbpAdrtWNTWPhzPni
    c0dUG7nvN/t5IeR8jCTy2dG7FrwLJC6g0GNbIdNTzmiAH6SGd+BUebI+gMFJNJ1X1scaS8
    0z00HA/wF7VVsgX7QSsLaTmIxTCC+/7Iq9N85RjudoC+zX1EB41dcutMqPej7e0kwz3FeA
    XRv9oUL8JOiOaw+gbuh9hL/mdYz4bZ7iizwfGt+qYYmTY0eyvlfA6/pQY9oQ3DYgnyRUUW
    4FdZrtuF81qRxfHu86zwhzBJ18YoVCmc2aRXlarlBoONUUJgtcgVCkaEXZkLmWRyNO6jt6
    8xq0sbwcHOi1P1+Ux23r1YBX1sS3BLb40lFwIMe65I9PJlJxQKa2RvVwQpzeNVxfw206ef
    8HTj69GZOOMX3l8VXHarIwcPPXR8yYQixfLBKgnDeP55Q5itVbdyqA1dwVDVQASLY1JbCe
    0QkWC87ZoPUi9OmNa0RMNUCIzSfdIKjhrrcyqYAiabaKnA7zajevpZjRS27Urj2kBV/fpQ
    kWbB769eE8Io9o080bTX+EW5OJ6jcWSyknjRqycouUo6eO+Y92Yp+jVOFQoA
X-ME-Proxy: <xmx:O8C_aqDQY4905AY8fHqOBu6CkEHJDucDa9ksU6JmXmAtPNcM0RlaVA>
    <xmx:O8C_at_JsHv6CU4abIso9-ptF_TECe2CpI6ogvVppV-VAclXq0xONw>
    <xmx:O8C_atKbzkk5Lj8pcFWytpMAPDNyky1a5tI5HfjTHeUFoen5uqvnBw>
    <xmx:O8C_augXelZaTDp6AGBc4mhp3jZ--WJWkSJpMHrNBpAT62Xg3Hu8dg>
    <xmx:O8C_ah-Fz4XNHqr4BU36HMfmzh4xOymd3sX3yNkthg2Gim_FR124vpRp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 10:31:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] stash: allow custom conflict labels for pop
In-Reply-To: <CAHwyqnWQUHi3d8HKBAWzEgHoGwqSRfUnMy4jkVT-m2NWwnEizQ@mail.gmail.com>
	(Harald Nordgren's message of "Fri, 2 Oct 2026 09:21:26 +0200")
References: <pull.2430.git.git.1790801929375.gitgitgadget@gmail.com>
	<xmqqfqyq8lwj.fsf@gitster.g>
	<CAHwyqnWQUHi3d8HKBAWzEgHoGwqSRfUnMy4jkVT-m2NWwnEizQ@mail.gmail.com>
Date: Fri, 02 Oct 2026 07:31:21 -0700
Message-ID: <xmqqwls018ee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Would be interesting to remove it from 'apply' too. Can we "hide" it
> by keeping it but just not documenting it?

If we rewrote the in-tree caller that spawns 'git stash apply' as a
separate subprocess via the run_command() interface, and instead
implemented the feature as a function call, the need to "hide" it
would disappear.  With the possibility for such a real improvement
in the future in mind, labelling them as "for internal use only, do
not use, as it may disappear in the future" might have some merit as
a short-term measure.

Thanks.
