Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0CF3D561
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771775773; cv=none; b=lA8v7qGlMy/6PjQZei1abDocfCQ51JmeO7wYgQk0I4N6JqMsxsk2gLDptv9MbKHBFaNoJVTWNzgh41IkiH1CmWkA62qCZBXD755SNSF9Qm6j39Myxcbu7XLxHFO5U5gfXnhiQKMOOzUVEi+YOwq8AF4xmHTjMf14u4qXrC2Z4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771775773; c=relaxed/simple;
	bh=z4/SSeLaNP22jxyKGxAW78LgsIIGnU8jyGBhMsG/mxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BY/YFwfGfX6HE2OUNIMbqVj5FD43I0Fhx0epJsuqJ/uIrJUjPtPCwK1iHp2Ktlm3zYRGGXawSiwvN/kx598jO5e+fpMlozWCJXrKH9xt7BwkvfskGYys45ZOFPXapSDSW16h2ltw9PobSG/2277JVW+1+4IFyTMdYDBOcYRo8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiB0WEX2; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiB0WEX2"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c70b4a0cda5so601578a12.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 07:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771775771; x=1772380571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EsO628mQHfJ53GZMXPbxpGggwRCHiK47JWkMMOxI/o=;
        b=XiB0WEX2T53WZVqvapB3h38OgiHCkwNreSEAkCsU1xq0IvoI3Gwa7sxNAoDd2GKyWB
         vmLICI6+O47tWO++lTNWH2rJRHSqn0mYdTiKcyz3mooPrQ+P5JtT0xjflyAMq0HVc33B
         HDKce5uk+3GKGwnspJdIlJ8Pz9M4ndoKLc5vFC0SGQsbrbJmxSKCaLjQm5EJ6zP1qKin
         IbjutxFlVoWsNBrj+grkpDgn70UEVJMet7A6BWdKeOsvEQ3D1cfR0ib07PCPkHvNYPbw
         GTNTxaEjZOsslO9CBG5vzoL1BevJN4voz9LPt+KhQXrsL06c8i2a2BJKZ2bzC6eOJ6co
         wTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771775771; x=1772380571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EsO628mQHfJ53GZMXPbxpGggwRCHiK47JWkMMOxI/o=;
        b=YYnCq+kPv6HNVsz4zPh1ld93v7I+Is8IKDPtcgtYQV6pyid2HuGiRt9rMSTZOJkUHq
         yY0jwTL+3XqO3orBO8M0o8+incPTKlSVFOENXei3xtpBWNEDPuNN6NgMoSFKSzbnhEcg
         5rBOeTX/ZXF6in8VTNRAyttZmfS5tgg8ai/Zi603kx1nvaKcr8GS4GW3aQzJ//7YrQ3F
         fnJna6RELy4aPQHbKyFyIhACJceeIkxK8VCA4l4Ownu92QB9Ya0NYkF49o7tUhnUok4T
         YTqPjP1tNBJO0f7jTnIFa+H7q+7QmBdX64q4JmRv2EG5RDrNUOxG3qrGP7A3L6ZYYYW6
         1DFA==
X-Gm-Message-State: AOJu0YwChyIx+/HhDeHXqVhkHu8f+n+Kg2FUTmcW+BqvrazqZrN3x3My
	xf6TWxU2WmcqfsNW3vzVstY13/Eo0O6l8NE1WsOHudRJcx5m2zUJpI+xTcgtuQ==
X-Gm-Gg: AZuq6aJR+6lCrPhyiq3RLu4ur3V/ae90IbxRIDa+RLlgYZBvAUdPDMqNEgM49z3q+Tn
	/tG8IdRVWY446mI3cIcl23cj2wZmkAP/0IJ8l7XEeHjho18y0k4B7SkvSupsfAFlR7uTWRu6o65
	5o5XZHKs8zldOeqciKySdjmakuqWLOVChixCUFz6OsN+PAE2caCT1/eEcjdslp5seqKt4fQ9Ob6
	/8keJtEFRNWUF62uwdwuMULFSdSAZctT+e3xpO8QMSRAH6V8bOf5x/BlKq/BeCc55+FFi6+ZMT9
	Y3fV+BvidEhbYpDCAwJN9WMChPQz5aoxWxGEzQUZ04hZotM/VUk6Nm81yQATu32G9vLrPp0PGGr
	Or8CjC+Bh2zeZsEZpfZkU7t4oz0Momeni9oRnpbq2wqfdxMqYfMJjC28yZE3CN9di9lIdyBs0Ny
	ZC66EDP1JDkWPrODIvcQwDn+9m/WpO4tq+Ss0ylNwPXY/5GK5wXvThkoHVFjg=
