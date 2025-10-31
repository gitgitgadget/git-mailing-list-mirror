Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EDC2222A0
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761936696; cv=none; b=ckBfrzhe9iqSCSGeKBu/8obv1xX2AkmRVG3x9EN71UG/uvVv1YRoFkLkZkKidjSwGhn7mCajrt8Rh6OxAQR8QxreJDWhfTgXKVdulOaLFLoFNR5pd0oza4pml7WxcXn30FuR8JvkOMmy+fNf/pUfHU1IZw6myR48PhC4Q85a7MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761936696; c=relaxed/simple;
	bh=io7BXZHSxQ/UixkVWx0wLoHO87VFUkMpehhhL3nKPeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0aeEDND3V0fn4IrjlfuucB+Ng/VRsD/NDMvNB7Msf+bfWSRUEjsu87bSM0gAkZc5mwdUs4QUBqqKmwFI4K+4zvBrKX2fw4ektgfJDBb09v+RZnbZ3nN1WcbQGLAbOKO1xP8peIskHYb5xrdlKLFQvNJbOgpI/PQj5jG/FLVq+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIt5LjSn; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIt5LjSn"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-945a2c8e52cso112094439f.3
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761936692; x=1762541492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OScvylFpQHLMHQerYqZHXfruaRzQTe9haCC88p5RC28=;
        b=KIt5LjSnSlc5I6N58R7FySFG1S8sLaaLuOEp6drHQtO3OEsPbUTlP61JltnxICie1X
         FHfLssFSgRqK3cvChhF1zvSnlGHP/P13IrWlaiaRWEpJzAplu7UD14LwWYeJ/1l5ZEIs
         xcJn7SahHOfltXkTht5vX1qbCiCoA1YPs9xRqojcuNdMaj1N4XfyrIDoRm6EfyjZpZvg
         Qlb37O5a9ERIIzph4QnH0omogaMk2+K0bLy0/zfpfx18NXiKjm0wEjp527P7kcDBFnQU
         1E4bYPs82LvyRqdnhQXv6/6PxhSxlZmgetZmQcaF7xBPyLiC/XWNez9668GjYk4uSEWc
         cXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761936692; x=1762541492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OScvylFpQHLMHQerYqZHXfruaRzQTe9haCC88p5RC28=;
        b=GBJRaUoUWV4utljtjsDbWUM8zFzDmzVvQRAvhdSyjkM40OJmM51yKJiy88TNEkjFQi
         JvjLGSyjtg8OuYrnSRB1vThlZ6glzNcGyVogxYEB8XH463dZdbps/1rEaMrYrpiZQDug
         floFEAur94tyg3kIfonv0wrc0Ux4QwXFmQxmlliCc7yj/YyRHuiuGAvAkCXHVNuK2/M5
         kNjTDHk31s4pdqCj9SsKP/pakR2iQO1kqc/++vvoyB8RI7+r+HHMilaC1Dcah30IIqBH
         d7awTj26vtXiGRpfWEIh2cgyii18K2gdDh9EbmeFbDmkgAuh+8JL3RXvfb4GcFvz/hOc
         zAFQ==
X-Gm-Message-State: AOJu0YwxtJOSTaK0Uh8oL2QfJwbxRNm0lX6kGXlIorenMxwvvYDj+H50
	4jGeKckeGNsfLipomK+3DbfcCY3HdD7U6U5JdskCKaKAZ677ZD4s8Ga9XoYr7hTYBxFQhGk4jsl
	6mMvULAfABgaaYaeQ02QRZFINEmkOLy0=
X-Gm-Gg: ASbGncuZ7xbysQxSpao6OaqzJgpphkHby8Ji91HVtjmDDkBwMxgYmQU+Pgd6hWcKV1T
	bHAGklpe/9/TEHoUuYF4SrqDoR7MFFpKNuafLfInE+yXU5iR00i2EljmV7qXnkDBMJwbs4Xvmkt
	NRIuAz032KZcLRCkf/XzUIuBZby+YDYOEeSw4gHbEFirBRZJxHHzBiQwpFs+1c7rIkgWWWX+xCv
	QudD6i/PYfIqQ+uzjl9Rsgij8LTQ4DB693dZ8fCgB3yvB6fpebQqN7N+FGRhz26ud/f65uSYxwz
	iq/9FT+w5f4vud0V
X-Google-Smtp-Source: AGHT+IEX7kpGqHFEHRJtg+FtyLGHzBeGf6KEbuzcXkH73rYWmeAIFvz9b66nb7pV/matoTQonEJo7Bv0QqdIi0tMq/c=
X-Received: by 2002:a05:6602:27c9:b0:945:bad2:28a1 with SMTP id
 ca18e2360f4ac-9482293d855mr688939039f.5.1761936692388; Fri, 31 Oct 2025
 11:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028214609.10041-1-siddharthasthana31@gmail.com> <20251030191931.30837-1-siddharthasthana31@gmail.com>
In-Reply-To: <20251030191931.30837-1-siddharthasthana31@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 31 Oct 2025 11:51:21 -0700
X-Gm-Features: AWmQ_bnV6Lj8KB3Oo5RAScaNc9ZPVGoMGFRAfweP3xDk8nrOQEvgFiIsrJvSGlw
Message-ID: <CABPp-BE9wyPpmPoufVPAK94hjvZ5UMFe5CV0RhKY8pyPCxL3MQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] replay: make atomic ref updates the default
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, phillip.wood123@gmail.com, 
	phillip.wood@dunelm.org.uk, gitster@pobox.com, ps@pks.im, 
	karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com, 
	jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:19=E2=80=AFPM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> This is v6 of the git-replay atomic updates series.
