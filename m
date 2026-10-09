Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41ED49D5BB
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547612; cv=none; b=LrjxwXH+Ftb74df8O5cmDzN9sf81RVMbw4XnjW9ZyYsLJGJzF62kYaIUVSSkSUiJTvSLo7Z4BtFBVe3VAtRSAqZ3LLm6sqtKvgSybiN2UMv8e/VuxTY0U2TZCi9gKk//cGzyV7UdDWR1o2G7wFLBtjuefS533QCvQc6iAnBeSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547612; c=relaxed/simple;
	bh=1dOKVAoaHQRjYmioIDYvdxAJpaJO4/oxEGD20sLZbck=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HvyrXCP13VOHVHn8GQ94GeJdgtgXtkOZr+W0Xe+3Jd4hX/NpaQds28bAWU5I+wYFDsLsvgOZPMXlYVeIsihGZB7MO/QYP+ba27f7t4GSE0PuR2gbuyyeeHMLSrqSjPOvPauhk730AlRLdDEV0jrkt/0lvbi2TQMu3Vv1KyggmPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=dUt1oypd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QkdmoPkt; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="dUt1oypd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QkdmoPkt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8926BEC0992
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 08:06:44 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 09 Oct 2026 08:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791547604;
	 x=1791634004; bh=BiUDZaVmZHCF/yWcP/HzKaEEb55ShFGSSHhWg/qxsQ8=; b=
	dUt1oypdB/Zbn2Bgb1wryqULBkm9cncSb9k3OGiVprNNErZfndTNbEZ/r3scxbAn
	jjBTzSv4lydu3WMYiOquo9TeTa4r29m5oVlCTWoFX8SQp9gQ8sddIgwldQLKmGlM
	totnb5NMQmYn41aEANvlEEy/uGM8RYTItsYkFZJVx0KDqxUANONiHxjt7c0/ZsaM
	5hLqVOwB7i1nK7Z+YdBP/3X69+yry/vasSbdan0ebz88Cb2ovIX6GKZCeBEddfcB
	uAaJvsSoEflgRmCiAElwxAzGKOvTDHpjubRvxytuumE7P5BGzKvueC0ZxwDk56l3
	9rbtuxwbDSJa+3FEtW9P1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791547604; x=
	1791634004; bh=BiUDZaVmZHCF/yWcP/HzKaEEb55ShFGSSHhWg/qxsQ8=; b=Q
	kdmoPktw0PcDW8RxtrEc8Hg8fdMucg4sLJt5h8FPIA/N0gI1pftLlPNycnGbocjI
	9vV4oVrnkUC7ifpE9QY+tQdOzpGBnpwjsaGQ72u6Bu+Wkq/ZDqCLvHoPTCVs2Ute
	e7sPJW7DC5As+m7BiPExuxpUCI8NVe2xkK5p76M5jX3D4PXLhUJjFSDjTupCjp1X
	ztZyG9KIPROxx7+cp9cOoSGprUz2iicZrc8W4JpflwBjHVao2z2dZmrndwKetSbe
	cAUzZUNAwZXcRGYbIB+c0zC1KxgxM1QR/LsvEFQPYX666RhlcHc4Tqncvj+PrxOd
	SbKRH9ziWxuO4g0wfehvQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791547604; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JhTxz6H9JG8xGRlij8yTV7gRguOK8S6LU6Hu2psY3J1VGRN
	2rzIQi+ygQflDFs7Qt/mQIVpt7tFwaolP5/szt8QN/CRzELDxkubxPc4Tqd6l/F0
	kXa1+xSQ+mJ9KB1NARWyjHMzfohUXqF+WtGc2Frk6JyiDbKdyQzlqz7hIwnzeWaZ
	DNR7s0ExQVDSV3blcZfZFt7qb6myQQaMbNX9AcWts0wC8dp94JBi4pTDrn37I1ii
	SMzFmJ4hTzQ0TscUrJTBE0YfKcgYBHfN5I0brxpMTaXlOJsXaBZ/XTJDzJ5SYP/R
	SZghvHTvZVsGf03pfO4ei+uTpjZi7O39gli4y+A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DA8jM2jdKE6Rz7c64rfl8IqYyPiJ48ED6Nvj5yRVsV4=:1dOKVAoaHQRjYmioIDYvdxAJpaJO4/oxEGD20sLZbck=;
X-ME-Sender: <xms:1NjIaqqvYQPC9qjx7KV7Ixe5QnrGD_GUSg7spC7-GWG_HVl3QPlotA>
    <xme:1NjIajdbsWzIkN5lvqQHEvdoz-lrBtg2d16z8X6hwBfi0Gbd2r61Kv_OAlXtYGAje
    AjkPafDuvWNZlSGIYFDZ_b8HJY_j0Tn-uRGU4Y-w-JtmhLW-y8kSCc>
