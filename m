Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDEA1DFC5
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711821804; cv=none; b=gbVLMt5DUcUcNWLEGYE0yWPz6O1Mip8F9TZUsFJ8IYfIab5hrEarkD4reRA5RULB/Hk7UxbmS24+ujlo1tlr2Lx9AcWer9xSVgntWExnEBwaVntq3XdgXy4GwphsjL7nhh3VHpJ9S+m3D27e6it9JcNt40WAr2jjR6+4VKTy9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711821804; c=relaxed/simple;
	bh=GUS0oTL5vZhdu/dil0jkIUSh7VzCl7913RGARAE/r54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J3xjXAYwcMrxslGZpFMqVgCJzS9PC1dXpxEoIO8cycl8WFLhgT481+u+oSl7+jsZuDtXRGU4uq8D5HlkL1bOEo5oAtTRhg+M8hXV5TD+obxKw+a7LzlRzqY4ia54+mu36++GcZFt3wQkBbjTZKNSpev1O4jMr699E6ER8e/4gWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=30yVwgLC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="30yVwgLC"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e0ae06181eso26397465ad.0
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711821802; x=1712426602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUS0oTL5vZhdu/dil0jkIUSh7VzCl7913RGARAE/r54=;
        b=30yVwgLCdnmmHeKz8pX8UKZob0Y8GN+qK9mK08q44LsNtT8s7btPBGP6CLOQFOAZML
         SYA4hMvbcn4aUr92kji/l/DVbSwObQkV/yv+xGeczSEWMW4olWHn9Jlc7SI1PMLYPmda
         8oJNNslGbUFMv7gOxbxgW7l5sAZnjoB5X6lBEVz0NjBjO2XO/WtUOSauQaeuvKYY9Zil
         bV+168Az2aktDj4leqC3YuySiPPDow2CJfYTSpP5uPQq+GOYdRBV2kWxPsXBjHfac3XF
         YsxIWC0f9YtsoH5fwkweaO/fSW1CQJ2bWg+NKkbzfAma6JxKkp1O3DfpiJq0cOUTOZjG
         Ya1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711821802; x=1712426602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUS0oTL5vZhdu/dil0jkIUSh7VzCl7913RGARAE/r54=;
        b=EhX54PeQG1vdm8O5iUxboQAc6glOcyY82zFOigoKgxe68LrMKKOaqdXqKpN73MZ711
         aLzQPCn3/EHrQ0DNqmzL8fKjrsTNjxKCYCmzffnpV9PuGoub1B1FQW1IRk7ADYqj3AmT
         lvThMfdRQrCrdFWNQSVCSi0KqrSqxh04sNPwFpmhn3tvxYxG6ufH908ajxeBZgB3dr7G
         IdA1HxJsnw+6/arYfCnT1jDL1z5zFHydqJuKFx4cI8UY6oXYXlRwGKYyRtnqRRXa6TEM
         7LgQ5q+yCe8Oqo1ejcLxtikt91Ijud+G3PQtseSPubf7FHEfkDGEnchr8Crh00SlWhR9
         W8zw==
X-Forwarded-Encrypted: i=1; AJvYcCVYHOvLDtcbWTwJoQijoCokziYu+7DkrnQAeBkKsR8HGEdbHNrLf3Icij1e18JdACe4K3LR1c5VhngOcwGHZFO6y6HB
X-Gm-Message-State: AOJu0Yz8wbXv2NILfeX7BPRu8kxcBE1VDya9lr0u9n2KNaBPPcDy5hRN
	aYdqp8a7fi2ZEWvgMYVn2l2/mCgiVRqBIxi+8LTtnyjAnNtugrmZK4NwdQHJb66wAG0JJIpyC6r
	p7w==
X-Google-Smtp-Source: AGHT+IERk1+0yWG2Y++i2dGgZySHhuF5kunY/JVZNkS7Y7LSLuIfbXETH15Tdc/I+Gj02eEL0nc3Oq0DwdA=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:903:78e:b0:1df:f9c7:6891 with SMTP id
 kn14-20020a170903078e00b001dff9c76891mr24043plb.6.1711821802392; Sat, 30 Mar
 2024 11:03:22 -0700 (PDT)
Date: Sat, 30 Mar 2024 11:03:21 -0700
In-Reply-To: <ZgPIEgFGVokYWc-H@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
 <xmqqsf0gvjrg.fsf@gitster.g> <xmqq8r27nhwo.fsf@gitster.g> <ZgPIEgFGVokYWc-H@tanuki>
Message-ID: <owlyr0fr61hy.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
From: Linus Arver <linusa@google.com>
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Mar 24, 2024 at 07:51:03PM -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
> [...]
>
> I would thus reformulate the proposal from "MAINTAINERS" to "REVIEWERS".
> Instead of saying that person A is a maintainer of subsystem B, it would
> say person A has a keen interest in subsystem B and would thus be a very
> good candidate to Cc in all your mails touching this subsystem.

Good idea!
