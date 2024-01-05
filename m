Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519AD20F4
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 02:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVH49mzB"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50eac018059so1470125e87.0
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 18:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704421709; x=1705026509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rtJ26I9mUrPhFAP6mi+zKeQ6XtP5kdJsxfWRpifDG4=;
        b=gVH49mzB9gePGc9LHfYGMOaQVTwh08fXPt2JJumVCf4uJSmXdW9PhuFb9x6+G/+vpH
         Ds6uM3stCP5hvDcA2KDwomTs2SpunKbcU7MJ6atDsbBIvg1/WquoUcP1DT6wPb7oQb7q
         VWuoJOwBLo0QbwoWcRXcLL4HzJwgzW9Hw9/fKQxueKtaeBeNxi+4aA/JwwVk/2N3aIB6
         OpYvuwXlUs+e2LUc4u3/GQbDGdA3Y1vBVH386/DTcFI8Vc6HusjyEBSpVMnVmc1OtS/x
         q25dXAOnp5I9532ak+n02L0rDSDQ2MxXNzx9Pll/3adPVse4PdUJqH08hIw8NYPuDY6c
         9hVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704421709; x=1705026509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rtJ26I9mUrPhFAP6mi+zKeQ6XtP5kdJsxfWRpifDG4=;
        b=n0j0iiO1952Cutn1wnWv7Xk7QUB56xquwyPwH8+t3HEoN3ljMJSZ3lFiYbwic3QRnP
         QNGYDw37Y3x0V/8Xa0s68dJRQEWx2d0FG5SxjeDCumqT2ZvPuLXP4aSZBeq8xYJWU8ir
         J1eiNUs8Bsp2222RemvX2Z1c2gfyoX4BvP36nbguNXgM9sVSZNE0YEgv20mSuqvsenwt
         TFRrbN5Btqccaq3RkvxUqtoK1dkSljRoWhSJFv+8cVOEM5VQbVtq34pN4vSZL6xyiojO
         caGzCdw7Ejd3+k1rTGeRGDRPpA63p3mbbFfy+X3/gEHEHF5DnzC/cZtMVAW/e9IjdEvc
         5vgA==
X-Gm-Message-State: AOJu0YxxnvwmqWskMK0kgoljRSq7uwa5lACpemGpqraCgglR1u+nKwh/
	B73H4WtP2WzDqZP15RX+3F5TqeXyVxQwLSs3vfw=
X-Google-Smtp-Source: AGHT+IEY3/xHFtTl3MhSAmVmQWdF17NCMiTE7P6fwtsYcR3VFXtQVZlrVk/zUh8VwjnHGinYwz7qbRURZPUEBSX+sjo=
X-Received: by 2002:a05:6512:31ca:b0:50e:7be9:52fb with SMTP id
 j10-20020a05651231ca00b0050e7be952fbmr787192lfe.82.1704421709142; Thu, 04 Jan
 2024 18:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHPHrSevBdQF0BisR8VK=jM=wj1dTUYEVrv31gLerAzL9=Cd8Q@mail.gmail.com>
 <ZZcIG+mNXhZ0rHw3@nand.local>
In-Reply-To: <ZZcIG+mNXhZ0rHw3@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 4 Jan 2024 18:28:00 -0800
Message-ID: <CABPp-BGJfvBhO_zEX8nLoa8WNsjmwvtZ2qOjmYm9iPoZg4SwPw@mail.gmail.com>
Subject: Re: Does extending `--empty` to git-cherry-pick make sense?
To: Taylor Blau <me@ttaylorr.com>
Cc: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 11:33=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> [+cc Elijah]
>
> On Thu, Jan 04, 2024 at 12:57:18AM -0600, Brian Lyles wrote:
> > Is there any real barrier to exposing that option to git-cherry-pick as
> > well? Was this an oversight, or intentionally left out? The
> > corresponding commit message doesn't seem to indicate any specific
> > reason for limiting it to git-rebase.
>
> I am not nearly as familiar with this code as Elijah is, but this
> certainly appears possible by setting the `drop_redundant_commits` and
> `keep_redundant_commits` flags in the replay_opts struct.
>
> I don't see any fundamental reason why cherry-pick shouldn't have the
> same functionality.

I was indeed focused on simply getting the multiple rebase backends to
have consistent behavior (we had like 4-5 backends at the time,
right?) and just didn't consider cherry-pick at the time.  Now that
those are more consistent (though there's still work to be done on
that end too), cherry-pick and rebase really ought to share a lot more
between each other, from command line flags, to temporary control
files written, to more shared code paths.  Adding an --empty flag to
cherry-pick as a step along the way makes sense.

Note that git-am also gained a similar flag in the meantime, but
changed the names slightly: --empty=3D(stop,drop,keep).  I think 'stop'
is a better name than 'ask', and we really should make rebase suggest
'stop' instead (but keep 'ask' as a synonym for 'stop', for backwards
compatibility).  Also, I kind of want to replace 'keep' with 'roll' in
the --empty option for both git-am and git-rebase, while keeping
'keep' as a synonym for 'roll'.  But I'm not sure if others on the
list would go along with it...
