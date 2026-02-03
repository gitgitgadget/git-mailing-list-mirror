Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9543F3A783A
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128150; cv=pass; b=bkTXSeqb1K7dpPvfcPVsDlCDi965fkj5oWoopG2abnYojpNz046AJ4DpOU3MCKBldosemvoHVBnT7BJecv90cjnRX5OYnSC+o6tCBL2dc6S4wb54KTo2WfXZm79hzvgApuPTwjqkuXeRi03NxbDsZ9O686UoFr/0yY70nOpb4e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128150; c=relaxed/simple;
	bh=oa4LzcX5Nno3EVyfWLJdwqz20m++Hc6D/WksEUmwPHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZFIeBvry2Rl0hSfHoAoO/fNhz0dok/wJkLYrK8JbvqN7E+8dvupCKm3Y2+7Si4ihWANibbbsaYioowx7aRTw+v2PWV6smIUvRFinxDS/T/3uHqCSzjFkX2cAPIx21eBHkXhvouEFjoLrGofJZIfX+rLGkixoqmxSHUZsbKdR10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRlZWb/d; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRlZWb/d"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6581327d6baso8219122a12.3
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 06:15:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770128146; cv=none;
        d=google.com; s=arc-20240605;
        b=bSyPYLJzUWLqbu4KMDtoawiEzG1+1Vh79RMsFsUvAhr37dkyRI1FOswzbciNQOM1hm
         kc4EmZ96ICde7A+yO+/Sy1Vj9Ds6fXdMVjqTOsp6XLlF5mvrbRKZQ/XKI2wTSUMIoDCP
         nkZo9hjZRpCtsfu028EKoucStHKwhkQtfK8iXiA8NNHauIpn5oFdF5pHPYSCHTTZ6ba5
         ZyIRAges22iQ/KqtASfTd14E7LBvntDQuZBtRz0v1NVSzv5T/ASqmbJgJw/PsM/hK0iS
         9f32ot8g0d6owsKPoOXI4q9kwDSvz7gtQ7zclIwrpSRP/h1Q52f3lB9KQvh4cP3FlABE
         ECJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oa4LzcX5Nno3EVyfWLJdwqz20m++Hc6D/WksEUmwPHE=;
        fh=v2W3A2GV79HYFNQRa/reyKNtM6Wz8tlZ4vqMTNWnlN8=;
        b=TakC5eWX1D9XHyQJTOZEPie/PzMrNHxw/CAPNHJ3Vs7tH4PV4oKIuCjZo7laCWJvKZ
         kI9DgjJ62TtRidKVNCAia3rMfc37sN3ol7R0i11QHzQXCWNCGxj3Lrs7/Jp/b/HJwJJO
         PHczJOjWYElwm0u/GPJFUpDeIYVz4e8d3NPNSELooMR2qJ+v5gg8Zmq5GZ4LIZVviEAW
         9vOer2pAtFslCvoJPUOg24QYJJpQaIueuur9y5xcFnhMl7V5Er1nBTGvsIXP4sCanTME
         yAcF1KR0zwmQdmTHar3Ppb3VMCHFPBE/uttKBttsiF3KEJ1JoVShEHkrjci0QcO3n1wW
         P+gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770128146; x=1770732946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa4LzcX5Nno3EVyfWLJdwqz20m++Hc6D/WksEUmwPHE=;
        b=XRlZWb/dw55A6WoKDwrFwyHFSNHexs9Cn9HzjOwiv2TNsFyOru6OyJ6S5sId1gseyS
         tSO/tH8X3o0wR63B+HBEVMiwcBtWCc2Db85uGqOLDN/ZxMCpLnUmdZWiVt8ZU3m67J3C
         9eqyDw1B6BhtPHHINJDYrruPT/5vQj2Wjv8Dq7/2QO0AOLCmjhK6H7F4NEqirPMuSj+M
         5chec+vjiYtXEDxd8bSSocjafP8AyzbF4nZHeMtuVh+DUOiEWWL3S6eUtOObjROHBgf1
         LqYzkeiGfPyoWhXnPWFaeutUZ36573wUvm1z7mwY5uG9B8I4eukSUEsQaZtAVlHrms+5
         TkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770128146; x=1770732946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oa4LzcX5Nno3EVyfWLJdwqz20m++Hc6D/WksEUmwPHE=;
        b=I9LxNuEb4cpPvCTpPiAiB8r1bx9xTWcMpQP9dnZ5prbIC6cfWb4Dun1mkcaq+AnjUK
         Tf9BnTOQpaDbKboQvvTg6dSigzeGa2NYqQxzbb9RyIzil62S3OviB+nhavqMrrsdKZFX
         1EH5cEdppR7+nm9UOyRfABX0I+ez1pQKBL70nqguxczlxUWQabcAPwKFjlKWEBSYk6K2
         6Rpxc7vLfSsH3bC0JD1xf7hNY9SrlDXfkA6wZjC2rBTM6b0cLPHEjej7QVSuOBseAPYk
         mLoUhTuDw5LTQfF+w0Zfz7+SfN0lsJIjR5vImKMek7eUB2IYLPJfQM6Zr0qfCPQ0ckoT
         Yr1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxMhphRhA1epXmo+eUJIXNNVD4NXXVDaQMN/qF/ZpTshMALVCK14sIRajIplXEqD/Iohk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1wFHzxhr/mAW4GLdDYLvKbYS4urpNx8SPxKckpIY0NG0lqZtP
	izHDA3KhaRDpUhnxL9O/+B21cuCdlOgeE6d+WdroLiGryTHveyhAMtu1uR925ezCObUlFx79t5z
	meR7g98AJqCVB9Bgk3l8efaZr2PCrzao=
