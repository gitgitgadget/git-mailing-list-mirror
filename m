Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB9C1D1510
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890059; cv=none; b=BBUoXlo3vhY5r53ABhTW485FBqm+xw1po0J+M5XtxrlzndodlWtINU0CCaB3slx8HOTpcT7aEnF0G3XoVilSRtOtu9t440sGz47whqsHuQMcds78CS+qbrzox0stqo7SnrfJMH2SuBvF9kFBXn0n4e31LmN++bkdbtR9K7Z/UJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890059; c=relaxed/simple;
	bh=lwdbm9ifmMhLX9Mo55Dd4AhdAbhNLiNNwXhVUwJhaf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkPkmh8UwVIk+qMEu43muiK8FzEFhk4C9x+mJDG7dnO5EbiX/XtW+Mi9WqqWVzcI8r9NzmDesGe6p254Zy3zltmHBbcSyRzIVuNUGq9tdIC+hFEK6J4oB5+7VDT/3WovIecj8ZRBc9rODAQAR8KHrSBmBCEJkETvXxYkd8nzRSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WA12qnZr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA12qnZr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so67612085e9.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 10:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727890056; x=1728494856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REao2NrJwGzJWW3p8CzMRICqCI/5PueryBuRMwUVL5Y=;
        b=WA12qnZrpgdPfIVdciP+rD4PaN0YQP7xifOZR8gR7E1gx4hE0nk2m9psMF2OBCJ1d2
         L4xMfhIx1IqYjNQMFd5z6bO1izO4BZXDP+hm1nGY3U0tIbSiup66hMYBewIUaAQuQEWJ
         3fgyYhWfRnoXmo5KmFF7KhC+NxG6slj6yc/4qgqXLGJNQg2G6z6/k3o9Iue2KErIBqu3
         9L8p45K33kPoHV1hhLRV9b6VMzZks+aZ+SUvCaZm06ZHPNLJ9BUAmDbK1ofmJLjPCu2u
         /WNmlQRvB8D4rgWkqu1e9nOWorifiuZBGUrnHoZNN6ttV7MJUcvbhwBgvrJaNjLiGdvj
         PbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727890056; x=1728494856;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REao2NrJwGzJWW3p8CzMRICqCI/5PueryBuRMwUVL5Y=;
        b=vrClJ7g25OmZ+zdw8wpQyDOKwkGGgoslJFpF07uD2BZ0WDAhd/bFUyJOGGcU7cS0c3
         uvzIf+KF/78o5FMwluH7zIhJtMvgukrREoKZQa7OAurJPMjcPxgOjouZ8rAPCDhwUdM8
         QAvg/5gFcNgu/qih3dO872+CC7z3HFrjp6Fttubi9XFDCT1rRBBTgrOnAIRXU5bCtLYd
         Arg85RkvFQsN3KRM4TdsyyqDYhwwtljQzmvLSC4PJwFeqkUr2YAj4Tw/cTpJBXq6NYqy
         V4N/c/C4FJ/hHXee6IwqALjAZdoH+xBJPOzXtqpwFmsvwtp8CiKy9JEuocI2CW29VnP4
         /mwg==
X-Forwarded-Encrypted: i=1; AJvYcCWgAHMizd/eqlngoHsod/16LNBWnZr5unUkf4c6ReaqK3oFES53ok5WfNnwXReJRtzfE/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0q7VJTrEjXNp3HMY1zBq+RDDBMZy5of/J/zY4XKBK2dXzXyU/
	06vLWaNBHlBdpgDC/k7Ga/Hc+B2T07lrRfcKFIJvlPQud0S5xJiR
X-Google-Smtp-Source: AGHT+IFeYW+RxGPR2r6CYZsr/LEWJMUfs2VGz+vHNuBn10rdJZ3J6uaba8JGH8BWKCqouJ3jFjlGJw==
X-Received: by 2002:a05:600c:5254:b0:426:5fbc:f319 with SMTP id 5b1f17b1804b1-42f778f4e11mr29460585e9.33.1727890056001;
        Wed, 02 Oct 2024 10:27:36 -0700 (PDT)
Received: from gmail.com (132.red-88-14-49.dynamicip.rima-tde.net. [88.14.49.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a02ed15sm24546715e9.40.2024.10.02.10.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 10:27:35 -0700 (PDT)
Message-ID: <2ed4f980-a294-4a39-9c74-f63ce9af1f70@gmail.com>
Date: Wed, 2 Oct 2024 19:27:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] add-patch: edit the hunk again
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
 <4dd5a2c7-26a8-470f-b651-e1fe2d1dbcec@gmail.com>
 <74289d8b-7211-452a-ac76-f733e89112e6@gmail.com>
 <9c7af640-ee3a-4a17-84f6-f56fee7efe37@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <9c7af640-ee3a-4a17-84f6-f56fee7efe37@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Oct 01, 2024 at 11:03:10AM +0100, Phillip Wood wrote:

> I'm afraid I still don't think that changing the default is a good idea as
> it is often very difficult to correct a badly edited hunk.

This series isn't about how hard it is to fix a badly edited hunk.

> In [1] you say you discarded that idea because the wording was too verbose

Not really.  I still believe that regaining the original intention of
"no" is a better option than adding new options to the interface.

I am not opposed to that change, I just think it's an unnecessary
complication.

A user who experiences problems with a badly edited hunk, edited by
themselves, will probably encounter similar issues as they would when
editing the original hunk.  I think.

I don't think reconstructing a patch is a realistic (sensible)
scenario that we should be concerned about.

The small change in the message, in this iteration, adds a bit of
clarity for them, I think:

> > @@ -1286,11 +1287,17 @@ static int edit_hunk_loop(struct add_p_state *s,
> >   		 * of the word "no" does not start with n.
> >   		 */
> >   		res = prompt_yesno(s, _("Your edited hunk does not apply. "
> > -					"Edit again (saying \"no\" discards!) "
> > +					"Edit again (saying \"no\" discards your edits!) "
> >   					"[y/n]? "));

> 
> [1]
> https://lore.kernel.org/git/6f392446-10b4-4074-a993-97ac444275f8@gmail.com
