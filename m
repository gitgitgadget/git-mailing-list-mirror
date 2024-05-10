Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44EB219FF
	for <git@vger.kernel.org>; Fri, 10 May 2024 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715373790; cv=none; b=AdXAtkIbm4kXw/0lqj89vnok2KHfYh9WLbRF+X5dWbj//2vh44Lz66D3GflTYvqV0J2/P319nBWDbelZwDXb0W/yMAFE4z5QxQgnTjFkqLCfDVSRsc0EahmjA/cX3XFT90aDTO19Oi7rojyKo8rzf70GgmCh3Y5D12EP2IJCkuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715373790; c=relaxed/simple;
	bh=tUHvE1Vk2jNDLMC2v30qTCZe4jP7JLs9PhRyc8PAH2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfctyjEgVr3skHIJ5hD9R+k13XAF1XXmCAigxYUy4V7ojf8U47rAcfw+cybk56OV6ohur4YoCzDtNwTFcfGFSOoaHl+8PrvXFSFxj/ZCn6GGwd/qYFxHRAioN+h8PP3Ztb9cAu8sMpU6WzRxz81rarEOVFYLQwAOKA7Ul/xmvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4b4KghNg; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4b4KghNg"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b27bbcb5f0so1065125eaf.3
        for <git@vger.kernel.org>; Fri, 10 May 2024 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715373788; x=1715978588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c72GS15HPV2sb1V20hAVn9BuL/XOXcmkxxsHs+6W5Sc=;
        b=4b4KghNgavZoO/9xOzR95fDn8F1Ih8eu2curIfdlgohj4ufF77HwFSyQ1mtSI0ODzb
         c2NHaYwpJ7IMI7LX3Qe2Sab4mkz29dDlE36sKv+2jNzK6uST5c7IFRdniCaoZbu1EXbV
         3o43YNQFQrE94k7fT7JO6Jcnmx2lfWFQMks0js4IGKFaev26N42VoIQ6+0T9Fjeb//KL
         HMrhmzoCZz6vfcklPsyy/HPIc7P+2CyApWQwnn8Inb3JnUH73+OuUvCO28XR+dHusYni
         jUjsagz4GCmE35usq/rNZJuxVKHtvOhH2s4JiFEOSlFWlyPMxdobcuyMld53KPRkqNK8
         0vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715373788; x=1715978588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c72GS15HPV2sb1V20hAVn9BuL/XOXcmkxxsHs+6W5Sc=;
        b=HF+1KIiu1SJLHXPlouooEY4oc5YCtRgfmlHeA+thl09ymdQ57N5LPUrvPXkmbDt6sv
         zLG7wMKPM/+gqVX2UTRgLetL1ORjPdBUXGP2kJe4RpJS00u0Q0hLXzrIQ095S0UgFtIR
         ytXtSRJUGVyl0wU9eJUOxAs2evHz8mv0nS9JVMllaE7kQReE++LZ21GtO7FvYfUoY87F
         NMxJBY04e9fS7jNQG07JRhxawMU/F79YsHYs0M3iuL1ZLr1Vu7bDjKV+h1EmJMRp8OUw
         osuQOSuSCCmPUszoHzlzl2uxABRJy+o5t6LeweJS8h8EFH4t/jGvERCPBU71C85yaEsM
         gfFw==
X-Gm-Message-State: AOJu0YzM9KMFw79HsHZO/m3+BvL7ZGdT+mPvm0VI5HXsIir++J/fB3Gp
	6Nj852JGJ9EZ6WQfQqXI241BH29TS3okIfCnOFqxubBXkXCQjWmOFAfjZP9Q/IYMtNDjfLW03+/
	f/TjMvlvYCHgsyzPaRzDEc1L0vpobJCRhn4MRViq8St3ncI/GgQ==
X-Google-Smtp-Source: AGHT+IHDBaQRrSX2D7mq15hvWBwZTu0FobjHyhtWK+iQxsum6uXE9Oak20kvrxzrvnwVyPXViJZpFwddBkrWJgfNaZk=
X-Received: by 2002:a4a:5541:0:b0:5b2:7677:4f27 with SMTP id
 006d021491bc7-5b28195ee6fmr3936063eaf.4.1715373787502; Fri, 10 May 2024
 13:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715339393.git.ps@pks.im> <2e308393edb0c34593e78603b43bee8d3a45dd8a.1715339393.git.ps@pks.im>
