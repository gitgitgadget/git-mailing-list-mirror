Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EC85FB8E
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848413; cv=none; b=jwFHpqfd4mKoWyv9h/dtTvkyQLlD6SIbg8aj5vpCqOECvxzO41bu6NKPAwSudItO466n8kzBHRPeWEUKfP7J3MOmOAKUWWeSa6YNtpcJ95XEjTaxscJh+uEfgRRP66EEDUbfpERinSVpSek0EDC7soD8DbyV0ZxDGO4HfCQP+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848413; c=relaxed/simple;
	bh=0i8VgStanKrYonl0JfSxNfR4S+uS3BJFUakU4OcX36w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t82aPTB0Xd5U5+xZqgU/pn4LUJM6j8q9+pvDiS7I700Mm0MiDlUUtTjYRXA6AMwnC7kWsrI4+f0rqlbOC7vzYNS5PAjpmDX4OIZ7kmNIQMfjF2dWiYV4qu0s6rWidvkcYujAdSuvZ6TSHUCR1mq9M/QA+Un4GCbMU0rLLuXpcUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qoAmKeaG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qoAmKeaG"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so8453426276.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 10:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707848411; x=1708453211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qx3Lud1jrocfh6HZzr8fF5bBFG8QjfRCMBLoCbQrudE=;
        b=qoAmKeaGYKAZ+PZUbtFOnCzKwOJVlfR28I77gGYAS2z+PSpWbOT6wakTVxuxw1z5kq
         Bawtxr9i5VJgrUL4vrbEsyAXtgvI76Cccc29q7vrzo6soFMKTfLq6tZmRqnkAqOkiPRK
         AMOIRX2FaSeW+hjEldUNPZcvjSgd9tLIbis5k1FGVmjaaCY4EWSEVJhPQz2sEaJz1wI7
         YeLn8hDjmTEl9tp+F1w+MPVWIOF6VpHdyhb0m6yqKg4CRbBcvxn44QB96OuU7SeWmh6z
         0XW1gnnre9piCX2sy+TxPjH6JNLKnj3CYg4wwAl4vdpqLlxPgQR6HyHLVR9Fx2SzCVDZ
         urGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707848411; x=1708453211;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qx3Lud1jrocfh6HZzr8fF5bBFG8QjfRCMBLoCbQrudE=;
        b=iGVU80Rmbe2iD4kD7VVMBWInK3z4rK2c3I/gpe2SX01p7uus2mBNOol5teuCR0IF6i
         cK2HX/zxmu8ZvXogBq5pxqcRKW1caJmD8J4a0PflpLuNy6N/plRS95fxTrnAk/we9FVE
         TxM+qBVX4QEFtQT7yhQ/CjfWRgDHxmqadSJ/mI1BbCqxoRDdg59See1yucrXhxw7IoUo
         mzEjvjvSLo1dyewXroLtunCxiwB4Z+JF5cG1Hgb59yl8iSLmVrlkOikzvcBJdxaeyAas
         PXFlL+3i9MaDzNQ39flEgq48CM/tbETRrC6u4TqZZksBIWSoQfCZ8Bu6dbtkvPCdKRPP
         Da5Q==
X-Gm-Message-State: AOJu0YxtbboYnP/c4En/VkWAF9tfPs3LEi1+cOzEk/RN164zMe8sk+0W
	sL9FRnUwol4lX4WQLm7TfRYiE2gzat9Y9iPtUEGinXzqIHlqhZEVYU1SuRwnmN+yb0Qisn5TfyP
	B7g==
X-Google-Smtp-Source: AGHT+IHrAGodxirEEWwp5eKX99QAHCsGrLTpNYgtm6Sqbur8ev4ODTpb3C1KoUPNb1OfxO5M/Bdp+W3mgaw=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1102:b0:dc6:d3c0:ebe0 with SMTP id
 o2-20020a056902110200b00dc6d3c0ebe0mr24344ybu.0.1707848411179; Tue, 13 Feb
 2024 10:20:11 -0800 (PST)
