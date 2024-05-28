Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0D517E8F4
	for <git@vger.kernel.org>; Tue, 28 May 2024 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891048; cv=none; b=bUhvSwqWI8ePHxK1bEukeYVY89sX5OBkOK6LbMOnlWMyPAwzXh926t91uVojYohhDfQn5uxdCfS5GFFNAmadZTx8At85WbKFGSXLznK3lCEGuIuCL5ATC1/TyX2WVlmgEYTraa5Trpn48UdFcPMqbVlJupjLDXse3is6fLBGo74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891048; c=relaxed/simple;
	bh=gLs27k9h8AThngnJ6SO2OioXBoyQCUm454zSptxtBEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHTz5Iu6WFmgjlEG2tKrylgqf0QjAIzDtV4SEMZgy61eaJ4RBslzVjes3eScQwTtBiQukF3/lyYxVwCC8/SDMdrS+Elc6k1AmqO758KDvecS8wUhQ+QmoQ2o/RWR9/vMQypONydwZfTPICxW7/wfu5whr9OZqSTVT8CGR0+Ftwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLts2/w3; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLts2/w3"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5785199f7d1so272748a12.2
        for <git@vger.kernel.org>; Tue, 28 May 2024 03:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716891045; x=1717495845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXr1khy/KJE3UsV4rsx9HbFToqDudfzS8zHmZ4ac9PI=;
        b=OLts2/w3DkeMbb4wJsqK+WosoUNte6g1sszrd6EenfnsDZuRCSHo4omt4SjmqjAw7k
         HdETBedufRP0TGtqN/jODxhqXAXVlwWv3P6vPILi4+k8uvENNjGkw+ixX8hJhlsk1pBT
         D6mEc2/VrK3GAR5rKX2HXvuBNK5In5MJ4FLuAiJ0R6ePZXHPILH4wNlFpnMNnwiLq1Yb
         LtIdlmurMOfq4XxM+I+Q1nkKbQAz/KCoB+wAI2Td7bEDxnrn3qobpbWirTU2a9R00N4q
         EVYKcZqZSCe50W9cJQT4IsQTZ0h96nDxAzxqfXay1A8z00TL4XumYmDZAt75KQrqsUiF
         wAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716891045; x=1717495845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXr1khy/KJE3UsV4rsx9HbFToqDudfzS8zHmZ4ac9PI=;
        b=aWxuGsxP5RYA5MxrSQSJKsO3rgVWM5AJZKO/FkqHWYv5cmdHRg65dNbmjBMLvbXMeW
         HjFSwBBXKuOyVImafDYr8A6yHgzByuokHvKjYjwRTwyXT+zwOUP0DIJgF/azRvhPu6Md
         yz6xAA1eKmTSFVSuTnRKfwY4ft2amAqGtsGUW6q7UDKp3FqpUrHh3TzM4zBiSFBs5Ign
         E7wgkGPH2U7GODz6OFVCMzRczj9ZwIxYW/pf9wQOANZO9FzEly/bYxypjrr2CuDIDHrG
         DAtTtPnBstGy9erwsSDEgEAMF5ogZyiRUOz+xpqCnpRG/JJAQZqOil+3Eww8zsCIzaxW
         32SA==
X-Gm-Message-State: AOJu0YwtjejKIHjZ3NkHoQL1hHVax1mh0bzx9eZ3pn7SozgM2zqGsWJ4
	yZkf1TvBspSZkVGpvYzgvoOPH56bheCrKf+qZuB3yizjXxPfS9SehYqedTXWvxJN3xNP7gZo2wZ
	spGwH7ohT6CwXaqAwAzEOMYwRGUQvEuPh
X-Google-Smtp-Source: AGHT+IHE6aduOGs3TNZLTFZgnsBF0oInOmor6N9hgE/h+I4HHBMVS5N4cT9mGpjQ9YA8UQMe9njGxnp2+IZJ3cFhsXM=
X-Received: by 2002:a50:ab4e:0:b0:570:5bcc:f749 with SMTP id
 4fb4d7f45d1cf-578519b3380mr10810485a12.29.1716891044424; Tue, 28 May 2024
 03:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221012135114.294680-1-christian.couder@gmail.com>
 <20240515132543.851987-1-christian.couder@gmail.com> <20240515132543.851987-4-christian.couder@gmail.com>
 <xmqqv83fvw7p.fsf@gitster.g> <CAP8UFD1JZ7eJzrTk1YPrfy1XLAnnLvukABOJE69-JbqVWtL1AQ@mail.gmail.com>
 <xmqqjzjikhdz.fsf@gitster.g>
