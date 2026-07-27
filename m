Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997DF3BED7D
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184018; cv=none; b=HJ2kMIzw/Fi7LDadz3YfOuRFiMUu9BnUkSI7ryhpLWxNmbOgtBdy+zzmbXZ/JxR/ZMuZfqKoLCFt2oYfkDYhnQyu9kvCX5WHnCpNe+wMD9oPWKcKPIyebxdOzgPozlfs86k6tli0vXyQTE9SX1tiqsuVzaCnY34vS/kDqTkipUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184018; c=relaxed/simple;
	bh=khvuPsDQFdaoRf3aUH2LpOvtdYrJDXhJ5mQgg7Pkl7o=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=nA9rpGMvxMeejJ0U16hGhKLSIYlqnKUw7V5NxHMUDjyeSQgRlqUn9fRoCbCxYPG2xt+NgzybjIsXABn2YDB2EgMzpfDWQyV8cqx3/yYgcmG3XE/53Lg/nmJaumqZwL8nUqSL6NS9nT0VQIoPxYHcbaaREAn/WryfyI59+Goozj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tH18+aVv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tH18+aVv"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47362928f65so2999860f8f.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785184013; x=1785788813; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BglIUMYiW+EsdSDAomWWJHJS540vuJ8bLfyMz3BRgKk=;
        b=tH18+aVvass53JJPdvtvHM96SnFg/3+KfqZvLgu5v3idJ1Z23StOBOontTdC/owboW
         Q2fLlGseSfeP3uXLnfunw5oSgwyWzdBOwicTw5eGF3E8kBRgsw0cBdDCALsqaBM4IPyM
         jOamEyBmJgsqY2T5kyU/4lgu+o/o1PUmqnfVMSTH2sIITZ9x+za3gChz9e54Q5bXzeL6
         zeGSUNXFtBOdgYDgr5/fDuFqLN54MClBEwVAKUbuYhMxuc5+bhZAZ1+4tpS+J5i73Gw7
         MAOWEJ+hqU+6VXo8JRuJMr9kj1/v/pclT2aYaW8u/AGy282w6KuTico0+TimTnnNwF5+
         fEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785184013; x=1785788813;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BglIUMYiW+EsdSDAomWWJHJS540vuJ8bLfyMz3BRgKk=;
        b=IPocnb/l37JmNRXxuW335LKpegKLMFNSjrUsyGAl4TMflrfG0b6iwOHlWmcdmfX+zn
         6RN108/RbSvvY+6wo/O7HcC3OC3BcaeRXbG2A3VGY1N63vb3592WRBKYMMvYGgyeSNJr
         jr5fenesHhRA1U+KDrDGB8TI6AZZVXgfC2gXnUGs+NmYd5Yq5XJWRflwldY/Ws8cavS0
         bkGBSWZZ7h3SNVwRu9iyCUET+JwC6Csb2cvwRe8VwzXuYPQiaHyCTHn3yIZVfDx3xFX/
         8z0gfJEPhPE428gN2jizLPh5+12RF4/XOD1AVf2fTUMD4svoDZ/QxRnIy+MmEzlyy+Ud
         wilA==
X-Gm-Message-State: AOJu0YyUCiJlKh/1N5LYR8xS0Egf902h9CupIQ3cswDaOUlgw7PAhYYx
	KPpoEEr6I9d4IinE02ZOhtt5q16yxYLe/VSmbiEiwN+fbTderYurOM1EDJHfqw9n
X-Gm-Gg: AR+sD11soSqN5oQzRGCfM9a2Aa7qnpyJjUtWoFfV5Zvuy/FfwemcOicbNau1VVxpxb3
	DcvJ3ZtP+oip2YQeSgSv5At6uUTi48OLtWGI15YW5mcheeNGEYrRvLtWq0rneqUnYBxvlfuZb08
	J+OJ665ycPZD3LgLTznZOeTN06QPwjAUC+5OPt/txMxXG+tWQQwMfDAa9rgbcHBxJw3qtOPQLZR
	gXtFpCEYXT2s/RL/K9Pr1CUwBMO6pkZSH+7GNw5vMIlBiegXC4TFSqWtVyRK7jYMT/LUU0pU25x
	P0U7Xp10UrmVtSBWwV1dsy7V+w7ZTQP5DPHFZFj9gIofE4wSPYg7NvImBJmIEjG/IxHmwb8D5bB
	ASqP5hn5X2MQTUjxPZz9HMo4aT8ugDE6hDBuVT6zSHDmaAiYOtqB9QFRfnFXpfTltGaMFcopHUW
	xCKQ16YtYRyM6ZxjDDDiMtti9GjwAqIsItZ6BY04TYBzBMpV55FOsj3SUzTCpKzs4gvopE8je5I
	NCLvnwCo31Z7Atla8ZdfOed7qYEv6WhqwjOdw0w0uP/cmQrHebSVPPStyRjwO8C+TcU8HdCK9y9
	qczlk3wyijo9X+3l
