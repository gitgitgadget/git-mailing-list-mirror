Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A4438B
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423712; cv=none; b=o5jyDEwECe/yVXICVDJvNRKSehWsizbgF+Y0MG42kM3snBCrzmszqozkMbXl3ZpbjGKZdS2fvB/5yM7M0YBvbVCuP69ZYtZG3trRd2VswLxsRO2GwOVniHxTeUbGUWVRRBMiG4wnL6mmPc16D4w6AT9VNe1WLyQjkiSPuBxZ5NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423712; c=relaxed/simple;
	bh=PllQJNTpSubVs8GrOOO4FZQiN0h2HYvGHo3XrJnPr3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlhKfhEoUf8ZrlZOJSyRO0hBWHMJqyrcMzD+iRAtQQEXjjyTLmmgG+1/nS2tWDJ/flIhwZR2CL+ITvy1aPa0xIcyUtCNQgncOzvnNPYRPM8Ppq7I+xzwg4tkxigZG+eA9C0MBYlue2qY+oYRXG1DK4WpQ0tysnLsnkbtkWnYeto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rcy5cEi9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rcy5cEi9"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so8717517a12.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 04:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722423709; x=1723028509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PllQJNTpSubVs8GrOOO4FZQiN0h2HYvGHo3XrJnPr3w=;
        b=Rcy5cEi9Ek0yXpeu4797d8KNjmFXlZrqBatN+6Dlhm+q++1hd3dt+gSbKoiXFN5GKx
         oUSnp3i6tqai4aTY6SsKpC3F7+DJxE2vWgX/EsEvUnZ09i8Z+X15Ld6+y8ZfHWXy+RRW
         WbjOPK4rAwLUlCaAFWiG6/dzkM5mDue1/hmo9Qp5fyELY3iu7sfuOHPpLNRJI5oRbHA6
         SOJxSJJapacQNtqyDMgf9ThNx3EtLHK4T8/t9maVfBFyhmWzKcPgeovrbG6y8UO59OuV
         MB+vD9lkepmYEE/x0TwlMdA6Drr6ujloVOg1ovnxe8JiBJBctanYP4gmwuY+GBqu1Lnl
         m/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722423709; x=1723028509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PllQJNTpSubVs8GrOOO4FZQiN0h2HYvGHo3XrJnPr3w=;
        b=AkGmdfXmCk41+vwjSI72zptHSMRP/F1SGl1DqAYK6/b3N4uLFbjB8W8MvbETFAebuw
         nBaNwkUeQ55A54IB90yjZbGtCogX6ROaOWTrrGtM5brSRD1DREC/UNVAM2UFXU5fudIe
         J+HvcgD8tGQ/m16BDbuNGAX2QBU54w1aoAOMlL8WY661/TvM7yi6zcWZ+6176oQYom0B
         dYSRVsocQ5KCIr7x+TdIE1YqRWgGkeav07CAfK0R/NGAeaenz7WV0zFx+WWuBsFTsrcJ
         rDooGR22da/quxCR0+6gJ+4jCGEIAxnYMsx9ImgoqFwrdo5A6DMpL9gqkHnNVxYobgXy
         uYUQ==
X-Gm-Message-State: AOJu0YyXjj114hNDb3urkIe+roblGy9Ru3qul3uWJgF5FgwEP5CQcVy9
	rGEX+6kEJNSXgGbOcXe42qtR/UKnBRvaxoKNLUE7DuSb6PJqyt0YvIhpJKNJd3N5xCi0eUCjRgT
	siBzBi0kaMieMb+69T6pgPNAHTMtN62TFZCU=
X-Google-Smtp-Source: AGHT+IEqa4AGYhLxidNwnLFf1FdDCeVG0wmAROGIRaOGdiVeVIBDOrGcxat08jIuOj/3zk9KGRwAtNpAawn7KTmNonM=
X-Received: by 2002:a17:907:948f:b0:a7a:a960:99ee with SMTP id
 a640c23a62f3a-a7d40074c96mr1016726266b.32.1722423709441; Wed, 31 Jul 2024
 04:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAQS9UL14d_LxTKFMghGvQQWS6dfj1RhTJYyKsz0PKoFot8v5w@mail.gmail.com>
 <2d7d6b38-b3f1-45f5-a6f0-54bd8a0d64d0@kdbg.org>
In-Reply-To: <2d7d6b38-b3f1-45f5-a6f0-54bd8a0d64d0@kdbg.org>
From: Steve <steves.sk@gmail.com>
Date: Wed, 31 Jul 2024 13:01:12 +0200
Message-ID: <CAAQS9UK7ynd7H6z4_+HN-ayGmR9jG0Aus77TN7rh-_1SCd9=4w@mail.gmail.com>
Subject: Re: Bug: Git GUI "No differences detected"
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Change #2 would still require us to manually stage dozens of files
each time this happens, so I'm hoping a root cause solution can be
found to prevent the changed file from appearing in status at all. But
yeah, removing the popup would at least reduce the number of clicks by
half.

ut 30. 7. 2024 o 21:27 Johannes Sixt <j6t@kdbg.org> nap=C3=ADsal(a):
>
> Am 25.07.24 um 12:37 schrieb Steve:
> > Problem:
> > Git GUI shows a "No differences detected" popup when clicking on a
> > file, and it returns back to the same state after closing the popup.
> > When I do `git status`, the file is listed there, but `git diff` (with
> > any line-ending-related switches inspired by stackoverflow) doesn't
> > show anything for the file.
> >
> > Cause:
> > I assume it's typically due to LF/CRLF changes.
> >
> > Workaround:
> > Manually add the file, which makes the diff disappear.
>
> Back in 2006, the only case where a file could be listed as modified,
> but then not have any changes was when the timestamp (and perhaps other
> stat information) was modified, but not the content. Such false
> positives can be rectified by running git update-index --refresh,
> therefore, Git GUI does so by default. For this reason, users generally
> do not see false positives in the unstaged files list.
>
> However, in large repositories git update-index --refresh can be so
> expensive that it becomes annoying. For this reason, the option "trust
> file modification times" was invented that, when enabled, skips this
> expensive step. On the flip side, there can now be files listed as
> modified that are actually not. As a work-around, the popup message was
> invented to notify the user that a --refresh step is performed to remove
> all false positives.
>
> This worked sufficiently well. Until core.autocrlf was invented in 2007.
>
> Enabling this option introduced a new case that can trigger false
> positives. But this time, git update-index --refresh does *not* clear
> the files that are falsly marked as modified. And we end up in the loop
> that you described and that requires the file to be staged (git add) to
> be recognized as unmodified.
>
> I suggest the following changes to Git GUI:
>
> 1. Remove the popup.
>
> 2. Write a message in the diff pane when the diff is empty saying that
> no differences where found and that the file should be staged to remove
> it from the unstaged file list.
>
> 3. If the option "trust file modification times" is set, extend the
> message with an hyperlink that, when clicked, runs the --refresh stage,
> i.e., the action that currently happens when the popup is dismissed.
>
> Step 2 effectively makes the workaround the official solution. Would
> that work for you?
>
> -- Hannes
