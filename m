Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1C827F727
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540509; cv=none; b=tfP6351B3GNB7PzGN0jsDPGf5LpvIVwDJSRuiKdq8YsuHEM1A6QjDL8pGVnKhKBkxQsXvi5xlMYXGdHrZKKwarSqLZ5a7OND93xquibpYa5HWXVCFKuGRo6iOqKwf9bwx9h1idy0kSQa2eKbpdyOM/IIWKYSLRzFHoxWy0Za7xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540509; c=relaxed/simple;
	bh=CfPIOxWBCZTH6SpytpEO5BUl0kW4wVhdq3dFZ7asfRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSwHh/58XYlFOZ4NsQta5rXl9ONUZ9MUUj7L1EhIMxYEG6Nrr8s223kL8LGxKHLDaTEOv414tL6dQo2eaQYXexldlzLWjOf6oA1egthXjKwE5DOYkkqMw2FW4SEbt5Jxma+spSns9F5IK9kcMf/nk0FZv/m+c1aTiyjVOTEF20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gnc0mtf3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gnc0mtf3"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b54f55a290cso950305266b.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 08:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760540505; x=1761145305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAVKXTqIV1MJqW5OrxVE5Glylsv5tLaMXW0nxihI19E=;
        b=Gnc0mtf3bqSPVEUykH5qmjKd3BRih/qsmtoqMoLFym4WHymFyo7B6FykqRqlIZnq3L
         Fvc6ORfnLI3UzZB/MBGEZOiT14dmltalv6P4LdsMBcGfMGEcSf9xTNQiqSWOX3XXW9tY
         L1fEMjUo19lj+oFaUZVQBTTGWpnwjcx+6yFdTAlxQTuOz3BEr8Bavl1Rtw1kfokQW4cW
         fG77Ted/wZRW6jy/nUBsABHbIIKt4HZeu809OmrRih0ZmcCgdNcOnJ7OUjlosZjLudA3
         j1XHiFG48RYWWxkbd4yQZSCnozufrd5kv4JVwZ36kYKx7mG6AJQJPq19PhdRxbVATEpB
         RlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760540505; x=1761145305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAVKXTqIV1MJqW5OrxVE5Glylsv5tLaMXW0nxihI19E=;
        b=ibAk0nHTVry/tG+E+eZnuGu+1eMf5P/h6a5xxcVUy7662+rMRVdClBhCvuwjuxeE8H
         UCgdd1svbZ+QwOBmx3xE7oHnnGyIr0AE6++kO0NvYPNDAk7c6Ve8j19g+b/CV6thiIH7
         f7ThvfXbF8PI3CnhxBRcNDPVtyrAvOfnZ+KsgUxrJLj2PfVkQscMRgykcOzEDOIxyXgd
         n5k2+pIgldMPhPejwSkOkXMp7TAlT75gzbhgRlyphPURWteErf5rqJUdVl6MHuD+5Ou5
         SrGof7NspopR4OPTm2GIdm2UxWzmof/nwMnvjXORwlioHQinMTx1pzPcyqqB/zUPrNXL
         0U3Q==
X-Gm-Message-State: AOJu0YyHEh4nyW9m0rj28m8w9/UeCEZJ3RHus+CtDmsnJ1CzcCkYlcpM
	SK+tqjCqiUMh1y7NquyEs1v2svwaohSR+P+2/mn/2b+WSpdUuUNYUKJLWcxBl7YPwXetOoV+p95
	97WACT0uaAIE7NBL/t0DDYugYZySlVS0=
X-Gm-Gg: ASbGncsTrATuDgQDZVo57BjYouU2HUqlwOMnEtqdea3v9fHPc3VzUgiC+9dtah2Yo2D
	ylpesroHj+Pa/P5e8zBFanRfRqibc5UeKYobhbxZX59CiGltL2Pdw9kPLlmvT2+Ou4KbVuigh4L
	AeSQb/PWEWMPFWQV7RYr7FeQ8i3qC65HJgeGyk/Lf5D49v45FU5qNd22Yyqoqk7Efgc3+w2Oe6E
	hHoKT8TGW9Ou1b9Q9XAh1L1XTvcow0iqv0F
