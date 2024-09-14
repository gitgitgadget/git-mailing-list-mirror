Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9721E4AD
	for <git@vger.kernel.org>; Sat, 14 Sep 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726330168; cv=none; b=Lh362Ob2ZpvuPJCQw5NlRGfdL+XVK7mOtm7z3mRpNKzloKMHNyf7vMSm0BvT89FGceZsbDLHK7gYPYbYlIJl3vt6Gqa2U/p1rSpdgGWGqMPye683BEvr2IRgFwpuu3U2dDHVnTQwJ+rCLJyFhgjTHukHBSRvvNL/PGCxBkoCx4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726330168; c=relaxed/simple;
	bh=kCKYFfxyOoyScVysdUs7pLaiNXo+c0G7hY39BOYL+i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIDErzUQVIq3CTVsYlMc4Cv6ghrZr5PZjh2SVhCCtOzK6kxazTy4n1dy3PwSb/McXIU4us8lUgPUTS3WY9KZgolRFELbF4BVGW8a9sMbKQNz+MsLUwk/oIhCINRV6LmdbXwR8Pyvmp5kj6XAakoUR4LwfI2f8FXsh2AtXrv6jYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJUKQwLS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJUKQwLS"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d3cde1103so415323966b.2
        for <git@vger.kernel.org>; Sat, 14 Sep 2024 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726330164; x=1726934964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCKYFfxyOoyScVysdUs7pLaiNXo+c0G7hY39BOYL+i4=;
        b=QJUKQwLSZLFemt5Ae9tEo9ULwPKEDLEESjz/hXIc3JnsgN6ED4dyg7A+AWdgtzh1jY
         kCs4bGyi6d6YOnyxywTys8iHWmHviDP1TX3gViC9zxQIvZ8aIX/xOf1sFIOwlJD2bSre
         npyRK+WCHwAfsjYVd0G1F3EeTBfIB1u+Vxe2vG/XTOnorvlp0CNPrfisvZO79H0vObP+
         wMDPIZ6fQ/o+apHkh/ZAvFZrZbLpJEbuc+ESueV0p6lunyA+9JxflOMHcC7rGls+8Wex
         TPS1k4veV20bFMhDBaOA32ZVWxiwQBG9wzNGXKqiRg/sI6rpKuGNMqm7iA1WcUfQ9VXv
         RHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726330164; x=1726934964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCKYFfxyOoyScVysdUs7pLaiNXo+c0G7hY39BOYL+i4=;
        b=f/o5WFwv3svTKubbMfCo78PCUgnGwMGdu2msl9OtBvgIXYbtrfTdZmNBTjRm8vdF/k
         A4iNCOa4yixlf3x1UgnjJwP1FgyfCaMaabLFUyK+/ged+op4lqUFVodpZClZcC/J0qfj
         R5qUs1k5hlNodH6byzGtHh2OizMgI+BBtGiIapnCxG9jXKRk0fyDgkTzrXR39q3dTudg
         zHvuk/PASGBLQlpdVLtd5lXIEonrBjDLqg86/QZ++1dhD7jeC4Jc3fWAvfUjAfqXEuYe
         5itqkrcrz6GOnkg9yZzSrYrlT7wjwyE6CKt+zHmJzRAOth6tzjnBJUxuSHTKJPg+EC3W
         I5Ug==
X-Gm-Message-State: AOJu0YyK55mF19Guqhd608iucKEWYoA0gce2tXqCVboyd9U/kp9CNz9F
	7kVPKjgbIgLkpUmPUDWg8BFVb4k4zrhoPNYD2uGZjOAsYUaHXSIx4XCgA6Iz0DF31p0LpbVjWDF
	Eda8yK9m5PpnykOgrMv3QyRInhQ==
X-Google-Smtp-Source: AGHT+IFq7yRfj2V6+TURISm6B69nKcjEa2snfUwCrWhzf5SHuQpN4d/TR/2JBy/fZ3U3V4XhLcVdqt3XEf/jdWAxjUw=
X-Received: by 2002:a17:907:86a5:b0:a90:3498:93b2 with SMTP id
 a640c23a62f3a-a9034989664mr995944066b.1.1726330163846; Sat, 14 Sep 2024
 09:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB=S_8JhN=WSuYRMWbGz7gZMRX9dSb3k8rJZ7zrxkbHKOqfzww@mail.gmail.com>
 <a25f71ad-093f-4e8d-97ef-503bfb9926d2@gmail.com>
In-Reply-To: <a25f71ad-093f-4e8d-97ef-503bfb9926d2@gmail.com>
From: Justin Su <injustsu@gmail.com>
Date: Sat, 14 Sep 2024 12:08:48 -0400
Message-ID: <CAB=S_8+SAYVBNPByMrgmPQtA9JKmKt+kmeRBB=9=bSR2LLiMkw@mail.gmail.com>
Subject: Re: Commit signing with SSH key uses SSH_AUTH_SOCK but ignores IdentityAgent
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 11:05=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Justin
>
> On 13/09/2024 10:58, Justin Su wrote:
> > I use Secretive (https://github.com/maxgoedjen/secretive) to store my
> > SSH keys on macOS. I've configured my ssh_config to use it as the
> > IdentityAgent, and Git can push and pull just fine.
> >
> > However, it seems that Git ignores IdentityAgent when signing commits,
> > resulting in the following error message:
>
> Git just runs "ssh -Y". I can reproduce this on linux - I suspect the
> problem is that ssh does not read the IdentityAgent config when signing
> even if it is outside a Host/Match in the config file.

Agreed, this seems like a ssh-keygen limitation. I reproduced this
directly with ssh-keygen on macOS.

According to its man page, if you pass a public key for the `-f`
option, then the private half needs to be available via ssh-agent. The
man page doesn't mention SSH_AUTH_SOCK either, but I guess it's the
best solution for my use case.

> Best Wishes
>
> Phillip
>
> > error: No private key found for public key "foo.pub"?
> > fatal: failed to write commit object
> >
> > I've worked around this by setting SSH_AUTH_SOCK, but this doesn't
> > feel correct to me. Is this intended behaviour?
> >
> > Thanks,
> > Justin
> >