X-ME-Proxy-Cause: dmFkZTEejlkMmUUb0yyppFSDVhGY0Chi4G/EXKlDcBchtO/TOrXK/OdVgyEMG8aaAgmNLu
    s2kosmwn3go86c/mIIowjm0f4TQVhbbHLD6wnUthyepAJEjz/S3VJoEdQvisWIiy8GfzsO
    9exu5QRStS91GMIJzIffeOfpNyN27XViWCXwlDT3uu3z7TEIqzt4J3juCkkg1NlnU1QoaS
    ir2yukZn2xQHNv9IA2MsjHmUUVUZr/+beUbos5fyJk5tMQC8y72hqQJL8Sg5UbcZAyhQsZ
    Lh0s1oiqN1FLgyyeItmQp2aJ+ztm52Pbe8DSvXCD6ESeXonA58fyx7RQasSOBhFKHkGiTO
    NV2mQ4lbnfJDue4JaCf/UkWNeZCg5+v9D87a9K5McLC/pkAHH6vVET5DVUqLQKSeddUZbg
    PJsaNuTNhI4v52z7zjYvafS5Ll31lYxsA6qy+ttp8b/8c2a+NEbu1NvfWwR0hrEfySYxm6
    SKj9Ek4iCiLHbaupYP8Xrd3KcKI1l5qG/9Ld32CBdfwLuKj9IZGrbInzL2LJMLpthKgPao
    8wIF5Hzi3NbeSgWMV6zydGSibm/arUYg63nSCgBy/fErKEhvq9Pg5cQ6Vf+mZtDlCHe75d
    D3h/YsiDvDWx0qhR/R0yDiHzX2dsIb9REK81+JWgVLYEelw9alVDfBRqJJIA
X-ME-Proxy: <xmx:1NjIarSL18Gu90Ipa_V3Obr1fP9lolUcua1LOJz9QWXxJFVKoRhPeQ>
    <xmx:1NjIaqlBWuu0-u3v3biAThv1gJB9VDRidyUhasvksR4to42u0bTQkQ>
    <xmx:1NjIarQAeQ-1ZL85gPnJq8CdIb5EQZlywhEOdl1L91kTwLPLoN_eLA>
    <xmx:1NjIaoNSrVkkkenZCZeAeDllUkr958xvhUzi1f9AZRkIY6Yt-tjESw>
    <xmx:1NjIauzaxjwamDl0RmA4dzn7sI_BSetRT4pfDtf16GCCkMaFHwW1rVVS>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 48B72780070; Fri,  9 Oct 2026 08:06:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFgDA7FykTTZ
Date: Fri, 09 Oct 2026 08:06:24 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <d0797b01-14ce-4ead-bdd6-84d7bf7c0aac@app.fastmail.com>
In-Reply-To: <xmqqse2h5hql.fsf@gitster.g>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <4505fdc9a6dec37296952107c90947e43f39bae4.1790261062.git.gitgitgadget@gmail.com>
 <xmqqse2h5hql.fsf@gitster.g>
Subject: Re: [PATCH 7/7] [doc] ignore conflict markers in gitmergeconflicts.adoc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Oct 7, 2026, at 5:21 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Subject: Re: [PATCH 7/7] [doc] ignore conflict markers in gitmergeconflicts.adoc
>> From: Julia Evans <julia@jvns.ca>
>>
>> Signed-off-by: Julia Evans <julia@jvns.ca>
>> ---
>>  .gitattributes | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/.gitattributes b/.gitattributes
>> index 26490ad60a..0a0fc950b1 100644
>> --- a/.gitattributes
>> +++ b/.gitattributes
>> @@ -14,6 +14,7 @@ CODE_OF_CONDUCT.md -whitespace
>>  /t/oid-info/* text eol=lf
>>  /Documentation/git-merge.adoc conflict-marker-size=32
>>  /Documentation/git-merge-file.adoc conflict-marker-size=32
>> +/Documentation/gitmergeconflicts.adoc conflict-marker-size=32
>>  /Documentation/gitk.adoc conflict-marker-size=32
>>  /Documentation/user-manual.adoc conflict-marker-size=32
>>  /t/t????-*.sh conflict-marker-size=32

> I believe the
> plan is to squash this into the step that introduces the new file;
> when that happens, the patch title will disappear and we will not
> have to worry about it

Yes, I squashed it in the new version. I don't share your opinions
about how the title of this patch was worded but it's such a minor
point that I don't think it's worth discussing.

> By the way, some of the points above might be worth teaching in the
> material covering merge conflicts (i.e., this series).  I do not
> think many people write manuals on Git with examples of what a
> conflict block looks like ;-), but a run of seven '<', '=', '|', or
> '>' characters may appear in real payloads that users need to use,
> in contexts completely unrelated to ours.
>
> Setting 'conflict-marker-size' to a length that their payload is
> unlikely to use is a useful technique to be aware of.

I do not think that would be useful to explain in this series.
(since as you say Git's situation is unusual and it's not a good
practice to explain things that we don't think are relevant
 "just in case"). If users ask for it to be covered in the future
we can add it then.
