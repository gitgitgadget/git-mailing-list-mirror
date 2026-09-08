Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31054A1DE9
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897007; cv=none; b=CDf2sE47Bcm/uGrQpoXLFdNeL2YkYlvKXIMfeKKPWds4Ut2RXi3/lRF4yhSmboJsJOntJNF/dadS8BSBzZNuYF8dEO9+OhkNOee4rL9bxpdew9s0cVaLScecPzRYS0MNPriDOQq3OTd8APQoL7Th7kQHJU58KzJaimQ/LaSCpus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897007; c=relaxed/simple;
	bh=jrWmVwcK8XDBR63nquZpRX3pjxI3BrJhLHDPgE76pGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uz3auLfuC+2TJIa3/v241LPKsyea0tCuRlc2fLi48bTgrjD5FvoBgp9UuB5IKYdgwtwa1nLEQSMz8HH57k68KspLxgbcLh2IJhf0kpn7MvFU/jm6ielQ5ICKVQMypp6qYo6499xDwmM+A+kxbPiyG3E2AnJ5FWYK/IyfEuvBgro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mVONRrEl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vFEIuyu0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mVONRrEl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vFEIuyu0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 81461EC0179;
	Tue,  8 Sep 2026 15:50:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 08 Sep 2026 15:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788897004; x=1788983404; bh=UZVdqX+rOJ
	SgH6y0qdH1jPoXqYYSSlpEnnUTFcGtAFs=; b=mVONRrElGAQqIJMZwYGbaPHz5w
	TT3z6v+7sUCRmCvnrwAeTzMiqClvQKJDI09T2bw3EG0B5Z7PUMcC7OKdk22+3JIt
	gU1y/YN3jd5JA9iS85jbPpo35aZAC9G/6BH5gUWrVI/LMchwJdlqCyUR/oiEnoF/
	/d2XmixbjzScvJ3HJYdGmqWsobevh03kI+ca+Cdiec3JwP5Qw539dHqKWhsNBZfI
	wpGaZClRxtsfm8txGKe9Y0Jfh9HDq4ijTy7bOeAZ/1ZT4JRfuPvFhO2ZudldsWVc
	Trn/gUtwBMNeGnc1v0IVT7Fg7RNT/vKDTjjio5q4cjbj/VwVRU68lcXHlIzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788897004; x=1788983404; bh=UZVdqX+rOJSgH6y0qdH1jPoXqYYSSlpEnnU
	TFcGtAFs=; b=vFEIuyu0VrZaERQ0TI3to9+RLF5w4EUJx5xKM/nRf3Do20jGid+
	PCZgFCujK4j64K20pCAAnn3gyKY5PvmicRi21a6+RGu16lpTPairWW+PNT7XujqJ
	MWHoWkzXoW1Eic9tAQ3gsPmH7/Genz4b6KKloUNAUQommzZBQPNEGvbkNPc7XSqR
	yyPpjqbfoupGiWHx6IGOSGcixUZrZRnSugXrU9krlF4PTHUQ1ni243OrlzrlWL7n
	l84JpphU0KIwgx79MNfd26y++xE5SfMNl6vcGMyg+8gPkblVAJp/Z8inl2XGkg3x
	xtCTFYjWwJ42adk3WVnBnYuFHvYdgbc9IhA==
X-ME-Sender: <xms:7GagahSY-BeRgQHD6QchR2pAbEAtgYV6ycp91i2T6gW0EYOsRFjM0w>
    <xme:7GagarcmmqZaAJrjCZ-5jCaoLgDpiXBpqX-YrHU-dgUR8walTooLfOL34VC765Tqx
    URSg_UADY8JRhMEJlZlEsCOHijvBBjZ_8Uc5Yq2EBaHBl10B-_kAA>