In-Reply-To: <2e308393edb0c34593e78603b43bee8d3a45dd8a.1715339393.git.ps@pks.im>
From: Kyle Lippincott <spectral@google.com>
Date: Fri, 10 May 2024 13:42:49 -0700
Message-ID: <CAO_smVjXjW6pM-bWbQmCWxVi8LLZ2iB2p6RYhJhtc529cgDxHA@mail.gmail.com>
Subject: Re: [PATCH 05/21] builtin/config: move actions into `cmd_config_actions()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 4:26=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> We only use actions in the legacy mode. Convert them to an enum and move
> them into `cmd_config_actions()` to clearly demonstrate that they are
> not used anywhere else.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/config.c | 44 +++++++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 25 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index e9956574fe..8f3342b593 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -87,30 +87,6 @@ static int show_origin;
>  static int show_scope;
>  static int fixed_value;
>
> -#define ACTION_GET (1<<0)
> -#define ACTION_GET_ALL (1<<1)
> -#define ACTION_GET_REGEXP (1<<2)
> -#define ACTION_REPLACE_ALL (1<<3)
> -#define ACTION_ADD (1<<4)
> -#define ACTION_UNSET (1<<5)
> -#define ACTION_UNSET_ALL (1<<6)
> -#define ACTION_RENAME_SECTION (1<<7)
> -#define ACTION_REMOVE_SECTION (1<<8)
> -#define ACTION_LIST (1<<9)
> -#define ACTION_EDIT (1<<10)
> -#define ACTION_SET (1<<11)
> -#define ACTION_SET_ALL (1<<12)
> -#define ACTION_GET_COLOR (1<<13)
> -#define ACTION_GET_COLORBOOL (1<<14)
> -#define ACTION_GET_URLMATCH (1<<15)
> -
> -/*
> - * The actions "ACTION_LIST | ACTION_GET_*" which may produce more than
> - * one line of output and which should therefore be paged.
> - */

We lost this comment when inlining this. Not sure if that was
intentional (comment deemed to be of low value) or accidental. I think
as someone unfamiliar with this logic that the comment would be
helpful to keep - it describes _why_ those items are checked for (vs.
needing to infer it from the action that's taken when there's a
match).

> -#define PAGING_ACTIONS (ACTION_LIST | ACTION_GET_ALL | \
> -                       ACTION_GET_REGEXP | ACTION_GET_URLMATCH)
> -
>  #define TYPE_BOOL              1
>  #define TYPE_INT               2
>  #define TYPE_BOOL_OR_INT       3
> @@ -1031,6 +1007,24 @@ static int cmd_config_edit(int argc, const char **=
argv, const char *prefix)
>
>  static int cmd_config_actions(int argc, const char **argv, const char *p=
refix)
>  {
> +       enum {
> +               ACTION_GET =3D (1<<0),
> +               ACTION_GET_ALL =3D (1<<1),
> +               ACTION_GET_REGEXP =3D (1<<2),
> +               ACTION_REPLACE_ALL =3D (1<<3),
> +               ACTION_ADD =3D (1<<4),
> +               ACTION_UNSET =3D (1<<5),
> +               ACTION_UNSET_ALL =3D (1<<6),
> +               ACTION_RENAME_SECTION =3D (1<<7),
> +               ACTION_REMOVE_SECTION =3D (1<<8),
> +               ACTION_LIST =3D (1<<9),
> +               ACTION_EDIT =3D (1<<10),
> +               ACTION_SET =3D (1<<11),
> +               ACTION_SET_ALL =3D (1<<12),
> +               ACTION_GET_COLOR =3D (1<<13),
> +               ACTION_GET_COLORBOOL =3D (1<<14),
> +               ACTION_GET_URLMATCH =3D (1<<15),
> +       };
>         const char *comment_arg =3D NULL;
>         int actions =3D 0;
>         struct option opts[] =3D {
> @@ -1147,7 +1141,7 @@ static int cmd_config_actions(int argc, const char =
**argv, const char *prefix)
>
>         comment =3D git_config_prepare_comment_string(comment_arg);
>
> -       if (actions & PAGING_ACTIONS)
> +       if (actions & (ACTION_LIST | ACTION_GET_ALL | ACTION_GET_REGEXP |=
 ACTION_GET_URLMATCH))
>                 setup_auto_pager("config", 1);
>
>         if (actions =3D=3D ACTION_LIST) {
> --
> 2.45.GIT
>