In-Reply-To: <xmqqjzjikhdz.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 28 May 2024 12:10:31 +0200
Message-ID: <CAP8UFD1_aHwbhF12v-miCTWEbbgjtpjTCmkRmFHu4Vusezq6dA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] upload-pack: allow configuring a missing-action
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 11:51=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> >> Repository S borrows from its "promisor" X, and repository C which
> >> initially cloned from S borrows from its "promisor" S.  Even if C
> >> wants an object in order to fill in the gap in its object graph, S
> >> may not have it (and S itself may have no need for that object), and
> >> in such a case, bypassing S and let C go directly to X would make
> >> sense.
> > ...
> >>
> >> It feels utterly irresponsible to give an option to set up a server
> >> that essentially declares: I'll serve objects you ask me as best
> >> efforts basis, the pack stream I'll give you may not have all
> >> objects you asked for and missing some objects, and when I do so, I
> >> am not telling you which objects I omitted.
> >
> > I don't think it's irresponsible. The client anyways checks that it
> > got something usable in the same way as it does when it performs a
> > partial fetch or clone. The fetch or clone fails if that's not the
> > case. For example if the checkout part of a clone needs some objects
> > but cannot get them, the whole clone fails.
>
> But then what can the repository C do after seeing such a failure?

It's basically the same as when a regular clone or a partial clone or
a clone using bundle-uri fails or when using a regular bundle fails.
If it failed because the remote was not properly configured, then that
config can be fixed. If it fails because the remote doesn't have some
objects, then maybe the missing objects can be transferred to the
remote. And so on.

The feature doesn't create any new kind of failure. In particular,
when you use a partial clone, even a very simple one with a single
remote, there is always the risk of not being able to get some missing
objects as there is the risk of the remote being unreachable for some
reason (like if you take a plane and don't have an internet
connection, or if there is an outage on the server side). There are
some added risks because the feature requires added configuration and
it can be wrong like any configuration, and because there are 2
remotes instead of just one. But these are not new kinds of risks.
These risks already exist if one uses multiple promisor remotes.

> With the design, S does not even consult C to see if C knows about
> X.

If S is managed by a company like GitLab or GitHub, then S will
certainly advertise, for example by showing a command that can easily
be copy-pasted from the web page of the project onto the user's
command line, some way for C to use X.

In the cover letter I give the example of the following command that
can be used (and advertised by S):

  GIT_NO_LAZY_FETCH=3D0 git clone
      -c remote.my_promisor.promisor=3Dtrue \
      -c remote.my_promisor.fetch=3D"+refs/heads/*:refs/remotes/my_promisor=
/*" \
      -c remote.my_promisor.url=3D<MY_PROMISOR_URL> \
      --filter=3D"blob:limit=3D5k" server

I also agree in the cover letter that this is not the most user
friendly clone command and I suggest that I could work on improving on
that by saying:

"it would be nice if there was a capability for the client to say
that it would like the server to give it information about the
promisor that it could use, so that the user doesn't have to pass all
the "remote.my_promisor.XXX" config options on the command like."

and by saying that this could be added later.

If you think that such a capability should definitely be part of this
work, for example because it wouldn't be sane to require users to use
such a long and complex command and it could avoid difficult to debug
failures, then I would be willing to work on this and add it to this
series.

> Without knowing that, it cannot safely decide that it does not
> have to send objects that can be obtained from X to C.

In the above command C is asking for a partial clone, as it uses a
--filter option. This means that C knows very well that it might not
get from S all the objects needed for a complete object graph. So why
can't S safely decide not to send some objects to C? Why would it be
Ok if C wanted a partial clone but didn't want to get some objects
from X at the same time, but would not be Ok if C wants the same
partial clone but also with the possibility to get some of the objects
from X right away? To me it seems less risky to ask for some objects
from X right away.

>  Instead, S
> simply say "if C requests an object that I do not have, just ignore
> it and let C grab it from somewhere else".  How would it not be an
> irresponsible design?

Again when using a regular partial clone omitting the same set of
objects, C also requests some objects that S doesn't have. And this is
not considered an issue or something irresponsible. It already works
like this. And then C still has the possibility to configure X as a
promisor remote and get missing objects from there. So why is it Ok
when it's done in several steps but not in one?