>
> This version addresses Christian's feedback from v5 regarding code
> consistency and test patterns. Thanks to Christian, Junio, Phillip,
> Elijah, Patrick, and Karthik for the thorough reviews.
>
> ## Changes in v6
>
> **Fixed parameter naming inconsistency**
>
> Christian pointed out that parse_ref_action_mode() used `mode_str` as the
> parameter name while the rest of the code used `ref_action`. Changed to
> use `ref_action` consistently throughout for better code readability.
>
> **Improved test cleanup pattern**
>
> Replaced manual `git config --unset` with `test_when_finished` pattern wi=
th
> `test_config` helper in the replay.refAction config test. The test_config
> helper automatically handles cleanup via test_when_finished, providing
> better test isolation and following Git test suite best practices.
>
> These are code quality improvements that don't change functionality but
> make the code more consistent with Git's established patterns.
>
> ## Technical Implementation
>
> Same as v5, using Git's ref transaction API:
>
> - ref_store_transaction_begin() with default atomic behavior
> - ref_transaction_update() to stage each update
> - ref_transaction_commit() for atomic application
>
> The helper functions provide clean separation:
>
> - parse_ref_action_mode(): Validates strings and converts to enum
> - get_ref_action_mode(): Implements command-line > config > default prece=
dence
> - handle_ref_update(): Uses type-safe enum with switch statement
>
> Config reading uses repo_config_get_string_tmp() for simplicity while
> maintaining proper precedence behavior.
>
> ## Testing
>
> All tests pass:
>
> - t3650-replay-basics.sh (20 tests pass)
> - Config tests now use test_config for automatic cleanup
> - Atomic behavior tests verify direct ref updates
> - Backward compatibility maintained for pipeline workflow
>
> CI results: https://gitlab.com/gitlab-org/git/-/pipelines/2130504045
>
> Siddharth Asthana (3):
>   replay: use die_for_incompatible_opt2() for option validation
>   replay: make atomic ref updates the default behavior
>   replay: add replay.refAction config option
>
>  Documentation/config/replay.adoc |  11 +++
>  Documentation/git-replay.adoc    |  65 +++++++++++------
>  builtin/replay.c                 | 121 +++++++++++++++++++++++++++----
>  t/t3650-replay-basics.sh         |  90 +++++++++++++++++++++--
>  4 files changed, 244 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/config/replay.adoc
>
> Range-diff against v5:
> 1:  3e27d07d3b =3D 1:  1f0fad0cac replay: use die_for_incompatible_opt2()=
 for option validation
> 2:  643d9ca86a =3D 2:  bfc6188234 replay: make atomic ref updates the def=
ault behavior
> 3:  334da71911 ! 3:  6b2a44c72c replay: add replay.refAction config optio=
n
>     @@ Metadata
>      Author: Siddharth Asthana <siddharthasthana31@gmail.com>
>
>       ## Commit message ##
>          replay: add replay.refAction config option
>
>          [Commit message unchanged]
>
>       ## builtin/replay.c ##
>      @@ builtin/replay.c: static struct commit *pick_regular_commit
>         return create_commit(repo, result->tree, pickme, replayed_base);
>       }
>
>     -+static enum ref_action_mode parse_ref_action_mode(const char *mode_=
str, const char *source)
>     ++static enum ref_action_mode parse_ref_action_mode(const char *ref_a=
ction, const char *source)
>      +{
>     -+  if (!mode_str || !strcmp(mode_str, "update"))
>     ++  if (!ref_action || !strcmp(ref_action, "update"))
>      +          return REF_ACTION_UPDATE;
>     -+  if (!strcmp(mode_str, "print"))
>     ++  if (!strcmp(ref_action, "print"))
>      +          return REF_ACTION_PRINT;
>     -+  die(_("invalid %s value: '%s'"), source, mode_str);
>     ++  die(_("invalid %s value: '%s'"), source, ref_action);
>      +}
>      +
>      +static enum ref_action_mode get_ref_action_mode(struct repository *=
repo, const char *ref_action_str)
>
>       ## t/t3650-replay-basics.sh ##
>      @@ t/t3650-replay-basics.sh
>      +test_expect_success 'replay.refAction config option' '
>      +  START=3D$(git rev-parse topic2) &&
>      +  test_when_finished "git branch -f topic2 $START" &&
>     -+  test_when_finished "git config --unset replay.refAction || true" =
&&
>      +
>     -+  git config replay.refAction print &&
>     ++  test_config replay.refAction print &&
>      +  git replay --onto main topic1..topic2 >output &&
>      +  test_line_count =3D 1 output &&
>      +  test_grep "^update refs/heads/topic2 " output &&
>      +
>      +  git branch -f topic2 $START &&
>     -+  git config replay.refAction update &&
>     ++  test_config replay.refAction update &&
>      +  git replay --onto main topic1..topic2 >output &&
>
>      +test_expect_success 'command-line --ref-action overrides config' '
> --
> 2.51.0
>
> base-commit: 57da342c78d8bf00259d2b720292e5b3035dadcc

This series is getting into shape nicely.  There are a few things that
need to be fixed up on patches 2 & 3 that I called out (including what
looks like some fixes that were accidentally squashed into the wrong
patch), but those should be pretty easy and then the series will be
ready to merge down.  Thanks for working on this!
