Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E704F895
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781217; cv=none; b=WRyJSutBjadIht7RR0qQkm2XAEMkVPqlBz+vkuUBsk8jplss+LxlCPZ88OPmib4BU4WpbXalOUOn0kstuWSkPRRulxDXinVuVAsY7S632JVz7qMKfOo3wLvxRtBfcUXm3u5nFEKRjlP3zxN2FrX7uifYSZlaEa44kLgYUblBsJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781217; c=relaxed/simple;
	bh=llRJwMRdluFHuJ/pm6XIrAfiCO22eCDrL/60OFmd/2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oqy/ZBlW8pKBIHLYbUSMRePL6gGHpJaQjpzb7SvgacHjIyv359kjLpa6tKLYV4erFV4In2Ve4JJYRaldquAEZIFEADYj/UXMlafyC3gbA/qUMMMr1MnWf5Jj0wQ45MW+0OeULW2/IqEdwN+bnKat39G5GT/RZweHbf/w4eXVZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2/DWCaP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2/DWCaP"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so5054666a12.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 15:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781214; x=1708386014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILg3RIcj3IfRktLAkd6H/zEuhl/s5yr3AOWC56hG2JM=;
        b=k2/DWCaPgk6w+HVPCT/RPtf7+fyOjbchiJNoCZdoQy77mb+lkEEc2LmVB74ZuSBzLb
         iV9JVauE8B0dCsIA2W5i82FZfhUE1XAxLvkP5LRgR+QwKW+T7LMxUUihgMtVXkpKSQpf
         GkkAp/G+/N9PBHAwmYCVDjQyDqI+yBSeNjjJXBVpew9aJg8PDV/Ek7U9tqzCjF31SAtD
         7xY5n20owyPvvz1RQB+BnKysqj/PTZz6Fu9A1dzTJUs4LTxeHetjbEIkJFalgGixU6Ce
         QpnZCifkG1NcQ8geAwLRv0s28ESdHLk1rMlk5JaESC3Um/08P+a9IlE5aoy/2Erh1VjX
         Ydlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781214; x=1708386014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILg3RIcj3IfRktLAkd6H/zEuhl/s5yr3AOWC56hG2JM=;
        b=Ijag8cbk0UKDelC6zOdXjc8JQg7JhU/9psFXOmIp5gmxx42k+f7SLGYu2DP7cIPiGa
         2QUsymGmA6B44xPNJhPNrKGymJxk4Roz0JlklqPZBOPiGglsnEmPT8qV0zDsuq/pAzMM
         oMqf3BBkbvjcrlqx+x7WVajThuJzlCoZC+evO1GucO2SjJUf4KZQLjWdrGyjBRtHhnn1
         d9kyk0+ZPNX8peHJXpSKjFD7TLWO4jAIeVHppF/fn0lwQ53CJmtaNX93+rNVUA3P+AmY
         /u/F4H8uvQv9s3eMC0qxsrXqPYuHtfbZFcfclLozajMDc0mG8XtApL5ZGAzYtpvU/kI4
         zctA==
X-Gm-Message-State: AOJu0YzMD4QwVHRcw3Y1bDYIeBERus+XEu6B1Z9Xka65m91OlHQDEdyU
	yOFckGWXOHsBJkOtBRdbHJKQVcFKjWfvOMRLYUwiBV3JN+pSmrAsMyPLAEDpC8eay+kjyAnvVqC
	tMqysHFgviwEL0u6q1n9Fk8ZWgiw=
X-Google-Smtp-Source: AGHT+IFPLfJPSLOz/khofy9uropf8JLvstLIDyo1NigqAUM2lHFA6KmQeDBMaiRjhzv7DkVDWVboWism0OKFmq8hq60=
X-Received: by 2002:a17:906:4f17:b0:a3c:e54d:301 with SMTP id
 t23-20020a1709064f1700b00a3ce54d0301mr859155eju.2.1707781214190; Mon, 12 Feb
 2024 15:40:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <14927038d855020f9ae7594ad5cc646257613cc1.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <14927038d855020f9ae7594ad5cc646257613cc1.1707196348.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 00:40:02 +0100
Message-ID: <CAP8UFD01SPF8bqAb2Kn-q7SfX9cYiU_tpDSZz1CnEFbUqQpXYA@mail.gmail.com>
Subject: Re: [PATCH v4 28/28] trailer: introduce "template" term for readability
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git <git@vger.kernel.org>, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Linus Arver <linusa@google.com>
>
> The term "arg_item" is ambiguous because we use it to hold data for
>
>   (1) trailers specified as command line arguments (in
>       builtin/interpret-trailers.c), and
>
>   (2) trailers specified in configuration,
>
> and these are both used to ultimately insert new trailers (based
> on the contents of arg_item, acting as a kind of template) into some
> other set of existing trailers (such as those found in a trailer block
> inside a log message) that have already been parsed.
>
> Rename "arg_item" to "trailer_template". This necessitates further
> renames to make the functions that act on these templates match the data
> structures (parameters) they act on:
>
>   - [*] add_arg_to_input_list()      to apply_template_to_trailers()
>   - [*] apply_arg_if_exists()        to maybe_add_if_exists()
>   - [*] apply_arg_if_missing()       to maybe_add_if_missing()
>   -     apply_command()              to run_command_from_template()
>   - [*] apply_item_command()         to populate_template_value()
>   -     free_arg_item()              to free_template() (non-API function=
)
>   -     free_new_trailers()          to free_trailer_templates() (API fun=
ction)
>   -     get_conf_item()              to get_or_add_template_by()
>   -     option_parse_trailer()       to option_parse_trailer_template()
>   -     parse_trailers_from_config() to parse_trailer_templates_from_conf=
ig()
>   - [*] process_trailers_lists()     to apply_trailer_templates()
>   -     token_from_item()            to token_from_template()
>   -     token_matches_item           to token_matches_template
>   - [*] trailer_add_arg_item()       to add_trailer_template()
>   -     trailer_from_arg()           to trailer_from()
>   - [*] check_if_different()         (reorder parameters only)
>   - [*] find_same_and_apply_arg()    (reorder parameters only)
>
> Reorder parameters to prefer input parameters toward the beginning and
> out parameters at the end; these functions have been marked with an
> asterisk ([*]).

That's a lot of changes in a single patch.

> This removes the "arg" terminology (standing for "CLI arguments") from
> the trailer implementation, which makes sense because trailers
> themselves have nothing to do with CLI argument handling.
>
> Also note that these renames expose the previously liberal use of
> "trailer" to mean both trailers we read from the input text (trailer
> block) and trailer templates that are defined as CLI args or
> configurations. Some functions implied a single action when they could
> do two different things, so introduce words like "maybe" and "or" to
> make their behavior more explicit.
>
> In summary this patch renames and reorders parameters for readability,
> without any behavioral change. We don't rename
> find_same_and_apply_arg(), because it will be refactored soon.
>
> For parse_trailers_from_config() (renamed to
> parse_trailer_templates_from_config()), add a NEEDSWORK discussion about
> how the deprecated trailer.*.command configuration option is oddly more
> featureful than trailer.*.cmd (if we were to remove support for
> trailer.*.command, users would not be able to replicate the behavior
> with trailer.*.cmd and would lose out on functionality).

This change could be in a separate patch. Also there were discussions
when trailer.*.command was deprecated and trailer.*.cmd introduced. I
think it might be useful to talk about them in the commit message of
the separate patch introducing the NEEDSWORK.
