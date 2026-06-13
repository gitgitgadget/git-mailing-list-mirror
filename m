Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7922E717B
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781359671; cv=none; b=gz+5t5sr9nMcKP4jEIv3guYfQybMzB/pkAMbHKyrkWn6SXvj+P6OX1XXLPwV0TJVIiYldsbATD35rNUDoasc2ZmCqh56eP5ospeNB3ZxdxUgeQW8g5ITtewYUzxuOarPBCi8mkAhU9BIrj7sMue1pjDMzS3XQ7ofao8fSTBHjsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781359671; c=relaxed/simple;
	bh=XdjzI1bdSihQvTvQaMN3KIHHyvh/yg58A/XyRXDqGec=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=IoTDxjR4po/+UvCOqsKnisyZrmVeRHqJlm75Bj+oAUp9phdi+CzwZ/eAgIMgfuEpeJUf/HQxCHsRFmTEgqJLLXwfc929nkoi8KTIDsLiY4Wqz0yPQo5jNiBZgjKeG/adcuH5sOiXfpVJCupbrU9NwlFI7R4ROCEnJeCIltp3usc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2P1IX7F; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2P1IX7F"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7ea6923cc94so19707357b3.3
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781359670; x=1781964470; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XdjzI1bdSihQvTvQaMN3KIHHyvh/yg58A/XyRXDqGec=;
        b=p2P1IX7FUmaiDhPs95mEQ7TVsMbqpcHv1IdNorDveewkoBqkSdfkqaM3iIobQHpPic
         Z96PqrtFx6zI6uLr2hJZiwpkIWWaYmq/2mjHyRGT/Paa/ro3+BlpPG9uWDJEhW6Pozd9
         xgb0NL/yfSy3nkLTF7N9OGA+ZkLfYh0wWHwe9Kis7PeMQ9q+93wBTUXsuX0KWa0gmVUM
         cA08HnPdcyaGZTLJ29JHXKKExus7Nb5OP8v/A5liRfte8fTjsVxZdviVK1nzVnILv1PH
         ojpuzKPInOXr6AOUmpm+v1CXEkJ6dbs/4NtMR8+CzD6phrHo4Fea62rkKiwqSHJ9gwAB
         19XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781359670; x=1781964470;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XdjzI1bdSihQvTvQaMN3KIHHyvh/yg58A/XyRXDqGec=;
        b=SGGZ5x9VLYEtkf2H2YozA8DhvnAui+H67hPDg7+MZMC53I8dSizfLxbJV1gwF34GDk
         KiDZaccQ7LjvC2XNmJc7wRq8+i+b5TIgLdU/HTtt1ocqQMbGId+JsCNwjlkJdYK0AFob
         PLnqJiV+RGq7qTww1ujBWYQ9EdF5J4zscVd4ewgrZU5IJFlb/C2aK0EjI8p2XaLGPTz9
         4NLNzLMosVRiqGmeGjLmz3gpqtk/juxwfHnbJj3335E7kKbHmyHbORajWkS81bUZddSW
         BKQc39XrwGcRfdq8iwDouHz6TM5+1nsw5mt/x5b+9X+nWK3/YDpfzomxS/3kXwWt9oFg
         GYdA==
X-Forwarded-Encrypted: i=1; AFNElJ9g+Q1atiL8l/2rixDQmrsSwICoFMyhYBlAX32SICQMknJ4Rzk19AsBPFzta9dDHTXQe+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBINccqg5SZmoa5YXZ8nCcj2IzVfcq+MtKMuq5jty68snP5n/4
	6QyNlnjYoLsIpxm5VnYKafCPllI0k/EIlPMXzsLipyI8UyTzJg67UqP3wf3ZIpXp
X-Gm-Gg: Acq92OENa1BxaSWiixNXr+KPWdpHtbcrfX+wtzzGgmXt43YgkAmou5weTC8jO1PewVc
	fSCtf2xtOHeDvka8sSTaqHgCEEXmuIRYV2Qje2FLIhZnQ75HzOTkd1idxLntxez+FOG0ZqpJIIz
	MBB6c4kfWxStcQ6yZuOIvP8r2aeUP+Shb+5XAtSUwt7RfLiiemDYu9hQt+kW9DOIR5Uy1y5btth
	ZHBl12Asepm5xrt8wlX9RqP2rvc2yUkVkUEAIcS9B+bwuK0W3azw8h7XPQ4oYJRaW6HrAidv9dB
	0WfaGp7wD/dENqyNOjos0QbAL1LTftuNlpVbffYyk7HsyXK20/I5b8cYCEwZdlaVJweZMV8dz0b
	NDWHYviQ8E5GmX3bq4kNxeqRxxrikGkKc25xiWYyswLJRekvHfnOcLjT+2OQ34neUHkZBlfe2va
	vnb2aEWR206JIsPQYxcy84N9HCPCe3Cn7Vd25QG8Z2YYMrupEyQ/utLOWLkdXMG/bRWYZFw6iA6
	rBOMA8HcGVmHx+Z41xwEtFhdi1480WoTnl6kXgTt9/JLw==
X-Received: by 2002:a05:690c:4c0a:b0:7d0:4824:6424 with SMTP id 00721157ae682-7f7b9016001mr64524107b3.39.1781359669663;
        Sat, 13 Jun 2026 07:07:49 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:b19e:99e5:a2b2:d273])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f7712f23a4sm22882857b3.35.2026.06.13.07.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 07:07:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/2] commit: preserve commit hash on a no-op amend
Date: Sat, 13 Jun 2026 10:07:38 -0400
Message-Id: <C33C3BEB-6353-4461-8E7A-72DB663F8BEE@gmail.com>
References: <355d4f1a-147c-47e3-ab09-06810d7910c0@kdbg.org>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
In-Reply-To: <355d4f1a-147c-47e3-ab09-06810d7910c0@kdbg.org>
To: Johannes Sixt <j6t@kdbg.org>
X-Mailer: iPhone Mail (23D8133)

> Le 13 juin 2026 =C3=A0 05:59, Johannes Sixt <j6t@kdbg.org> a =C3=A9crit :
>=20
> =EF=BB=BFAm 13.06.26 um 11:16 schrieb Harald Nordgren via GitGitGadget:
>> git commit --amend --no-edit rewrote the commit and moved the branch tip
>> even when nothing changed, because the committer date was reset to "now".=

>> Reuse the existing committer date so a no-op amend keeps the commit hash a=
nd
>> leaves the branch untouched.
>=20
> `git commit --amend --no-edit` is a way to set the committer timestamp
> to the current time without changing other aspects of the commit. This
> takes away this ability, doesn't it?

Indeed. This is a convenient formula to force CI re-runs in certain environm=
ents, and so on.=
