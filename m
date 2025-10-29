Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C601134845C
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753085; cv=none; b=NFYKupwgpGTjBjzQH7QweRd9HiFLOHI1sKj+Ldp+r+p93c9cOgUYKRZMJ82Amexs+fHN9iYMaoXEOqdoASYXa46mIZg+Awm25mE4TLk/sT43l4wHAFAK6FdOriZasgKh+BwqC5N+Z8Oykkcp6UNXaEEn41ST4CFMiiYBia0qgwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753085; c=relaxed/simple;
	bh=9m2SqvLiKwNJ+Mgyv7PxG5KYC1LGWswkcGl/sO4yJeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ppe4qMNS7lcCBlOFSkKa1woXOPbCion0K4ow4OlZ0UVFrjlJeMWqeNMdX9WnNyqKkGipKCl7M4dkFCJNEAkhPWd0+tbl/84PMWH7uIWIAeUBnvPKqTbGtiIxdUjg1y/r8okbFJVh2zpngRH1ClUCYKfrKYuN/2tOsz8ZSARjfVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT+0e47B; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT+0e47B"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso6047672a12.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 08:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753082; x=1762357882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKMLMwZBZ6qj6NtiOzx10r0AIj/IC2iFRpdKHVI/Yrg=;
        b=dT+0e47BSNeF4nSBzLcdC3D8e8X2xHURr67ARU8R4sfgex951TQpgjFmEAwroyxM9b
         IbU2OTOVeujhilo33ifnl00EB4CdyKgPQsokU7de99LpcF9kzq9Nf062eT2Po2ONzXuE
         HtyrVdGHTtE8D82TXUKecSLPlDDhKThOvyQr+W4z/vA9zd7T6IBHj3Lc7ly/R64AUt8n
         IIWxLW+wYqZYLWkfCfLPPUdzZoXvK/m68Ka0f9yoSHJGPj+94RjcaZbUExTO4rx/irHm
         DEy9QQg7qeH8b2dUBVVaKPGKdE8kN6yrPZ18ACLDSTYnoQ1aD/2qdZSmqn9QBNiaztzA
         Y3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753082; x=1762357882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKMLMwZBZ6qj6NtiOzx10r0AIj/IC2iFRpdKHVI/Yrg=;
        b=Mog5kDRE1rFs9/ItD2cEm0Is6d5NMtz78SOwBmDIrOfOV+sij0p+5XC64dbDHy6TrV
         xI9EkzP9skhKfn7RUu8nP+Vlndw4u4RuBUStAQlXxoMLzFIp/g+IwDR+PTlWYLJ6RcKu
         FYk6qJlwa1Pkj+IIL8ER4hv0ku/zWMHXJrRWjcC307Tleq/Npf34W07+lN5aQ1f83MoA
         bnbDIpZ364kIWiAcKL5FcOtdvzfvqUfZ7LePimOsdi/fZlDeUwCRFsi5cDe8KDd0X/jG
         exFMGsPNB/RLM/6OY2jonbF5ZfQrdeYadDAbt1D/TlTnaRPD0Aa9sp3vHxPmydjCx6e/
         K2ng==
X-Gm-Message-State: AOJu0YzxPPppLpnkTkBVUx1c6qK+mf0vIm8GC4+NVK0/IGWd4IG8dS5f
	leMKQpR3GdFhoafIfI90L8qDt3zutNvli2EUz6Xf9DnzeFKvB+cyPFE9ZzSlAQ8TDuvEgiiiHRW
	53PzOABOR+t4Ggoy2HP9iKQ03rkxFfHMb9U/4
X-Gm-Gg: ASbGnct32S5tid9JDT6rh1eiYiWlcG+GyYawtr1J7TLO/WWCpuqNRKXbLJ8HTk/qcII
	VHcuKQqOP3EyRtzHjcdusf1Bl+32PRceygco3hQacLXTcE9yfTIcJLvdSKwZDsudmm1TlPlCq+G
	pfcqI8PMrZoc+HID9DP+UCSu9xcBwRT9zQlk8iwplx/InGQEcsGkMZ6RM776509/GgryHfhrp0s
	R0H43VTzjpNMAoW9FC6M9PUh78A7WxY+h/8KI/jpgSTq03UE3tRDaapL5KGxtkgHevdBc+pUQZy
	wGJgmYSA15a2lozajg==