X-Received: by 2002:a05:6a21:9181:b0:393:6103:7f2e with SMTP id adf61e73a8af0-39517e26f1cmr11290707637.31.1771775770970;
        Sun, 22 Feb 2026 07:56:10 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:9188:668a:fc76:50af])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b71a7351sm5452400a12.8.2026.02.22.07.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 07:56:10 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	gitster@pobox.com
Subject: Re: [RFC] send-email: UTF-8 encoding in subject line
Date: Sun, 22 Feb 2026 21:22:01 +0530
Message-ID: <20260222155559.1777883-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CALnO6CBhB+O-CBCw3f+2n5yaHO7Wk7-Adaa9_4shXZvciGpUPA@mail.gmail.com>
References: <CALnO6CBhB+O-CBCw3f+2n5yaHO7Wk7-Adaa9_4shXZvciGpUPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> On Sun, Feb 22, 2026 at 9:07 AM Shreyansh Paliwal
> <shreyanshpaliwalcmsmn@gmail.com> wrote:
> >
> > > > That makes sense, I tried it below.
> > > > I also wondered whether, in addition to this, it might be helpful to warn on
> > > > an invalid charset, and/or possibly fall back to UTF-8.
> > >
> > > Agreed on the first half of the statement, if we have an easy and
> > > portable way to tell if a given random string names a valid charset.
> > > I do not recommend to "fall back" to anything, if we are asking an
> > > input from the user.
> >
> > Following up on this, I tried adding a warning when the provided charset
> > does not appear to be valid. Current flow is,
> >
> >   Which 8bit encoding should I declare [UTF-8]? y
> >   Are you sure you want to use <y> [y/N]? y
> >
> > With the additional check, it becomes,
> >
> >   Which 8bit encoding should I declare [default: UTF-8]? y
> >   warning: 'y' does not appear to be a valid charset name.
> >   Are you sure you want to use <y> [y/N]?
> >
> > This uses find_encoding() from Perl’s Encode module to detect any
> > unrecognized charset names.
> >
> > Let me know what you think.
> > Also, is there any new test that should be added for this change?
> >
> > Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> > ---
> >  git-send-email.perl | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index cd4b316ddc..e62fa259ba 100755
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
> > @@ -1044,9 +1045,25 @@ sub file_declares_8bit_cte {
> >         foreach my $f (sort keys %broken_encoding) {
> >                 print "    $f\n";
> >         }
> > -       $auto_8bit_encoding = ask(__("Which 8bit encoding should I declare [UTF-8]? "),
> > -                                 valid_re => qr/.{4}/, confirm_only => 1,
> > -                                 default => "UTF-8");
> > +       while (1) {
> > +               my $encoding = ask(__("Which 8bit encoding should I declare [default: UTF-8]? "),
> > +                       valid_re => qr/^\S+$/,
> > +                       default  => "UTF-8");
>
> Here we change things, right?
>
> - The original validation is "at least 4 characters", the new
> validation is "at least one non-blank." I'm not sure why we'd prefer
> one or the other, frankly. The original goes to 852a15d748
> (send-email: ask confirmation if given encoding name is very short,
> 2015-02-13), which is motivated by the same problem we're discussing
> here!

I see.
My understanding of the earlier change (852a15d748) is that the
length check was intended as a heuristic check to catch obviously invalid
inputs like "y" and trigger an extra confirmation based on the fact that
charset names would be at least 4 letters.

With the additional find_encoding() check, the validation becomes semantic
rather than length-based, recognized charset names are accepted directly,
while unrecognized ones trigger a warning and still require explicit
confirmation. The relaxed regex (at least one non-blank) is only meant to
ensure we receive some non-empty input before passing it to find_encoding().

> - We get rid of confirm_only, since we're about to roll our own
> confirmation below:
>
> > +               next unless defined $encoding;
> > +               if (find_encoding($encoding)) {
> > +                       $auto_8bit_encoding = $encoding;
> > +                       last;
> > +               }
> > +               printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $encoding;
> > +               my $yesno = ask(
> > +                       sprintf(__("Are you sure you want to use <%s> [y/N]? "), $encoding),
> > +                       valid_re => qr/^(?:y|n)/i,
> > +                       default  => 'n');
>
> …which might want refactored a bit so it can stay close to the original? idk.
>

Actually the flow needed to change slightly to insert the validity warning
before the final confirmation step. Since ask() handles confirmation internally
using confrim_only and is used in multiple places, it seemed simpler to keep the
additional confirmation local here rather than modifying ask() itself.

Let me know what you think.

Best,
Shreyansh
