Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6304078DE
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064720; cv=none; b=MkmlxuTDOfrc4wvZNz2l1r99rcXdp3mstwHpHjwxiJ8PD+sDrSUcD6FP2WNhL4xaqvYk7vE7QfRV64mhi4nOTJgji00GL26khjAnemOUgAf2T34U6Z17LV2LGDj3qQg4/rKFIuZj+XYBx6XaUBgKhmB+nQQF12QtoozCcdf1ZT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064720; c=relaxed/simple;
	bh=INNvmizzr9bSIYe8CafS+8FpdeeEetTVCSzMqAOG4Zw=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=grtbKVHQsG73+h7UTsO3D0csSNqa5GI+RR5SQx7Y/+GH2lTecKfhOm6kLz4RdFmi2/oTBBfFCUfjYPljIeHbs1r7eaS4trwe0SQOWIekmNl5V3E2J4rCtnxVlZ4IvObWMDmk2FKedOreOdvNBom8XtbeUz7S6R2Yrbs5cI8r3b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LrI/M23K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DG+wpvdo; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LrI/M23K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DG+wpvdo"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F529EC00A0;
	Tue, 22 Sep 2026 04:11:49 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 22 Sep 2026 04:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790064709;
	 x=1790151109; bh=30w+H+Jy77CB1IMMrGrDw8PzlyBU4ZgFjnjr6bpNuYc=; b=
	LrI/M23Kre781/2ebAk2fJlHrOTQ7kNDV/ecbJSSCMd6mLegTXHKbYaFtuC7ke29
	nQHQzo0HTLv2u5SgfwyhBP48BEsSAoyAF8IyfXCSmd//ZOqCfNzNaGuipeKqvTF7
	O8pm3fPymmh9YSkBuyLzSN3io7vLRfobGH57fQ2uUa1VgOfz2ie4p/+O3wEZtJzl
	t7d11zw7ssdxoPVDHRbKMIwoaJj/Zvxz/smoIfvtd/9Y20jfXba3sw+HGErRhESP
	XpSCxGyPbk2n1dx6/YcOi1aVZ2l29jvZh9BIMXdCV7il2hEsMh5tuWQ576D0+WjZ
	bWypaOBUMaHJEy5dj/PGNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790064709; x=1790151109; bh=3
	0w+H+Jy77CB1IMMrGrDw8PzlyBU4ZgFjnjr6bpNuYc=; b=DG+wpvdoWHCkIV9y0
	UlF4M6hSXDWwc89H8IiupBdYyv1gUhPQ6D1bhD2k1X1U2hSCV+iRmgXw9ZF7TOPP
	ZlLANtQ/6XYuzp72XNi/c2weZMcJ/ePqpfSf2Kd+pJQgAKvXW2CSCq2VKFPBXl3J
	1ntTrpRlmNqat6c0Kcy1U8gA+WE/QxNXiy7tkZM6N4AiYLSlUs94X+Vnn3f+RqF9
	ChnBxWR51SUYtI5yO/E9JIsImT7SHLxUyZMP+xhe9ALxAqJPWDA97QsFf+Y5dIbC
	s15JOr300ta1Ma8Nxt1b14zx51gxK7aTPCEUIGCmxWE2pQuhhQK1tQigCFhzSjNX
	38WzA==
X-ME-Sender: <xms:QziyauEG-zSJq6oQb0PPSzr-8ANgDolVu4mwFaqoHp5J4JjpDRCgObg>
    <xme:QziyaqLnCmhyigkUYCI0xVWc81lASFaF_MEBbkaQRItxUzXGkNWJBQ_yl00G5JWzb
    hc2bSB5TDczLkmNMvf2JQ4_wzIYkS9Lg893kJC6ObO5W3WXHu47FBg>
X-ME-Proxy-Cause: dmFkZTGQVF+VrS8yaEqsrqQixzdx8MhCNxTQPyZ9KiyFYOfBO9cjFtHEDdurV0kzSV48YL
    fSmDi5W2Q7QFczPE8y2SevT6+7SD9IdnGJ10kkosaxNeBN/BhG+/DySIkp6Ue6BuPFZIcJ
    XfwZusTEJKVRZjoB8FcHZDuIedktWDKIhsDLrk8tMrq43n91Wkp7/hCd1/MOwbJGn4cftw
    AjnCe7tDUR9jIkAl88GYbw3WUlwQF8q8pfIWgVsEc0TJQWbpSdmudJnLDpeEia5XZuhkPd
    Trr/s3lxnxbG0e203cDFhX5MiFmbPLn41aHmD+GNcOagJMlwTxX+RjHFAsa3j/g/3570a2
    zp2TvY70BJ1Cr8QfnCExg+J8FnPueO0+J3UcNGTKcZEXFSPToBNM97SRdmqE7+QEpuw0pC
    IIuhnuXsW5EmLVKdapdvV7Vc8tHpm21qQBDLf6OyFLLXcBMU2gnsnlFkjy5+feCXIiTSDA
    7cwndiQV/Z+vs5dHvICn/nIl8mJu4NCZybt8BzvbRz9BEOFYe2arbqlBd3/FH3YgtkUhNe
    ZAoALHZoeq6l/diG0tJ1WX7UXj5nw4Qi+K+85zXUKq4kzyHjxQmCermT91ukbwCCqh4OEO
    mgCutV7GJup2KBe84BZAl03lynGRz7BKY751IOvRMFzjed4hvB3+uOI+M0ww
X-ME-Proxy: <xmx:RDiyakzoCOOznjT6soF00ePuFE0Lq0v4FvmAWfUUGglEQesGqjh8yA>
    <xmx:RDiyamN5aeGlnk-CE90tsz_TLyGSlv-hdPqwoCGnTxYIV_Ko8K_KUA>
    <xmx:RDiyat4eAmi7iDJ7FnXLjp5S_7Xz8DO1HebGz9pGkyV9p-JejXjbIw>
    <xmx:RDiyavOD4sbJ9aNz8kbTqdP5pPAroP24IAkw_gOye4lDB5b7weJqLg>
    <xmx:RTiyal4hSbvQVR4sFRncTg78EOcAfqCzmFxaGxhBHVFOrkvnBS8sDTqk>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4AFEC22C008A; Tue, 22 Sep 2026 04:11:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 10:11:26 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <92ae04ac-6e94-4785-ae51-dbe794c07fad@app.fastmail.com>
In-Reply-To: <xmqqwlsei1pv.fsf@gitster.g>
References: <xmqqwlsei1pv.fsf@gitster.g>
Subject: kh/format-patch-range-diff-notes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026, at 02:11, Junio C Hamano wrote:
> * kh/format-patch-range-diff-notes (2026-08-24) 3 commits
>  . format-patch: learn --[no-]range-diff-notes
>  . revision.h: rename struct member to reflect notes role
>  . format-patch: simplify get_notes_arg parameters
>
>  The 'format-patch' command has been updated with options to
>  configure notes specifically for range-diff output, allowing them to
>  differ from the notes displayed on the patches themselves.
>
>  Expecting a reroll.
>  cf. <8f0a076b-4822-44e2-a842-cc1e39ae1c1d@app.fastmail.com>
>  source: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>

I=E2=80=99ll comment since it=E2=80=99s almost been a month. It=E2=80=99=
s a straightforward
reroll but I haven=E2=80=99t been able to do the about hour=E2=80=99s wo=
rth of work.
I should get some time at the latest on the weekend.
