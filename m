Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884CD25F994
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759478404; cv=none; b=c46gXalLIxa+XfetC8Yh64hBQuN+X1P1mPWMkorF+Zcv/bjtuooSJwxB+FcXffnl63wPcDw1LHvEQoNWjqGrCVQB6QhQOwGTFTg2vLGidZCLLU2wD8ilDjRyAYgtsB/qpgGms9On6R//GlFA9LVdU8kB7lPH+r4x+j+GhpFtEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759478404; c=relaxed/simple;
	bh=Rwf/CuKVjRaFxzx1YkCekHPZZesj9sp9Omgcw60mF38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tz/dNZBVSWxrRZaTwxE0214GKFRev2WJb4oToZfjQizD4HhxVxLLKAtKBpHK2nCaMCAyZBk8BOmnfhGOBK2p+yDLzIULukNz7L5nAeb8XocFbRyDDDCItjr4Y1Ar8Rfz+6Pm4hprrW97rlIHsIBICb0E19zeRcWzIhUn7NLsoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fvj4UXAM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fvj4UXAM"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6394938e0ecso811355a12.1
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 01:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759478401; x=1760083201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/cI1HyidHYVHZvC3ZxiDQ7QNlczYGS9xq7HbhthMgg=;
        b=Fvj4UXAM/l581wUP2eVRVyfN9OGvzkAuj6OYJ+vFaAKhImolMpOVE6PILC5hm6jRzw
         4v6Cmr3WYUt8j8jkoDrLMcovNviJ2LzMLivIj3gU/uvOLwvNk52tvCRn0EQqZIIWOTr3
         NfkLNhkXP904PAKt5byEDTjZjzJI1MeHOiqQCobEy+yJlK4mXEe3t5bNhuZleot7Rz0T
         qmycmBCH9gk4nl3QBPLqqW2ijEJwkXHVbk2NQzzepQp7XUeWyzabncKdZXMJg3l1eT9v
         1PPIPArRliXWvG7nuQegRd0gO2YyCybap+Q+jyx3rHkkZgeDXggOGHNQZ9RBZBa2PJky
         27Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759478401; x=1760083201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/cI1HyidHYVHZvC3ZxiDQ7QNlczYGS9xq7HbhthMgg=;
        b=PLOxyvstC8oCTlIdKu7z2/RZJchGrLjDlKMGmk806awheeonp+RPUnCrjHSzK0US6H
         F1FDjDmF47XCoVU1J9bnbKRjZqme2TCWiJ8/oOMraauR+51YL07GgVwWsF7GJC8aaLFF
         6jlsnVaoN/4YvloIx4v1+qy/RlZYTmSme8CW06o/uBf7SEZ35yIy/L6p4nHE0j3TSgZa
         FD27lKIyiUkwWbVZfa5IpoX58iGUyDJNfTGosfpiB4hTZ1H0nT0CB1SHDHAAUyvbOZHI
         jXxpXmiOgjl47VULcGAmqLmT72DjcNAbM6MNPvfGPNAmpgjN8/ZsY8mh/3FpuVaUCH9V
         khHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZxje0368uTXPutgMyMKweJcIK+dclWrejTSyUtb0rKD29F+nYMLHtHy96VZpB+HttPu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOOzNbZvehh3Sj5eufxr1RIJzOq8ffhbwVuPDHspl5KpohUyHt
	TXJnfA5FMHbSB5MgO1OBVnP8GXSQx29UyYAEQBRU/6jr/4GepiD96T7EmhEizZ7CyEJRkuzvrjL
	GYfb9u5he9SlttBeoOnpeJZbF3yfEiXtCk0OvAkg=
X-Gm-Gg: ASbGnctYOrhN0T/z9EtDLPbutdgY1VY4SV7VTzU8M70TaXlhYw9eZFpsA5DtojKVA5p
	3/q+Mgq673Vc6cwQzxHzXQLMhI2Dq6aOCCIHy0ckmGRAcvpd04GFwplsy3Sx+z2HIgPOeDeRS1S
	9bIQiCdUJlaSKW34Ww1XyOg3PY/RI0+HkDOIRf0IyoSkZ3MQzyMaHMh8gQ1axZxNm3RO4OBjzMk
	AgpQD4LKldnA9iNHlt5nUEvKavs5gk=
