Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA778216A2E
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801695; cv=none; b=J5Lfwj87sm7N5f5h1qAtiAonCWX0IZbxDDBvrIMYL7RnuuMulAEP2tKcdGtaDGL1hsZnhJh4CPjvHRwSKhCO9C3Ef3A/dhQd8UVAMbieYG7YsGgruSCD3vWOAR6mdD+Og2pZzEVVbiQz35dr3azNs+lGp6B0mRlQEleikeY9tw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801695; c=relaxed/simple;
	bh=5SlGCvtefMglW996TAycYCld6Wx36afB7xbCTYKVKeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHj8vM957+PtraQ8Fhi0Qyrhm/J9GkO6vHwC+aiJ1Ujbbc6IqcsRbUocIMgm8pu6f8I2Ng6dh/X+itVrXBnfmXqmV+cjEESb1dv1SoloP9IvSImShIlH/ELR7mAe8lD7BmMPu40Fkyb52oPDHiz/x26k2Uu/1Us2CvlSocGnaVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Scsnh36y; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Scsnh36y"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e2915f00c12so1547513276.0
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729801692; x=1730406492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C28h/7ekqPTcwJ00my/peyAY4WFJBE0YxJalntXP90o=;
        b=Scsnh36yPKy9UKG3kf4jXwb4mvIPg3afNs+R4r0q3cepYp5CGZKhqt8D5WIKI1zs/s
         uDPrSOST+Df01OSSCKocBiEloWTd38r6GDoX0vB7XY2sDAhrViTTrUe5zq7SR5F3UzVG
         E3P7urAh5jtwguSAzll0sZuJOElLNUZXtYbsPdaJ1E/NdLht34cL9pt7gaKZakFX7f90
         uFHFKoLjN1D+82IZPKp4W/8EvSpLh/igfATv1gdwMsJeAUb3N81z6HBSgBZN2DHwO0WH
         7jXGInx4r34Bv/typY9oGurY8ZBDWBW21Eqkq78aQdaQ+Nq7sDh4lOa+kmniVqmHa/+w
         /lZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729801692; x=1730406492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C28h/7ekqPTcwJ00my/peyAY4WFJBE0YxJalntXP90o=;
        b=OE/q23/Av1bcoPCWq0p2VW5ZQszqZL2tvs/h/kmPvCCpin71Ob89iMJLZaad/LWWvO
         2vaJ6vRr7fCBH4raBFurcUOGOEmySnBJ2nkfXgoMZuEYtk/f90ivP1mzMdgISzp2l8sY
         AYEy1pRY5iHZKRe4wWznEmrZ2eq0flIGohAJfae1xGH7pzW9Mdk91PbjWtpkeXf8kTL1
         p/anNfbbVcDAUw4Q6qRzSFEn33MXpFiuKkgYbDNfeVbS+N8to25zyp9oJlDhDG0lSSMx
         mf/RJVrxemK2NfYj0Vto3HTN/5SaOnnegVM6s8UyjjjZ0xcjp+OWqfXD6knhhhPnd9nD
         TYKQ==
X-Gm-Message-State: AOJu0Yz77CVGlLaa8hlTkXwDPc/v8vVgKMYHwDXLtqisTouKZht0JYMt
	p6HuQNPXBAiVq1O8cuRuqMUh7wgZQrlJq5M1dc5JSy4ZDlH5/jji6PWE90LzACjWTWl0+n/+/hH
	LKMed+UqpliY4cv7UauK/eRKTSM4=
X-Google-Smtp-Source: AGHT+IGK2/mFadzLPzpsnuEb260OQjLdQLbjg/haUOTwQuernXONgNYejOlYaAlqXRdH+qGCaywAVznj1POMxdEer+0=
X-Received: by 2002:a05:6902:2486:b0:e26:5b7:9f95 with SMTP id
 3f1490d57ef6-e2f2fbc3321mr3649008276.35.1729801692606; Thu, 24 Oct 2024
 13:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240926013856.35527-1-eric.peijian@gmail.com> <20240926013856.35527-7-eric.peijian@gmail.com>
 <CAP8UFD24jDT1yFNTp-T==-avccd4QjrwRtfJ_-wPx78H31VSiw@mail.gmail.com>
