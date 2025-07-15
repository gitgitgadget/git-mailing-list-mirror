Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173BF26B76A
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599981; cv=none; b=D/8Tfx1dJcxURB7lXGZyYCw7XCIrnnhIEZQNR7qeBJ+fSN22Q+pY6ra8A7vLWfwgs9WS0mSnfgwMQrzCGWomhzmnD6HDzC2PFGdoSgJbUDJkoMJ6ohfSfVFIZEVIP5iYqZYoEqI8Wyb+tO0GukP0YbX8AtvNIvxnCDpT9uJDmEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599981; c=relaxed/simple;
	bh=c3t6Cu7stwDGMZFQCAAVWtOgFj1DjBXDK38GxWqmDv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYoHPpJdDrkJYj3G6YWLcZ4xfHfBGcEeYiBlNaZw7WRgVz9L/IOiKj+y1ATogiWsAi6oQi6UrGc1zETxhpE3w6M/7gMsYTjEpU1fgcvPld7gDXrMwrPwDrVM7hQsBfZOUNok0MrqYI+yn9MBv0dZO4ux6/HhTdT29ldHQ2LOhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+4A7Eq9; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+4A7Eq9"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ddda0a8ba2so42885575ab.0
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 10:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752599979; x=1753204779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXaMfScG3LGohqHTIPhow/RRW0gkS4DotZkv3auSecQ=;
        b=U+4A7Eq9qitY1bCwib/3gxbcKP+fW3exgj5LBJ+Ekk1XWYujQST+x/7cXPHbF2dTeC
         XxEOBs3hMyET90f1zW4FhMK67ndg5Y/nO8PVH+ALcNWAs/cfsMlaOyZXf7YbuxQm537c
         uZ0C+7tSengFsFWXiBPyEJvfnTMdujiwL2htV7RsgQ3A5G/S+GV979BMOJIIgpuapFiG
         CXosDCiL7q4Wrhuspfej+zCtwC9Rx3KDnCN/ahYKaHqjuUs2YqczoC41iKYRvuWgy1sE
         Z8aYJP1sx11QY5cCGJOEa5POz4xpUPZpPBjG5VG95pa6vKtea94CHYkjJgdtRxC3LQN4
         IC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752599979; x=1753204779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXaMfScG3LGohqHTIPhow/RRW0gkS4DotZkv3auSecQ=;
        b=YoZhre1Sryyw0auTj6kj4gSK+HIdPHKLBpNjRDrK349Hn3WCogtOcxk6iHRsjADsP1
         m3DQ2A2S2qNUT+LSF+eA2hjVtIE+bVWRjCly6mz9VFcxoNKI04zTViEOp/ErnA8DN6G5
         z3jq42vjP7bTMFuV8kWVWNu+M1Env6VxR4ZrtJbMaO8gEkoiVkILJXNJHmuVupeR4ypg
         Nyd8z0iyGjT7bwmW8vWTOeKVw/UMys8V9d2dU4FmMfWwa/6MACQqe/SKdLd8Wt6FDaas
         ZrIDIsSzZbBPAqmnopXybr5cHZVnmmN8VfNFy9odSgEcY1d2ZVqraJ1SbbZiw07p/Txy
         mUWA==
X-Gm-Message-State: AOJu0Yw5ycwHUKHHId7iVE5N3r/K+2eEv8uYUuhuwHwNtEc8WqQR6efi
	r9Mp5lisO9Fat8IgfTAb2blFRVt6OKxhbUQB4OCt/llsfiAEgy6Llrj6AXqGxJwu63PqkGzzYSl
	6jLgZJJFG99GEBXbiemLpPsABELMuDyo=
