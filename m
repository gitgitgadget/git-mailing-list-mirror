Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23C1C36
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 00:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797362; cv=none; b=Ahr+F5xy3m4VAohqrpIaksRjx1Ywr+54kZ4GBfYWvYfT0Kjhg/5elKjAqoqp1dthH5O43erF+V7TIQ1gyxwPhk8MIOQeeJIvtIvrIWs5G2zaQ5VGujJNk8yi4FvNe3rd9heNC+WoAKpwUj4OOZCwPBwrhdtvgiI9SEgOaZ8Rq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797362; c=relaxed/simple;
	bh=iBmxoOdkcOK7yZiEdGIeKQQfDo63PsB8MkvwBS1tYlo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CbzLikp3/WR9d9YlA5MYrmxyhEOLbyFmFGLbUDY8VmrDzYq+ZrxXL9z2+Brq/0vfEQNyeG6u3DA4YzU9mRQKhzeQ7tkLwbCm96LXSMsXoXL/2zPlMWREgN2dnU1QXeJLqkS2j/7n6cFpXMDUQAgx3LglfvF4/+05YDiC6qs58hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmy17bTN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmy17bTN"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b45edf2303so1346198f8f.2
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 17:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752797358; x=1753402158; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBmxoOdkcOK7yZiEdGIeKQQfDo63PsB8MkvwBS1tYlo=;
        b=kmy17bTNiGQLI8YoD0XMvviuEjAZsCXQA+saKWFSJeLAiZxyu0bvZa8YR8NSPlc6R5
         zMuG/+svi+5G7hX4a2nVQ1BJj5n9gX3Y5T/lrzkzA7SXyuhsNOL8G2t4zk73oy0DDZgI
         790d6KjV3GgeZjknlWSeHQ4jNsGtfohp6K0PLcKbF4wRYMoWuBCJnbmUH+YA6lNE12X7
         uSkeuRln52dyDVhoTxFar+Ore/4r3+JJL6mtNAQ9xqcTr8KL4t20VeyRrdXRW/juU1w/
         +z/4TAWwNW0pZTxwYqo3ROTs6lXX4JLfQ31nonKgHwAYYKEeNl9jinbrOia6X4WTsGXe
         MaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752797358; x=1753402158;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBmxoOdkcOK7yZiEdGIeKQQfDo63PsB8MkvwBS1tYlo=;
        b=f/EkLYEiGvjqBPhH2stwkFZO5aOI0UeLuunUiOMLvZXOzFW9okDe+kuNJ/tVzLMofz
         Ov042X03JWJ02PW4q01fKQS3+pv35i16uzpZ5vMxwfQ/6VVL/5iJBx2s8DqyBmmgZs/M
         hMGJWG9pxurSPoVq/tN3NX5EojN6yGurherMgaX1Ct+3NEII98Ajc8SeoWPgbB+rwc86
         0kWbN3DwjNPQ6tas5UV0tjX8o7E+17AlVX48NeFW6JGQI4kmY7f7Pe/6I/uUOpJ22Q6H
         FV0yXrboyYTVkFFm78uhmuIfPk0NQWa6mMTVIWrs1Mr4eD4bPZ/JkOAsDI6G6cu60aZG
         qjVw==
X-Gm-Message-State: AOJu0Ywv6yHisKoqHcSPezxdm6zuh0/CHtt42bWBfdwT/PuvfuXwkDIj
	VFVkQVXBJsA5vyIHUN6a9CIf9Lr2+ZBPfQT4QIIw8gVwcgDaJpWeW8S6Im4j1w==
X-Gm-Gg: ASbGnctOA3pVr5t2x3OjQOt0zDS4m2RmLtEOEBi+HguUnhy2S9p3kvlh7Ydpp2zE+LT
	kmqNGIA8+KFvMaFiKcTWn3n3vYCa5inqmlOOUup8JRFrlASbcOQOa6u0UjNK8A0qZ1YjXC+vi1d
	83svYCoX65ZY/VR0KXaH+EMxTIBnJKfw+fzWbdbzda5aeOmzslMce3hBlB1BAZUTJBKqQBsqrdO
	EeDgd+L6x5HaMxdQRJYJZ0byBKyYwZcKDutfXaG0XcOU0oG3uLPwPTYrNmvqS/9LmnxfZMqdIxG
	Q3dPmbq+dWGe5VdT4BgCJFb6fHWb9QWKPHJ87An3cp9BURn4Vg5Z6r+ZLUfvIUhETPAsoHa5f4j
	0OLpjFgWBqjdO2XBIiVexB9cDBNqOCqR1us+nojL/z3dqOT7XXItW3msvE36cKK4=