X-Google-Smtp-Source: AGHT+IEqO2oZzXOJBoH3sX2lkWw3c2YYDt7AxQGVGB8l/FFxiw9TcEqzNhSONBlRk16few0QVEtBczI9untqAzBfL3o=
X-Received: by 2002:a05:6402:1598:b0:63c:1066:8bec with SMTP id
 4fb4d7f45d1cf-6404437fceemr2663584a12.35.1761753081938; Wed, 29 Oct 2025
 08:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L9anYu4LKWGDKrwzBBytMunJ3UjTehNN9m2DigG8yCNHA@mail.gmail.com>
In-Reply-To: <CAD=f0L9anYu4LKWGDKrwzBBytMunJ3UjTehNN9m2DigG8yCNHA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 29 Oct 2025 16:51:09 +0100
X-Gm-Features: AWmQ_blVUzzClnKz--OtlvVrZQZ27kTIJbIV8cXS83uIhZvWxC-VQhydOh5gB1I
Message-ID: <CAP8UFD0a+RxQ-pPWrmwOYhBic6Oy9C1NeA7EmEyj2KYYDyS4QA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BOutreachy=5D=5BProposal=5D=3A_Refactor_in_order_to_redu?=
	=?UTF-8?Q?ce_Git=E2=80=99s_global_state?=
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 29, 2025 at 2:18=E2=80=AFAM Bello Olamide <belkid98@gmail.com> =
wrote:
>
> Hello,
> This is my proposal for the project
> "Refactor in order to reduce Git=E2=80=99s global state" for the 2025 Out=
reachy
> Internship program.

Thanks for this proposal.

[...]

> From a high level overview, environment.[ch] exposes some global
> variables that reflect a per-repository state and examples of such includ=
e
> git_work_tree_cfg, is_bare_repository_cfg, and core.* settings and functi=
ons
> which also depend on `the_repository` such as have_git_dir(),
> is_bare_repository().
> After a brief study of some related work done on the project,
> it is important to understand the purpose of the identified global variab=
le
> and how it is used across the code base, observing how it relates with ot=
her
> subsystems and moving it to the `struct repository` or `struct
> repo-settings` if its
> use is repository specific, or specify an appropriate context based on it=
s scope
> and use this context in the accessor functions.
> For example in [1], Patrick Steinhardt observes that `core.hooksPath`
> is repository specific and is stored in the global variable `git_hooks_pa=
th`.
> The variable is then moved into local scope in the repo-settings
> struct and a new
> accessor function `repo_settings_get_hooks_path()` is written and used to
> set the `hooks_path` of the repo specific struct which the path subsystem
> reads from.
> Similarly in [2], `core.sharedRepository` is tracked via the global varia=
bles
> `the_shared_repository ` and `need_shared_repository`. These are then
> moved into the repo-settings struct, with new accessors functions
> written to modify them,
> and calls to the accessors in the path subsystem are then modified to
> replace the old
> accessors which modify the global variables.

Nit: the above paragraph looks very big. Maybe it could be split a bit.

> I also studied [3], [4] by Ayush Chandeker,] and [5] by John Cai to broad=
en my
> understanding of the project.

Are there some cases where strategies other than writing new accessors
functions were used?

Are there pieces of work on this that were started but not finished?
Are you planning to finish them?

What are the roadblocks that were faced when working on this?

> 3. Review Existing Patch and Define Criteria (December 16 - January 9, 20=
26):
> -------------------------------------------------------------
> - Thoroughly examine the existing patch series submitted to the mailing
>     list  to understand;
>     * What criteria makes a global variable a suitable candidate to be
>        moved to the `struct repository` or `struct repo-settings`
>     * What appropriate context it should be moved into based on its
>        interactions with other subsystems.
>     * If remaining a global variable is the best approach in its case.
> - This information can be gotten by paying attention to the discussions
> in the patches and also engaging with my mentors and the Git community.

Are you sure that it will be possible to define clear criteria?

Thanks.
