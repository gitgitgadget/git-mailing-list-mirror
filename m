Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F117EF07
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646376; cv=none; b=MfxGuMcxHx7RkazLIXvkZ93PtdbrKkgoQCSCqCktpWbXEOfrHBV1wGEjDNrglA/imPkRVku+aP8Unum55Osus4p2YgqI3365TqiAN1nTrJOwNKgiEHisWVMInNGtHzo8NE3JUWhsDcQDWXG7ZJTOEyj/DhaEA4lFjvnUfvRt9AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646376; c=relaxed/simple;
	bh=PbjFJiCek9Upiwbyvf6LWzXlrvHJFdaW6XFhHMI4XcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktSGxknNtz5ktqe74PbLmj4iRum31CfuWcNVVrfkvEQvH7w/LCFYA84PGGD2gewdlp0bd+hO022EeYnj5jdocJBsk76C+m4noUB2IrgMA8HAir/Vc+/8nbfZxclMEUgSwjdTqTR/LewQVUJYhtT2fdKpsSbwX9qDOvF4ecP8MGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPADGhl/; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPADGhl/"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c3ae8fa863so814404b6e.2
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711646374; x=1712251174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yA9Jujzj6OkwWULe7paESQvSrUPIcKXFnUOw/rmrBF0=;
        b=gPADGhl/WAX9xgLHbJXE5hig4QnB9rqOXQlm6KTTECNKg+2rEP4/f2wFyzNAialxTD
         zJXQNpZUxauSDFqGbwrzUz9xJV8imX/W2PakXMd9Ov/gWp0oFQD9GsMcIgzEoU8Nl9/N
         MGAhdNrwha2/4+nI8PappQ/c1vOCPbvoqEFi9qjW1edfZoE9iKWJF/8RTo842jNyJWLR
         JgTNv2BYm981AfhLx3LlrsTzWkgY9MPSkInmRMUrypn9bIWANYPfcozD3ndjVHwJvdvu
         WDdV/bm7Vd67NUbSyGtTNV+4sBcmhTzTjXbVxuPaycXc0TGX0RfTbjoiOIFWkGvlo+1e
         q+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711646374; x=1712251174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yA9Jujzj6OkwWULe7paESQvSrUPIcKXFnUOw/rmrBF0=;
        b=xOgzeXLgzxG6Z8yR/YGIhktRQMv+3br6aZ/aPjOmlF6GjHrMt03fOY8y6cIXXAb2xu
         4Kcj16hYa82KLYQy2Kz0agGfhPBlV6jTv2nixJQqLQXf6SwGYBG8tPjZogbjcBM9lHlJ
         AW/o/sEY9hK+nmSTaEBhSyXQ5cermGS56ted4gNXnkhRN3Bqu+8yQyOwNiOfCt5qu0EB
         Yhwo03s7HgTqrv1I5ZTDTcHO/GU6v/UlR1RTJ46qg/E62sxFCmOy/zx+mainepTuQagm
         gXXggMNphBBj9POvV4au6d0fttkmImFG59BBOQ4J70fMohWPRaEf6XR1kmGV7b1HUCzK
         0J2A==
X-Gm-Message-State: AOJu0YyIdjwzOTLq5EbzLrc/NIw+282X2IaSY27mmaQikaNkWBjhjJEE
	u8LLJbjJBAo58xJQIm9F1cz1Oam670YYccdfyU1klPJK+tflnBXgZ8znR6r6BIGHJT6s90ne5tx
	3VV9dt02g3wVxpEgJZ554fyIT2Kg=
X-Google-Smtp-Source: AGHT+IGDbyLz0MjaqKauhYK1QKXZVD2/w6NQPggMgNXcqfs0DQD6Ipf+E+W4uEBbiCcC7TcK8wvbeuVO879IWSvAy/o=
X-Received: by 2002:a05:6808:96:b0:3c3:cc4c:684f with SMTP id
 s22-20020a056808009600b003c3cc4c684fmr3517076oic.25.1711646374084; Thu, 28
 Mar 2024 10:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK_130T8sZUZAuvj4x7sB278kVL7ARaBv3Pg2djQB45O+7xKTg@mail.gmail.com>
 <xmqqo7aywfc5.fsf@gitster.g>
In-Reply-To: <xmqqo7aywfc5.fsf@gitster.g>
From: zhang kai <kylerzhang11@gmail.com>
Date: Fri, 29 Mar 2024 01:19:23 +0800
Message-ID: <CAK_130RadXce-_PwnZTzJ6qmr3m=OXd2M9bCj2gggM49RxL9=g@mail.gmail.com>
Subject: Re: Update message_advice_pull_before_push to mention how to push
 after rebasing
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I am not sure if that is a good idea in general, though.  That "if
> you just rebased" applies only to the case where you rebased your
> topic branch.  If you forked to work on topic from the upstream's
> primary integration branch, worked on that topic, and then rebased
> your topic on top of the updated upstream integration branch (which
> contains new work from others since you forked and while you were
> working on that topic), you do not want to force.  force-with-lease
> may help you avoid overwriting and discarding others work, but the
> only sensible next step in such a case is to pull-rebase again,
> which will rebase your work on the topic to build on these recent
> work from others.

Indeed, there may be more complicated cases. I think the key is
whether the tip of your current branch is really behind its remote
counterpart.
How about we update the advice like this:

Updates were rejected because the tip of your current branch is behind
its remote counterpart. If you want to integrate the remote changes,
use 'git pull' before pushing again. If this is not the case, you may consi=
der
`git push --force-with-lease`.
See the 'Note about fast-forwards' in 'git push --help' for details.

Then, we add a more detailed explanation in the =E2=80=98git push =E2=80=94=
help=E2=80=99 message.