In-Reply-To: <CAP8UFD24jDT1yFNTp-T==-avccd4QjrwRtfJ_-wPx78H31VSiw@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Thu, 24 Oct 2024 16:28:01 -0400
Message-ID: <CAN2LT1Dk7A-y9ffNTjf+UP6VKZZgFOephFSAk8eDUi06UjteYg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] cat-file: add remote-object-info to batch-command
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 5:49=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Thu, Sep 26, 2024 at 3:39=E2=80=AFAM Eric Ju <eric.peijian@gmail.com> =
wrote:
>
> > And finally for --buffer mode `remote-object-info`:
> >  - Receive and parse input from user
> >  - Store respective function attached to command in a queue
> >  - After flush, loop through commands in queue:
> >     If command is `remote-object-info`:
> >         - Get object info from remote
> >         - Loop through and print each object info
> >     Else:
> >         - Call respective function attached to command
> >         - Get object info, print object info
> >
> > To summarize, `remote-object-info` gets object info from the remote and
> > then loop through the object info passed in, print the info.
>
> Maybe: s/print the info/printing the info/

Thank you. Fixed in V4.

>
> > In order for remote-object-info to avoid remote communication overhead
> > in the non-buffer mode, the objects are passed in as such:
> >
> > remote-object-info <remote> <oid> <oid> ... <oid>
> >
> > rather than
> >
> > remote-object-info <remote> <oid>
> > remote-object-info <remote> <oid>
> > ...
> > remote-object-info <remote> <oid>
>
> [...]
>
> >  If no format is specified, the default format is `%(objectname)
> > -%(objecttype) %(objectsize)`.
> > +%(objecttype) %(objectsize)`, except for `remote-object-info` commands=
 which use
> > +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not s=
upported yet.
> > +When "%(objecttype)" is supported, default format should be unified.
>
> I think we should warn more clearly and strongly that users should
> take into account that the default format will change. So they should
> better not rely on the current format in their code.
>
> Maybe something like:
>
> `%(objectname) %(objectsize)` for now because "%(objecttype)" is not
> supported yet.
> WARNING: When "%(objecttype)" is supported, default format WILL be unifie=
d, so
> DO NOT RELY on the current default format to stay the same!!!
>

Thank you. The warning is added to v4.

> >  If `--batch` is specified, or if `--batch-command` is used with the `c=
ontents`
> >  command, the object information is followed by the object contents (co=
nsisting
>
> [...]
>
> > diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-=
remote-object-info.sh
> > new file mode 100755
> > index 0000000000..6826ff7a59
> > --- /dev/null
> > +++ b/t/t1017-cat-file-remote-object-info.sh
> > @@ -0,0 +1,750 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'git cat-file --batch-command with remote-object-in=
fo command'
> > +
> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +
> > +. ./test-lib.sh
> > +
> > +echo_without_newline () {
> > +    printf '%s' "$*"
> > +}
> > +
> > +echo_without_newline_nul () {
> > +    echo_without_newline "$@" | tr '\n' '\0'
> > +}
> > +
> > +strlen () {
> > +    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
> > +}
>
> The above functions have been copied verbatim from t1006-cat-file.sh.
> I think this is worth a comment or a TODO before these functions
> saying that common code might want to be unified in the future.
>
> Maybe something like:
>
> # TODO: refactor these functions which were copied from
> t1006-cat-file.sh into a new common file, maybe "lib-cat-file.sh"
>

Thank you. I added "lib-cat-file.sh" in v4, and let both tests
t1006-cat-file.sh
and t1017-cat-file-remote-object-info.sh refer to it.


> Except the above nits and another one I found in patch 4/6, the rest
> of this patch series looks good to me.
>
> Thanks!