X-Gm-Gg: ASbGncuNtB993aA4zIrn4esvUQWv1P4FAUB69kWQwH4+av6dvexrhHdAAMeOZC83UCV
	7NOJqpaNR1qOTxrikNsXrVl1822C8PQxwWB3zWZ8irj0rwFDnWX6rIX8ehMZPHc3H3lJHrZOwie
	r4+y4leOOIYhgSc+px1oMYuyD/e4W3pUx16lI8c6hmlThP+f/FdiITzee1Mw/B1hvjV+RhgxK8I
	AhPTUbpOurBcPif6C6QmPRugISQ1DWtz/k3ceV1Vw==
X-Google-Smtp-Source: AGHT+IEOznv0mqfIEAB59aIIVF+p9PU1KIT3OqNnwHhTT09r+Gu9jtYm+PzBfi+9Z+ROFfQ3kXxzR2BwIZPLVwEvoj0=
X-Received: by 2002:a05:6e02:228c:b0:3df:3bdc:2e49 with SMTP id
 e9e14a558f8ab-3e279201acfmr36040625ab.12.1752599978877; Tue, 15 Jul 2025
 10:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk> <cover.1752587571.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <cover.1752587571.git.phillip.wood@dunelm.org.uk>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 15 Jul 2025 10:19:27 -0700
X-Gm-Features: Ac12FXybBcOFHz2I6Gp3fKbGTVd_GNdQ1T6eHvXcHKjvIlDxTVAWFyib0ypSuvY
Message-ID: <CABPp-BHoTxT1UQtgy2bH=mc1re_LPngKX-50GPh_wbtMMZZpyQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] C99: declare bool experiment a success
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	"Brian M . Carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 6:53=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> We've had a test balloon for C99's bool type since 8277dbe987
> (git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
> 2023-12-16). As it has been over 18 months since this was added and
> there have been no complaints let's declare it a success and convert
> the return type our other string predicates to match.
>
> Thank you to everyone who commented on V1, the only change here is
> to fix the typos in the commit message for patch 2.
>
> Base-Commit: a30f80fde927d70950b3b4d1820813480968fb0d
> Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fuse-c9=
9-bool%2Fv2
> View-Changes-At: https://github.com/phillipwood/git/compare/a30f80fde...6=
69687147
> Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/use-c99-boo=
l/v2
>
>
> Phillip Wood (3):
>   CodingGuildlines: allow the use of bool
>   git-compat-util: convert string predicates to return bool
>   strbuf: convert predicates to return bool
>
>  Documentation/CodingGuidelines |  3 +++
>  git-compat-util.h              | 12 ++++++------
>  strbuf.c                       | 28 ++++++++++++++--------------
>  strbuf.h                       | 12 ++++++------
>  4 files changed, 29 insertions(+), 26 deletions(-)
>
> Range-diff against v1:
> 1:  352f80c49b7 =3D 1:  352f80c49b7 CodingGuildlines: allow the use of bo=
ol
> 2:  a0f9182aa20 ! 2:  0b2402e11cc git-compat-util: convert string predica=
tes to return bool
>     @@ Commit message
>          git-compat-util: convert string predicates to return bool
>
>          Since 8277dbe987 (git-compat-util: convert skip_{prefix,suffix}{=
,_mem}
>     -    to bool, 2023-12-16) a number of our sting predicates have been
>     -    returning bool instead of int. Now we've declared that experimen=
t
>     -    a success lets convert the return type the case independent
>     +    to bool, 2023-12-16) a number of our string predicates have been
>     +    returning bool instead of int. Now that we've declared that expe=
riment
>     +    a success, let's convert the return type of the case-independent
>          skip_iprefix() and skip_iprefix_mem() functions to match the ret=
urn
>     -    type of their case dependent equivalents. Returning bool instead=
 of
>     +    type of their case-dependent equivalents. Returning bool instead=
 of
>          int makes it clear that these functions are predicates.
>
>          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> 3:  7eaf8042061 =3D 3:  66968714739 strbuf: convert predicates to return =
bool
> --
> 2.49.0.897.gfad3eb7d210

This version looks good to me, thanks!
