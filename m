Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FA92010E2
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086962; cv=none; b=fhc63Ww8poz1uxqo0rxYx2EnzMdg4XluXCAGc9R7nlSmz0Q1rX3zKiYdT42bgcdjubwh1pmdBLwz1obt6+8K4e8k7UGQhHpoSC1UMwWIIAwNo4KNklv7BfAsX5rzk9cTNDXmL88MA2M7GgcPrSZ0ftz6SMldIjrp3IJbhgNVuWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086962; c=relaxed/simple;
	bh=nFLvH+GAY5tQ8jdcEawN9aN8m9Fzt5G0RS98dReqWkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UugAg/gHZgrP9HDm1kBdyRXZFcsyPmwL/OfvFuO36xSmjCUt+X+hecMOLRs9p5gLBnIGU/d6ejH8v/GoPpVfzmYxVThC/x2AiAMfckdOme3TE/ezBxaQ3QivFHn75DBJMmC7MNaRzIyeyUrRCkmflwKjVK/uqp0mBV4PiiEnc60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WH+93OrY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH+93OrY"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549662705ffso2563729e87.0
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 03:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741086958; x=1741691758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxg+MN4bA34c354YnSVIxGqvI3nTFUucVDAAYJS1ShI=;
        b=WH+93OrYRFofxSJqmKvjlBGbX+88wCmX72HcqPVVTCwWVmQ2N1pUkZxRv2c8vnr1la
         rBBb1QWymO0upeK/YR3DA0dfyj99PjuuNL9yQV66+Mxg1kFZYLQ/GF6EemG/RtC2is7l
         w67VDzik9+1Sy0p0OoFaZt1yqdn+vro/catjjlwKWtz3IvUKhCi8ucgp+sq4bjpGrvvc
         576rc77AEEq7evcbFQXMSX8Y1KyKR3EmeX45YOagQwoVc106oN9orgIightCoiEokMMB
         DshZOKMUC/qeBP7lxubhrsw9LMMrZ4hpklXpNyImbaXM5mVx6ewZ3+7z3+nABKXK1WUn
         wsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086958; x=1741691758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxg+MN4bA34c354YnSVIxGqvI3nTFUucVDAAYJS1ShI=;
        b=ezVh+EbbII9EmH2kB8WPNvMbZ4TJ0H9V92IuBZRsJ4bCBI8TamAdhgE+trgycTw1oT
         +idtz5nnhs4Jvmy5vM/BrU5u87V3VBP5BLtiBHeUWUX/EhIhtzBHqWKTNe4scNFpWCH4
         BWhIPsmG5qNgf3NtJRw9C8/R/0vuMjQ+qkNDtF3R7HDSgMwBXd47QlSzzgW7SPLDS9Md
         hB3NFtvsI+LZAfg3j3akkoXUr0pVY/6TLN3CFeVL+9cMLqlKM7dAGs4lAv0+S+5WUNki
         07+P1PK6ACpFgBncQd0rMllLp9hU9u28W6B06UXaUY6yr9mOLPbA2/msG2xV9kUY/do1
         yYKg==
X-Gm-Message-State: AOJu0YynMaWr4yEOHWizTRh3lKOV1tJkPa1ShHtvu3fpQcuM8UoceBFF
	pw15xWKCfWmuSPWWHC9AYqhNqa+W0bPQt9MnSrj9HYlk5e8o7jXh50yWaxnNLAHTpOkzK7hFSIV
	EYC+ZRrJP4hJa/Dbn6L9TsGVohX9OcLhAsMo=
X-Gm-Gg: ASbGnctxwE8tkRSqKI0zzh+does9XUpUgYmbtKgGAdOtLiUgWyDpTF5Yy8+GsYAoeEm
	MDqJXky49gS/OwalfsHFIQj8QJFz5Y7U7Xz4uJiBWPtbCjJnh845VuHiysoGRjcALCRPqQo+Qd2
	Om4FQL1dAzvK0GjywgFrFi+1FktiEAU/W8VsmWi21XHMcKFI+Ws8IckLW7mqw=
X-Google-Smtp-Source: AGHT+IF9CiqUv1ep8epsLlhfa4BYz1Ly3hcAV+si0noet2a8xUMazRG84xt4PnOdq1km1Pvb/Nu5DC4YiCMTgBRZikY=
X-Received: by 2002:a05:6512:3f04:b0:545:fc8:e155 with SMTP id
 2adb3069b0e04-5494c3283camr6572139e87.20.1741086958150; Tue, 04 Mar 2025
 03:15:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
 <20250304092722.25757-1-danimahendra0904@gmail.com> <Z8bd3iHrhXb4WH6A@pks.im>
In-Reply-To: <Z8bd3iHrhXb4WH6A@pks.im>
From: Mahendra Dani <danimahendra0904@gmail.com>
Date: Tue, 4 Mar 2025 16:45:47 +0530
X-Gm-Features: AQ5f1JodUrT9YQr46CfMVB-UVxIcW853Kb0tc1P4caOGIHg6nep-2ddw4wfCoEs
Message-ID: <CABGrwBC2120vR6=NuXHzQnsv+Bfy=W+4Nx8zjUHqLDq+4V-FPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] t1403: verify that path exists and is a file
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 4:33=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Tue, Mar 04, 2025 at 02:57:22PM +0530, Mahendra Dani wrote:
> > test -e does not provide a nice error message when
> > we hit test failures, so use test_path_exists() instead
> > and verify that if the path exists then it is a file using test_path_is=
_file().
> >
> > Signed-off-by: Mahendra Dani <danimahendra0904@gmail.com>
> > ---
> >  t/t1403-show-ref.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> > index 9d698b3cc3..4afde01a29 100755
> > --- a/t/t1403-show-ref.sh
> > +++ b/t/t1403-show-ref.sh
> > @@ -196,7 +196,8 @@ test_expect_success 'show-ref --verify with danglin=
g ref' '
> >
> >       remove_object() {
> >               file=3D$(sha1_file "$*") &&
> > -             test -e "$file" &&
> > +             test_path_exists "$file" &&
> > +             test_path_is_file "$file" &&
> >               rm -f "$file"
> >       } &&
>
> There is no need to execute both functions. The underlying
> implementation of these functions use `test -e` and `test -f`,
> respectively. The former merely checks whether a path exists, whereas
> the latter verifies that the path is a file. It follows that when the
> path is a file it also has to exist, so using `test -e` (or rather its
> wrapper function `test_path_exists`) is redundant.
>
> Patrick

Sure I will remove that test_path_exists() check in the patch v4.
