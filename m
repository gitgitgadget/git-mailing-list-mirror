Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB626E6F9
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752608123; cv=none; b=WifR8hA+GRXOiOFKEHX4L9SfTF4CGb7u3U1MWK9PxD6x6p7r8LPXgjFE1Izf+sCi+OTcncwBcftxbthw6W5Mx4AartFbVMJOmf31JTxQJVIR8r+WVGNfnVl8CEH6VhoDqINaSprU8cHcNt3r3uO1DW7SR1Jq9a8wvH3oy0C8BWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752608123; c=relaxed/simple;
	bh=pMrhZa28X1DJoJlhEfeeZO2vZPKR01xy/Mb03s5d2hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MD7KSj9+f8noNYaPqT/Ol1HCLy3UMB6B7iSK2wFoPiunHxUyJRXb1vKMIlqY1TVzE5ZWN1UMCQy/q5knaKXLiZH3kZ+/cIG1rr2xNa5zpZ4nCpeq42h8p/nCvjrJvi/28Q2oW/4ZiUN8GUCiq5At+DdAvxifS/jRLYYDe2+i3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYfxvi5Y; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYfxvi5Y"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-875dd57d63bso12789439f.0
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752608120; x=1753212920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIvRGG37Y1mBAuHt8gEAH3gQXXXD+B6atJwI8WELdb0=;
        b=SYfxvi5Yb5EW4qkVw7Kpks3rWktzSVH3m9AbByeKPSSrrShwlAPYyz2ydFbR9rtUfk
         7rJr6iijO38Oy+EcoZapwLuU7G5VkzHI8ah6ZJ5QoNg7wyHdI0UKGKFWgDqTKDywRKoy
         bWjW/Vc35BhP+6rEQs+E+eC4Aqs+WZEJFdXuN+Mzw03ELNfCRhDiQQ8NERK3DxKEppOD
         rWXDDfaARJDgYxHXkg5BMFS3DwRmBSltLXry/nveG24BiJG6m3oIcwGxIbeml9RuZ0gM
         v1spTp4ZrFybGMhde+e3T7d/3ZAJG48dEfL4qzB++nto/N5HI2CZkTt5zwEt/5DPZhFW
         26Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752608120; x=1753212920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIvRGG37Y1mBAuHt8gEAH3gQXXXD+B6atJwI8WELdb0=;
        b=Q06sn27Sm8mehvrOJ4g8LwhACQ6/zIlcLBfHy92gLd8CLaPQU3eYvpkH4UAjwcgJ5l
         x+H+eHweCo+2Gj6txNvUpBNys789SM7mp5TQsPPCP4GB9e3MVPfN4d92zZ44sIvmg3zZ
         05wgGiUWHvWKt3EEzMGCkrXWEqsUVKmxWdkbX9DrgzSoHeHtC/zJQTMvR2jP0LJuxiIs
         M07SBFTWNZwOURQYYzLReoAibkier1W5eSNUiaZcnOAVgFCJabGyAU+hISzVxGaGr8PV
         OjhgM8RMFTqNGdD5vNRvCF1I6U0GjFwaN0IQyLgvPZr46HfklEsi6/nOsKmqfA1Veo4B
         vh4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXen/oRxzGa9i4037Xc9iWh1uO/W4Ru7V9bKx0bcyrL7zF3wBTVZJ/nfhmGYRK3VrBWakc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4fh9bSiErHOnjb7QOKR1oxyvYg0b3iZKZSO6hb7h6OXunUZwl
	tYzdMGKquW6oI9EDCSFyztcsjEpTbnS4+dWCXclpFrA80x7CghmtASqpwSLkEUx8BSMZ4lYCg1J
	6ueK3EqoJHnY14edQ1sNDzUZ3disIyIp6L7Z4
X-Gm-Gg: ASbGncuWEPS1mKXMxQLOvM66xa6gZKJiNCZn8EiYaAXxDQyjtWGPDkQzzj/WIphxmr+
	PeOGJpITylaQGWzYR1LeW8lH/Q8tyxAuGaKjHpCzQ9UUTF37aiui3LOHdpIoEAD4BUNOflqcFF+
	84lFN/sCHZARn2Of970uxjydeM6g8iv1WP3RgCk5WlkWxtDnz6KvynFbDdCtLywpv9hlh+dv8Yo
	dCj9fGyj5kcW+3Tgwg290fRDl+99xijuQB6TBPe8g==
X-Google-Smtp-Source: AGHT+IHehakBDSIQAaA2HPQW68mSMGztRc2RP8OHgjDFuDd9y5Q/7axRaJDA7DQ5eh+LsPJsYv59GS19dJ4FAiSUdiw=
X-Received: by 2002:a05:6602:2bf0:b0:876:737:85da with SMTP id
 ca18e2360f4ac-879aec80118mr460907439f.0.1752608119720; Tue, 15 Jul 2025
 12:35:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
 <cover.1752587571.git.phillip.wood@dunelm.org.uk> <CABPp-BHoTxT1UQtgy2bH=mc1re_LPngKX-50GPh_wbtMMZZpyQ@mail.gmail.com>
 <000001dbf5b5$8b316f00$a1944d00$@nexbridge.com>
In-Reply-To: <000001dbf5b5$8b316f00$a1944d00$@nexbridge.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 15 Jul 2025 12:35:08 -0700
X-Gm-Features: Ac12FXwPr2PJu6TcancHZ_FgzoOuc-aSKCZ6AlpSdtC9XovcC76b3ti25KdTARc
Message-ID: <CABPp-BHjU2NFVoM+wkBxDrr3P85yYzmS-O4mBAc_e4_6wfOBMw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] C99: declare bool experiment a success
To: rsbecker@nexbridge.com
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	"Brian M . Carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 11:23=E2=80=AFAM <rsbecker@nexbridge.com> wrote:
>
> On July 15, 2025 1:19 PM Elijah Newren wrote:
> >On Tue, Jul 15, 2025 at 6:53=E2=80=AFAM Phillip Wood <phillip.wood123@gm=
ail.com>
> >wrote:
> >>
> >> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>
> >> We've had a test balloon for C99's bool type since 8277dbe987
> >> (git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
> >> 2023-12-16). As it has been over 18 months since this was added and
> >> there have been no complaints let's declare it a success and convert
> >> the return type our other string predicates to match.
> >>
[...]
>
> bool is not standard in all c99 implementations. I have to #include <stdb=
ool.h> in order to
> use this type. Please make sure there is a mechanism for that.

From the referenced commit in the commit message:

$ git log --oneline -1 -p 8277dbe987 | head -n 13
8277dbe9872 git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool
diff --git a/git-compat-util.h b/git-compat-util.h
index 3e7a59b5ff1..603c97e3b3f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -225,6 +225,7 @@ struct strbuf;
 #include <stddef.h>
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <string.h>
 #ifdef HAVE_STRINGS_H
 #include <strings.h> /* for strcasecmp() */


So, there's not only a mechanism for that, it has already been done
for you 1.5 years ago.  No extra work on your or anyone else's part
needed.  :-)
