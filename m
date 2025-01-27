Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0C11FF7CC
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737985154; cv=none; b=ajtbJyrM9k3zNE/V3vSEGbLnHWtAxxJDfQI6mfPwqBBAmOtu70dMhuqMMtoIRt7rr8YLaOFikhFe6IUaKVMvXe0ssn4c6dDcEAEOf7M8zHd/niMlGiB0Jl+fL6oMvCXEoDXJF1pTumxYATWIg9vmuUPld7KVectmilkjUZ+jSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737985154; c=relaxed/simple;
	bh=uz2HCbon0euqCgznK1qwdmPwGqfO+fcdESpcrvcK63Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pW2AuqMI8Q126dacdOuc9jS3TlJdunaOj/vtqwqRTtrJb18L3o9qzztA4bY4yO6rjG58Kay+VKsJhC1247uh6cAkAYruyOzxYa9YWKhH6xQ1eXz31XRCqSebi4JwilEYb22gqdWfRAun2pd7lUt2/lx0RJ3gn8ekWSQ4X8yGHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9X6q3sJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9X6q3sJ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso6273792a12.3
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 05:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737985150; x=1738589950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECYbizMMjsEi7E6dS3uGngB5mp/rWwAd0uOcxNAVrNU=;
        b=A9X6q3sJnqEq0f5cbmSflf8waXGndK3ddCUmbFWpo1X+b7hf/0A7TKCX2h3t/WdqPz
         rGQYBXIuD9VmnafUF+IE8bpYeZo3dERiAGXS0/zTd6/SxKqS/K5TVKE8TIlY5Dx+JcHS
         W6Iw4xY+8jQv3JkjHJWeW694xGmtGECANa5fmnBX+P/m9N25tVqVyp179qi7BZXIsBE4
         CCsDpeuVg5er+WX6Hh/fqTe+GxOnqY2Xi0TdElaQF1fwoTkYfnoxd97/osX1T/4ouC5m
         aFLsg3Tqs7imUZ4p6oButw3imOFkok6fjqwGgTXCz1Wl1atVUEZ8mfgUALrHBlVsPAY0
         Obkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737985150; x=1738589950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECYbizMMjsEi7E6dS3uGngB5mp/rWwAd0uOcxNAVrNU=;
        b=V4RZ0nXiJe9Fp+ND3xCta0TvqqGfdclrqVioxl3q3zMTW+zd/HxrVNCl4FoLLbhXUX
         hQVyQ4Oc4gKsrzMo3rQcibhAPeGT+caxTwtobf9cqsSo2Y4LJUHmsU8N2YBueRIpX0lN
         wGxdYMvJD02UQruXEf6Qln161C9LEE0EhLVI6DkVQ6BH+RKiJjIvW01UU1yRMY9Hx8SO
         QBHSuR5ULhxnBZP1lVXGNmU3VrewQv4QyJ438gCxaHJEuQEuyej9wZQNLH02XWrs+5DD
         yda3l/Ls4O0ZvqG0hi+x1/SoI62/5374JhksnZui1vDzeSjjOXn4GjCkTJOBpeRLUEow
         F4Xg==
X-Forwarded-Encrypted: i=1; AJvYcCV4DZd5/PURagSNguiSBcRn0N5L5TNGrL8vhsX5xZz67nAqcuv0fiti94Rwdnd2WrWdt2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHTGHpuc+G9UH187Tmbi/aVzFGBZK5NN0Yv4/gMGR5JPuVd0Le
	ryBgmE4eGsDwhKy2CUHA51zdyiFWt/osr6gFRZRi6bxvkEF4E/JP4xeuTYy6FNzTsyrsJ9trclf
	nKvOvsBcB62EnyZVRrsnlQbs5Sd0=
X-Gm-Gg: ASbGncv8XEB8kdCrbhXNsCjuCYHuzjeyGAkNDcSCzmVid7D7adHeYVrBieraZFP9+HC
	s3Iemy/i7kdbQXnFgFmfwPKOB88dJxUdvE2LtGY499I+LyBMCa0t+zcZkfsOCX92w
X-Google-Smtp-Source: AGHT+IHIXkXxBCMN65uRUby28YOtLrMt1Lux7UJqRmm7rayff77HHoyjffZONCGPRcD0b90jo6myMY7r28Xq1fvV69s=
X-Received: by 2002:a05:6402:5106:b0:5d4:4143:c06c with SMTP id
 4fb4d7f45d1cf-5db7db086c2mr35712195a12.23.1737985150191; Mon, 27 Jan 2025
 05:39:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
 <20250124122217.250925-1-usmanakinyemi202@gmail.com> <xmqqed0sxdiz.fsf@gitster.g>
In-Reply-To: <xmqqed0sxdiz.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 27 Jan 2025 14:38:58 +0100
X-Gm-Features: AWEUYZmB8jaD2nuMDhjF2mOfk5OCk_lxHF5zhuYClrHwHQs9uF1tq9-CBEVCS_Y
Message-ID: <CAP8UFD31A9KuqzXrDWzjokWzBtTYsF1FGJPX8PFAWXnn_2BH_w@mail.gmail.com>
Subject: Re: [PATCH v3 0/6][Outreachy] Introduce os-version Capability with
 Configurable Options
To: Junio C Hamano <gitster@pobox.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, rsbecker@nexbridge.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 7:39=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> The only remaining issue from my point of view is if we really want
> this as a separate and new knob with capability, or if we would be
> better off to carry this kind of extra piece of information by
> enhancing existing "agent" capability.  Given what Web Browsers do
> in their UA strings, it does feel cumbersome for analitics tools to
> pay attention to two separate input sources (os-version and agent).
>
> Has somebody brought up any downsides of cramming the OS information
> to the existing agent thing?  I have not thought of any possible
> downsides since I made this suggestion in a previous review of this
> topic, but I may be missing something obvious, so...

My opinion is that it isn't a good idea to enhance the existing
"agent" capability. Yeah, it goes in the same direction as what web
browsers have been doing with the User-Agent header, but I think web
browsers are an especially bad example that we should strive not to
follow.

According to Wikipedia
(https://en.wikipedia.org/wiki/User-Agent_header) the format for the
User-Agent header is now "Mozilla/[version] ([system and browser
information]) [platform] ([platform details]) [extensions]", for
example "Mozilla/5.0 (iPad; U; CPU OS 3_2_1 like Mac OS X; en-us)
AppleWebKit/531.21.10 (KHTML, like Gecko) Mobile/7B405". This is
obviously very difficult to parse for everyone including analytics
tools and is not very flexible either. It serves as a way to pass
information about available features, but leak some privacy
information in the process. The fact that it's used to pass
information about available features has led to a lot of user agent
spoofing which means that analytics, statistics and debugging are
likely harder than they need to be.

When Git developed capabilities and the "agent" capability, the doc
took care of saying things that it "MUST NOT be used to
programmatically assume the presence or absence of particular
features". This was done to go in the direction of not passing more
information through this "agent" capability but instead use separate
ones. So I think we should just avoid putting other things in the
"agent"  capability to avoid what happened to the User-Agent header in
browsers and to stay true to our original intent to have a different
capability for each advertised information or feature.
