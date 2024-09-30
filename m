Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71327126C07
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686249; cv=none; b=pSRVSmWnV/T0+C2ep57K1Ds1jyBFK/wpOWUnPWgKNGLnm4WD0ZGvajT/01Da1mEYmkL5v5e9rP19GvDn7qiqXinlbF1uyPcDqq8N4xdc7YimQrZJh3m3RfgJRV9lOr+ZaIdwUCaxK1DlfwSgdgyGAzcZRhfyRfJZ6nlYkCKdhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686249; c=relaxed/simple;
	bh=1iQwy/K4PLwDdq00bkrgZXJGjomIqejSpa5ptPP5PT4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L4ucveyEPgMZ/oyCmcDBZhFniqziAw1Jja7476QjYwyAJQvnhl/3568WE/tue/5yM+EmUnX4j/nYo3QZ9RrFXTQnjgz8F5VBGjwuvzialOFwMJiZeLw2DmHyhY7DOHjIJ0gE2TEqkqc4JJOc62Y+MNJI2UkMoiXrulWvY+vSqUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXTWoTuG; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXTWoTuG"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c883459b19so3326575a12.2
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 01:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727686245; x=1728291045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5KnGDpOE0bhdnq9jkykRbUOnFjEUmHYROGupLZoI3t0=;
        b=nXTWoTuG2yTl+8TiE1LJCu7IbUswIELNEHSealb4IdnQUM1oeeE0ms5MUOSF8Se2oK
         1RCbdWqedBS8JeDAU6XJAxSErWa9fV/JJnne4Y6ORC+tU1e77KTvrcetdKKGocFOHdYH
         tZFoSwAIyo7xiinjWjcig7gxM4w08RoKkkUFTbPnAnrEnl1OOspGUSO4bWf3y+cnBdXz
         rQRrof4eA5NgqiJSOQIffVpQmGLT95TgBDnvxOzO7L9p1SysIkBdEq9wlWdSjuCB5Y8I
         R1jj+CjFIv3RXH5EMrWipvFRJyfYHqCDtcDHOX4B1FPF1DK2nrX42y9Q5Rz11xvYOhXc
         d5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727686245; x=1728291045;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KnGDpOE0bhdnq9jkykRbUOnFjEUmHYROGupLZoI3t0=;
        b=I3Mpv0qt0O2nJJFTV13aJDDIZPVH18F4Wx35wD1EML9IcL3//caqy7jyc0gaqmeUly
         OAOqPcCxRmclM8mn8nLdNu9lJ1m0SuZsCW7gXntwsEb81U5mJDAR4Ae1C+4qSsLW4Wzo
         DLmD4K8FJKW5j0TZVp+BvnHA03c+3DrfERrsfbudfyQeca7turx0adJFHJyDjx+ujDan
         SWxSHWlNXY1teFufaoIot6ERJOYYF9sB6wNOKgaOewZ8smrzGI/t+5VSMdqYq9GIW8a8
         d6ENFJq4C9m7r7aBP+UtOnXHKE8UuiNzR6NvErJ8S4fdQNcbCO7JJZoUrnlsFkqtlxQk
         IPGg==
X-Forwarded-Encrypted: i=1; AJvYcCVlMifkJ1Kj4KVaOR4fMRQMTb2MX1UEE7HOhgpFmwTruLkU6GOkmzJG5nVTZeS4dRCcCaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjALUdPLYWP8D+l2ljEAWAehwEu5VDfNGkdT1xc9fZw9/jUs32
	X1s0+PQ0XBw48ewyfw1NAFkcZf10+EigwHTKlzFvG300QRceynWd
X-Google-Smtp-Source: AGHT+IHjgFFdRVlc2Uvs37EFsj0TSGuutDN8U2wgB+oBVdgDaLc8p0SY2tOQsafWl4N5voO10ihKkg==
X-Received: by 2002:a17:907:3e21:b0:a8d:7b7d:8c39 with SMTP id a640c23a62f3a-a93c4ac9362mr1392402766b.43.1727686244401;
        Mon, 30 Sep 2024 01:50:44 -0700 (PDT)
Received: from [192.168.1.212] ([84.69.151.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c7130sm493647566b.67.2024.09.30.01.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 01:50:43 -0700 (PDT)
Message-ID: <a43fa510-9a96-4b92-8107-0c00209d5161@gmail.com>
Date: Mon, 30 Sep 2024 09:50:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: ./configure fails to link test program due to missing
 dependencies
To: Eli Schwartz <eschwartz@gentoo.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Henrik Holst <henrik.holst@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Jonathan Nieder <jrnieder@gmail.com>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im> <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im> <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
 <ZvOn_wChzEgXtpMd@pks.im> <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>
 <xmqqv7yil70d.fsf@gitster.g> <39508a38-d98f-3883-3887-971385a3805a@gmx.de>
 <d3900cc3-8a0a-4da1-829b-5bcdd7ebca28@gentoo.org>
Content-Language: en-US
In-Reply-To: <d3900cc3-8a0a-4da1-829b-5bcdd7ebca28@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/09/2024 19:10, Eli Schwartz wrote:
> On 9/29/24 1:56 PM, Johannes Schindelin wrote:
>> Meson came up as an alternative, so the obvious question is whether it
>> could be used conveniently from within Visual Studio. It takes but one
>> look at https://mesonbuild.com/Using-with-Visual-Studio.html to see that
>> no, the instructions ask the developed to use a command-line interface,
>> which is the opposite of integrating well with an IDE.
>>
>> In short: If we're serious that we want to stop treating Windows-based
>> developers as if they were unwanted here, we'll need to stick to CMake.
> 
> Hi,
> 
> I guess you didn't read the previous comments in this thread? Maybe you
> should take more than one look. :)

We cannot expect everyone who wants to build git using meson in Visual 
Studio to read this thread and find the message that mentions installing 
a plugin. It is much more likely that they, like Johannes, will find the 
documentation on the meson website and conclude they need to run some 
commands on the commandline. That's a problem with the documentation, 
not the person reading it. Even if they do find the plugin [1] it is not 
clear that it helps - no where does it say "this enables you to build 
software with meson", instead it talks about syntax highlighting, code 
snippets and linting for meson files.

Best Wishes

Phillip

[1] 
https://marketplace.visualstudio.com/items?itemName=mesonbuild.mesonbuild

