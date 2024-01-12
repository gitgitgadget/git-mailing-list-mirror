Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895C415E94
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP5dcEH9"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e6a94affdso976445e9.3
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 11:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705088075; x=1705692875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyUYTYHNnQ63Cepeds1op3QHfYoQ1BCuN2ef0e3WafE=;
        b=iP5dcEH9wkuPaeDRQkI8VbWortr4XraDB6Q1THziedfrrIlQd+mwe1DYR3WfPn4UvM
         r0AMoi6vKzOA5l91NXyJ6PUWaRqf1ehm9VBHUVwMBCzxqa0i78noznfD53xXbD3EuyCy
         7pI+hguYcdd7YpLDE9i3cgPXFKY/XDlWl6cFZOrc/xeB+9F58b9niVSaKzVDuYJPbX7I
         lAxKIdF7YD6rW/TOoNiZ+ykfW5hUO5CwECE7tjVu7etEZ1757/Q/+iA0k1lZ2fjqAEf1
         Ez6X3We07KeHJaxb+mwRhuXYcCCyFU2RtyF0l8C852Ch3Xza+DI4jW/OyBMBq29I3psq
         VDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705088076; x=1705692876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyUYTYHNnQ63Cepeds1op3QHfYoQ1BCuN2ef0e3WafE=;
        b=F0o3mFX9akv4kHSHe0Y6vN9FBEO7s9FyPVoLTjUopUnj3sKtGX/RY1F/633OpuDPCE
         mxxDCWjaHAYe0UuH8ipkn9wmS4TZUusDRHTV2TR/ldhHU4dgpYweg4RuJfWvYqlcZ5WG
         llM184v2MOB6lmrVMxZTO5nS92Z0mVR9BhAIX/QFYAuo4rcJJ4QXN8mXYAeb54UkePmx
         msQcWze4Ehk0UHlHsdt+UZXyeRrSP4pKlyIZh7KlqrTzE7uIMqSW5FJoQpvPl2mDjfZh
         7PrZwgWK9L6vEdo9NqA/F/+3UpidRmNzgjn7OvZWws17d4Fi2XRMrFP5/zbfJBNrauLh
         saIA==
X-Gm-Message-State: AOJu0YwzOPL89pIBmsDl/tTz5owVfUxrPMO6kcSJSf4CtVCzLKk+Ajd+
	suDDF7uOUcZy7s8UBSHd5Dk=
X-Google-Smtp-Source: AGHT+IEnJ1p91WpgdSMvtzkjztJFYP+degxUoiCkbLLJnvHPlaJcgtyuYvYQsZm34emLuI7LIJviZQ==
X-Received: by 2002:a05:600c:3641:b0:40e:664e:b012 with SMTP id y1-20020a05600c364100b0040e664eb012mr657733wmq.117.1705088075462;
        Fri, 12 Jan 2024 11:34:35 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd4-c452-0-4d85-f76e-9351-ffeb.ipv6dyn.netcologne.de. [2001:4dd4:c452:0:4d85:f76e:9351:ffeb])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c314500b0040e5e21cd7bsm6678490wmo.11.2024.01.12.11.34.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jan 2024 11:34:34 -0800 (PST)
Sender: Michael L <mial.lohmann@gmail.com>
From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	mi.al.lohmann@gmail.com,
	peff@peff.net,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	wanja.hentze@bevuta.com
Subject: Re: [PATCH v3] builtin/revert.c: refactor using an enum for cmd-action
Date: Fri, 12 Jan 2024 20:33:59 +0100
Message-Id: <20240112193359.2332-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <xmqqil3ybets.fsf@gitster.g>
References: <xmqqil3ybets.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 12. Jan 2024, at 19:13, Junio C Hamano <gitster@pobox.com> wrote:
> > But your way of seeing it also makes sense to me. I think I just find
> > the "START" name jarring because we do not use that word elsewhere to
> > describe the action.
> 
> Thanks.  I forgot to say that I share the same feeling, both about
> "NONE could mean no-op" (but then seriously why would anybody sane
> want that?) and "START is not how we spell these things".  I can see
> how DEFAULT could make sense, but if somebody picked DEFAULT between
> two sensible choices NONE and DEFAULT here, especially if they claim
> that they started this enum to mimick what is done in another place,
> and after they were told that the other place they are imitating
> follows the convention of using NONE for "nothing specified, so use
> default", I would have to say that they are trying to be different
> for the sake of being different, which is not a good sign.  I'd want
> our contributors to be original where being original matters more.

I am sorry to have left this feeling in you. It was not my intention to
be original, but I just did not understand the reason for the other
name. If I wanted to be "sneaky" and wasn't truly open for a discussion
I would not have mentioned that it is different in the other file. I
don't try to be original for the sake of it, but yes indeed if I have a
hard time understanding some reasoning, in my day job it is my role to
ask these. But I think I am indeed questioning a bit too much here.
Sorry for that! You as the project lead constantly have to do the same
and I am in awe as how you handle it.

I am sorry that this discussion did get out of hand. Especially since
this patch does not even introduce a feature, but is only a refactoring
of an already perfectly fine codebase. My only intention was to align
builtin/refactor.c a bit more to builtin/rebase.c but the current state
is 100% good as is, so I think we should just drop this discussion.

> > + if (cmd != ACTION_START)
> > 
> > Likewise here I'd probably leave this as "if (cmd)".
> 
> I 100% agree with the suggestion to explicitly define something to
> be 0 when we are going to use it for its Boolean value.  So an
> alternative would be to treat all ACTION_* enum values the same, and
> not define the first one explicitly to 0.  
> 
> Especially in the context of a patch that wants to turn if/elseif
> cascades to switch, I would suspect that the latter, as switch/case
> does not special case the falsehood among other possible values of
> integer type, might be easier to maintain in the longer term.

That is indeed what v4 of the patch did that I prepared half a day ago
and just did not have the time to properly check again before I submit
it. It also tackles the other issues you mentioned, but my feeling is
that the current state is good as it is with the characters and so we
should just drop this discussion.

Sorry to have caused such a stir and that I took so much of all of your
valuable time! I for myself have learned a great deal from all of you
and your interactions, so thank you!

Michael Lohmann