X-Gm-Gg: AZuq6aJzf8yX2wqHzpaKqpci9MgaZPqhzz3hrPiCCAEbOvfiVMmSr1+ulkDF1j9buT+
	RB3WLaZMf14mdv/ctU6jeG2mmw24C+P4i4llElqrPvucagaTkqv5Dcauv6J2jQrhjsQ0z3d8tL3
	D09ZPA5Hqf3oKJrmxTpCk1MizIFNPVzaJbeYZ56DCpezAdq4J2NkFOm87noAkCAD3jyrQLKvm+Y
	vsRi221gGL0tZWFsC9PpuBSxYUxU1kVJvTiKQLJRKKst8927o/w8+gzu0yjjkFLKx13nmcirA==
X-Received: by 2002:a05:6402:35cd:b0:650:31ef:177b with SMTP id
 4fb4d7f45d1cf-658de5bb620mr8671779a12.34.1770128146104; Tue, 03 Feb 2026
 06:15:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
 <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com> <CA+J6zkSo1LuFUdTU8m6z4vANrJ2r88EV6RDDC_0ZW3bWec2v2Q@mail.gmail.com>
 <CAP8UFD15Fkx0t4DYcWjK+WgeZBOzfYNyOePQXGU46Fyf4+pFgA@mail.gmail.com>
In-Reply-To: <CAP8UFD15Fkx0t4DYcWjK+WgeZBOzfYNyOePQXGU46Fyf4+pFgA@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Tue, 3 Feb 2026 19:45:21 +0530
X-Gm-Features: AZwV_QgaOe-Kq_Ytn1mOkJhfdmbMqt6Q1Z7wW43NyltV076n9HJ5DiLuK18-_vs
Message-ID: <CA+J6zkR0tvv1b7db+jQ_XW4ft3_p07bCJOm96B30VKx1abpF0w@mail.gmail.com>
Subject: Re: Git project and GSoC 2026
To: Christian Couder <christian.couder@gmail.com>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git <git@vger.kernel.org>, 
	karthik nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Meet Soni <meetsoni3017@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Bello Olamide <belkid98@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Feb 2026 at 16:03, Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Chandra,
>
> On Thu, Jan 22, 2026 at 3:43=E2=80=AFPM Chandra Pratap
> <chandrapratap3519@gmail.com> wrote:
> > On Thu, 22 Jan 2026, 10:38 Kaartic Sivaraam, <kaartic.sivaraam@gmail.co=
m> wrote:
>
> > > I would be glad to help as an org-Admin this year too. I could act as=
 a fallback mentor in case any mentor / co-mentor becomes unavailable durin=
g a particular period of the program.
> > >
> > > I also Cc-ed Chandra Pratap as they expressed interest to be a co-men=
tor before.
> >
> > I'd be glad to help as a co-mentor. I think I'd be able to best help
> > with project ideas related to reftable or testing, seeing how I worked
> > on reftable tests in my GSoC project, but please let me know if I can
> > help with anything else as well!
>
> Thanks for volunteering!
>
> We don't have project ideas related to reftable or testing in our idea
> list, but we could add some. If you have preferences among the
> projects listed there, let us know though.

Among the present ideas, I think I will be best able to help with "Complete
and extend the remote-object-info command for git cat-file". I could help
with the other projects as well but I think my co-mentor(s) would have to
pick up too much slack in that case.

P.S: I did not receive the "mentorship invite" that you talked of earlier.

Thanks,
Chandra.
