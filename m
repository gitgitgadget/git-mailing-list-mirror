Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4DC28FAB7
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184519; cv=none; b=nHiGX8jS13OCH0WYmHyMcTupoPoWyMhuElBQM5WbhTsmlsZYtZGvLyeCN8mrC4Zpj857oe3zI8nrUvkGNtQnzCGcVxyCm9RfO2G3U2GI/lntIv7mAfV6HrGt/IsLqAlkyRNRLp/J1E888bawBdqj1FZrcsXcXzaQmFzYneEzbmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184519; c=relaxed/simple;
	bh=lBBovAgpKcbIlN8ikRzXZhNBY3sxY+hR/kiDXPzIcv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hf/rxX63daWTSsSERqRgwQU5+jdsV5lrYvPWJ4sMtw84OC9BES/H1ewUUhYDAQAKzlSJyCgxSoSu+pNtTddWcATKJTBBdq+Y65/LbHMB43a3txfNSp9lYFxdwlD5FZdQ55ByNOHlqEbO4J4N25l8YvwEPjnEaCfPLIYcEH9fVBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvVMyL2U; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvVMyL2U"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-611e455116aso844804eaf.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752184517; x=1752789317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBBovAgpKcbIlN8ikRzXZhNBY3sxY+hR/kiDXPzIcv8=;
        b=lvVMyL2U6L5RzNmn+eK5S8D4/bxnFYkaGRPdMpVbejVAeu8mFUE/+/VFis11xGTUPh
         7393AqsphUNp/vDkSoCUHlNx1+0emNjxu3AB/+OXdTKfUxqG40XxfBlglB2459IPbmzC
         RFDYNSIqHG5YpNo3MuzQVGssfnDgrqt6rHDLbH+V6xG1DhnAtiGyjcMWwELuq79C+bCe
         orY868wwUiqXCKh9IUyUawS+V93vQFi8WmP8UfL4nKg3su78XGywSr7gA7TQKXBlnIVG
         FKe2k0SSA003o3wTXx+6Fqk+m4/uQ/2fYvLuqsHZ9W3Ud8OmzCJvM1xEQNX+11urDq9X
         VCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752184517; x=1752789317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBBovAgpKcbIlN8ikRzXZhNBY3sxY+hR/kiDXPzIcv8=;
        b=bT6OJAysFrci8vDYOZhGvY2gC3YIX8t4rJhhYtUDI8XVkuSzmuXrKQTCxeuVqdVQb5
         y6J6dQ0sPAMtQxpF8LOALhsFHgMWZFb5KjI0hiQZQeDzVlODkyftkGQ/6GwhiNv9rNhf
         LcvZtqqNhke7C/GrZsgLXEIWGtE9nktix8E571a1pAR0exh4ygh3Kr8fPFNFpLyQjk1k
         7QgFGQenSGDaVTi/JbOo2dH4ZxfCpvcR3YdbgGQ5pJ9VGsR/RsQrJWvrnWOkNgFFFyel
         PYa+rZDIUW+cJnymEUGRaTVspMKTh0TenmaSimfjyEcgYbGyTkIiAOZso3eAKxBWg0x0
         50Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVKbrqFCyaq/abuI8odKZgPlyyX8DJCvGykvTopgsDdWmlMAlSPfTfl1xQmvAstR6Lg6j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjjLr/Y20kvJRvFFB96UvfTEMaifNIUcA2yAvDByT+eK4h2qct
	Gevc8XKOANnxNszVVGZZ9E65fBt4adbDJXkL2jiuuYnDFRaPrXjK8kcy+mHYp8WM1sOOL/t00OP
	Vje7CUWRyZmkCpwSsaTFDlyT7ocy58wo=
X-Gm-Gg: ASbGncviNTfSLeQyvYKevvJsrTdmuzx4HUc2XeURIsdT2WD4toxjRZP0odgZGU/2aay
	Ka4SYrb6E9fOHUOPEQaWBqEs8bhOKS0l4F3xbrUlbZxGdjW/ywfRI9PzL+KzWIBdlMgWpfDSiSw
	LbZEesImM07ppYwN15CFpF/oUiVCRRHvPW/xtCnwhYpvqe+LqH3JQt1DsJyobhmtq3a1PGS0sEj
	kbQVKdpnV43+7n2
X-Google-Smtp-Source: AGHT+IHLRAXttrAzZrUe3M/q41cssMNk6XIDVuy9fJdS6gG6jGYAUtoJwijXe2kBxfpoJOoXfaQ4xn4Yq7DlC5NrlwM=
X-Received: by 2002:a05:6820:2715:b0:613:c3e6:10f5 with SMTP id
 006d021491bc7-613e5fc625bmr620355eaf.5.1752184517233; Thu, 10 Jul 2025
 14:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706163009.335780-1-sandals@crustytoothpaste.net>
 <xmqqv7o4ajq1.fsf@gitster.g> <2DBEA13C-5E74-4314-9A39-E045A0BC221E@gmail.com>
In-Reply-To: <2DBEA13C-5E74-4314-9A39-E045A0BC221E@gmail.com>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Thu, 10 Jul 2025 14:55:05 -0700
X-Gm-Features: Ac12FXwOMFY5_2Df5ZbbV1eptM7395cHwht2EHQinGd8KN01I8EYNM9TB5VZYDM
Message-ID: <CA+P7+xq8F_rMCQ3gVcwUT_pq08bYS=i-Dr00t728ExouAVVX-g@mail.gmail.com>
Subject: Re: [PATCH] SubmittingPatches: allow non-real name contributions
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>, redoste <redoste@redoste.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 7:01=E2=80=AFPM Ayush Chandekar <ayu.chandekar@gmail=
.com> wrote:
>
> I want to know how we deal with anonymous contributions. Let's suppose so=
meone creates an internet persona claiming that foo bar is their real name =
or an alias. They make some contribution and then abandon this persona. So,=
 isn't this effectively an anonymous contribution?
>

I think this is an unrelated issue of whether or not we accept
nicknames or names other than your "legal" name. It is always possible
someone is lying, whether we do or don't change that policy.

The exact decision for any such given change is likely context
dependent. If a change were made in bad faith and we discover it, then
it would be matter of excising the change. If it were merely a change
someone submitted in good faith and we can no longer contact them, it
might make sense in cases to find a new owner or maintainer, unless we
have strong reason to believe that we do not have a valid DCO, in
which case it might also require removal.
