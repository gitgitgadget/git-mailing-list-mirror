Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD823290D0
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127236; cv=none; b=I3He5fhhlouKaCHo+Wb4lO/0C5B4lNHIiF/XZ4SkTw3L/nbb6zPB9YkjihMXSFqssYVAaGOdFMtTkXk67Z8t/QxMnhqgBzhJr73/+fwXp8u0SZG167jIvIFRbWzj2yqa3DMdkotOToiGkFjgc+Ds3XhGFzdRvPyznuNZPRSk1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127236; c=relaxed/simple;
	bh=vFhwywmQDPr+20VUivmksJzL3k/iTxX+eYkJ5HJ2h18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbfzT09SRJ4db+iaBgy+8w47VEU4n1fVn3/WljKir3kulAITuuUQEUYSIeH6B17ll07T9MUEyAy8JVnQC1LPkppDqlwdlwMatNQLe7bZA2XhWcwJ8Y5KqlIVMPCT3Vf05SSOyr6XKdTR1Bqigp2tkRLDee+QsbJgCwwtdo6X66I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzrzzCoJ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzrzzCoJ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3562e858da5so460327a91.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 09:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772127234; x=1772732034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c71q4QByOoM/R3q4TivdKh2FrLs6zDCZFIKVKkQ4klM=;
        b=XzrzzCoJJ0bgXKqgDTOFHYh92c1Rat413NfwXXsczYsaDxY9NQAHrNakxmTbuq/mEa
         9N+x7ZU7V+n+Aw5ro5rzoI1WwJ/2dH1O0LefUcdj8oUBdnbwlrZSV0U/7X+iHHqYFl5X
         0s1XzqIhPz7qN7lqE471YQZY2Pt0eHJ/XrShg6vF/IOnw1mDavslCu1bnkkLuDFVPnNd
         v5zZdLvRHYh8ZSS8pcpws2UG4FUyFDKrGkyKvIAbeEv8LLJ5Z5VZ/kWoq3bTslVOCb1C
         Eie5nqbS3B2VNLvlw1iEV/Sz+7XBgovX0tXJgG82fOqX59/FD0wNd3ddOMp5/e6TT+iC
         SoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772127234; x=1772732034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c71q4QByOoM/R3q4TivdKh2FrLs6zDCZFIKVKkQ4klM=;
        b=VEvMJ634i7XpIG7Zp2Mlh72Etg0m/me7mKl45FjLpqenK3R9Cqgn24UDwKbA4cSZyG
         aGCFTWf/wWI27ZgtmEhIMkYS9dx3KSMXAkAJrY1L1+zAWJ+OmyIgNXV5PZFtoV8Pq+tm
         XBHnjpxe+Wg+ioBaXu1qaSulPCU9224RqsSURFXXkpEboucVBRAI41jDyiuR4u2KOcCP
         FLxxPXRgdZGe+uEjyVf6DzoVH5BjSJ/K+ndejhGVlyEE+c2l+1FzsYzIuMdV5CzuLVqj
         uWd17fFlVHvUoBv3lQPhtVnPmInPvrpn0Oxg2PC+YWSXl8SJ8CyMSyDoX36IctgoNnKx
         x1Uw==
X-Gm-Message-State: AOJu0YzwXl8Q5Ob2c5VB3ze2cr373H91Gk0xPt4+fa1AXQuAkMSya+6t
	05oU9zvGpXfeAODPv+G0y1fJxz3KytEsORJlly/3sB6iIPi+TinOPNJaKOqHhw==
X-Gm-Gg: ATEYQzyw7WNuU9eu8EgBMOGk+tZfhTCeiXBegVJ5F7t+jcGACdEwS0WoYSmqwDhE65t
	1yjJeGqJ+aunbr0T1Gu1pM4ocbRq45SfK24pK2MNeQ6nfU5/JFns+9ZzHmfcCJHCvlIf5fGvZrb
	X8b6PxyvMe7tOci2vhtq86Ugnq8b6uQqa4zb5j+8R/VKzRDDgE73ncyanSFiYZ0phc4qZJdFxts
	qT6n/5tU8eDGT7bwu/EozdhlEDvkVTmJgYuhZtaaEAvGaFfFwiWzd3/N3LidKXH7ZfRt/06tc/+
	3Mt2kHmp0M8DPgiMJ4Csyizmix13/Qp28ORlUX4MOF8QWCQyqwP2MBA3s7TTYs7NvBwFyDcVKjB
	c6SPrcFjznD5x+CmZ7c0FsbgS0NdRniL2xUgGyh+sZ46LmTHKB/KgHabTchrQPZMmRnb80qqnCP
	gEzAUiEm2BhYVIC9BRSrAZexXj0erdrJU/U92ee5nBD1o4KXjDNAYSOnboSLs=
