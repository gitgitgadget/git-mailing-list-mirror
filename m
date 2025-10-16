Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E476026
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632496; cv=none; b=Ool5fip/n+ZPn7vcCBrC7ht9ngPD6a7Xg7hLKPpTQxrEnr/EriXgJ1Kgkmrqd9g1uHrBOEHvyBHVZAT7MaTqDlGBsZLn54FrUf+wERRRe3KaBy9WdGL88/4mrNGHLLS1uL8xJvWCK/1q/OgjTZuG4kMFcYLsWYbzn0qf6kKGPnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632496; c=relaxed/simple;
	bh=NTzu7xWjXlbNfDqubQZg0X7OKlDGfrblNJqW8kbKLho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3abcQtH/5Wv9osIM1D40k6AyLnuHIYQXldaNrQVlZkvwEG0Ve1Vt1WcOrEQRavn0X9osmUVys8WqjnNnv6dkC/xDvKe48tpnaZi/7CZKUq/BDoThpSlCGpy7UbSCW/o0p8cXXc05uhDVi81KTv2Ka4Mxb0lvA5RFN9JLz1X3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hulqrKy7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hulqrKy7"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-633c627d04eso83a12.0
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760632493; x=1761237293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ysVCBCYAJZIqKX833gj3/dOh9oVa2h1aH97piMXgJys=;
        b=hulqrKy70qsX5LAaEkr1q2zmIOpxTpfkqj764gXUrXoerT2j8P0kDiHV50vavz5qfi
         jcleozgsveeJfj87RIPAsx3ohs09VZ1z8xIf+heHDLGCEN8YWnL1vTQXT1HdjK36dfBE
         t45BWSimm4nr4x5QXHzjZhGNQI4DvOcvUfeTmtDjuOnLaFtQ1vYgJiwR6qQLaNJCb4EB
         WT1vKNYiFMZ5JT4wXJDrwKdOiBb8ISEPC+PjSWW07UnyhvAOvU0gLZcVWCRDjXrcV+33
         Y30kYmIRnTAIF1nxi8BCWqJ75PBMA7au3H7Apjd0l5Roh5pds/bYGwtWZa4m0oSqOoyY
         e+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760632493; x=1761237293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysVCBCYAJZIqKX833gj3/dOh9oVa2h1aH97piMXgJys=;
        b=Sc7aiO1FgKauYQUjZ4wUeFUMTE1a4Sghw+dsC39rj0brdx4AoX8RI0SecDfQsVk8Uy
         NpeUGrTlne4KPeLmYwzW9aKs75db+A0qRH+Trckq7K8wbWcjVpVyHt0x4Q8hLk0cRV1v
         HJBUYsC3yFuuKdpQMtGQqbPD182rud7mdOqqU88TLKuTFMKYy+QEoxvMxdOLWPNgyS2V
         LjioC3K90J6KiJ9XZMk5feEOVkJUxA3VfALIsdiYW5jqexcL9xzOn8hsTFgwvHvhDn1Y
         x+v7ifT+v/uP3hdUX+ILLpW4UQf75q5GsD0l/VHlceIymJ713+sowWx+xnyRS/VB30cb
         KzDA==
X-Forwarded-Encrypted: i=1; AJvYcCWmoKvtRXIZL1rnHBsdi/kd3Yyg5sYlW9u9pSJb7/H89tJkHX8L4xQ4lF5NFzsnNJDiahE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcHiO/1k3Ke9Ms60m6UANJR0zr96gLYPX+wJjK9IslNkNVZXJm
	135oZ6ZIXmDHWdByRYVeBhz2wjjH5O9+/imq6Q7RqG2K+Q2AD/a7Qg5O/rEUF25Y2Lt1+HrXnbe
	O8/z2kcAzLNpHsx4SN/qaE49OKzfXZ8xPW63VJ5lR7AjDwj4Mov61Ftsm
X-Gm-Gg: ASbGncvo0Ow8BnmYOWeNA4ZH+uMCxIKzVi1hGeg6/bdaafHFP5DGUsS83qNdbiHPZ/+
	veBI5Jv5+0mETlMXuTy+pwuxso1joAufK2k5mvkzPN7G9+CB6ALeLA/1p+5CE6wKYv9EosUXbqW
	enExWsvlxgGXeMBF2mFVxroHu3ldLDcGuFTh7mQ3y2SdNIixFAphoz3jkPl8EtQhAvt9Xh1k/S9
	uSp+6oS59ip64dVu5sKnBI7+3zNH+jjMj2bzFY6jLIQZ9fRAylJijziYxGKwU3XbFfO3a0Km2cD
	LxG10Ic88C9NWYA=
