Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07719364EBF
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771919835; cv=none; b=g5T5mWBqOjxKaC+yiCU+TujyxBosrnqoVJX49h/apnqWSOjGgEc80jM7h6FxyABaI/7kqcH1mOD0DrKpVbIV/MwDtYbpRsqXEFUl+8ZAXrdAIUo0OpVR0WwbDV88M1PGW6WuEpH1IUBY+6ZIleWT/0hC64hKEV2HrrVrHM17Tu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771919835; c=relaxed/simple;
	bh=j9WEjLUAEblLibNc2NWcvkO2j8pRhoadK07Fe3nYUM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9h/AV8UlrKarsU3SljO9umtkXXv5srrcCSKuAe/l67mRd62e9I8tR7LzKpme+SMaIcmXvUlfPFnmby5Nkjs+IqGHPiuZmKt7D0F7V96vqBKIOejaUFjykGzLvcqZbNpZ2z/GArN1sP3U4FEys84nQ8MA6wt3FdbXlRZAitEVVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKRHFWye; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKRHFWye"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-358ed90bcefso107241a91.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 23:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771919833; x=1772524633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBKfBBa8UXUKjU9w1KUuyzDd0JsQd1QwSMM+2RYB1OU=;
        b=iKRHFWyevZBpJgvSI6jv8zYwr6SCY7rkBwyykzzd+dBxSE/c2cLaFxDZmhDbn1L+W6
         nawRiHEkxIabMQs6jeRUHMGimM/XGrXpRbNQ255SBAxU/nMDa748XEcQOhEMMOWxobe0
         ekYag2cR1QWzHHLzy5kiV5P2BzZynVXd6HYbmlJxNv9zQ+VBb7BrjKQsA5WWAlgTczse
         I6zz571gSchIeXsZ8YmIxttzCwfSHy9jOX2Uka40BtLTEW241g+dkJeyNtO56fogZSdW
         ADvUeLVn147APJ8mHSwjzVZYp86CCoqt6Ob1dZWjYJF8FnuXEHSJkM2Sqcxdtdgw1o1h
         ODlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771919833; x=1772524633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VBKfBBa8UXUKjU9w1KUuyzDd0JsQd1QwSMM+2RYB1OU=;
        b=XruLD0FQCf64SitHIDnVwav5uGtT32lqaF59Yjje6bTppuAa+6AoCZcOn8d9Woo1nG
         RmrnFIAngwFvpDtpxhKvexNBj8feCfUYC6Ijx9sYWnZS4EAWrZIgGqbCf57i6xe4NXhK
         skThiiu6hzyg2TvNceJ2XKF4wZM2Er8SudCJcIqTSM5rLaT4/FNjjiMTUco2ra5iF7Qe
         Wo2saAVNQAEFNEMcY2Q46PPhFgyRSVmka0WLKaHQeFqpqgAa/a2mYOksUwkXnW4E1j3K
         2H68fxCsreXbwl8JefNz+9a908NKHF8YAYg2W+jCBE2eqXuC3pNjqRWD7eZDQzvThMgD
         mhuQ==
X-Gm-Message-State: AOJu0YxOFxjrqAXdoaAAxhJMmDNExt4DStH8+QP2NfPCqI6oTopN5lM5
	a7wlkV2L/qk3JAErCI/LhP7p0+3yYohuqNQyrCX05X17AzvUtQvBLM0lk5NA+A==
X-Gm-Gg: ATEYQzxsLeYrXZ2e5eyPvJJaAT8szKSg6HnoGjuCZx1xjS67ULuyOFs0HCoprLxAXKS
	V6vNw93Z1fOPvdfH/9jLtzzaVQ6zQQCEVTc6AIbpKwsIvr+9C8/A+fOz9farqB3rK1uF+c87Trd
	J+pjTuvOLGYqaiXtDlufebONKscC85UBHARkQVf6DDqW4fZwggr+AqhhLoMS4yf3XpJIvbTedXG
	RzGR8ZWkVWUOONiDnfu5rKGCJS/81DlnvDhCGsaSBIMi95coWoWNiYDe8wHUNChzsl3L0RA0a1S
	NqFCCqcRKwfeDPJOlZFeuGmqdfGNG7XbEi6bgdCCHukDLu88wSEUmrHb6Oje6/gQmydjCQgBWkQ
	69uWfrOfOKA1HR8UgOTirXbM70Oy7oMVc6RQjdLLzuR6HiLdpzkfGO7sWKGGimIhM3QtF/SEXl/
	Dr6S46ddPKvy9qMtqE+h4Em0xjaqa607pVtm0Gt4uty0ktVN8xKTIoyziUwm4=
X-Received: by 2002:a17:90b:2cc5:b0:354:9b26:cdf8 with SMTP id 98e67ed59e1d1-358ae818565mr9792663a91.10.1771919833040;
        Mon, 23 Feb 2026 23:57:13 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:c914:4ec6:1b85:93b7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358d79b8332sm890555a91.2.2026.02.23.23.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 23:57:12 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	gitster@pobox.com
