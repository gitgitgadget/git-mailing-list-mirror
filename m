Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C4309EEE
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770066620; cv=none; b=ArC2k+cT2Qg1TfhaC3Bq4x58EloHiBFmd3b8BcbhEgfdlnrEwlxAct6Z+NB0zqpKjZWatJkTKjHaDAikjADzvfLb1qJjJwQgm7eXyovFeFvtM6DnqpMVUjjE/1KLx76PcvrxQGAGN4RurIQCMxLWqZ0Qrpj9/AIZso3NN8fbSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770066620; c=relaxed/simple;
	bh=pO6bcpDDlPM3K/Pwa5obSBFjqqirAbpX5CqZXXsmddQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FGY/UllYtzEnauyThq4ltJ4t8OgvO+asg3M1PZIET0fqHGi38nXZUNMz7oh0D0SWgXcKf9NyBUIl63BQzCo4Hjdtj5AFfPjrAW4nq6pyPngEUrPtBLKAqu33KwtGEO0gRHSFWry1DscmTw6XA3xn9BE6zZvwxsnumTZ1ONGHQyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2Bw2MNz; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2Bw2MNz"
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-45c733ccc32so3131384b6e.0
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 13:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770066617; x=1770671417; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNLcXOHMex49W3+QTKrLCKw59Py99c96RGPD45xGaNM=;
        b=M2Bw2MNzYs1vuJp6fuvUFtzbju+tyM4N6JW3xALwoL+5x5Rec9dAnAU2IE1tlClzLy
         c9Xrp/6mdaGxWC9jV0LDZlh4+odwGPzN66SVbRb2tr3tq3+e1Xrjoo8xpFQThF1ieV+e
         H1KkSdax8h/BcZmTiKs2vFQu+sSYeNlc0ZhwM4WG5NrCNGsBU+0f3esBYV+2qFK7AQ6n
         9mlZwFl2JxstWm2iH5oHnffQAktAh54DXHenDoph+udgSz0UyjXFDK3Dqwhbj1trArs4
         D4BFIAagCoBG/9vDczE2D0zjtGrPadplUvFUjWwtYI9guBmUm0i8D6cxs5w1H1eOfAdx
         MX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770066617; x=1770671417;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNLcXOHMex49W3+QTKrLCKw59Py99c96RGPD45xGaNM=;
        b=T2cgt5V6S1WSNq/m8vr69F5n46QRK8bk+uM5TmmDioEDopFFYBPwXBi4pe3x3NKeyA
         S4OY8V19M8YVQHY4nsadAb2+fMD/s145c0QfwEzlvE2o4V59XbBtDprnQwF0eJposwn5
         dFPH7CiS4r4W/4I+iJN9gSeMRerGkCu/Pdm+HNZX7fMDdH2eXrRsdJsO1ZU2c1GlpmqS
         Ci6owkOt+/hP0a6ZS9JbpvDY830jzrc7xPliGoDCBfpwMJg0lsHKCdL/Sg1OcGUYl8td
         HweCHW84+odE4NdVwwE9FrWl+fK6qrXPBHkTccYnMV4xgxXfV4Hsdiz7zgh0EPiovYEK
         Tr6g==
X-Gm-Message-State: AOJu0YzXE0wnTQTCLlZvOVvcAclWJXrv2sTCqCBhl4T+VKvD0slaG+PB
	pudkzdvUT8T90ubWDl9lFMeS0hwLX8N9RA9MEJ//Fd7c182euS1oIQld
