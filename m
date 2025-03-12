Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444081ADC98
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815878; cv=none; b=XhTZtHeW6XA3fYKMdQ55UrOry58p0vcYpEYbUchP7pUeJz+Vis0GQkMpnshD/o5EFGW3v5Fae9twAGoktVdWqNlzumZ3e8saexXZYRxjpo8KP3z41ztcSgQFnfMjS3oHLpOb2yFwjXcVhCwoxwK1Tmw0ePc6HDhwEtvAAfffmwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815878; c=relaxed/simple;
	bh=7muLlloYJOpKI9aUmrGmwhSryr5d5ym9rKINLSA9tw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxWwShKgWVDDJli/ZRImXtXFEz97panW5BDG7vVV0UW49AJK02GW/604T32DAzJdztTErylOGn31n/1tqfoqOepjdaP+jHIf34uRwWpCmOv/cvu1qkg+UEeE55zU4cGTxq2hjKaytD4AmBm+LdKi0YCGUe31I1i0PWm0OV4qQBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQIjl+y/; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQIjl+y/"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8553e7d9459so6804939f.2
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741815876; x=1742420676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6M9Y9lNz+12K5aWjZexhSHhqtPctAv5/Lbmz6yL72M=;
        b=hQIjl+y/v+OuPZTPWiMhkowYRuSAduMD+YALOufxOql6Nfh4Y4A2BlkDLGDslObhbp
         JmX8E9gyzlAMpGpHzb4tDWd18Tv3x/+LpBE+Plo/AxbdLPl4z5DkLrfkXri+DClbyVlt
         b+IoBIFmpwhLwG9MlPTJ3mSOCq4UxLCVwvpuoq4RBMhKy+CWj4Wq3cLJiiBbs/i20bbJ
         wy9BlhA1hIA4U9it4/rJW9Qm2pBatMR1zJ9HkQQbY7c0BZEVXontm8+6d2khz4iNlwdo
         KYQKqcTcqaqIByPo3Reqg2coGQj3WHGKio7lsq9fk4Mcdt85kgNmCLtJlhnYtv0jNR7t
         2DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741815876; x=1742420676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6M9Y9lNz+12K5aWjZexhSHhqtPctAv5/Lbmz6yL72M=;
        b=ge0RSAMxYQrEL1D4bhUX1Xx3k4KC86GiITKjOo4UQt5/G5ZqFcrvxIIuLiPuyyybFA
         65Z7bXIum4rrvpA7JnKM4p9lp0/ugtvh0aZ8wnJE6DIX93xlU07EaqpWzf7972y1wrg1
         AMBarPK/efJJiA9XD4Mpi6/6BeMCv85GGVMEETk8hi5EgxCCADO3UINwmVSwGZpJAepJ
         Hez6xJcRMbnAbkj45TtKJ0BQVUkUHIurzdgftr2KK4lJnEnbjmz+bOovY2sH41J3lDlu
         ReDytewnw13geXnggTOOtg1dT9e8A3+pXCqtTtiZU4UsVLPHgRTINVGVszQEstSXAnjM
         t7IA==
X-Forwarded-Encrypted: i=1; AJvYcCVkLqC0GfDek6MEuLnFshS8r6LoiofVmd1De1gSqwXsZwxKoFVL1B1X2a8IrNg+zl+3Kt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Gnoe+oUshsuovS2PWzrX2h6NToKsLJuCGB6vhPg42h0GJcEY
	ko9VscM4hr2LnKDnUvAHREQ52Cfy/Fvud6a1CFSXW5j3JRoaF1gST3pzIaf7N47IcQU0GqJ9g/V
	bj3ORjq8HJbSNB/+pYTp5BvWZbvF5kA==
X-Gm-Gg: ASbGncvnn2TEHXhyMgX0ItO+IE4lb9r3XBcz9KoOcaixvfveIqVr/CRJ1HgwfcV6nZv
	/Vfkj0E6CZxbpy4mNmOXhnm3h/jsbkavO6mnQdQw3bcZ+9M+21Tc5Ai/4q5ksmbc2F42SP+VK4v
	MQd+h+sbXdBT+mek6jOPMD54Fo8jahcFGr5nZsL098p8YgVZvi3CzLpBlWRP4S63SnjZ9L6w==
X-Google-Smtp-Source: AGHT+IG/qcG1ZYMd8Svzlu/8Twv5yJc73zWwAkDbIbzKz+TMwTX1G3mFjLq/6HeRYjFTu3zwdl4Zr6XsdrrAyWA6WDs=
X-Received: by 2002:a05:6602:b96:b0:85b:4484:182c with SMTP id
 ca18e2360f4ac-85b448419e1mr1705038539f.11.1741815876386; Wed, 12 Mar 2025
 14:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
 <c2a2be336e0ed7966b6ab0ef004f150537167b55.1741362522.git.gitgitgadget@gmail.com>
 <Z9HopHJKPv7CXI3R@nand.local>
In-Reply-To: <Z9HopHJKPv7CXI3R@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 12 Mar 2025 14:44:24 -0700
X-Gm-Features: AQ5f1JqndXMePLu7hvscl0J3YUzVOMN4FZSeqQzjx2YIaTkrDXzD8alhme8jTrs
Message-ID: <CABPp-BHoHsc8Pov+d3B6i9T4sRg2g4-tt+hLYg1VHT07XLyncw@mail.gmail.com>
Subject: Re: [PATCH 3/3] merge-ort: support having merge verbosity be set to 0
To: Taylor Blau <me@ttaylorr.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 1:03=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Fri, Mar 07, 2025 at 03:48:42PM +0000, Elijah Newren via GitGitGadget =
wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Various callers such as am & checkout set the merge verbosity to 0 to
> > avoid having conflict messages printed.  While this could be achieved b=
y
> > avoiding the wrappers from merge-ort-wrappers and instead passing 0 for
> > display_update_msgs to merge_switch_to_result(), for simplicity of
> > converting callers simply allow them to also achieve this with the
> > merge-ort-wrappers by setting verbosity to 0.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index a6960b6a1b4..8021083c112 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -799,6 +799,8 @@ static void path_msg(struct merge_options *opt,
> >               return; /* Do not record mere hints in headers */
> >       if (opt->priv->call_depth && opt->verbosity < 5)
> >               return; /* Ignore messages from inner merges */
> > +     if (!opt->verbosity)
> > +             return;
>
> Looks trivially correct ;-).

Yeah, but after thinking about it more I don't like it here.  I don't
really like the opt->verbosity thing from merge-recursive, it simply
survived because it was a semi-public API, but I'd rather minimize it.
So, in the next round I think I'm going to stick this in the
merge-ort-wrappers rather than have it appear here.

> Should we add a test to ensure that we don't regress this behavior in the=
 future?

I'd rather reuse `git {switch,checkout} -m`'s tests for this purpose
rather than adding new ones (and perhaps the ones from git-am; can't
remember if those also caught this).  If you feel strongly about this,
I'll just squash this into the later patch and make it bigger so we
don't need more redundant tests.
