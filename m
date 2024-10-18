Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AC6188CB1
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268169; cv=none; b=Qh1pWJFZ5dHOsh/lLd+p9Ushf+WMo6Qi5ewKhn/PmLnOO7xfYSUR+LXbDiAMM06OITaRXRQW8nbmSTXA2feKILnvUa5xA2kjd2DOZioMu5PIN2LTleG/5CpwUDUzwUFfiuKlDKuCs7kY2uX24W2DJAhu7WMJoAogGk1NVuu/xJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268169; c=relaxed/simple;
	bh=KKeIPZ2MFKA9UTrsHDegO1sYLhjXsxo5MRWXsajK53g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0JORQxTf4E4GFACdqUFipDbfN2dtNwsi8YdjI8DGRVppfolcMNqo/EL09EHsCt0VzvvBJI8Il2hYT35Y3cStt2H1BW7fIErwgWGEI0oSPFapENpzHi+vluD9Y5WfUeizGPdhGNEKUKbVrL9Uy1Q3JvuEHUaCOiFa6Ub/W8Xi5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SC6IfYyf; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC6IfYyf"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e602994635so549633b6e.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 09:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729268167; x=1729872967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKeIPZ2MFKA9UTrsHDegO1sYLhjXsxo5MRWXsajK53g=;
        b=SC6IfYyfj9Cs4x5RQShReK9h6Oz/JTxnnObj41HoTZJl9Ek+PUD7JNwjEGd7XZWAx8
         zFIVrLtPvkqL9jt7k1bzeZWxx0WYGN2J0wERD1hH9IPLJcXR4+wDQbbDiMUkcXmNnnMk
         WkITLD1rHyiZvmGJarbCM8TbsIZTug5WWxaKfllIrcrG1+eMYMNYbQIHXGolvLVnyVcL
         9FudtcROUYEbv3a1IMj9a4fNVtX0gPdSyJHgI0dWf3F1oOIXIWuvX+wq895wkHx9uoMr
         0x3EM/21O09C9bCco759G3Ai/apix7pNUFOWT/c+zVmwTJxJOY98WEQ/oA6m9g3okCfe
         sg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729268167; x=1729872967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKeIPZ2MFKA9UTrsHDegO1sYLhjXsxo5MRWXsajK53g=;
        b=I06k2Igj4nOCfFbTnLyc/2m9tsqnGc/m1LqX8T494Dmr3oQKYk5aFViwZ6hvEx6MQ/
         oUB2G87gXf0TD4/Z2w0kUcu0GujmRTHt8VjnuoHd+3F9CNoyD4R5gQDDk/YHr2rJ/7V4
         IbRtA6Ad6KK5hOFQpfq2XkF/rLx3W7C/Lqtse97tXDi17A5b+SVM6+O/3Mq5VqE0N3f3
         dgN//GKzoRx005OHjEv9INl8la6tq93XNLx54H30sAcPZpx9EJFsjabz8itcPvVl7JHX
         i8DMl+vVEVjIWPABGjmEQy81bYbmoU1m+nim7YXgTn798eewaSA7b5pMTIYcKcyYIOcI
         JZLg==
X-Gm-Message-State: AOJu0YydpZ2MDOssizCgWiAftXnBO6Cwy9r/e2o3TmA65lXFTqVfS1XE
	6cZNR9DdTFonO/LcC2WGtCndXhAflaS7EzkrpF0p1spT/eo86Uo5OhQa/+6+HUWOJ0KBcn8FCFF
	APRcKrn0MYuscqzHnBzrN9Td71TihfjjC
X-Google-Smtp-Source: AGHT+IEbADcvCYmucxVGydpXmr3wKUhllJWTjWbN+dZ+/CbbchTLmf5FoNaMwmw+ddGOmddFTo8/T7o8zsd+9RaCDho=
X-Received: by 2002:a05:6808:15a6:b0:3e0:4558:612f with SMTP id
 5614622812f47-3e602da2a25mr3490074b6e.36.1729268166809; Fri, 18 Oct 2024
 09:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <705912536.3510460.1729265181938.ref@mail.yahoo.com> <705912536.3510460.1729265181938@mail.yahoo.com>
In-Reply-To: <705912536.3510460.1729265181938@mail.yahoo.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 18 Oct 2024 16:15:54 +0000
Message-ID: <CAPSxiM9cSQnrcKPdkJwGdMT+B-YSWr8deX1=uXsYa4xk1mHexA@mail.gmail.com>
Subject: Re: Oureachy: Microproject (Modernizing a Test Script in Clar Framework)
To: shamimkhanum@yahoo.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024, 9:16 PM shamimkhanum@yahoo.com
<shamimkhanum@yahoo.com> wrote:
>
> Dear Git Community,
>
> I hope this message finds you well. My name is Shamim Khanum, and I am a =
C programmer with a keen interest in open-source development and version co=
ntrol systems.
> I am writing to express my interest in working on a microproject related =
to Git, specifically focusing on improving the Modernizing a Test Script in=
 Clar Framework. My proposed approach involves a thorough review of the exi=
sting test scripts to understand their structure and add a small enhancemen=
t. My background is as an MPhil computer science student at the University =
of Punjab. I am currently in the Outreachy contribution phase for choosing =
this project. I am passionate about contributing to open-source projects, a=
nd I believe that my skills and enthusiasm would make me a valuable additio=
n to the Git community.
> Thank you for considering my proposal. I look forward to your feedback an=
d hope to engage with the community to make a positive impact.
>
> Best regards,
> Shamim Khanum
> shamimkhanum@yahoo.com

Hi Shamim,

Nice having you here, I am Usman, an Outreachy contributor like you.

Below is the extract of the statement from one of the mentors Patrick
which can get you started.

=3D=3D=3D=3D=3D
I would strongly recommend reading through [1] and [2]. They should give
you some ideas for how the Outreachy application process is designed to
work in the Git project and lays out the expectation of us mentors.

Patrick

[1]: https://git.github.io/Mentoring-Program-Guide/
[2]: https://git.github.io/General-Microproject-Information/
=3D=3D=3D=3D=3D

While going through all this, you should get additional guidance from
the mentors also.

Thank you.
Usman Akinyemi.


>
