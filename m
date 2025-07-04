Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969FF1FC3
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751597363; cv=none; b=KjwBZlo4mmyZshCc6evzuSUc31Zz1jtuzHrhUdKikWMctMFNs0eWMRhbEwAwU/C9X60jRzsJWXnOFnJEr/r6YV1zO2GcroYu7WEGqTW31Ba9MLTNCIhf5RmiFPbHg0Wj7dQhuib1qaC1A01YwWPMCJ4ULdrzCIWPGJEzD8GjGVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751597363; c=relaxed/simple;
	bh=ry8QzQ+slRErj5SWOhw16YUuWrRbbzXkAzUfd88V2lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AkJhlPbt4Mn2OhMjp8smsUBIcR17ee1yPstJG+vcJJolRtXHQ0dYOrHXApoP1hiMSxJmbw9GaALJ/bFJAqgftqVadwUZ5wHz9USxm742Nz/uCu01/4OWF8xtk+h0BdWmwPYrH/Fsv2AlCfnEKmCABkZxLEyvl+K5du2e10i4DKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FKTjxfF9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FKTjxfF9"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b3220c39cffso479031a12.0
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 19:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751597360; x=1752202160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vrh+9maVKt8vYR4QpPjZyjBL+unbqdGoSg/ZSYeW4fw=;
        b=FKTjxfF9eLy0D3+c9lnoBvc19xNRWaobTidwO7oyegcilBo62pCDt1iH+KehEBe9u/
         rFN0Xc/xhFBvawStSFDD9xyOzpNGA1KOMuIa5mOmLCDOg3UIZqKc1xLn/h8MP/Yekfqo
         47g/BiFkMlGqwzTctW46lIBS5hw9N4A9I5S10vvyQKH34U1QxZnK34aCg3NeOVS4xzLv
         IvVYYMznndcL1Ew55T8fcOmmPxZP/paerfvOX4V6PPgY3Ktilu76qHi016U3v/gtNtVz
         D+9e6gKvjw3QAs/M7T46f7CYGfJT+Un6YZFWxlrlxL4Iu1zGmpgyxI/d1sBzEiDM+353
         zh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751597360; x=1752202160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vrh+9maVKt8vYR4QpPjZyjBL+unbqdGoSg/ZSYeW4fw=;
        b=Qkebkt+6PEj/Vd8pOxDfi5AJPtT0gHHd7svPjNEYZxkWwF68hgxxOlyPP3MubaUizP
         04ij3R3TFgmSxhM5zfE/UnZAjEwU8Nkk6uy2+htLG6RSpMMDLkKujRUUtSBCwBdqYYxA
         LKb1SowlUttxZRvzEw2rV6MCn2OON1LcHuVjcpgNrl1iYt3bbZdzBUKrrnKo1PfVScyn
         iHRAhJVk8K39iKXF0OOVUT1HsUgPZ+ZzwiRMhDFZg1A0NB2Wsi4sAuZYuYzlKKOxZ5Q+
         Z8VLiNYvh2dRjpS56J/vGVrS5TUn4l8eSxLW6myClP25EyTMD0RYYezr5SPEc+jWcpv3
         EkwQ==
X-Gm-Message-State: AOJu0Yy4pVjgT9p5iNTNbTzJ59VJyV5QhOkW2S06Y3h/XZV04niUyqgi
	27135I2lGb6dGMqLcIron64WoynKZo2xAa9IZe+kb/LDd4RH4G1aPVd+QSLX8z4MqwTCsLcLxh4
	Ebu5w+9ULH8TVR87X6IfHWt1e0L/GbGCCvz4PcYW5StKvd1SUHe9twpk=
X-Gm-Gg: ASbGnctEKQu9uHQD4+5B/N/M/WJEl7HKlON5sHDzjrbq4Dvkm3cRZ4NDimy0FdeltoR
	dHTwYo/qn3c0p9CLQB9zR2M/o9n1AV7wL8J4EvkE0Sbk0ik+Pw3h09gACM1fZmS/X0lmWIEeoRi
	cqFi6sVrN3CqcXmGfcUsLxBhJB1C+WLHiO1ti+SQ45bOWnXQ==
X-Google-Smtp-Source: AGHT+IEjJ+NZ1mvzRJZi8isMu0+fFplEr8qPnVMYjqbAkrZDpzfUDj79TMHgQqxQOZs/WiCZAgKV+/9E1MoVILOZKDw=
X-Received: by 2002:a17:90b:5289:b0:313:f9f6:309f with SMTP id
 98e67ed59e1d1-31aaddc3354mr486085a91.34.1751597359747; Thu, 03 Jul 2025
 19:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <boris.20250703161436@codesynthesis.com>
In-Reply-To: <boris.20250703161436@codesynthesis.com>
From: Han Young <hanyang.tony@bytedance.com>
Date: Fri, 4 Jul 2025 10:49:08 +0800
X-Gm-Features: Ac12FXxtScCVcWJyn8uwDI6wk97N-L4IMHWIOHMTF0suioUyZgPlaUJgHpwc0Jk
Message-ID: <CAG1j3zEiD341X-_ZdR2puaEmZZ0ZBWSmyboyyGZaDXcDTcmAeA@mail.gmail.com>
Subject: Re: [External] Document ability to disable template directory in git-init
To: boris@codesynthesis.com
Cc: git@vger.kernel.org, karen@codesynthesis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 10:51=E2=80=AFPM Boris Kolpackov <boris@codesynthesi=
s.com> wrote:
> Looking at the code, this undocumented (AFAICS) behavior appears to
> be there at least from git 2.1:

Digging through the changelog, I think the feature is added in v1.5.6.4:

 "git init --template=3D" with blank "template" parameter linked files
 under root directories to .git, which was a total nonsense.  Instead, it
 means "I do not want to use anything from the template directory".

> I would like to suggest that we document this behavior so that it can
> be relied upon. The motivation for omitting the default template are
> repositories created by tools, such as package managers, for the sole
> purpose of fetching some information from remotes. In this case all
> the stuff copied from the template (such as hooks) is an unnecessary
> waste of time and space.
I've seen some package managers pass "--template=3D" to git-clone, I'd
say this is a widely used undocumented feature :P
Document the behavior would help people understand the existing
usages of --template=3D

Thanks.