X-Google-Smtp-Source: AGHT+IHFepId5TG8Rqfxu3ZQJeSc3SSyw6zvxK/X3XQYSsRWten69MaN5fUtzjV3NBs4Pb1kEOotP88+IJYVFwVKPac=
X-Received: by 2002:aa7:c98f:0:b0:62f:a8d7:2964 with SMTP id
 4fb4d7f45d1cf-63bee065dc0mr232739a12.3.1760632493165; Thu, 16 Oct 2025
 09:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1989.git.1760566054455.gitgitgadget@gmail.com> <i5lgq7cunzqn2k3puuudzb53efqz6cxev64l6ukwy2kf24dab3@ndymfd2ocit3>
In-Reply-To: <i5lgq7cunzqn2k3puuudzb53efqz6cxev64l6ukwy2kf24dab3@ndymfd2ocit3>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Thu, 16 Oct 2025 09:34:42 -0700
X-Gm-Features: AS18NWDo1pMLOfkCzruFti9gz9aqXZCoi7VROiXTHwTiOAG29-rJv3WukP5CRbA
Message-ID: <CAESOdVDbVDwmYOFRAAC07GXaJ871FiPWTx58YMLta7vAWDjgfw@mail.gmail.com>
Subject: Re: [PATCH] BreakingChanges: say that `git diff X..Y` syntax will be
 removed in 3.0
To: Justin Tobler <jltobler@gmail.com>
Cc: Martin von Zweigbergk via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Martin von Zweigbergk <martinvonz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 18:28, Justin Tobler <jltobler@gmail.com> wrote:
>
> On 25/10/15 10:07PM, Martin von Zweigbergk via GitGitGadget wrote:
> > From: Martin von Zweigbergk <martinvonz@google.com>
> >
> > The `git diff X..Y` syntax is quite misleading because it looks like
> > it shows the diff of the commits in the X..Y range but it actually
> > shows the diff from X to Y.
>
> Personally, I would like to see both the double-dot and triple-dot
> notations removed from the diff commands because they are often confused
> with the revision range notations.

Oh, I agree. I had forgotten that the triple-dot notation is also accepted.

> In my opinion, the double-dot
> notation doesn't even have much value as it can be replaced with:
>
>   A..B => A B
>   A..  => A @
>    ..B => @ B
>
> These alternatives are just as concise.
>
> > IMO, if that syntax is supported, it
> > should show a diff from the merge base of X and Y to Y. I hope Git 3.0
> > is a good time to remove support for the current syntax and
> > semantics. Then we can perhaps add the syntax back later with less
> > surprising semantics.
>
> With the existing triple-dot notation, `git diff A...B` is equivalent to
> `git diff $(git merge-base A B) B`. I think this is what you are
> suggesting about that the double-dot notation should do. As mentioned
> earlier, I think both these notations are too easily confused with
> revision range notations so I think we should avoid using the dot syntax
> for such a shortcut altogether.

FWIW, `jj diff` can diff between two commits with `jj diff --from A
--to B`. It can also show the changes in commit A with `jj diff -r A`.
You can also show the combined diffs in a range with `jj diff -r A..B`
(i.e. `jj diff -r A` is a special case of that). I think that's
consistent with the range notation because it's the same set of
commits that are considered. But both `git diff A..B` and `git diff
A...B` take range expressions and show diffs that don't correspond to
those ranges. So I guess I'm saying that I'm not fundamentally opposed
to having a way of showing the combined diff in a range, as long as
it's consistent.

>
> The triple-dot notation is a somewhat convienient shortcut though. If we
> wanted to remove it, we would maybe want to replace it some other
> functionally equivalent shortcut.

Makes sense. The problem is that there are not many symbols that are
available without requiring shell escaping. I don't have a good
suggestion.


>
> All this being said, I've sure there are folks in the wild using these
> notations in scripts and changing would cause disruption. Maybe the Git
> 3.0 release would indeed be a good time to remove them though.
>
> -Justin
