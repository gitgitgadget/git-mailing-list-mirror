Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7D223DCE
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791698252; cv=none; b=Gp7AIjoJTd2ayXz3qT5zbVJNWTvMDLdcwLcCl1n+NnCeJmLOJxqWD5gpK8VSSI7T9fi6XKej5hTg9EQoV7tErWseyN99h6iGGWxaVXQXQdzsEVsdIHr+G1Vhes3tLeptv27hsCbEeG2UxrxkNtH+jifJN3kovJbrrAoBwkErC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791698252; c=relaxed/simple;
	bh=PltPNPVpw7Ies5Sm5NQFQ/pOGdJRkxOxNCzdPYM8WBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I0ivhRhHZ9ecwbvQBpAhjsVBB0xEjlWEQ0EJaM5tnd7jDLzzYCiUjv0epBEi9jvaExqONjjQjaymSf/qzZDweJjl3yg71NIMCvDeL5jhLhVUoDsFOItxikNS8sj6WdN2KZoQkCkBhRXIx4PxpGYJRfgI8taAxj7EXHBY1vrfs7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kiZAtHFA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ebm9Dy8B; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kiZAtHFA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ebm9Dy8B"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 151817A00B8
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 01:57:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 11 Oct 2026 01:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791698249;
	 x=1791784649; bh=zB5ZsU+DIgU7AEHJLABqUW5N+P23Mi2sDsnvEEesaYY=; b=
	kiZAtHFAFHEB+DrSKQOsLrLXgsOJPgzZs/wovd2fAwMpcylIvs/T1/NPgOiwQ5y3
	lWRob2Yi/fj7Q/LUc13TTDnEUoPXeihJsDKbEPqQGlTlGqFSCu+/TIPIAvmQvVHn
	6C++1jvxnxdFr2la0FU4c7fp5ruiAu1tSdoGZ+O5I5hx0W/SEd9c/1cN9+lGbXgK
	+c2rFFxpl7q1smfOIulK2D5XAT+iLEO/G97mxmFBTlnVjDocxVqwgCPjXxK4gwm1
	8GTC0dJgvHG3axuCJQWjDCAi1BU0YD4hp4PAIBKSZFykVkh4ad6syDsliJP4DhQS
	fCsn2XV/zAzrneSYe50jLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791698249; x=
	1791784649; bh=zB5ZsU+DIgU7AEHJLABqUW5N+P23Mi2sDsnvEEesaYY=; b=e
	bm9Dy8BH/DqDCi/5nqYXxTKLZDGJMc4b4DSKpuOliuzJ+w/leWiMxI49Z6z6ZPu7
	sfLISphRx9fZ3os5Xur7reHHLS5lSGhtGLFMb+FpX5JyB29dRhRbeBXoDjuMegzk
	OqHA09N2jLijpEpqVq/bR+AUymhGnHgo6eHy/uuT1Q0ljHo3Bgy37e+hAr3Igf4E
	iz6Mn37+79UbETTI639KM1Z0Bk3Do1wNX/JMmFp4PEXu2eHh21zGvKmqOioOWIET
	ST1rB7VGleOqAHlAnNanH+9tNqhMSc9y+Heqbmcy12RB2T931XKORvVQn7tw6wfK
	m4TZW6AfRniHDN41yp9JA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791698249; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:VWksIfWagoKaefclXLSlbzsi9urVT9ByKkucctvFC15/V0Y
	QhD13N1xP8JQE/v/h/XM6katJbaEUNllThRoV2lszMt4sTBXJ7Y2om2ZJfrVFim7
	ywiaN+Z9PQWcJX4YmkjrXQEQbB5DGpuYOOlJwVCX1tUxCiNf4s171RRKldN9oQfp
	8N3fstOj/1HJXF23DkcA/0wees5kWbdSTIaFifvjMyTwmynAVYqsowW8a7QOGh9f
	vMrxyGmpxsqjgiU0YXt1qMyZhbd7zZMJXM9UZFchpt/sAVG7a1tuydIDxrHhIeog
	YExeDuuIOWkunLj0xMn1KP1saAWxcUdm8ioIQQg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:iQbT5SX7T4Cuuo1aF+HSt6FQc6lk1yatXO+JN4Y+qEU=:PltPNPVpw7Ies5Sm5NQFQ/pOGdJRkxOxNCzdPYM8WBk=;
