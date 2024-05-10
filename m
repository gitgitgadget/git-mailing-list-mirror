Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D285165FBA
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335742; cv=none; b=FCWehc8iTVgdb8r4SwokBwgTU6r75GPBO28KsxQifi0jsFyNfxbKERIsMEqukKyl69o3y/+7u3sNpBtkqul1ZWUaHmHwOf+w00z4/DOhFGEtDfdZR6a7Ztg6RrkFFPgNWp1jqVfJ6zYsV9RnKG91nXMoq7r6mFj4c+CXiY6mqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335742; c=relaxed/simple;
	bh=5wO8ORt/6+fw7cUv74EkbVbfmQc5m3dUOkiQmhJg2Jo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=BOwuZ4UPmFOFyGZUJiwO7g9x4yA21EOcXUZBH5y0k0hWFAIz2c9al8BMPHPkyKTEdOXAMu6YqFk8sB5jUYAFtyUgBgO+0ET3xY9bsPiQ8Z6T6QgEJY/5nmvpYVUFUNPzcF1DrGpgjC1BT65LOy/KgFgnEVD6kEHfCGQeXNbzY7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEJQS4xJ; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEJQS4xJ"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-23e94f0788aso894831fac.2
        for <git@vger.kernel.org>; Fri, 10 May 2024 03:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715335740; x=1715940540; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RqrmpyfXFeE1jFC07uDt3li9oBX25qTeMKpyP/Dpdo4=;
        b=aEJQS4xJcBR/e+dH7y7wimuxP6mfTULnIrnNGfZXmjoVz9kc7VJquWa5QGcNi8oE7S
         rOOxIIeFiNR6TrrOBfUMYxzZxRmvbnrhnQuCBbY7T9be+zL0giwgKOl2X3MHcpcfozWI
         MMubtska403944knP/w2RZi+QQgiOWC7QeLOCIkggeab6BVawvUj1la1FG0QTM0zT8kg
         jxMvDvzNbv8n7AeeMH42osMbnDkvZOOu7nmfD0M1cM7ys8/r6BU586KCgGOOKVNWMWF2
         wEBKUl8g6Ls+VoD5Kd3FC/Hu5+Fbh2r51UpQVWSmqgnl1PMR65+/xd/VF3VllBNz9ML/
         KuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715335740; x=1715940540;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqrmpyfXFeE1jFC07uDt3li9oBX25qTeMKpyP/Dpdo4=;
        b=Jc8gcNoFbRsZ0I6llesWXEFIwk1dtZmbQJ0QbxxgKMPaiWiMNpGQq1hggvfWbD3tu9
         tZ/oMCWkdyGYCtEKhN7wWUGraEsEkrvSl5NljbvLP0/iGQItHrZrVfjSVPaF/hiv46y1
         3HDfvFpvtB0hEG2x9pGA7FolaY5cxfdMTvmyaFzj+RACZuD/D/enf8CA8SzrUdC2aEe3
         QUM01wzcSLjo4q2k2q74i1a3hFCK1NqavFpbll/TNa7tcM36cP/XXSPzyW3CUd+lURR0
         /HqTtltjG78D1YErtsYTl0bhuV4zzBSKHxSXezrySnUByRGQrrZfzJqH2X1wRNt9uQ2J
         5BJg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ3SojtLUNI2lcRzhwS6o7QM8om9TN01N7/3oh+zMgVRu483aBogw/+mZ7inOgUnbtXf3PgeRRWoSpNPmvG2ld8ncL
X-Gm-Message-State: AOJu0YzMUd2OqavsPwR0TwXmnGd5KL1/bGaHbgzARLi0fVLjefgHy+29
	3282GOqfgzmMB6ga62rcb++65oCu3iZzyAet3jO6fgO8l8dhvbq83ihpt5FiJ/llrC5+ZNMJuV/
	Q1p7j4T6x9y1QqSxeDNZ/LG2OBvk=
X-Google-Smtp-Source: AGHT+IH08F7Mtk+oE8N04QEMy9pyuMzkq/xDUpfIf2uA59dVUpxZeAl96cdzj1lgZzKY/Ufva+bmM5px3rOgrnf5Pl8=
X-Received: by 2002:a05:6870:b313:b0:22a:828b:57ea with SMTP id
 586e51a60fabf-24172f95dddmr2319305fac.53.1715335740190; Fri, 10 May 2024
 03:09:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 May 2024 03:08:59 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240509211318.641896-3-gitster@pobox.com>
