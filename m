Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0014988B
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbc649c275so508395b6e.0
        for <git@vger.kernel.org>; Wed, 27 Dec 2023 14:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703716172; x=1704320972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YW4TtleCuJ6U06+gKeQFgMTpYOFBkV61kPQmd6apYH8=;
        b=i11SueiWLHvy2iUyeuWNYK11bDLzY4n+zgr2sysqdnAy+iuPPgIVdSnYjvkbLBWuef
         YVmGQYsru6ddNKgRBED+DUMpIywwJ6NqUpTSg8/edV4VblQI5OmeM31TK6Bf5SxWqYag
         VvmuTfpKCF7AIdUuWkGHMdXivHDEJTZFbN7lv69OXLvDS8/zlAcSLHVMZ4B6WBumAIGv
         4ucAkX/0Txl7ToeFW9R8By2wbPd2wZdzACaoZ8MF/YqACKiAK1bXfJZTN0XC1O56VGvh
         h/OXD0pEZbPGRNsWgg7tX3Wsw9IXfghnrDPYoc8no7Eg1T1IlVQ+UFe9gRiWosEetGiz
         lSTQ==
X-Gm-Message-State: AOJu0YwRDLSdripUIXugyXke9TuFb4ob/FmAJFCzbQzPAGHEqhrC3uHA
	tDciI4k85M5qzTbCAc2hD2LsNDv5wBuKBVPes20=
X-Google-Smtp-Source: AGHT+IEe4jbbw8qHIdtOkQunTuzqNnDiy52UfKQvf7a/Sxt+kz6WY52G0cpmKch2eb7++s5hYVYk980S12Fkb5qDTQ0=
X-Received: by 2002:a05:6808:2383:b0:3ba:1080:f8db with SMTP id
 bp3-20020a056808238300b003ba1080f8dbmr5003754oib.55.1703716171834; Wed, 27
 Dec 2023 14:29:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227205340.9886-1-britton.kerin@gmail.com> <3d46bca1-96d4-43ba-a912-1f7c76942287@smtp-relay.sendinblue.com>
In-Reply-To: <3d46bca1-96d4-43ba-a912-1f7c76942287@smtp-relay.sendinblue.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 27 Dec 2023 17:29:20 -0500
Message-ID: <CAPig+cShsSSd-jpvSW_sq3-R++zjtHU-m2PmTsz-Nx9YVRStug@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: use singular form of repeatable path arg
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Britton L Kerin <britton.kergin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 3:55=E2=80=AFPM Britton Leo Kerin
<britton.kerin@gmail.com> wrote:
> This is more correct because the <path>... doc syntax already indicates
> that the arg is "array-type".  It's how other tools do it.  Finally, the
> later document text mentions 'path' arguments, while it doesn't mention
> 'paths'.

Yep, makes sense.

> Signed-off-by: Britton L Kerin <britton.kergin@gmail.com>
> ---
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> @@ -17,7 +17,7 @@ The command takes various subcommands, and different op=
tions depending
>   git bisect start [--term-(new|bad)=3D<term-new> --term-(old|good)=3D<te=
rm-old>]
> -                 [--no-checkout] [--first-parent] [<bad> [<good>...]] [-=
-] [<paths>...]
> +                 [--no-checkout] [--first-parent] [<bad> [<good>...]] [-=
-] [<path>...]

Looking good.

In builtin/bisect.c, the "usage" string says "[<pathspec>...]" rather
than "[<path>...]". Perhaps it makes sense to unify these?

Also, there are a few more documentation files that could use the
"<paths>" to "<path>..." fixup (though not always in the synopsis). A
'grep' indicates that git-checkout.txt, git-diff.txt, and
git-rev-list-options.txt also mention "<paths>". Those may be outside
the scope of this patch, although they could easily be included, as
well, or made part of a patch series if you feel inclined.