X-ME-Sender: <xms:SSXLasmmFE9GzyEI0P9BNx0SQoODvex8w0dbYuBYK-_jhxkRtofLPQ>
    <xme:SSXLanUsAuyA7X2hCPO2HYJB6MsMmyqAQUc1t9ShMQ8XSXqvCc5QanjxZd4fGgvEo
    zh1AyKY1tTaJhXgH4ZR-8BZ7N-lu-_9IO3mXxRe5Dx8BsO4E7UW3k0>
X-ME-Received: <xmr:SSXLahE2W2gMwSsWh8uMD--U-nbgM6ohDgfoAHY0bETWL1o-ValBuvVhB26N3mYWhGuzxMSyxXFWUL384uUnXeAe05PH5czs2VBq>
X-ME-Proxy-Cause: dmFkZTFbERWqVBWkcTlBOwYe2TMzVFH1umYgMdColeB8w0I4wyX8+cAND8adj7Lo/T+bR1
    FUgyumuj+zyvKSB1xvPJcQRPpBUtW1Vh8MuBy1bACcYMYcIQt0qOZDP8kswUeS90eFzDH4
    7qLrkC1m7SiqE9TF9ZNv9Wz21fwxvM3ACHMoYto2fzT0UzBR9j/h3Ug7STX8wlLnniv/B5
    crJrlwvYR8lOAzi/xVLlFHmoktmNOwPzhaMBUmMO4c3PEA6HKy10yAV32rAa/Y7G09Nlv6
    h21xpchNUIldmRD+SRIo4nY9N7ZpBVxXOYuKKmV24H4ut2gyi4LTZgX0Ns1mS55RuUBtgQ
    6EkKXJ3N4q7aS7tlQZ588ml2VbwVj31NB9N54g97st6eDIFY3iPjhjP8+D2f9VfRKT+keY
    CU0Ctp5p+9Ftxn8KnHxY9vM0NFbn6gi7Eih8insGtT3+HDediSBLe0Ht2bGbKx/sueg9Pd
    AXDTsRrVWQt5HyojiT33m36dKj0TTNk4iGbl1O6fsd4hy3L22K7IlDR+q4AkYPrC/k/KT3
    8voQNt3b6qhC6wL4NPJHv22rSXeEN2lqnc7mwF9tk52amWOlKix+c1I55YDddhZ7k8jyK5
    WrxgVKt97Q7taME75LEchl5d81Qr2XS5/qpgo+ri/FE8N3DWQJYzdZxnYGFA
X-ME-Proxy: <xmx:SSXLajcIKyzHOuFJEVyg0Z3R1yk45ZwmQMyaztPDQpGeSJ7LbfqFLw>
    <xmx:SSXLaiJDZMD7bEQbBq2ZvyirW26f3L7K8G_ZOieXsdfRtcdM-6Rq_g>
    <xmx:SSXLaoFpkrSbDz9QHhOe1N49qBntnBNmjD10WOJDLmIDAjelrJgYCA>
    <xmx:SSXLalATfoU_kIFe9yVM8fn6N6JobOxZ9pBa1EcCxhHBho4Zlu1fmA>
    <xmx:SSXLam0U6qP6yBWNBd0KSajFsqkBDzDVuYsahD9s5JZYYL6BEgB922pj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Oct 2026 01:57:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>,
  git@vger.kernel.org,  coygeek@gmail.com
Subject: Re: [PATCH v2] repack: do not rebuild packs on --dry-run
In-Reply-To: <BBCEC2F7-CA8A-4460-8A4F-D8305D3E9134@gmail.com> (Ben Knoble's
	message of "Sat, 10 Oct 2026 17:06:18 -0400")
References: <20261010210050.76064-1-r.siddharth.shrimali@gmail.com>
	<BBCEC2F7-CA8A-4460-8A4F-D8305D3E9134@gmail.com>
Date: Sat, 10 Oct 2026 22:57:27 -0700
Message-ID: <xmqq33ucg4oo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>>  ...
>> Fix it by returning right after the candidates are listed, and add a
>> test that checks the pack directory is unchanged with and without -d.
>> 
>> Reported-by: Coy Geek <coygeek@gmail.com>
>> Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
>> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
>> ---
>> Bug report:
>> https://lore.kernel.org/git/CACgTecOm+=vbf50tZNXhcYvRi1ZTsQwbjVoJAbQqs2CmXdJCxg@mail.gmail.com/
>> 
>> Changes since v1:
>> - reworded the comment
>> - documented the bug in the log message
>
> Thanks, I’m happy with this version. You may add my Reviewed-by, if you like

Thanks for writing and reviewing.  Let me mark the topic for 'next'.

