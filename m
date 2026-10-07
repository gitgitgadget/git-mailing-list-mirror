Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D513939A4
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791408119; cv=none; b=Gb5tlwHMoKfWOaQYDnDg/TenbRAk5Jx7r7V6Q0G/WklweqqJz5ohaD62iKYCNJDSAaVrM15FUaiy6NtHPI6T3EL8K+DtIUmDXPdAWBNzB+usivazyr3wIXqhogyUzAMhCyzCbUu2HIf9oSCo5SVbxHeMcul2bhURjf6W1CcnDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791408119; c=relaxed/simple;
	bh=yivj9CvvnJ3WfLv3KxAW+RuKns1M+FG7gn0aXWzEyeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=df6eIwY6Eu+gfm7Ntvqtdo3oUaRjfi5eu9GXlYuX59krk6C0TjeGLETbUHeQXpy5B0jrA7fKJktrx4gDQK028rOkPBysdbyG8jmv9TCifAN+FCSoSd+e2flZJHjy0sbdmgZzkCR/ucEF50o4oiVV+N/2mQIPUUcu0uPRf3Bf7c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eyLdwZlW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLPZGcuP; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eyLdwZlW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLPZGcuP"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EE7547A0122
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 17:21:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 07 Oct 2026 17:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791408116; x=1791494516; bh=KCcv3Euaxm
	6aOC3vEVqou0QLaOrXPFJeN9iTpmfrK68=; b=eyLdwZlWhd2Ec2hBGpSI1vBMmV
	5ADkKdWZfgrCX+uQSfdTfTmOA4XLrIlbcs3c2H4ltRiF3b4DL/gOPePAv40QELw9
	TpJOGMvqm0abuTWh8zOhphX1E/PswCdIyCAS5TyDGVmneWh+yohKZwmXIgE9nOUa
	BkqmUMJb9/4zlRGAzI9/gvZyifzvtUDdxvKZ14YJRb3ps7gZsbaF2kmYPzwCR1aB
	7DNrW06c+C8gvrSFYQNVQe4sOFSfOpRnIPQOzzutHSMCRDPu/JoixKHJ0JyJ1h2U
	PS3e9UrBwfBM3iw/UWByyOggrcvtm7VVoxbFFAC6qe3YrE+Id/WE5OujOPTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791408116; x=1791494516; bh=KCcv3Euaxm6aOC3vEVqou0QLaOrXPFJeN9i
	TpmfrK68=; b=fLPZGcuPI6j6ZTyQ+0WHmfCWq0x1ThyZughqgNE5UOqsmmT7OF3
	E5RWNauFtksY21Qpze9y2U3K4a2o60X42zzA12sP6EFYyPy6oOBMY4GVhkly2/rU
	MczCCyis1FAIZ/BSSNDslXBBwyEBHfs88HJIDbS5IAQA3voiB4yk3PAx9MhUAyWs
	TKtHyjjpjqLCugIn7JBnBLw4uzAtmevmdfPQ0UHA14OuLPm22YjoMNk40f2DDehQ
	dQxa2kjx7/j9l5vbJS2XYyRlPLU8eGf56FL6Q9Pn8qRKct6JVp5sYVQtDDM3NjPH
	tYcE+Tomye0rL/qlO6N9I3TqrGjg+bRLKgg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791408116; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:XOjIvevcnUuavmb1fZ5hDJvB/Xs2WJT4PtNp6wXjTrV4zhE
	nOUpgWhjf1Aj1+OuiFcY5ADspnmYcyVUWaNypYsum4nmTznO6cj8jsuuUaB0N2e4
	XculTazWQoibN4ZWUuYUSasGWo3joOu8FpXWs6UMW+a3UJ9s++KFAVTdSDjlKXpg
	/qcd2qgOruey5Qo3Knn98wkR5hGvQUb9x4KMcs2vaF9/vD7RBPgNnVMOL9FSgIa+
	4cXMl/jqQMf5txRT/2TpAO0rKidSEauyjvE/eahpXIxBC9DyBMaizA+B67CM4Fzy
	dlS7A50t8HAQuRNTz9OfFhPBzaBXY0LhT5mE4gA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:pTsCeEms4DT6iq52wSftTRp8nZ8HmsCc0aBoTljmguQ=:yivj9CvvnJ3WfLv3KxAW+RuKns1M+FG7gn0aXWzEyeI=;
X-ME-Sender: <xms:9LfGasggwuF_rPDV7SrF6OOHS2K1xWTilr0EuAxbX-vbbPkLeRp-QA>
    <xme:9LfGar6LqEyn-plPK3cNsG5o9MBEmNLK9_7aDje6omeheyfdGt5QSGS74JQAD0fOk
    7O6eLhym0ha3sVFKv--EqmxDk7fmDaVwQGT1P2YUa_xIVBGXexBgQ>