X-Received: by 2002:a05:6000:24c2:b0:473:b32:ff28 with SMTP id ffacd0b85a97d-47fafa71bc3mr685169f8f.34.1785184012477;
        Mon, 27 Jul 2026 13:26:52 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f864305f5sm50730674f8f.17.2026.07.27.13.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 13:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 22:26:50 +0200
Message-Id: <DK9MX0YJ07S0.1TOBLIA6ZNSEN@gmail.com>
To: "Jeff King" <peff@peff.net>, "Alan Stokes" <alan@source.dev>
Cc: <git@vger.kernel.org>
Subject: Re: Assertion failure with git cat-file --batch-command
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <CAFZW3h0K6vi15HhMEX30Ab+pjRc3mQr2Myv9KJUH=MWzsvt0FQ@mail.gmail.com> <20260727095735.GA1153453@coredump.intra.peff.net>
In-Reply-To: <20260727095735.GA1153453@coredump.intra.peff.net>

On Mon Jul 27, 2026 at 11:57 AM CEST, Jeff King wrote:
> On Mon, Jul 27, 2026 at 10:30:43AM +0100, Alan Stokes wrote:
>
>> I first observed this in 2.43.0, but it still seems to be present in
>> 2.54.0.
>
> Yeah, I think this has been there since --batch-command was added.
>
>> Note that if I ask git cat-file --batch-command to include the
>> objecttype in the output it is fine (which gives me a workaround). Or
>> if I use git cat-file --batch.
>>
>> IIUC git only fetches the metadata that it needs for each object, and
>> that is determined from the format. For --batch I guess the type is
>> always requested, since it is needed to print the object contents. But
>> for --batch-command that doesn't seem to happen.
>
> Yes, exactly. In the normal --batch code path we have this code:
>
>         /*
>          * If we are printing out the object, then always fill in the typ=
e,
>          * since we will want to decide whether or not to stream.
>          */
>         if (opt->batch_mode =3D=3D BATCH_MODE_CONTENTS)
>                 data.info.typep =3D &data.type;
>
> But for command mode, we don't do the same. This makes your case work:
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 1458dd76d6..78eab9723d 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -690,6 +690,7 @@ static void parse_cmd_contents(struct batch_options *=
opt,
>  			     struct expand_data *data)
>  {
>  	opt->batch_mode =3D BATCH_MODE_CONTENTS;
> +	data->info.typep =3D &data->type;
>  	batch_one_object(line, output, opt, data);
>  }
>
>
> but there's a slight catch. That expand_data is used for every request,
> not just the current one. In normal --batch mode, every request wants
> the same data (the user-specified format plus the object contents). But
> in command mode, some may be "contents" requests and some may just be
> "info". The code above turns on type-checking for every request, making
> the "info" ones pay to look up the type.

Yes, for example, both 'info' and the 'remote-object-info' series
(marked to 'master' in the last "What's cooking") [1] act on
data->info.typep.

This would make 'info' do a type lookup, and 'remote-object-info'
request "type" even if it wasn't present on the format.

>
> A type lookup isn't all that expensive, but it might matter for some
> formats (e.g., just "%(objectname)" does an existence check and nothing
> else, so we never even access the object data).

Yes, and only the atoms in the format get expanded, a populated type
without its atom in the format won't be shown.
the wasted lookup or a bigger request are the only effect.

>
> I guess saving and restore data->info.typep would work.

Yes I think that too, I tried this and it worked fine:

static void parse_cmd_contents(struct batch_options *opt,
			     const char *line,
			     struct strbuf *output,
			     struct expand_data *data)
{
	enum object_type *saved =3D data->info.typep;

	opt->batch_mode =3D BATCH_MODE_CONTENTS;
	data->info.typep =3D &data->type;
	batch_one_object(line, output, opt, data);
	data->info.typep =3D saved;
}

nit: On the current code the parameters aren't indented correctly.

>
>> I'm not sure what the correct fix is - always request the type in
>> --batch-command, or perhaps only if a "contents" command is issued?
>
> Yeah, in general if you are asking about "contents" I'd expect you to
> get the full name/type/size triple. But it's not wrong to ask for less,
> and certainly we should never hit a BUG(). So I think we'd want a fix
> along the lines above.
>
> Do you want to try your hand at a patch? It would need to do the
> save/restore, and most importantly add a new test to t1006.
>
> -Peff

[1]: https://lore.kernel.org/git/20260724-ps-eric-work-rebase-v21-0-ba67f02=
4fdff@gmail.com/

Hope this helps,
Pablo