X-Google-Smtp-Source: AGHT+IHtx2m/9JAH5sFErh0K5E3YC6CYElirUWLMQcaLWc2GHXxf2t/v5/rYdLan8YYocUs4pPqyQA==
X-Received: by 2002:a5d:5d85:0:b0:3a6:ec41:b9df with SMTP id ffacd0b85a97d-3b60dd82984mr6644572f8f.49.1752797357417;
        Thu, 17 Jul 2025 17:09:17 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e11:5000:e0:e54b:573e:d3c7:b549])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4c754sm246882f8f.59.2025.07.17.17.09.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jul 2025 17:09:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: Git bash 2.50.0(2) not working on windows 11 PRO 64bit
From: Fabio Frumento <frumento.fabio@gmail.com>
In-Reply-To: <CA6C88DE-F21A-4146-BC69-E68276FAF592@gmail.com>
Date: Fri, 18 Jul 2025 02:09:04 +0200
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <924B7F4A-F03C-4AE4-8162-953B1FDE6B8C@gmail.com>
References: <C4F62B0F-1729-437B-B9C0-0FEA74B307E0@gmail.com>
 <572ec2d0-b587-9cf1-7643-1a0f3e59c268@gmx.de>
 <af2ab4ad-51d0-7b88-a0aa-6063e3857d4b@gmx.de>
 <60796326-CA62-4AC6-82F9-4F1943428645@gmail.com>
 <CA6C88DE-F21A-4146-BC69-E68276FAF592@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

I=E2=80=99m trying to nail down the issue and bash quit without any =
message while loading the bash.bashrc file in /etc

The offending line is 57=20

"$(declare -p PS1 2>/dev/null)=E2=80=9D

If I comment the related line and leave just=20

export PS1=3D'\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] =
\[\e[33m\]\w\[\e[0m\]\n'"${_ps1_symbol}"=E2=80=99 '

Bash continues but then crash loading /etc/profile.d/git-prompt.sh

Then the offending line is 22

GIT_EXEC_PATH=3D"$(git --exec-path 2>/dev/null)=E2=80=9D

So I tried to run a simple:

VARIABLE=3D$(ls -al)

And guess what? bash crashed without any message

So it seems like any $(command) occurrence is crashing bash=20

Hope this could help to solve the issue, but the main question is: Am I =
the only one with this issue? Could it depend on some local =
configuration?





> Il giorno 18 lug 2025, alle ore 00:44, Fabio Frumento =
<frumento.fabio@gmail.com> ha scritto:
>=20
> Hi Johannes,
>=20
> Ok seems the issue is with bash.exe, if run with =E2=80=94norc option =
it start and I can use bash, sadly git-bash start it with =E2=80=94login =
-I -v so no way to have git-bahs running
>=20
> I=E2=80=99ve recorded the screen and captured the cmd window during =
startup (it immediately close, just a frame) hope this could be of any =
help
>=20
> CIao
>=20
> Fabio
>=20
> <Screenshot 2025-07-18 alle 00.41.04.png>
>> Il giorno 18 lug 2025, alle ore 00:24, Fabio Frumento =
<frumento.fabio@gmail.com> ha scritto:
>>=20
>> Hi Johannes,
>>=20
>> Thanks for the suggestion
>>=20
>> Yes already tested, same problem
>>=20
>> When launched by double-click or invoked in a CMD or powershell the =
usual black windows quickly popup and then close
>>=20
>> In cmd no error message is written, it simply open and immediately =
close
>>=20
>> Other tools like git-gui and git itself seems to work, it=E2=80=99s =
just git-bash not working
>>=20
>> Kind regards
>>=20
>> Fabio
>>=20
>>> Il giorno 17 lug 2025, alle ore 19:27, Johannes Schindelin =
<Johannes.Schindelin@gmx.de> ha scritto:
>>>=20
>>> Hi Fabio,
>>>=20
>>> On Thu, 17 Jul 2025, Johannes Schindelin wrote:
>>>=20
>>>> On Mon, 7 Jul 2025, Fabio Frumento wrote:
>>>>=20
>>>>> After upgrading from 2.49 to 2.50 git bash won=E2=80=99t start =
anymore, a prompt
>>>>> window shortly appears and close immediately, downgrading to 2.49 =
solve
>>>>> the issue
>>>>>=20
>>>>> So 2.50 don=E2=80=99t work on windows 11 Pro
>>>>=20
>>>> Maybe v2.50.1 does?
>>>>=20
>>>> If not, please run `& "C:\Program Files\Git\bin\bash.exe" -li` and =
see
>>>=20
>>> I meant to add "in a PowerShell session" here, but forgot...
>>>=20
>>> Sorry about that,
>>> Johannes
>>>=20
>>>> whether that reproduces the error (in which case the terminal =
window won't
>>>> close immediately, giving you ample time to copy/paste the error =
message).
>>>>=20
>>>> Ciao,
>>>> Johannes
>>=20
>>=20
>=20