X-Gm-Gg: AZuq6aKb4gcnkJL22VpY+BheCthcFvmaDgLbp4zSo+0apcFDL3GzUooRHILTOzj2uf9
	097FYjwjGOaIf9Oeujv/+RaTh2sMfVNse3cr12IwBNCa2sLJ4hdUb1OWZRD2v8z2UdeHfArxCtp
	PkO0gkMnc3KE+U5lhixDDkhQnkfgT5qldgzxzH3idvZ/Z2eDh2f3wVMwNwM+EbtQo8fBSssaXqo
	UnduXZVT06gu6FxJPO4h2p3utQns6wX1SvlULAGzAuRRfa84PLpvS/60AoG16Kfteg2f6/DHWJS
	PPBPU+TJjb+wR0IoEFtcxB1q1atrpL1FNobgrEWolPkpuwUBAWZRKdJbOS8tCiuIiPXCWqCU3WS
	eX4sHXj/r8rl0SsrwcnkNn2MjPPcu221chYLSXdanKwUMbgy4o7NztucJtrRGtTN9/DGeY2r9JE
	t/6+SPQgsAoI3Y1VjuSz3L1kYfe3lakEIs4wf+2YQTrRfT9IY=
X-Received: by 2002:a05:6808:1312:b0:45e:f91f:9730 with SMTP id 5614622812f47-45f34d207a6mr5393281b6e.51.1770066617682;
        Mon, 02 Feb 2026 13:10:17 -0800 (PST)
Received: from smtpclient.apple ([107.11.98.107])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08e23c09sm10135330b6e.9.2026.02.02.13.10.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 13:10:17 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 5/5] doc: document reversive traversal and related modes
From: William Hatfield <whatfield.git@gmail.com>
In-Reply-To: <4710431.LvFx2qVVIh@piment-oiseau>
Date: Mon, 2 Feb 2026 16:10:05 -0500
Cc: git@vger.kernel.org,
 ps@pks.im,
 glencbz@gmail.com,
 avarab@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <725FFEF5-90F5-4C6F-AACB-C372BBCC4C84@gmail.com>
References: <20260131214309.1899376-1-whatfield.git@gmail.com>
 <20260131214309.1899376-6-whatfield.git@gmail.com>
 <4710431.LvFx2qVVIh@piment-oiseau>
To: =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
X-Mailer: Apple Mail (2.3864.300.41.1.7)


> On Feb 1, 2026, at 4:03=E2=80=AFAM, Jean-No=C3=ABl AVILA =
<jn.avila@free.fr> wrote:
>=20
> On Saturday, 31 January 2026 22:43:09 CET William Hatfield wrote:
>> Add documentation for the new --reverse-traversal, =
--append-superproject,
>> and --reversive flags to git-submodule.adoc. These flags enable =
post-order
>> traversal through nested submodule hierarchies, which is useful for
>> cleanup operations and dependency-ordered processing.
>>=20
>> The flags only take effect when used with --recursive.
>>=20
>> Signed-off-by: William Hatfield <whatfield.git@gmail.com>
>=20
> Hello,
>=20
> git-submodule is being transitioned to `synopsis` style of markup.
> See https://lore.kernel.org/git/
> =
05e68e28257cd450463d253abe9b2995759bdc10.1769462744.git.gitgitgadget@gmail=
.com/
>=20
> In the same move, there is some work on style consistency of the =
manual pages.=20
>=20
> Below are the remarks on what changed:
>=20
>> ---
>> Documentation/git-submodule.adoc | 20 ++++++++++++++++++++
>> 1 file changed, 20 insertions(+)
>>=20
>> diff --git a/Documentation/git-submodule.adoc b/Documentation/git-
> submodule.adoc
>> index 95beaee561..2be477952d 100644
>> --- a/Documentation/git-submodule.adoc
>> +++ b/Documentation/git-submodule.adoc
>> @@ -437,6 +437,26 @@ options carefully.
>> only in the submodules of the current repo, but also
>> in any nested submodules inside those submodules (and so on).
>>=20
>> +--reverse-traversal::
>=20
> Now, options in description lists are backticked:
>=20
> `--reverse-traversal`::
>=20
>> + This option is only valid for the foreach command and requires
>> + `--recursive`.  Process nested submodules in post-order (deepest
>> + first) rather than the default pre-order.  This is useful for
>> + cleanup operations where nested submodules must be processed
>> + before their parents.
>=20
> Please start the description with the actual action of the option. =
Then, you=20
> can add conditions, context, explanation:
>=20
> Process nested [...]. This option is only valid [...]. This is useful =
[...]
>=20
> Thanks

Thank you for the input. I will remedy the documentation as described.=
