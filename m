Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA3145324
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738333827; cv=none; b=Oa9yx+uD3NyX5SOeb0sv2xWWrl4h0evZAsyZNY37W4siSCrWPAQMrGjaWiS5kCpBMVwR6ZjufpqjR0buejxzlNhIn1tPTJ3N5D1qBhtsNownQn5U17ubRuqXh4WCTGtUSO1wLdSojSweGjCSh+egDOEwt/C1Q1jmRZPHF74NYBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738333827; c=relaxed/simple;
	bh=DrMitZzCUQSztnJbXLve15iQyDrKcF3D0BM4AL14xCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/LXJegv5vYxTKqoU9AUYRMTkNB4IZhpndsiOLJu8m6iV2olrDlv7f4RV2rTfCm/yyk5T7UaNcjSPoeS1i00Mr6SRDh7ytb4M7Ia5zhrN87BMVzr1+5t/SLDed9Pm1E39JMBzP7h9oKnGRu6TXAoaBbxraZ+xmKLT1r0QSyRrIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2dtwcMI; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2dtwcMI"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso3521340a12.1
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 06:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738333824; x=1738938624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8H1STAxSIbYP2kAzAF874I7n2vofx7D6H2CCbqqDp0s=;
        b=g2dtwcMIGVQhkxFba9xr0jFyBqdwziTG34nOV7Oi/s48L8icpanv918Vg2+d3pbG/X
         biY1yWu5ZhxXruUHGv5AeT8aTloqaj0mwRKDLqilo1Bw066T+ckKcGox9kDasdrRcYwm
         U1D6jQKZumacw1BbhfYAyMkIZQPdIImnrdJp70ueGWMpPRhujJlxLpmgYVX8OLuRvOV7
         teZjwFgi1ZJ3UnhePQGlRquB01mw1ExgNIsvTvlX5aVta2pXegHGR9KY3zpMOHxHbocF
         HVWGdVFPzeUEwyXAT6k+Zxp2ZjfihcN+a3u4CiqSHqSjwmxWIQjuiWYuhjlTvA0gXkAA
         FUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738333824; x=1738938624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8H1STAxSIbYP2kAzAF874I7n2vofx7D6H2CCbqqDp0s=;
        b=UGZACnOFXiTBM5oN3rJcA3VP9KRP9R+UNOh1smQObVrnfTjn3U/8c8k37VHX94bwjL
         KH5HvfS2RYD08HXgrI7GbHP6kGWh1qLd2APRHsdk5dx1tj162rgP2wVoa7srYpm9MvRV
         cMMM3wDa6AYJqpCkEWHIBrV0rz1sHktQmnsYvse2j+UzQHs0pqTHnC/rS1CGDSJTWh2D
         m5o2VCIVqbXR3zOCZQ1FcZw5NURCqxjP1GHJwbruBZ+7k8y3au6zKGwbUWdQb7RkJuDv
         6I6K5VpCL8Dxqz8WM3dfgwKbyT2y9BzsDx3IhmutMjzt9CiTtB2PFVEzGIJk7A8Iujq2
         O4jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkngMWAIOEOb0+NwSJFx7QnYZVBEA87GKulR5dfGGnc4z20AI+Q+U0AoOEWnuwYAz6lMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy51poF65tzgatjcVZyAj7PEJNPs6RbwotJ4UHBBvD2+lEKtHOm
	AwwSx0Ni2bMxWtr/vR30aadbV9eAzOBnEP4nJTbYjaOnwZZ7nv9QqnzjgdJBkPgZmreDI/CM4xl
	1ZjROyyWum0URHYhw1XVV17wn+48=
X-Gm-Gg: ASbGnctQvB5j1Ce1I2/UFwMKAKrYF/SqglZHOBSeJDhygIojmrjVDgF4Se75LWGXZ2C
	7fEt2YdXlbE0F5DptUb6HM4qanl6fOpNuy+FbdyPhjSJWMCgh2Wv6/+pr3O/bPQ3dTWY84/ZzeS
	0=
X-Google-Smtp-Source: AGHT+IGSL7UWTCRa37gYgiqBbHh8+c+oQJmV1CqeEumyU0smh4hXXQuXOsYU4DNzpBUpji9qwx8W7gqyP+UljFvyEy0=
X-Received: by 2002:a05:6402:3514:b0:5dc:f48:f01e with SMTP id
 4fb4d7f45d1cf-5dc5f01e783mr11690418a12.30.1738333822089; Fri, 31 Jan 2025
 06:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
 <20250124122217.250925-1-usmanakinyemi202@gmail.com> <xmqqed0sxdiz.fsf@gitster.g>
 <CAP8UFD31A9KuqzXrDWzjokWzBtTYsF1FGJPX8PFAWXnn_2BH_w@mail.gmail.com> <xmqq5xm0wa5l.fsf@gitster.g>
In-Reply-To: <xmqq5xm0wa5l.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 31 Jan 2025 15:30:09 +0100
X-Gm-Features: AWEUYZmEFaoYI-BFbECet5Wwi0MFzb1Rg-Up444Mwzve0vP8zdzvk8z_5R2Zfm4
Message-ID: <CAP8UFD1+Qa2cRkYs8R_Lgr8Bkz7YqPUW6Q3ogKcrBSp+q-3qbw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6][Outreachy] Introduce os-version Capability with
 Configurable Options
To: Junio C Hamano <gitster@pobox.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, rsbecker@nexbridge.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 4:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > information in the process. The fact that it's used to pass
> > information about available features has led to a lot of user agent
> > spoofing which means that analytics, statistics and debugging are
> > likely harder than they need to be.
>
> Yes, that is a valid viewpoint, but ...
>
> > When Git developed capabilities and the "agent" capability, the doc
> > took care of saying things that it "MUST NOT be used to
> > programmatically assume the presence or absence of particular
> > features".
>
> ... the proposed os-version thing has the same wording in its
> documentation, doesn't it?

Yeah, we repeat it to make sure that users read it. I am fine with
refactoring that wording if we think that having it once is enough.

> What is being added is not to be used
> in a way that requires parsing and trusting the result.

Why not? If server people want to do OS stats on their clients, for
example, why shouldn't they parse and trust the result?

> So unless your point is that users (like those who parse User-Agent
> string by browsers) will do the wrong thing and assume these strings
> are usable for feature detection anyway so we should make it easier
> to parse, I'd have to disagree.

We should make it easy to parse because people will use this field
(otherwise why are we adding it?), and we want to make it easy to use
rather than hard just because we are nice with our users.

I think we should not assume that they will do the wrong thing,
especially if our docs are clear about how it shouldn't be used.

>  If we are not aiming to make it
> easier to parse and assume certain things that we do not want them
> to, I do not see why we need to have the pieces of information in
> two separate capabilities.

I think it's just the right thing to make it easy to parse. Doing OS
stats on the server side doesn't need to be unnecessarily hard.

By the way, if we put the OS information in the "agent" capability,
how do we separate it from the existing "package/version" content and
make it easy to parse? I don't see a good solution because
GIT_USER_AGENT could be used, and the config option to not show the OS
name could be used too.

Also we don't know what could be in the "version" part. The doc says
that the agent part is typically of the form "package/version" but
doesn't require it.

Thanks.
