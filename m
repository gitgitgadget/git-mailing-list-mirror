Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD92481C4
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 23:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877540; cv=none; b=ilqTL8PRiljJ0qLljxxwXVv8kDSQ8PaLzzaZKthcFs+e/P0Vo4rajab/+jSZezP67xtP7xWH2JTp45yM6N0majuZ/TvFtG56YX+E6zkUh/x2za2MF0zLy+ObSDhata1oiOcZpHGBx+PwOT57ZmQxnujBIU+sYZ4T3RowhVbh/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877540; c=relaxed/simple;
	bh=HxCZdqjckZx1N9AF5htzsa7hMrVQbbg4y6e1s6p2Y0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVwh1PnSGg8MRwfpsAmpp3WrKPd+DNJjbE3wYN3YLWH5kqWUhNuN4UyrI4ZwuwR4F7Ep+R1OaNtbpf7wBqyBX9QMwJgpEoL49h5ewPLQ+zgR4pqqHj9t8g/ORJ6s+dZudWxKu7BlSsvGoNUT/eZ4arHr8fOn7T2gmoad2gJBrds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcLi2NoE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcLi2NoE"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41551639550so2417735e9.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 16:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712877537; x=1713482337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0R6V+OoGhcaXOn6qbn11ajJ7l6ukDrz0D/XkJlfRA8=;
        b=QcLi2NoETZdXblQnhMlNu4SSvVqc1LxgExA/Gn+M5LKlYXyFGYR/9iRZiCc6zySxHR
         CoI0fPrFjrYpHJllihFKOaK4D7PvcEO3aOCxuYbXdJz5DMr3ed2Wr4dr8GwSNQREueWv
         NFe1SClCm7UEiuAeY8XaovyCnQT/6q/kVY9o5P5MKfI98BlCKFIPK1BigsXTTQQRlpFx
         GVlQU7qsKfislDzMgF0IYC2Jdaps8tS1S3yuWS2EL9oEvJz3fZEcGGRwZwLr2G39Sg9D
         WAz9VU53mYHYk4JU1IUy+ONHJYcjNh8WISn4zQmLAeYmYsrrH/C2gH+kKuxjST1nSkt6
         oraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712877537; x=1713482337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0R6V+OoGhcaXOn6qbn11ajJ7l6ukDrz0D/XkJlfRA8=;
        b=T245p8DV5byEitw5WEyVV1xaCA0tX3dzMnHvzv/Pi3nPRKfvp7SUgj5ygfiQTYO5n+
         XRMtlJtOyfLKKmA4owAXQiK4Zc97x2/ZCGvPed0bPPViaO1yYBNxvJiwlnPb36QI395a
         4pZ1pgPheGBjOuqmP/BjSfseK8Ms+xWPGqa/rAvrE33lqoD8R6SmuKSICjPCShju6asQ
         h0QN/Bv1KBcq/RlJ/QBForkfaN5itcKK+wHYdlccjJmTohD4bX3NkoNnWMDrDnHtI9g5
         qZ3RQw3NoRulVGkVL28vNbtBVEplorMVButiCsJgDrX4fr/eXplBNJwj50R/WsLwdEXr
         +jPg==
X-Gm-Message-State: AOJu0Yw4JIJ8Tr84ZPGo/b4vm4SJe9Cix1G8/GQGqIw0RXDgAJDlUnx3
	Wfzrs8W3wkzYPsn5ZWdLUof3wKz/XP+KKyrnMTgR2SBA4RUswBrD
X-Google-Smtp-Source: AGHT+IETJHbZCm2vqtOw1566UXNipCSlr+ycr4rYCqVu9gzrWl8RXomdaLHw5XH18/nOCkhw53w0cw==
X-Received: by 2002:a05:600c:35c8:b0:416:34c0:de9 with SMTP id r8-20020a05600c35c800b0041634c00de9mr1061360wmq.29.1712877537233;
        Thu, 11 Apr 2024 16:18:57 -0700 (PDT)
Received: from gmail.com (188.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.188])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c35ca00b00415dfa709dasm3722789wmq.15.2024.04.11.16.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 16:18:56 -0700 (PDT)
Message-ID: <d485c4cd-f963-45b7-9fa6-801738c7c066@gmail.com>
Date: Fri, 12 Apr 2024 01:18:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] launch_editor: waiting message on error
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
 <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com> <xmqq4jcb495u.fsf@gitster.g>
 <54dcd4f1-5a79-47ba-9650-7115b7170a84@gmail.com> <xmqqle5lxlwm.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqle5lxlwm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Apr 10, 2024 at 08:44:25AM -0700, Junio C Hamano wrote:

> > My concern is that perhaps term_clear_line() might clear some useful
> > information for the user.  Although I am not sure that this concern is
> > sensible.
> 
> It happens ONLY when the error message the editor itself emits
> (which comes later on the same line as "We are waiting for your
> editor...") without terminating newline itself.  Otherwise, we'd
> have
> 
>     We are waiting ... THE EDITOR SAYS I FAILED
>     _
> 
> on the screen, and the cursor is at the _ position.  term_clear_line()
> would not clear anything.

Not with a careless editor:

--- >8 ---
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
	fprintf("editing the file...");
	exit(1); /* unexpected exit */
	fprintf("\n");
	return 0;
}
--- 8< ---

> > Stepping back a bit, how painful it would be to drop the
> > term_clear_line() and start using advice_if_enabled() here?
> >
> > This is what I'm thinking about now.
> >
> > 	$ GIT_EDITOR=false git commit -a
> > 	hint: A-good-explanation-to-say-we-run-'editor'
> > 	hint: Disable this message with "git config advice.waitingForEditor false"
> > 	error: There was a problem with the editor 'false'.
> > 	Please supply the message using either -m or -F option.
> 
> I do not think the problem is in the case where the editor
> immediately exits with an error.  It is when the editor opens
> elsewhere (or more likely, opens another tab to let you edit in an
> existing GUI editor session, but the editor's window is buried under
> other windows) and your "git commit" will stay silently without
> giving you back a terminal prompt, leaving you wondering why it is
> taking so much time.

Yes ...

>
> So I am not sure if the advice mechanism is a good fit.

and I'm not sure either.

However, two things that I like: by using the advice mechanism we avoid
the term_clear_line() and we advertise better the knob.  I discovered
advice.waitingForEditor while inspecting the code.

Using the advice mechanism here is just a thought.

> > 	$ GIT_EDITOR=false git commit -a
> > 	hint: Waiting for your editor to close the file... error: There was a problem with the editor 'false'.
> > 	Please supply the message using either -m or -F option.

> I do not think we want to encourage "-m" when the end user did not
> say so.  Instead we should let them fix their editor to keep them
> more productive.

That message can be traced back to 62e09ce998 (Make git tag a builtin.,
2007-07-20).  My understanding is that we suggest -m or -F because using
the editor failed.

Are you saying we should stop giving that "Please supply ..."?

I see that message when I'm editing a commit message and decide to abort
the commit by making the editor end with an error.  So, that message is
misleading to me.

Therefore I'm fine with removing that message, however, I'm not sure
that's what you're suggesting.

At any rate, this is tangential to this series.
