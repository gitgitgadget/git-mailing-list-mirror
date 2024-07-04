Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E78C2E62F
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 05:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720070536; cv=none; b=uhE9+5jQInMqZeCPyWOCt11i4tnYqDOmgcWMP48xm5p+jp9dwPPe+glUz8h1CDYNScEXSirtEKZ6shCenaq2Du1ZT/tMd0yWZwvehCfKRZAbSIsZu+ifmbLCHjIn2z16rar0P3zEsQ6msNOrzKwMJ/UD5vRmhlOVvsMrAPMxWnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720070536; c=relaxed/simple;
	bh=24ugwcJAxA8SAf5+QY4tRhUwhnxZ0OV7fTUKC5EQXKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tTYAsFk65ikxnlFDyxaT0UBxd4lRqi+CcEkiePacid6qBjkopIkTI1mvSZG29YRzhXsiudCYgkNUhrnLMMfmdfAUrjXMABghYJ/aYNJXx4o0GR2Zs126kyVekHBOmyBH83wv/4lTS8CdOkCO7FKnXPy25kOi2ABasLhlXScdbYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6WRT4ZW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6WRT4ZW"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fab03d2eecso1475275ad.0
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 22:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720070534; x=1720675334; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Usq9Ee0OaZCJO3rK3FQ4sFQvEM7FXYCXyMqERsDTUQI=;
        b=m6WRT4ZW9wL9kInCGWY8pyDMIvw+NlQATZEus6pymOq2XlLDJfbIN5BZlsOBRTh2Oc
         YyVTELejFOBXRrpzfDVBSY8kikpGoCdiSHvN4mKe0CjI6+wMDqfdeV77cHPFdo+hoBNk
         OTJ2kO18zSP+Sfsmbw30872vP68SloEAbldQFP/9yBVuAWBVv3mKZhUbVV8HetTt14Ym
         BV5SjXxpq7eXq1HJi/B+LUopoRQOuRgAZQytYA7U2fslAEsL+RzOa4G2fK2ZvxHIDrVF
         JIaXZcmCba8u0+Vsisf883eN66xJ6AuSUfgAOydydxnXFHx4iEYpByf9xYIhkhVuMAdS
         XBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720070534; x=1720675334;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Usq9Ee0OaZCJO3rK3FQ4sFQvEM7FXYCXyMqERsDTUQI=;
        b=JwB3Syl0N6SzDiYYEeYzJvw5yc9TXU95yKpvl7IdtHoZoh62Sozr6xIrXETz+qy04e
         TImGZ8JFd/O2gVRVovxnNOW2AvB7HQmuil+il11xnly4poFu2rjE4bj46W6y1vZ/ev8b
         5n4ZVL47Sz7vBH/D251xRWe/4vHjiJHJZ5t4ram0OWC33WcGARNEF2Fj+Sh4WFmGi6h6
         MKCxaEg7rlhllYSg3p+m8PsIjGrSlyplBRvli4TAuhOZAVvVh1i3eRNfvhsXXYkCYNjU
         fOC97e4luG086xR+3l4sM+D+kx3bPYzx6/u3LggF9KFRbkskdLBOOQyjNGKvn6/vKoyn
         ai7Q==
X-Gm-Message-State: AOJu0YzEOVEP8UL2l99+wwLLTpAf3zYoNEqnjN2c97zVdaoWFhrGARnI
	7lFK2GgREdwoKmKqP2Bm0XiA5Wkopwof7dHmP1wUQHxsUG2UdtJw
X-Google-Smtp-Source: AGHT+IHZwEP5acuFDFEYu5dr8L8yOTAxGpg3gQVB/Z81vzaeCJK+KmYg8YcmpFFXsetZaNceFevfSg==
X-Received: by 2002:a17:902:d481:b0:1fa:2e45:bcbe with SMTP id d9443c01a7336-1fb33e971femr6715215ad.31.1720070534156;
        Wed, 03 Jul 2024 22:22:14 -0700 (PDT)
Received: from localhost (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15389b3sm112894085ad.121.2024.07.03.22.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 22:22:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Eric Sunshine <sunshine@sunshineco.com>,
  Derrick Stolee <stolee@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] gitfaq: give advice on using eol attribute in
 gitattributes
In-Reply-To: <20240704003818.750223-3-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 4 Jul 2024 00:38:16 +0000")
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
	<20240704003818.750223-3-sandals@crustytoothpaste.net>
Date: Wed, 03 Jul 2024 22:22:13 -0700
Message-ID: <xmqqcynt91fe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> In the FAQ, we tell people how to use the text attribute, but we fail to
> explain what to do with the eol attribute.  As we ourselves have
> noticed, most shell implementations do not care for carriage returns,
> and as such, people will practically always want them to use LF endings.
> Similar things can be said for batch files on Windows, except with CRLF
> endings.

Sounds good.

> Since these are common things to have in a repository, let's help users
> make a good decision by recommending that they use the gitattributes
> file to correctly check out the endings.
>
> In addition, let's correct the cross-reference to this question, which
> originally referred to "the following entry", even though a new entry
> has been inserted in between.  The cross-reference notation should
> prevent this from occurring and provide a link in formats, such as HTML,
> which support that.

Thanks for being forward-looking and extra careful.

> +With text files, Git will generally ensure that LF endings are used in the
> +repository, and will honor `core.autocrlf` and `core.eol` to decide what options
> +to use when checking files out.  You can also override this by specifying a
> +particular line ending such as `eol=lf` or `eol=crlf` if those files must always

"this" being ... Not what gets stored in the object database but
what is done to the working tree.

What is being "overridden" is that the earlier two mentioned here
are configuration variables that apply to _all_ text files in
general, and the attribute mechanism is a way to give settings that
are more tailored for each path.  I think the reason I found the
above a bit hard to understand when I read it for the first time was
because it didn't "click" that this paragraph was about configuration
giving the general default and attributes overriding it.  Perhaps...

    ... are used in the repository.  The `core.autocrlf` and
    `core.eol` configuration variables specify what line-ending
    convention is followed when any text file is checked out.  You
    can also use the `eol` attribute (e.g., "eol=crlf") to override
    which files get what line-ending treatment.

or something?

> +have that ending in the working tree (e.g., for functionality reasons).

I'd strike "(e.g., for functionality reasons)" out, as the next
paragraph makes it sufficiently clear.

> +For example, generally shell files must have LF endings and batch files must
> +have CRLF endings, so the following might be appropriate in some projects:
>  +
>  ----
>  # By default, guess.
>  *	text=auto
>  # Mark all C files as text.
>  *.c	text
> +# Ensure all shell files have LF endings and all batch files have CRLF
> +# endings in the working tree and both have LF in the repo.
> +*.sh text eol=lf
> +*.bat text eol=crlf
>  # Mark all JPEG files as binary.
>  *.jpg	binary
>  ----
