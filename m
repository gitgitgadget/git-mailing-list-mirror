Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1411D88D7
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 05:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765256892; cv=none; b=A5fP4Sh50wvUGkQYUe9+Itqz0IM0SqzzmS3zR4xQjnElEkyhSKY9XOQn713teXpDcCy0rl0B+V75A8TZQPOyh5MMe41G8PynwV64yCRhA3LOjeyU3o8krnSvLeVi6ZpLU5ESwVoOfHbUvJBIpPyDhjzMBHDsy+9M6wjc/HQ2R+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765256892; c=relaxed/simple;
	bh=4+ly0Nx8YmgJ7phm8+a8V2E2uXrFIAiSjSI0Aw4LjgU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YxhkjfBKrShxUJpA4B+xwrtrt7xmUp3cgtGX46pVc8W5Xf+Omi6DiWtaVl/htEz4MyWd5ZrxKpOcY4xmGrkBwdmZzUA2Y1XQTd5Sm567cGrx2/zCSHatB9JWJzTY33g5xho3chrOCXIEHhLC2rrYbPxoomVUHrAvZiD30OQVoxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLopyWnV; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLopyWnV"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-78c4aa7af99so20082497b3.0
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 21:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765256889; x=1765861689; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4+ly0Nx8YmgJ7phm8+a8V2E2uXrFIAiSjSI0Aw4LjgU=;
        b=KLopyWnVHEgJyK99hIRaCZApYnmtslczr4S0Hyk+HMx5Lo3jGSfOXpzzxuCz2vHPMz
         yZwPLf0ew8LHD6hW8z1KWxlUUOpOP/5RISo0YIzg2mxQDAyCcBn3XOi6LooOdVNeFLQ5
         kWFAbTA7tG/lncey0wsGtYyTXhAcTx1c/oTY3zo3UzJNVHEyv8CP4rxAi3mpDwMpdLb2
         u5DyO4XP96CtD34ERw/PgbSZI63DujFbks0wzTF577WxcFx8DDZu0mM3o+hUmHnU2dTI
         Vbpy3t5MkYy8YQ25EV6ckTCs5L+BBk7dwic9vvpd5Js3BVtTDh1oixrN5EA8+skVR2ff
         Lq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765256889; x=1765861689;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+ly0Nx8YmgJ7phm8+a8V2E2uXrFIAiSjSI0Aw4LjgU=;
        b=k6SMiS5gpQI2CGgmK/OmBbo4pGOO9Ie0Abo5TTh/zOsUzlR/n4NkdCVfFC+q9ATEfr
         di+OR0HpnX25I1TC6zLXiNh0/0XapwcTLYjLp6XmNcrX/U5WgXuR2xCPzaAsyz8Dzt4l
         g3SK5x/GpzOh/B2CnxEfXEnUNjoCZxJTQF4QFyM+Demwsv/mZtSzDo46XbttYBafflr5
         VosqZWQCVbRwtGqXdYACQ75tZOg7wBa5JWEVZ3LrGG77M6zQiOb2PXIhEoxbJyO7DHjV
         KsmIfJmL4LdLAYPynOXybiTS9lIcOMyf4Imhbx/G+kqgr2+vFyXiVGLkNoys7Kj0llvl
         g1Gg==
X-Gm-Message-State: AOJu0YzbPlPCzvXYtgKLluIAml6bHzALE9RY+aoRygH/QhnHjoauNzos
	DAqUsZvVnl0sERPVcbTIiUqacf6Thz1uZj2X11j9wzkMAM9ZgNrBPFP9TpTM5ecz
X-Gm-Gg: AY/fxX4yPYy6fF382R+qvkTpEa0EkUdMxVptIgFjTSWaStkeaEtxrWx0zQv7GY9bLWu
	JmAgO0lul1WHxrv5c+9DbWuwymxa+Irpol510V59ViSRIWgHVXSumK5S69wl9vk8lFBUSWenxLP
	pp3xHvmW9jDt6HGM+bR6yXKJffbZ+xwpt67MFIcbm7XopysVgZvQb9Lg1ATbg1fEQZYeiVQx1tn
	tlUlEqRZaINs3ue3EzHotgUMfk5CNCtb/o2DW1qGLNbUsj6P2WEJXAgX2YFIbbpHct/OHx3TZY6
	ZqaQNr9/JINHPHFbOpsAsCrP4eyVEz3g2OF185avgOPKu7ckvTGSKbcDJo5tOOGfLe1qYBECpos
	9Z32tpT+J/q/1rfzW0YotdSHxQGmZenCZ9Ff8lyyLf6Wz5aBsLosxRAjHfmPZAZ6ROUADHIHe3i
	Jsb4RroelQI2n013GeSewxYSHMV78gSOji68JcvvD8erVi10F62jofc+gCtpbZzYGmbJpgK4ofI
	t1XcJGZ