X-Received: by 2002:a17:90b:4b0e:b0:354:a60e:9bcb with SMTP id 98e67ed59e1d1-35928a38f31mr3404317a91.5.1772127233951;
        Thu, 26 Feb 2026 09:33:53 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:5354:a570:7b23:3daf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359037af175sm6276131a91.13.2026.02.26.09.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 09:33:53 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	gitster@pobox.com,
	philipoakley@iee.email
Subject: Re: [PATCH v2] send-email: validate charset name in 8bit encoding prompt
Date: Thu, 26 Feb 2026 23:02:47 +0530
Message-ID: <20260226173336.194601-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0.154.g7c02d39fc2.dirty
In-Reply-To: <CALnO6CDSJPnVi-1RUsr7tFMwa0_xTJkiQmzTL_b-BGq=6PSz0A@mail.gmail.com>
References: <CALnO6CDSJPnVi-1RUsr7tFMwa0_xTJkiQmzTL_b-BGq=6PSz0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> On Tue, Feb 24, 2026 at 4:39 PM Shreyansh Paliwal
> <shreyanshpaliwalcmsmn@gmail.com> wrote:
> >
> > When a non-ASCII character is detected in the body or subject of the email
> > the user is prompted with,
> >
> >   Which 8bit encoding should I declare [UTF-8]? foo
> >
> > After this the input string is validated by the regex, based on the fact
> > that the charset string will be minimum 4 characters [1]. If the string is
> > more than 4 letters the email is sent, if not then a second prompt to
> > confirm is asked to the user,
> >
> >   Are you sure you want to use <foo> [y/N]? y
> >
> > This relies on a length based regex heuristic check to validate the user
> > input, and can allow clearly invalid charset names to pass if the input is
> > greater than 4 characters.
> >
> > Add a semantic validation of the charset name using the
> > Encode::find_encoding() module of perl. If the encoding is not recognized,
> > warn the user and ask for confirmation before proceeding. After this
> > validation the lenght based validation becomes redundant and also breaks
> > flow, so change the regex of valid input to any non blank string.
> >
> > Additionally, the wording of the first prompt can confuse the user if not
> > read properly or under any default assumptions for a yes/no prompt. Change
> > the wording to make it explicitly clear to the user that the prompt needs a
> > string input, UTF-8 being the default.
> >
> > The intended flow is,
> >
> >   Declare which 8bit encoding to use [default: UTF-8]? foobar
> >   warning: 'foobar' does not appear to be a valid charset name.
> >   Are you sure you want to use <foobar> [y/N]?
> >
> > [1]- https://github.com/git/git/commit/852a15d748034eec87adbee73a72689c8936fb8b
> >
> > Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> > ---
> > Changes in v2:
> >  - Added braces in if-else block.
> >
> >  git-send-email.perl   | 17 ++++++++++++++---
> >  t/t9001-send-email.sh |  2 +-
> >  2 files changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index cd4b316ddc..15387ac377 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -23,6 +23,7 @@
> >  use Git::LoadCPAN::Error qw(:try);
> >  use Git;
> >  use Git::I18N;
> > +use Encode qw(find_encoding);
> >
> >  Getopt::Long::Configure qw/ pass_through /;
> >
> > @@ -987,6 +988,7 @@ sub get_patch_subject {
> >  sub ask {
> >         my ($prompt, %arg) = @_;
> >         my $valid_re = $arg{valid_re};
> > +       my $warn_invalid = $arg{warn_invalid};
> >         my $default = $arg{default};
> >         my $confirm_only = $arg{confirm_only};
> >         my $resp;
> > @@ -1005,7 +1007,15 @@ sub ask {
> >                         return $default;
> >                 }
> >                 if (!defined $valid_re or $resp =~ /$valid_re/) {
> > -                       return $resp;
> > +                       if ($warn_invalid) {
> > +                               if (find_encoding($resp)) {
> > +                                       return $resp;
> > +                               } else {
> > +                                       printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $resp;
> > +                               }
> > +                       } else {
> > +                               return $resp;
> > +                       }
>
> I think this is asking "ask" to do too much, since only encoding
> askers can use warn_invalid.
>
> What I rather meant was to extract relevant helper procedures so that
> open-coding ask around the encoding question would be easier to
> maintain.

Hi,

I have sent a v3 on this, in which I introduced a helper for the confirmation
prompt and also made validation logic specific to the 8bit prompt.
Do you think it would also be better to move the encoding validation
into a separate helper, or does the current split look reasonable?

Best,
Shreyansh
