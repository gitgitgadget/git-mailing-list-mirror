Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB043E4C96
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375072; cv=none; b=Rr38wnUBAXQpnCx/4FSImoQzDmFDf3W87Z30GgmzVV38++Cr9HdG8CAVAiFwYSYbPbGgeLiJNeBU8Fs4k6BpwwzctVMZQvz1/Btr4qLmiQ3EPeN/P2Lg8B2peZRPetQrbM4qVlqxI45mOFQ76vHf7cTf8IxZS9xKH517yLPjhn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375072; c=relaxed/simple;
	bh=b0S07iP1dfaaoiS1iSBbdDz/+QU5AyZ6c6sWxkop3SA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RCpqlb5m7fhryXqvRKvQWQaL7g6evqZGJxOi0aS67fSKoEzb9IIj6//hIW2Np/un2yZ72ZvJiABV4pNagtG/dCwCK7EMWcE9hxPBnbVAzN0A/6f03qtdyChqgv+QNGA/q7G8O/JkCQ556wrFcFfjKh6+QdJfxPcVpDfzi7ZHDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc/z+JlS; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc/z+JlS"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b965f447cso12335135e9.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789375068; x=1789979868; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b0S07iP1dfaaoiS1iSBbdDz/+QU5AyZ6c6sWxkop3SA=;
        b=Wc/z+JlSrTi44qp42yWLsbpeWLsbY8DBn+expBBVaHEi6hnfYatz9wxPl/8gYZq57e
         9HlzIi+Pit5fRWiwtJpy3CgZHxHazgD+OsurNxfNlS0/uEskGhsvPhbxBatcwzdjJLjq
         EDbSbkupnpzppnr1JL/ZwteFfng6A8OcwrpS05jJ8gzuYicI34IbB8IcvUnFaniQ16If
         p/WHmBsMLot/GrRo3eUD/nEZqzMAI8MkEXnSn5aeQw1o+HZCsNdRo3ruOFn1yyjPoFZL
         V2cTXWYwGx4y+H2k5YZHX2MrwYL+LegtQdAuALGby5mE8R+diposTGKq9RChzxsR0/BG
         5Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789375068; x=1789979868;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0S07iP1dfaaoiS1iSBbdDz/+QU5AyZ6c6sWxkop3SA=;
        b=BFJX6GWz4mcHnkT3V3WTfZ4INqOUoRzWd4KHZcsFzDtJrXhgeppx1SXTrBHsVEDqEV
         b14T8BqjFUYBfXDl9wn0o3dFOpwFciNOVLJpUWQ8uXZigj1yXf/qCiSECp/pjRVcEzlO
         2V3aXFQ8wAU7tgrjC4yP1bPDNHoWtqUpI7tdlI1ajs/6RYBJ85RWeE0CH/dC4PX1ofV0
         jdG94GXjFlD6upYnWEaGyAhhEiJNx5Nmp9l9MO+SZR7K2dME5hkghZWO5QZTe8mej1vP
         5qPuclahtJ7g3ZhKX7U7VdcJtr1yttH0aTIWY3SyOFkEqnI0NxU6a3dtowZTkFMIyacc
         6IbA==
X-Forwarded-Encrypted: i=1; AKwUvBwIBPaKKyLT5JG0hXK5VtoAdbibpSeuQ0Gz/H4KKpMiePG/57Yps+8ST+qODhO6xweUqp0=@vger.kernel.org
X-Gm-Message-State: AFuF++lLoswhR9gly5EAvKBgXJi5753wibHAZi3I+9X0OYplUpN55mQQ
	KB+ConcnpWry9Iwajp2gNwib5G2gLYLF/lb7cPiCVCWhqMV0t+OO/nWH