X-ME-Received: <xmr:7GagalC60ximrGnoq2Xd6Ab1pa1bM7T1K4V9pgtcrcgea45NM5OA60NGiIs3qZejInprXYxpj0wk4_czbWXnvjDtuEjdI3d27uR5>
X-ME-Proxy-Cause: dmFkZTGhLJ75TOl7gfAMN50WZnpfC1CN3DNfgylTqeQ0eyXqWdjAr5J31v7CLap0nDXmnu
    qDaAJXJEl/ZgJx7sLf9g2nZT+8/qKoab/y6EmS6fDU1HMX+ZqUYlcHCgzA17K3264YMi+/
    3cAwVeGGdz1Q6NOLMN2jbHd1v38EzosbQvFZKIuWXE1W/fybtgm66JGaKSDqGj5OR9sfJJ
    5hNaBjj+BpXOldxqSow09w8Jkno68z+g94ShMohl9dlRshedWOUE04GqqRzP0zykDYxi3V
    iRqS/m1ebnYkSPdlgI9kpNAdeyYUCweLwLKLpQ0qiumvRyl3Z+e9HZh9V41Pj+nCBu12pR
    0UBA/3DXN1lFzopFql4XHhs8ImrPD2FGDtpYIIHiQ2zkAz/W7SQV5zxAujzoggTESysf2b
    yL2UuhnrsabanVx6AT/XXhwcNAtzJk2eqCl/uB1pFYfRnBvgurINbqATr0G2HTgernTB00
    zq5TVF2RzbcHXyHYFa7ZRsSJUAUtT/rpG5pTDLrLwwvPJQUaVDE4p/S4d3wKUZgxVQQxtk
    JkNblPkyGAL2XYYd4G0FlLgBEL4P74lB4Oofo57j0Ze/hymjLu4H1eZ0Aortk7jl3ebbW5
    7s98hvz5KIf88j1HD9sSpf6V8EbiV9ZJXEfxwusecDqOULkpEp1D7+SDwyxg
X-ME-Proxy: <xmx:7GagatmTlz9_dW-W7adOyaoRtscDmaKs7HDJiirTiMKxe5z8Dz1UWQ>
    <xmx:7GagagdFRTAK6tc82elrTysa8Hw1_eV4aXHO7DyBbnAq4Vf49Gk7PQ>
    <xmx:7GagahSpXwxiw6y_7maW-cZ-noq81w055k4aiwXsQKjQIgGSag8iDg>
    <xmx:7GaganuznwATzFB1-4dpz6DBJucnwoKwzNEJhVwbkVe_BwDSDZ-XTw>
    <xmx:7GagarsjnJpc9JV-N2ZJF0ASynOpBNkyHWrG-C9gsRAhi4JLT_nntW7B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 15:50:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v8 2/4] receive-pack: drop static variables to track
 report status version
In-Reply-To: <20260908-758-introduce-hook-v8-2-be88a671ae1f@gmail.com>
	(Karthik Nayak's message of "Tue, 08 Sep 2026 12:27:02 +0200")
References: <20260908-758-introduce-hook-v8-0-be88a671ae1f@gmail.com>
	<20260908-758-introduce-hook-v8-2-be88a671ae1f@gmail.com>
Date: Tue, 08 Sep 2026 12:50:01 -0700
Message-ID: <xmqqa4prwmja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -2563,7 +2569,7 @@ int cmd_receive_pack(int argc,
>  			   PACKET_READ_CHOMP_NEWLINE |
>  			   PACKET_READ_DIE_ON_ERR_PACKET);
>  
> -	if ((commands = read_head_info(&reader, &shallow))) {
> +	if ((commands = read_head_info(&reader, &shallow, &version))) {
>  		struct string_list push_options = STRING_LIST_INIT_DUP;
>  		struct strbuf unpack_status = STRBUF_INIT;
>  
> @@ -2596,10 +2602,18 @@ int cmd_receive_pack(int argc,
>  				 &push_options);
>  		odb_transaction_finalize(transaction);
>  		sigchain_push(SIGPIPE, SIG_IGN);
> -		if (report_status_v2)
> +
> +		switch (version) {
> +		case REPORT_STATUS_V2:
>  			report_v2(commands, &unpack_status);
> -		else if (report_status)
> +			break;
> +		case REPORT_STATUS_V0:
>  			report(commands, &unpack_status);
> +			break;
> +		default:
> +			BUG("unknown report status version");
> +		}

Sorry that I should have noticed earlier, but is this really what we
want?  version is read by read_head_info() from the other side, and
in earlier iterations of this series we used to have something like

	if (report_status_v2)
		report_v2(...);
	else if (report_status)
		report(...);

without "else die()".

In any case, BUG() here is inappropriate, as setting "version" to v0
or v2 is totally up to what the other side of the connection would
say.  BUG() is about a programming error in our code, on _this_ end
of the connection.

We probably should have

		case REPORT_STATUS_UNKNOWN:
			break;

to catch the case where the other side did not ask any report-status
and do nothing about it.


