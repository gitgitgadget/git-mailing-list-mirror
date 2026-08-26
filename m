Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF3B32B10E
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787730425; cv=none; b=K4CDlvdX/UmAKUWObLmJieHeMboLxYLPztExjx4kKossUwwBWBkPkn5Nr17oQksA9ktp3a2QksoVDIt16uk89HQvC5EcQZCyvSCZjJVRaowwCqCbuu7H4jzY9CVy+vCMicvpKo1JrNyKXvfAjEasTaULbR3T/YhYa1sr3xOsW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787730425; c=relaxed/simple;
	bh=P2+5w4u4vxJQkboCt1AU3V7UGBPsAftoj0henhOvXUg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gzG0sf98MkXJ/xcoghehmEMXLmEAgkVBGgF8HPQGhwQdW+ttORr8nVfhJZ74u92AHWHQctFAaUhkjvF5wWqcR4dg4m2Mi5gWESPcPznBIrj4DWiNRaym1NuVlLOrjV/e1kMl5G/r6skvRRP/a1O6sbvvEs6g1DveRgg7TCAichI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=k0/Gepyc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jmwu21NV; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="k0/Gepyc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jmwu21NV"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 02D3FEC026C;
	Wed, 26 Aug 2026 03:47:01 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 26 Aug 2026 03:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787730421;
	 x=1787816821; bh=Irk0UiFB2tQjtQvJ0L8he452+Bn6/1s8T9jMtyIWJe4=; b=
	k0/GepycuP95B6tX46VE/QbZpbyOQ0vAUDDyPLglNxC2CEiCzNikrfq8W86OUx+M
	HFX8rYneuBNAJGT4ZlkjyDQ1/aHzRyNdGuRn2UnpuqOj7H87yNTzp0E0wumLVqRq
	clwF8te7qVAoTIFvKHT7ChSehPqWq7MEeo/fEXcH0ZWLRAjJQnQ+ISHyqTAoHb7C
	x/sPb6X1uQL3azR7fnDmSMQOeN/W/5CpvxSkfUNyq++Y3E4RSIeLb6g2/Wn6zitY
	dsWUiu3NiqM8lB5k4N3COYYcy8HlthbHUpVKCZiH57D1NaHbK9ikgS43smz4XxAl
	LrGr0jHvtQykxq2UpzWQnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787730421; x=1787816821; bh=I
	rk0UiFB2tQjtQvJ0L8he452+Bn6/1s8T9jMtyIWJe4=; b=Jmwu21NVx88Xit1qy
	wnaMU1lRnTgJVnB8GXU7E4gqr9IwdTo/sKSOC2fFE9LzzIw7U2cK47FUaXmeIWRr
	Jhxstvv8OPhQePg9lHaXX/umQzfdUgjJyKg3QulwkIaiccSY8ftF0Ab+5i6LTp3u
	4L4m2f9Io5clULB09aQqKJ2Orl3OCb1WI9AqkKTKtuFOl7At7m+8s2H9UY8EkwpH
	/chqBmHqU8Zeq+oe2vulGEswTuvVhVI46l16JWJziSde1MYy5d5WL+Cb9MeoPnE6
	ir8mRmKnmm0qBCRaGzUFGBjm48KpQEqEFfZC3UcjnyROIL80OpkQ0l/LHGwDbDL/
	unnvA==
X-ME-Sender: <xms:8pmOaux6iUKCmnce3Xpb-_OPww_Q0lzG3_Dp4LmlcQUv10f7dAqfdaU>
    <xme:8pmOalEyGK7fw62DvogaWp_KkD81kFzf-kFSHVHyVwU5K5nkkkj6JD3gMtsCjz2Gn
    4jNQfNlbe8ifRQ72aKgoObFkVhMAIchFpZ2Nn7cwrHgsI6lyJDIFtg>