References: <xmqqy18issfv.fsf@gitster.g> <20240509211318.641896-1-gitster@pobox.com>
 <20240509211318.641896-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 10 May 2024 03:08:59 -0700
Message-ID: <CAOLa=ZS_5+x7_xxppD8BE7RA0X+BFHPm=ffWg4JDgORqR5=sqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] SubmittingPatches: extend the "flow" section
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000770965061816b924"

--000000000000770965061816b924
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Explain a full lifecycle of a patch series upfront, so that it is
> clear when key decisions to "accept" a series is made and how a new
> patch series becomes a part of a new release.
>
> Earlier, we described an idealized patch flow that nobody followed
> in practice.  Instead, describe what flow was used in practice for
> the past decade that worked well for us.
>
> Fold the "you need to monitor the progress of your topic" section
> into the primary "patch lifecycle" section, as that is one of the
> things the patch submitter is responsible for.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/SubmittingPatches | 112 +++++++++++++++++++-------------
>  1 file changed, 68 insertions(+), 44 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 142b82a71b..8922aae4a5 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -8,53 +8,76 @@ project. There is also a link:MyFirstContribution.html[step-by-step tutorial]
>  available which covers many of these same guidelines.
>
>  [[patch-flow]]
> -=== An ideal patch flow
> -
> -Here is an ideal patch flow for this project the current maintainer
> -suggests to the contributors:
> -
> -. You come up with an itch.  You code it up.
> -
> -. Send it to the list and cc people who may need to know about
> -  the change.
> +=== A not-so ideal patch flow
> +
> +To help us understand the reason behind various guidelines given later
> +in the document, first lets understand how the lifecycle of a typical
> +patch series for this project goes.
> +
> +. You come up with an itch.  You code it up.  You do not need any
> +  pre-authorization from the project to do so.  Your patches will be

Wouldn't it be better to have the following sentences after the next
para?

So the flow would be
- Have an itch. Code it up.
- Send patches to list.
- Get reviews.