X-Gm-Gg: AYBFou39JdBGX9B+qvvzogfF278pCDn6FknOKjP04HbIYgRQczeEJrUmy1Jl+IXMuVA
	FySWV+RQU5pDXiRbLNTjEPzBvN/ac+FUio2GLaBIeMKZ4vQWP5C1SByqAOCHgabIEGBMNKnuBQM
	qFUwDhoA/XGekSb4O+FPAQRqeSxYHabmYKZTucL/LPxtPY02AeU3XlFmVf1AWEOnR4nspx5QgXj
	GxV/z2UQ2JekuMTPCpc/t0RXnumBfTNqwMfrWCV3KNuAMfbREchwUDQhC13Oe9CzfoweFCZm33U
	pzsVlu3j0BlWqg+10L8QL1LtgnwqLnF+Nn09Ij7nBrzvYeqY3zEg8x0VAtHzTD7sBFsQyy8MTSn
	p600JzCr7mX0VF8gMYuvHImX50EXGIGJUBlQffjnrJ2qRBD3sMm4SOTLPD8tX6+8MvppfJicO9C
	0WwYHwD6pVIGgMR7mynU/QGe+WfA21vB4qHJE2Hn4T30URifZPmJZbapPL268qQxTv4JRbte/AC
	bZC/Y1TSoPTma6GBjmh7444xTDHd8SxSnRbWH1DF1IaGaLIffrT0rd42smCpFIPdgKUccBtiQ8S
	OcuqSfxjVRQ0VhdNjneoNwwqdUu+VuuKkjSZtRbJ8FX07qop9sRmNR6LIrN7xSyoMu7rCbv+GUa
	RE/d/nSfLbLU0yNNj+AMvz/M=
X-Received: by 2002:a05:600c:3583:b0:49e:645e:2616 with SMTP id 5b1f17b1804b1-49e7a637631mr22065925e9.5.1789375068257;
        Mon, 14 Sep 2026 01:37:48 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:dcf3:86c2:4b6e:597])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35bed0sm25920221f8f.32.2026.09.14.01.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 01:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 09:37:46 +0100
Message-Id: <DLEWITFIKFFK.NSANTRY5XBCB@gmail.com>
Cc: "Git at SFC" <git@sfconservancy.org>, "Kaartic Sivaraam"
 <kaartic.sivaraam@gmail.com>, "Pablo" <pabloosabaterr@gmail.com>, "Usman
 Akinyemi" <usmanakinyemi202@gmail.com>, "Tian Yuchen" <cat@malon.dev>
Subject: Re: Participating in Outreachy's December 2026 cohort
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Christian Couder" <christian.couder@gmail.com>, "git"
 <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com> <CAP8UFD0oYnoXgQ84wHbGg3+QhX78Ucn_CXXYOe8uFpReb7X1Ng@mail.gmail.com> <CAP8UFD1hAjtPuWL8asZ2LzEMJKHGh2oO73n_tsUSADtEHh9b-g@mail.gmail.com>
In-Reply-To: <CAP8UFD1hAjtPuWL8asZ2LzEMJKHGh2oO73n_tsUSADtEHh9b-g@mail.gmail.com>

On Wed Sep 9, 2026 at 10:12 AM WEST, Christian Couder wrote:
> On Sat, Sep 5, 2026 at 10:26=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
>
>> Let me know your opinion about these and if you have other project ideas=
.
>
> As no other project ideas were suggested, I submitted the project
> ideas I mentioned above. You can see them in the "Approved Projects
> for Git" section of the above mentioned page
> (https://www.outreachy.org/communities/cfp/git/) as:
>
> - Improve how command arguments and options are scanned and parsed
> (https://www.outreachy.org/outreachy-dec-2026-internship-cohort/communiti=
es/git/#improve-how-command-arguments-and-options-are-scan)
> - Reduce Git=E2=80=99s global state to enable Git's libification
> (https://www.outreachy.org/outreachy-dec-2026-internship-cohort/communiti=
es/git/#reduce-gits-global-state-to-enable-gits-libificati)
>
> The links to these projects are currently only available to approved
> mentors and coordinators. I applied to mentor both of these projects
> as this was required to submit the projects, but I am very much
> willing to remove myself from mentoring one of these projects.
>
> So please apply to (co-)mentor one of these projects, or submit other
> projects you are willing to mentor if you prefer.
>
> Also let me know if you see things that could be improved in these
> projects or the Community Application for Git.
>

Hello,

I've applied as co-mentor for the libification one, this way we have at
least one mentor for each project.

Regards,
Pablo