X-Google-Smtp-Source: AGHT+IFJ9utsEuU7RDveiBx0Du+RO2gGAmoyLBkT1AT4ojDZC0v/cNLzW9Nzsd+ZMpeU2ObqsWCiCVm6qxzwjakbtlw=
X-Received: by 2002:a17:907:2d8a:b0:b3f:9b9c:d49e with SMTP id
 a640c23a62f3a-b50acc1a540mr3128051066b.57.1760540503591; Wed, 15 Oct 2025
 08:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760490943.git.belkid98@gmail.com> <aea3b80a8883c4dac4e05defdee3eb82b83fe8c9.1760490943.git.belkid98@gmail.com>
In-Reply-To: <aea3b80a8883c4dac4e05defdee3eb82b83fe8c9.1760490943.git.belkid98@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 15 Oct 2025 17:01:30 +0200
X-Gm-Features: AS18NWCgB4JED-sAC0dv644__oKegahipynXo1jQcrYlROn99DK5Qt-m_5EKa3s
Message-ID: <CAP8UFD1U07T8_nX+sSL6ZHhCQsQuy5PwfQfbHC5piC5W5T=7Cw@mail.gmail.com>
Subject: Re: [PATCH 1/2] [Outreachy] gpg-interface: replace strbuf_split with string_list_split
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 4:19=E2=80=AFAM Olamide Caleb Bello <belkid98@gmail=
.com> wrote:
>
> get_ssh_finger_print() accepts a signing key and then uses pipe_command

"pipe_command" is a function too so it's better to use "()" when
talking about it like in "get_ssh_finger_print()".

In the commit message subject, if it doesn't make it too long, I think
it might be better to also use "()" when talking about functions.

> to execute the ssh-keygen command, gets its output and sets it in
> fingerprint_stdout.

Anyway I am not sure we need so many details about what
get_ssh_finger_print() does before the split.

Maybe saying something like the following is enough:

"In get_ssh_finger_print(), the output of the `ssh-keygen` command is
put into `fingerprint_stdout`."

> The string in fingerprint_stdout is then split into 3 strbufs using
> strbuf_split_max(), however they are not modified after the split thereby
> not making use of the strbuf API as the fingerprint token is merely
> returned, hence they do not need to be strbufs.

It might be interesting to say that the fingerprint token is returned
as a `char *` not a strbuf.

> Use string_list_split instead for simplicity.

Here also using "()" could make it clearer that "string_list_split" is
a function.

> Note that strbuf_split_max uses 3 to specify the number of tokens to

Here also using "()" could help a bit.

> extract from the string, while string_list_split uses 2 because it specif=
ies

Here also using "()" could help a bit.

> the number of times the split will be done on the string, so 2 gives 3 to=
kens
> as it is in the initial instance.

Maybe: s/initial/original/

> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>

[...]

> @@ -845,13 +846,12 @@ static char *get_ssh_key_fingerprint(const char *si=
gning_key)
>                 die_errno(_("failed to get the ssh fingerprint for key '%=
s'"),
>                           signing_key);
>
> -       fingerprint =3D strbuf_split_max(&fingerprint_stdout, ' ', 3);
> -       if (!fingerprint[1])
> +       if (string_list_split(&split, fingerprint_stdout.buf, " ", 2) <=
=3D 1)

According to its doc, string_list_split() returns the the number of
substrings appended to the list. And you said in the commit message
that it should give 3 tokens, so I think the above line should be:

if (string_list_split(&split, fingerprint_stdout.buf, " ", 2) < 3)

or even:

if (string_list_split(&split, fingerprint_stdout.buf, " ", 2) !=3D 3)

>                 die_errno(_("failed to get the ssh fingerprint for key '%=
s'"),
>                           signing_key);

Except for the above points, your patch look good to me. Thanks.