Subject: Re: [GSOC] Discuss: Refactoring in order to reduce global state
Date: Tue, 24 Feb 2026 13:25:44 +0530
Message-ID: <20260224075650.1885050-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <43DCEEB9-33C4-4EE2-9FF3-49DCB9B837E0@gmail.com>
References: <43DCEEB9-33C4-4EE2-9FF3-49DCB9B837E0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> > Le 22 févr. 2026 à 10:56, Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> a écrit :
> >
> > ﻿
> >>
> >>> On Sun, Feb 22, 2026 at 9:07 AM Shreyansh Paliwal
> >>> <shreyanshpaliwalcmsmn@gmail.com> wrote:
> >>>
> >>>>> That makes sense, I tried it below.
> >>>>> I also wondered whether, in addition to this, it might be helpful to warn on
> >>>>> an invalid charset, and/or possibly fall back to UTF-8.
> >>>>
> >>>> Agreed on the first half of the statement, if we have an easy and
> >>>> portable way to tell if a given random string names a valid charset.
> >>>> I do not recommend to "fall back" to anything, if we are asking an
> >>>> input from the user.
> >>>
> >>> Following up on this, I tried adding a warning when the provided charset
> >>> does not appear to be valid. Current flow is,
> >>>
> >>>  Which 8bit encoding should I declare [UTF-8]? y
> >>>  Are you sure you want to use <y> [y/N]? y
> >>>
> >>> With the additional check, it becomes,
> >>>
> >>>  Which 8bit encoding should I declare [default: UTF-8]? y
> >>>  warning: 'y' does not appear to be a valid charset name.
> >>>  Are you sure you want to use <y> [y/N]?
> >>>
> >>> This uses find_encoding() from Perl’s Encode module to detect any
> >>> unrecognized charset names.
> >>>
> >>> Let me know what you think.
> >>> Also, is there any new test that should be added for this change?
> >>>
> >>> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> >>> ---
> >>> git-send-email.perl | 23 ++++++++++++++++++++---
> >>> 1 file changed, 20 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/git-send-email.perl b/git-send-email.perl
> >>> index cd4b316ddc..e62fa259ba 100755
> >>> --- a/git-send-email.perl
> >>> +++ b/git-send-email.perl
> >>> @@ -23,6 +23,7 @@
> >>> use Git::LoadCPAN::Error qw(:try);
> >>> use Git;
> >>> use Git::I18N;
> >>> +use Encode qw(find_encoding);
> >>>
> >>> Getopt::Long::Configure qw/ pass_through /;
> >>>
> >>> @@ -1044,9 +1045,25 @@ sub file_declares_8bit_cte {
> >>>        foreach my $f (sort keys %broken_encoding) {
> >>>                print "    $f\n";
> >>>        }
> >>> -       $auto_8bit_encoding = ask(__("Which 8bit encoding should I declare [UTF-8]? "),
> >>> -                                 valid_re => qr/.{4}/, confirm_only => 1,
> >>> -                                 default => "UTF-8");
> >>> +       while (1) {
> >>> +               my $encoding = ask(__("Which 8bit encoding should I declare [default: UTF-8]? "),
> >>> +                       valid_re => qr/^\S+$/,
> >>> +                       default  => "UTF-8");
> >>
> >> Here we change things, right?
> >>
> >> - The original validation is "at least 4 characters", the new
> >> validation is "at least one non-blank." I'm not sure why we'd prefer
> >> one or the other, frankly. The original goes to 852a15d748
> >> (send-email: ask confirmation if given encoding name is very short,
> >> 2015-02-13), which is motivated by the same problem we're discussing
> >> here!
> >
> > I see.
> > My understanding of the earlier change (852a15d748) is that the
> > length check was intended as a heuristic check to catch obviously invalid
> > inputs like "y" and trigger an extra confirmation based on the fact that
> > charset names would be at least 4 letters.
> >
> > With the additional find_encoding() check, the validation becomes semantic
> > rather than length-based, recognized charset names are accepted directly,
> > while unrecognized ones trigger a warning and still require explicit
> > confirmation. The relaxed regex (at least one non-blank) is only meant to
> > ensure we receive some non-empty input before passing it to find_encoding().
> >
> >> - We get rid of confirm_only, since we're about to roll our own
> >> confirmation below:
> >>
> >>> +               next unless defined $encoding;
> >>> +               if (find_encoding($encoding)) {
> >>> +                       $auto_8bit_encoding = $encoding;
> >>> +                       last;
> >>> +               }
> >>> +               printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $encoding;
> >>> +               my $yesno = ask(
> >>> +                       sprintf(__("Are you sure you want to use <%s> [y/N]? "), $encoding),
> >>> +                       valid_re => qr/^(?:y|n)/i,
> >>> +                       default  => 'n');
> >>
> >> …which might want refactored a bit so it can stay close to the original? idk.
> >>
> >
> > Actually the flow needed to change slightly to insert the validity warning
> > before the final confirmation step. Since ask() handles confirmation internally
> > using confrim_only and is used in multiple places, it seemed simpler to keep the
> > additional confirmation local here rather than modifying ask() itself.
> >
> > Let me know what you think.
> >
> > Best,
> > Shreyansh
>
> Ah, my mistake for being ambiguous. I meant:
>
> The code is similar enough to the original that perhaps a helper can be
> introduced, or at least we should keep the equivalent strings together to
> help those who change one.

Thanks for clarifying, that makes sense.
I'll refactor and send a revised patch on this.

Best,
Shreyansh