X-Google-Smtp-Source: AGHT+IG5vbO95jvFbxFHMHezlcNOiYxH2G6Itb7QkW+9pIJ+SXxTgqUZXYsHZmb79bSAsOHfZmpu+51Tf2Wib009OZI=
X-Received: by 2002:a17:906:c149:b0:b40:9dbe:5b68 with SMTP id
 a640c23a62f3a-b49c1280693mr250187666b.5.1759478400796; Fri, 03 Oct 2025
 01:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com> <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7Mkcg@mail.gmail.com> <0fba2f5e-03cd-439b-90bd-f613fcc4ae23@gmail.com>
In-Reply-To: <0fba2f5e-03cd-439b-90bd-f613fcc4ae23@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 3 Oct 2025 09:59:48 +0200
X-Gm-Features: AS18NWDzIGfnU3vCkWKoNraz1l0jD5OI33I4cizxaARnw48XTYenIn1epJxz2PA
Message-ID: <CAP8UFD1JBeGxV65DFCs9dSkYwMpSBhWCZoj6dXCwmKgZnR_=KA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default behavior
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org, gitster@pobox.com, ps@pks.im, 
	code@khaugsbakk.name, rybak.a.v@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 1:27=E2=80=AFAM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:

> >> For users needing the traditional pipeline workflow, --output-commands
> >> preserves the original behavior:
> >>
> >>      git replay --output-commands --onto main topic1..topic2 | git upd=
ate-ref --stdin
> > This is good.  Did you also add a config option so that someone can
> > just set that option once and use the old behavior?  (as per the
> > suggestion at https://lore.kernel.org/git/xmqq5xdrvand.fsf@gitster.g/
> > ?)
>
>
> I didn't, but I should have. I will add a config option for v3.

You don't need to add that configuration option in the main patch. I
would suggest adding it in a separate patch after the main one (which
changes the default behavior of the command).

Note that in the commit message of the main patch, it's nice to say
that a following commit will add a configuration option for users who
prefer the previous default behavior.

> For naming, I am thinking either:
>    - replay.updateRefs (boolean: true =3D update, false =3D output-comman=
ds)
>    - replay.defaultOutput (string: "update" | "commands")

If the command line option is called `--output-commands` then I would
suggest naming it "replay.outputCommands" and making it a boolean.

> >> @@ -330,9 +361,12 @@ int cmd_replay(int argc,
> >>                  usage_with_options(replay_usage, replay_options);
> >>          }
> >>
> >> -       if (advance_name_opt && contained)
> >> -               die(_("options '%s' and '%s' cannot be used together")=
,
> >> -                   "--advance", "--contained");
> >> +       die_for_incompatible_opt2(!!advance_name_opt, "--advance",
> >> +                                 contained, "--contained");
> > Broken indentation.  Also, should this have been done as a preparatory
> > cleanup patch?
>
>
> Good catches. I will fix the indentation.
>
> On making it a preparatory patch: should I split it out as a separate
> cleanup commit, or is it minor enough to fold into the main change? I am
> leaning toward folding it in since it's directly related to the option
> handling changes

If there is only this additional small cleanup change in the main
commit, and this small cleanup change is clearly mentioned in the
commit message as a "while at it small cleanup change", I think it's
OK.

If you find out that other additional small cleanup changes would be
nice too, then they should definitely all go into a preparatory patch
before the main patch.


> >> +
> >> +       /* Handle empty ranges: if no commits were processed, treat as=
 success */
> >> +       if (!commits_processed)
> >> +               ret =3D 1; /* Success - no commits to replay is not an=
 error */
> >> +       else
> >> +               ret =3D result.clean;
> > The change to treat empty ranges as success is an orthogonal change
> > that I think at a minimum belongs in a separate patch.  Out of
> > curiosity, how did you discover the exit status with an empty commit
> > range?  Why does someone specify such a range, and what form or forms
> > might it come in?  And is merely returning a successful result enough,
> > or is there more that needs to be done for correctness?
>
>
> I was thinking about automated scripts that compute ranges dynamically -
> they might generate A..B where it turns out A=3D=3DB, and treating that a=
s
> "no work needed, success" seemed reasonable for scripting.
>
> But you raise a good point: A..A seems like obvious user error (why would
> anyone do that intentionally?), and B..A where B contains A is likely a
> mistake that maybe should error rather than silently succeed.
>
> I am inclined to drop it entirely from this series. If there's real deman=
d
> for specific empty-range handling, we can add it later with proper
> discussion of the actual use cases. Does that sound reasonable?

Yeah, I think dropping it from this series is fine.

What happens in those cases should be documented if it isn't already
though. Those documentation changes should probably be in a separate
patch.

Thanks.