X-ME-Received: <xmr:9LfGasbGikuK0-6Up6_nsAnTfrUip4sWX28iZ3no_JEqGSyf2TZA3JxMXAm-n5ALURX7Y799EsI0wqZXznB9JeCWDn9Pz3CW4TQe>
X-ME-Proxy-Cause: dmFkZTGHWbLW1Hxj6lccEolAFQ6DwnbZ3z2ug9Hdo+xLMCtpAvvcyq8VNR35UYUJSE5O39
    c99oybAkDPdXs9b4+JwG8EX3LRwcKI19pJWCYFXhwOHG3SZQx6QciJekZDIxn3A/tUlvAi
    u7NVAxabcU4Dqvc0WXiNq+FLhJWAqJUOdjPWuXkC6MV1ntqYLqVnob/cWI9rNU5VUhlt2g
    BExUWh4qrHSxbSPQSrYmGLiIZ4jrw6nRIBgtHdvz0IDuasd6aySe64Uqv53ibba8mo6jWG
    jzQvZvXef1YM33C/2aq7CV+D3JKcwVii/zP+Cy7JY1O/5ovJOwAJV/rEaLm4gjB70ElXJi
    qWboBX/712RthjqCgf4Q8gUGKaYemY7cqGlANVVoBXFzyIDMPHkr8vYFWvKFEtVQoTohA3
    W/Qz0n7BUYbE7SpqmTNm5/K8GBoXCWCm8NicyWPrZQt4SO4QB6TQM9tOYoBMuYmJoA5i/d
    rwFP7FLXT/GZO93Qa5umm0gt3TK0Os3h6Lw9fCf6hgYkLj33OgQq3w+mYekVUzJNoXXmYJ
    /dUSulGpEG2AOqKnSkQMC7XXZg28/2aVG9GG0Iv848f0mcsY4s38z80ZZqL0I2m8y5ERtN
    4RGcmzka5LEucO2fL5whum8wSQ6rXqZocL3OjZ57GQp7QZ1opYP8KBdpwO0Q
X-ME-Proxy: <xmx:9LfGao6w1VAM3hwKm7aXPJgEjhlCmHE2ib_7VbA5xOlgsZL2rTthJw>
    <xmx:9LfGanB9mYMgXTmB86uxAoHFMCCLikb064Z5XqZMAK9UnKLElTYXQA>
    <xmx:9LfGamdiSbZhRU4UhBFI5Dqjpc2oaybohd1miLjbs8ZnSQgYPkbNgA>
    <xmx:9LfGauK31OpUsMr1ASfTk5wRSjhN52iRvKgaKacGJHCImKDzar-nEQ>
    <xmx:9LfGakIQc-jFhtQJgeAai_NLLxaiXpXLC7O8onip7UqqPhcV5wusi5P5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 17:21:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 7/7] [doc] ignore conflict markers in
 gitmergeconflicts.adoc
In-Reply-To: <4505fdc9a6dec37296952107c90947e43f39bae4.1790261062.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Thu, 24 Sep 2026 14:44:22
	+0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<4505fdc9a6dec37296952107c90947e43f39bae4.1790261062.git.gitgitgadget@gmail.com>
Date: Wed, 07 Oct 2026 14:21:54 -0700
Message-ID: <xmqqse2h5hql.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH 7/7] [doc] ignore conflict markers in gitmergeconflicts.adoc
> From: Julia Evans <julia@jvns.ca>
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  .gitattributes | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitattributes b/.gitattributes
> index 26490ad60a..0a0fc950b1 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -14,6 +14,7 @@ CODE_OF_CONDUCT.md -whitespace
>  /t/oid-info/* text eol=lf
>  /Documentation/git-merge.adoc conflict-marker-size=32
>  /Documentation/git-merge-file.adoc conflict-marker-size=32
> +/Documentation/gitmergeconflicts.adoc conflict-marker-size=32
>  /Documentation/gitk.adoc conflict-marker-size=32
>  /Documentation/user-manual.adoc conflict-marker-size=32
>  /t/t????-*.sh conflict-marker-size=32

The title of this patch seems to show a fundamental misunderstanding
of what these custom conflict marker settings mean.  I believe the
plan is to squash this into the step that introduces the new file;
when that happens, the patch title will disappear and we will not
have to worry about it, but regardless.

Setting a custom 'conflict-marker-size' is not about ignoring
anything.  It ensures that payload lines that happen to look like
conflict markers are not mistaken for them.  Machinery like rerere
parses conflicted files, and you do not want it to mistake a run of
seven '<' characters at the beginning of a line you deliberately
wrote as the start of a conflict block.  You prevent such mistakes
by specifying that the conflict delimiter used during conflicts will
be N (!= 7) characters long, instead of the regular seven.

By the way, some of the points above might be worth teaching in the
material covering merge conflicts (i.e., this series).  I do not
think many people write manuals on Git with examples of what a
conflict block looks like ;-), but a run of seven '<', '=', '|', or
'>' characters may appear in real payloads that users need to use,
in contexts completely unrelated to ours.

Setting 'conflict-marker-size' to a length that their payload is
unlikely to use is a useful technique to be aware of.

Thanks.