X-ME-Proxy-Cause: dmFkZTEHRI4PO6XkDS2cUNP/zviYr//hRXmO+LxAps90kpqKSXS+lqpEgrHpcO2uR1wyRk
    2qijEJOR8qjCU6OySAY9RjzH9gOO2qnyunwPFMO8eT+lb5XgBKRQGJfNMzP/0Xm1mgb2LR
    FMou/2ArVBN0x/ar0rbfplw3X5v057F5n33WkG15Z89ddvrvEhiUsDd8Z8G2c+UfG+xMGW
    XfuS+vfBCYqVBORM+/t6Xc5RMtUcgLpcn1b/PIsqTQVuq+KlJLGKyBteNEN8dTGAErhm5r
    067LAs1EcoSLA8rzZz1TJnD99l+0SCAGLbXt0XxkV/7afblx9NdGuoSk9RTlEltH7B9HtF
    3UPk9x1rxSEBJHvmKmigNm2YQ791K9B8XmMwGJcftOMTlfzSnfN03YtVDescbnjDv8gImd
    F4kdvaIymbu71m6QbnU8gWrHlSK7scTQsqUJLOFMblLgejUEgn/7wmPRp/AuwkrwDpV8pp
    JNcO4ckRxJ1+E3m+Lwf38X+I+m5iM76BSw6RFXw44rJfZcY9oKhoMcJAmK3c6fXINUxh7J
    8OM5GBSDeSTrTmeQoBkRlzz7i4D8gsTwIZ+ntH5QigC/+nxmUmZqAxW4TC+thExDiL+27J
    pGOPCcgy5P5AODxizBnN4gsSICfFfo0jIdJw1H2DQ8+kXfCeVNX7AC/9kUvQ
X-ME-Proxy: <xmx:85mOahd1GCZs11VukCSpw3Nk8c65MGIRew5tJ1Slg9Z_0EKkmdYKCw>
    <xmx:85mOatLNqjymS3L2vo5Fns_iZDW2gPRsWsVTW7mm6GXmxc0SpqxTsQ>
    <xmx:85mOaiHMAg1sz_XuJtllhm7k5ReiJpoKz_tBvnpPUVsvm5Xr0as_Kg>
    <xmx:85mOanp7mndJBTa6HvAjcSSFgfvnBPQVsOunuxORra5quOl9A-yfCg>
    <xmx:9ZmOat2hVJOe8Tbbm4JYwhQxCsk0lE89SoB_euB8E5rHD5ERdO8KknYp>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5726822C007A; Wed, 26 Aug 2026 03:46:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZTdDQX8qfvR
Date: Wed, 26 Aug 2026 09:46:38 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: edvard.jo@gmail.com, git@vger.kernel.org
Message-Id: <03ce12c7-a0c1-43a9-9198-ace60c8ba9a8@app.fastmail.com>
In-Reply-To: <3505ADD2-C8D9-497C-B8F3-F7FB46696525@gmail.com>
References: <3505ADD2-C8D9-497C-B8F3-F7FB46696525@gmail.com>
Subject: =?UTF-8?Q?Re:_Whatchanged_=E2=80=94i-still-use-this?=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Aug 26, 2026, at 09:18, edvard.jo@gmail.com wrote:
> I was encouraged by git cli to send you an email when using the command
> =E2=80=9Dwhatchanged=E2=80=9D that now needs =E2=80=9D=E2=80=94i-still=
-use-this=E2=80=9D.

Are you running Git v2.51.0 or something? That older message (since
updated) does ask you to send an email with no ifs and buts:

     'git whatchanged' is nominated for removal.
     If you still use this command, please add an extra
     option, '--i-still-use-this', on the command line
     and let us know you still use it by sending an e-mail
     to <git@vger.kernel.org>.  Thanks.

But the updated one has some alternatives:

    'git whatchanged' is nominated for removal.

    hint: You can replace 'git whatchanged <opts>' with:
    hint:   git log <opts> --raw --no-merges
    hint: Or make an alias:
    hint:   git config set --global alias.whatchanged 'log --raw --no-me=
rges'

    If you still use this command, here's what you can do:

    - read https://git-scm.com/docs/BreakingChanges.html
    - check if anyone has discussed this on the mailing
      list and if they came up with something that can
      help you: https://lore.kernel.org/git/?q=3Dgit%20whatchanged
    - send an email to <git@vger.kernel.org> to let us
      know that you still use this command and were unable
      to determine a suitable replacement

    fatal: refusing to run without --i-still-use-this

>
> For my purposes, I could instead use
> git log =E2=80=94oneline =E2=80=94name-status
> Or
> git diff =E2=80=94stat main

Yeah, those are similar, and more =E2=80=9Chuman friendly=E2=80=9D than =
`--raw`. What do
you like about the command, the specific output or the command name
itself (muscle memory maybe)? If it=E2=80=99s the latter, you can make a=
n alias
with more human friendly options than `--raw`:

    git config set --global alias.whatchanged 'log --stat --no-merges'
