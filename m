Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D50D1DA0E1
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761248031; cv=none; b=dgpfMzjujBcEsY/UXyXb9IhQbJkJMGeJ1O6p1ikNapczpeHj2GFoPQZeUNtbSMweJZTgcEhLg73XX2/I/TNFbZgjBDUzqV0zbDRUBxt+qlXKTpUbAAyf6bT+pFd+0WMhuzaheyo7cWm0Kx0QlkoUbuT1ghAXJAy8uexME/9sEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761248031; c=relaxed/simple;
	bh=/a6O9V+U/AVX/dpjinQz1AuFexrHOZE8Agew/bcfm5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxQbV5XA8OalqHU99MpeCqfyXvYHL3ADIu54+nSIQq10auFpVL8CP+eLSMko1/ueJ9DDdP2yt6jlZ6kqovsKqYJLb+PLZp6bvwyHcz24bNBb07rjS/DTMBnZkS/T0+3DRsGk6A7dHC2lV9wsZAekXBZNyPx70Dv/4ervUxfO8ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=pX/HVyM3; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="pX/HVyM3"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-93e817d3ee3so105048439f.0
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 12:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761248029; x=1761852829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=55owLWmRsEBzYBk4ADI9L6gdj0TyQV0PkMrHon3iPq8=;
        b=pX/HVyM38bYSBWmV5YeYh9YqV5I3HxGBECzP8f1hHpOXmZuAefGUj3nYluKTfJyugr
         p/apPN+TP8xRgJOeOCrrHyNvxjwXP9VeXKJNl8uNhOsAwH+xqm/DFVyp6htmwAcGJcEW
         CLNHZAdQ0NTPQFGRH+fCFGMhRiGXr50iYmLr0xFiJS/h5Y3gig+LtNQ3T54a71Y1dJmj
         DND6Gx0wELsvrTcxpebjhD2ganpNe3pncz6JPtsZm+fqH3fUAamTQX8DKoEbsHhnvyCm
         I5SE8TZOhudlkToLyUSv5VTWTMl622vJm4F3HOI47Mo81oGZwLdynFTkmL0LFu8XGrO9
         eHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761248029; x=1761852829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55owLWmRsEBzYBk4ADI9L6gdj0TyQV0PkMrHon3iPq8=;
        b=oyUzOT55fPKyfc7Hr6goBDfidUT4PLw9BqI3l2aWF1sGA28iI1M9R8Gxt3VCgcisO/
         XQJKKOIT9hHYgiKuDxHa3wtJ3+nQj1lSKlrqEhDa+YCWPYnrHR5gBMGACjWzPZBD/Cxv
         jUipKwxp4Jg/IryRZkB3vBb67ykC/Ab6bHA0jeBHAOtkrBmYu/EIASiXUAvwDBiEy0hF
         MuRWMMZI6UJp2uNKKOyVgtnS/kS1634A4guEgToSEwNClKFymF02ECzOqIajVHiR6chz
         JagOGRrudcqNfPaBMbTWx0oZRNhBNFA0fS9oCrF3N/ml2R2zbm3WpkOt6zCt0MGlZcz+
         KtrA==
X-Gm-Message-State: AOJu0YzF8QBRlg8JFs7tVfcxig9sIG7kbnC43+ImIjjop+xhmNLUStuR
	r9ObTZHAWCHNHqdahYVTMe9p67oIW87XmZBgYYmPlZ/OM6ZvxwCzPlY2jdPmfhKoOJI=
X-Gm-Gg: ASbGncvOtRitgVBmSHtypQe67fXwEzOA8cmKWGASp8FhMA4WUepspMH3BOUNkk6/zGL
	AhUjrN95F28IK3KDqaVWm+QuiEjKUm5G16lTqAk8qCbkg9gUJNrjgK5gb3K6Hu/Z93qw+JQYlFa
	AVwUvQrGo1gpolQsjKM0cGRtk0r7SVhvFRG2OO8DU7IHCvEzgZEIimCWhJ5aUJgbkjNIyyYuCwQ
	tjCAViMZrn8O52KLSqQWGDt2GHOGFkpPj4oA1rlpPugae1NAqWWDUeOsIEdEh5PjwnacbB2ncXp
	AQuGlHp1qr8iPd/3q8giwbyoIla0YlX4sYh2MjZU6am+47VOX4BRxoNmhX90jsPTkNzMPo6HDvc
	cDoukcdAWb2tYDlFH1nkyHg5vInFsMHfCrAQE+SBjjPFhpnehukxsdh84MfW385V+5WUi2rmvEG
	jP1mxF1gwlFd6RKVHKnXAQ1IWZcojN8myZivDBL/SdPdO1jZzEeuRIwnaSNJEiro/yS0Y85ss86
	8flcoHJ2TkWq6Nc6s65J8+HtdyL
X-Google-Smtp-Source: AGHT+IH4R+oi6eXxCh5SNMXHxpNk+rvFhxu9ccM/lbkEXYVKFq22FuDgYrSryh5VRg8H9txqVQ/HSw==
X-Received: by 2002:a05:6e02:1a66:b0:430:ae01:227e with SMTP id e9e14a558f8ab-430c52a9c73mr330377895ab.22.1761248029249;
        Thu, 23 Oct 2025 12:33:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-5abb8eae82bsm1252268173.58.2025.10.23.12.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 12:33:48 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:33:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/9] builtin/maintenance: make the geometric factor
 configurable
Message-ID: <aPqDG+f9ZL4Oc1Ar@nand.local>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
 <20251021-pks-maintenance-geometric-strategy-v2-4-f0d727832b80@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021-pks-maintenance-geometric-strategy-v2-4-f0d727832b80@pks.im>

On Tue, Oct 21, 2025 at 04:13:26PM +0200, Patrick Steinhardt wrote:
> The geometric repacking task uses a factor of two for its geometric
> sequence, meaning that each next pack must contain at least twice as
> many objects as the next-smaller one. In some cases it may be helpful to
> configure this factor though to reduce the number of packfile merges
> even further, e.g. in very big repositories. But while git-repack(1)
> itself supports doing this, the maintenance task does not give us a way
> to tune it.
>
> Introduce a new "maintenance.geometric-repack.splitFactor" configuration
> to plug this gap.

Interesting, this wasn't exactly what I had in my mind when reading the
last round, but I think this is worth doing on its own. My apologies for
being ambiguous in my earlier message :-s.

I was suggesting that we have a repack.geometricFactor configuration
variable that defaulted to two, could be overridden by --geometric=<n>,
such that we could start doing "git repack --geometric" without having
to write "=2" every time.

I think that that is probably still a useful thing to do in and of
itself, but this change doesn't preclude our ability to do that, since
it just overwrites what we pass in to 'git repack' when calling it from
within the maintenance context.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/config/maintenance.adoc |  5 +++++
>  builtin/gc.c                          |  9 ++++++++-
>  t/t7900-maintenance.sh                | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
> index 26dc5de423f..45fdafc2c63 100644
> --- a/Documentation/config/maintenance.adoc
> +++ b/Documentation/config/maintenance.adoc
> @@ -86,6 +86,11 @@ maintenance.geometric-repack.auto::
>  	objects that would be written into a new packfile. The default value is
>  	100.
>
> +maintenance.geometric-repack.splitFactor::
> +	This integer config option controls the factor used for the geometric
> +	sequence. See the `--geometric=` option in linkgit:git-repack[1] for
> +	more details. Defaults to `2`.
> +

Looks good.

Thanks,
Taylor