> +  reviewed by other contributors on the mailing list, and the reviews
> +  will be done to assess the merit of various things, like the general
> +  idea behind your patch (including "is it solving a problem worth
> +  solving in the first place?"), the reason behind the design of the
> +  solution, and the actual implementation.
> +
> +. You send the patches to the list and cc people who may need to know
> +  about the change.  Your goal is *not* necessarily to convince others
> +  that what you are building is a good idea.  Your goal is to get help
> +  in coming up with a solution for the "itch" that is better than what
> +  you can build alone.
>  +
> -The people who may need to know are the ones whose code you
> -are butchering.  These people happen to be the ones who are
> +The people who may need to know are the ones who worked on the code
> +you are touching.  These people happen to be the ones who are

This reads much _nicer_.

>  most likely to be knowledgeable enough to help you, but
> -they have no obligation to help you (i.e. you ask for help,
> -don't demand).  +git log -p {litdd} _$area_you_are_modifying_+ would
> +they have no obligation to help you (i.e. you ask them for help,
> +you don't demand).  +git log -p {litdd} _$area_you_are_modifying_+ would
>  help you find out who they are.
>
> -. You get comments and suggestions for improvements.  You may
> -  even get them in an "on top of your change" patch form.
> -
> -. Polish, refine, and re-send to the list and the people who
> -  spend their time to improve your patch.  Go back to step (2).
> -
> -. The list forms consensus that the last round of your patch is
> -  good.  Send it to the maintainer and cc the list.
> -
> -. A topic branch is created with the patch and is merged to `next`,
> -  and cooked further and eventually graduates to `master`.
> -
> -In any time between the (2)-(3) cycle, the maintainer may pick it up
> -from the list and queue it to `seen`, in order to make it easier for
> -people to play with it without having to pick up and apply the patch to
> -their trees themselves.
> -
> -[[patch-status]]
> -=== Know the status of your patch after submission
> -
> -* You can use Git itself to find out when your patch is merged in
> -  master. `git pull --rebase` will automatically skip already-applied
> -  patches, and will let you know. This works only if you rebase on top
> -  of the branch in which your patch has been merged (i.e. it will not
> -  tell you if your patch is merged in `seen` if you rebase on top of
> -  master).
> +. You get comments and suggestions for improvements.  You may even get
> +  them in an "on top of your change" patch form.  You are expected to
> +  respond to them with "Reply-All" on the mailing list, while taking
> +  them into account while preparing an updated set of patches.
> +
> +. Polish, refine, and re-send your patches to the list and the people who
> +  spent their time to improve your patch.  Go back to step (2).
> +
> +. While the above iterations improve your patches, the maintainer may
> +  pick the patches up from the list and queue them to the `seen`
> +  branch, in order to make it easier for people to play with it
> +  without having to pick up and apply the patches to their trees
> +  themselves.  Being in `seen` has no other meaning.  Specifically, it
> +  does not mean the patch was "accepted" in any way.
> +
> +. When the discussion reaches a consensus that the latest iteration of
> +  the patches are in good enough shape, the maintainer includes the
> +  topic in the "What's cooking" report that are sent out a few times a
> +  week to the mailing list, marked as "Will merge to 'next'."  This
> +  decision is primarily made by the maintainer with the help from
> +  reviewers.
> +
> +. Once the patches hit 'next', the discussion can still continue to
> +  further improve them by adding more patches on top, but by the time
> +  a topic gets merged to 'next', it is expected that everybody agreed
> +  that the scope and the basic direction of the topic are appropriate,
> +  so such an incremental updates are expected to be limited to small
> +  corrections and polishing.  After a topic cooks for some time (like
> +  7 calendar days) in 'next' without further tweaks on top, it gets
> +  merged to the 'master' branch and wait to become part of the next
> +  major release.
> +
> +Earlier versions of this document outlined a slightly different patch
> +flow in an idealized world, where the original submitter gathered
> +agreements from the participants of the discussion and sent the final
> +"we all agreed that this is the good version--please apply" patches
> +to the maintainer.  In practice, this almost never happened.  The flow
> +described above reflects the reality much better and can be considered
> +the "canonical" procedure to get the patch accepted to the project.
> +
> +In the following sections, many techniques and conventions are listed
> +to help your patches get reviewed effectively.
>
> -* Read the Git mailing list, the maintainer regularly posts messages
> -  entitled "What's cooking in git.git" giving
> -  the status of various proposed changes.
>
>  [[choose-starting-point]]
>  === Choose a starting point.
> @@ -241,8 +264,9 @@ reasons:
>    which case, they can explain why they extend your code to cover
>    files, too).
>
> -The goal of your log message is to convey the _why_ behind your
> -change to help future developers.
> +The goal of your log message is to convey the _why_ behind your change
> +to help future developers.  The reviewers will also make sure that
> +your proposed log message will serve this purpose well.
>
>  The first line of the commit message should be a short description (50
>  characters is the soft limit, see DISCUSSION in linkgit:git-commit[1]),
> --
> 2.45.0-119-g0f3415f1f8

Thanks, this is great improvement.

--000000000000770965061816b924
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: aee2f2407cacef97_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZOThqa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMS9sQy8wVFo0cWxDV2k1UmRBOXdhS2hRekRQQ2YxaAo3REJyajR3MzUy
UzFtS2tyVU53d1BLM05jTEtKTSt4OEdrS2FXYXJuVUh4a1h5aFovM0kraUhtUERYbmU5Y0pBClVH
MWpZa0tlMEp2SWwzMkRzbHVucFNoRXBEWWl2SDRvUk9aQm50UUJwYndmTU9yUFZGT0lGaHdyWlZn
dmNDbmQKTnY4b1dTUDBLZFZqemVTTnh1OU5aU2xoSkw4VzBYM0F0RmVyR3BzVElUbDlVZXBuQjlI
N09lTUkreVE1SXF1MQplemJxL1RtQ0FrWk5DNUhrWTl3elc5Y3oweGlIZEx4cnh3aUkyWWFWUXc1
cTdwdEFUSXVGcURYZXdLU251TFc2Cm42TjUwelEvUUVWTUp3WUh0QjgwR0orL1ZramRWOStMa0Ni
MjFxN1MwSkdYY0VkL3V4N0lOY1lQTVNlWlZkQW8KM0tkOEpjVlNZdjZrZ0lWZVpoeUZ2bllyZGd0
dlo2aFVRbWZQY2NGYVU5OTRUQ2xBU3R5VnEvUDVERFo5M1gwUQovaXlGUGdKem1kTDlyTmIwWm1O
MEhMczBnQzV0bGViaXQvV2ZybURIVHVpbkNiSUxpN2hJSGY0YUhIelNXZ0NqCnpYOWhjTVRFYk8w
UXBRMVI1RWM0RWVyQ2lFWEtlS2J5eHQzd09lND0KPThsUnMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000770965061816b924--