X-Google-Smtp-Source: AGHT+IFO0JDdjnoBJo0klC7JMO9sfd9/luGmkFnbsd5G8OecmY52KLtHgvBzH9i1hKKQ1nN9FE/6HA==
X-Received: by 2002:a05:690e:24dc:b0:640:e021:ff79 with SMTP id 956f58d0204a3-6444e7b6632mr6007393d50.39.1765256889127;
        Mon, 08 Dec 2025 21:08:09 -0800 (PST)
Received: from DS0PR03MB7290.namprd03.prod.outlook.com ([2603:1036:5:36::5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c5dc3330csm2809167b3.5.2025.12.08.21.08.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 21:08:08 -0800 (PST)
From: Ryan Johnson <ryan.johnson.code@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: UX failure: SSH authentication failure diagnostics
Thread-Topic: UX failure: SSH authentication failure diagnostics
Thread-Index: AQHcaMjneoFPjyQXbkClfgbHeCI7bA==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 9 Dec 2025 05:08:06 +0000
Message-ID:
	<DS0PR03MB729012244C8A65D318FDC205A3A3A@DS0PR03MB7290.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

When Git fails SSH authentication, the error message provides no indication=
=0A=
that Git may be using a different SSH client than the user expects.=0A=
=0A=
PROBLEM=0A=
=0A=
Multiple SSH implementations commonly coexist on a single system:=0A=
=0A=
=A0 Windows:=0A=
=A0 =A0 - Windows OpenSSH: C:\Windows\System32\OpenSSH\ssh.exe=0A=
=A0 =A0 - Git's bundled SSH: C:\Program Files\Git\usr\bin\ssh.exe=0A=
=0A=
=A0 macOS:=0A=
=A0 =A0 - System SSH: /usr/bin/ssh=0A=
=A0 =A0 - Homebrew SSH: /opt/homebrew/bin/ssh=0A=
=0A=
=A0 Linux:=0A=
=A0 =A0 - System SSH: /usr/bin/ssh=0A=
=A0 =A0 - Snap/Flatpak-packaged Git may bundle its own SSH=0A=
=A0 =A0 - Alternative installations: /usr/local/bin/ssh=0A=
=0A=
These may use separate key stores and agents. On Windows, the system=0A=
ssh-agent service is inaccessible to Git's bundled MSYS2 SSH.=0A=
=0A=
A user who runs:=0A=
=0A=
=A0 ssh -T git@github.com =A0 =A0# Works - uses one SSH binary=0A=
=A0 git push =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # Fails - uses different SSH b=
inary=0A=
=0A=
receives only:=0A=
=0A=
=A0 git@github.com: Permission denied (publickey).=0A=
=A0 fatal: Could not read from remote repository.=0A=
=0A=
This error gives no indication that Git is using a different SSH binary tha=
n=0A=
the one the user just tested. The user has no reason to suspect this is the=
=0A=
cause. Debugging this issue typically costs hours of research.=0A=
=0A=
SOLUTION=0A=
=0A=
When SSH authentication fails, Git should:=0A=
=0A=
1. Print which SSH command it invoked:=0A=
=0A=
=A0 =A0 =A0Using SSH: /opt/homebrew/bin/ssh=0A=
=0A=
2. Detect if multiple ssh binaries exist in PATH or common locations. If so=
:=0A=
=0A=
=A0 =A0 =A0Note: Multiple SSH clients detected on this system.=0A=
=A0 =A0 =A0Git is using: C:\Program Files\Git\usr\bin\ssh.exe=0A=
=A0 =A0 =A0Also found: =A0 C:\Windows\System32\OpenSSH\ssh.exe=0A=
=A0 =A0 =A0=0A=
=A0 =A0 =A0To use a different SSH client:=0A=
=A0 =A0 =A0 =A0git config --global core.sshCommand "/path/to/preferred/ssh"=
=0A=
=0A=
This diagnostic should only appear on authentication failure, not on succes=
s.=0A=
=0A=
RATIONALE=0A=
=0A=
Git for Windows bundles MSYS2 tools for cross-platform consistency. Homebre=
w=0A=
and Snap/Flatpak may install SSH binaries that shadow or conflict with syst=
em=0A=
SSH. These are reasonable packaging decisions, but the resulting SSH client=
=0A=
mismatch is a known, common failure mode that produces no actionable=0A=
diagnostic information.=0A=
=0A=
The fix is a one-line config change. The problem is that users have no way=
=0A=
to discover this without external research. Surfacing this information at=
=0A=
the point of failure would eliminate significant friction for beginners=0A=
as well as veterans. Seasoned programmers and beginners alike complain abou=
t=0A=
UX failures like this one all the time. Considering your tool has become de=
-facto=0A=
standard, you should take care of these problems. Dealing with this problem=
=0A=
 is the responsibility of the tooling creators, not the users. Do not shunt=
=0A=
responsibility onto every user to sit and spend an entire day of research a=
nd=0A=
headache unraveling your poorly-communicated configuration nuances.=0A=
=0A=
--=0A=
Ryan=