Date: Tue, 13 Feb 2024 10:20:09 -0800
In-Reply-To: <CAP8UFD01SPF8bqAb2Kn-q7SfX9cYiU_tpDSZz1CnEFbUqQpXYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <14927038d855020f9ae7594ad5cc646257613cc1.1707196348.git.gitgitgadget@gmail.com>
 <CAP8UFD01SPF8bqAb2Kn-q7SfX9cYiU_tpDSZz1CnEFbUqQpXYA@mail.gmail.com>
Message-ID: <owly1q9gb50m.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 28/28] trailer: introduce "template" term for readability
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git <git@vger.kernel.org>, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Linus Arver <linusa@google.com>
>>
>> The term "arg_item" is ambiguous because we use it to hold data for
>>
>>   (1) trailers specified as command line arguments (in
>>       builtin/interpret-trailers.c), and
>>
>>   (2) trailers specified in configuration,
>>
>> and these are both used to ultimately insert new trailers (based
>> on the contents of arg_item, acting as a kind of template) into some
>> other set of existing trailers (such as those found in a trailer block
>> inside a log message) that have already been parsed.
>>
>> Rename "arg_item" to "trailer_template". This necessitates further
>> renames to make the functions that act on these templates match the data
>> structures (parameters) they act on:
>>
>>   - [*] add_arg_to_input_list()      to apply_template_to_trailers()
>>   - [*] apply_arg_if_exists()        to maybe_add_if_exists()
>>   - [*] apply_arg_if_missing()       to maybe_add_if_missing()
>>   -     apply_command()              to run_command_from_template()
>>   - [*] apply_item_command()         to populate_template_value()
>>   -     free_arg_item()              to free_template() (non-API functio=
n)
>>   -     free_new_trailers()          to free_trailer_templates() (API fu=
nction)
>>   -     get_conf_item()              to get_or_add_template_by()
>>   -     option_parse_trailer()       to option_parse_trailer_template()
>>   -     parse_trailers_from_config() to parse_trailer_templates_from_con=
fig()
>>   - [*] process_trailers_lists()     to apply_trailer_templates()
>>   -     token_from_item()            to token_from_template()
>>   -     token_matches_item           to token_matches_template
>>   - [*] trailer_add_arg_item()       to add_trailer_template()
>>   -     trailer_from_arg()           to trailer_from()
>>   - [*] check_if_different()         (reorder parameters only)
>>   - [*] find_same_and_apply_arg()    (reorder parameters only)
>>
>> Reorder parameters to prefer input parameters toward the beginning and
>> out parameters at the end; these functions have been marked with an
>> asterisk ([*]).
>
> That's a lot of changes in a single patch.

I confess I was not happy with the volume of the change either. I
suppose I could break things down into renames vs parameter reorderings.
Will update.

>> This removes the "arg" terminology (standing for "CLI arguments") from
>> the trailer implementation, which makes sense because trailers
>> themselves have nothing to do with CLI argument handling.
>>
>> Also note that these renames expose the previously liberal use of
>> "trailer" to mean both trailers we read from the input text (trailer
>> block) and trailer templates that are defined as CLI args or
>> configurations. Some functions implied a single action when they could
>> do two different things, so introduce words like "maybe" and "or" to
>> make their behavior more explicit.
>>
>> In summary this patch renames and reorders parameters for readability,
>> without any behavioral change. We don't rename
>> find_same_and_apply_arg(), because it will be refactored soon.
>>
>> For parse_trailers_from_config() (renamed to
>> parse_trailer_templates_from_config()), add a NEEDSWORK discussion about
>> how the deprecated trailer.*.command configuration option is oddly more
>> featureful than trailer.*.cmd (if we were to remove support for
>> trailer.*.command, users would not be able to replicate the behavior
>> with trailer.*.cmd and would lose out on functionality).
>
> This change could be in a separate patch. Also there were discussions
> when trailer.*.command was deprecated and trailer.*.cmd introduced. I
> think it might be useful to talk about them in the commit message of
> the separate patch introducing the NEEDSWORK.

Will do (will reference the commit that introduced trailer.*.cmd also),
thanks.
