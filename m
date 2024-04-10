Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2759813C902
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733045; cv=none; b=S189XDwPfbq8llArWZoGx7Z0kguz4kM1jziWFBxKC1I8iP/BcupkJltQOXFt5WYidc9974K89Pg9Jzt0Gv+5ILx6wzWiz8XxNtgjQDZqamM/vAujCJfAJXUKq+pXkYaqfJdV8jgBxGVL5aMoTNExbLp1M1+qjmAhPsskI8z1TVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733045; c=relaxed/simple;
	bh=Fcz9qH7C/3cZDZgNC1vFhRQOv7gy9ZN4XAl+6lkD7q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwTsthSMGKIDkH5yKSsTHxkpMoUVI/U5LcSrn5oNp8zAbOJCWgyi3MlqURd7YD8HXMTAQJFA0b9R3jrRflWO6Algl67IjnDZNeM/zb19cwOEqbTbNgXkBTQkPtnfsBciBc8W4sv5Y3IgaKujDTfdW7cU9YnBpapXJFEjI2MMrR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alniovfB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alniovfB"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so241567b3a.2
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 00:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712733043; x=1713337843; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=spuDFVgHH7W3ZvmKjgDMpTA6Gy6WlW+/CIIG+Jkuugg=;
        b=alniovfB3j1sj9iA1Z5z7O2qEyh5I9Ws8G88mPLREC0eM5p2VrgQfaz8cc6njpqV0w
         AsC0rgPyzB9BHchGPmSNiFymipeGpIr5isZ2Tbz0zaH4DsMgt9DgXlI1qw9G8aRX/vYu
         Y+gNoXBKvbFqG5oVy+f1iIvIOlIojG+WLoJXeNGWpyf+J1lhjJje9ZM/CJLIMKOqQnXC
         UvhBm1uF2iPLAhadRDwb0zrjPscz2dWy+j3N62sOaP5mYMYKa69EMPgStrk0BTFCAEhE
         rBrEfe8lKs7soiV6jXJpby0dIdcP3XnN/r3F3K7Cb4bkTRXEl/z5sZSzi/6ICfpJMm7Y
         Brig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712733043; x=1713337843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spuDFVgHH7W3ZvmKjgDMpTA6Gy6WlW+/CIIG+Jkuugg=;
        b=EVs5b9O9sJ9ypufZUS+qsQLc0/HcbF4D3BweYXLTbjoN04dCHD4Ne1xfMjx2Gc9Q2E
         Vn52a+whDhKhoSTOYK9BsQzL/+XPz9XJ1M0bmRPtJeedi7Ro2TeQwoBKmNEm4OXOa7bx
         TI/iRwddEVyJf/Jsfz0+1wKOv6VKuC+01oQlJzx3+z4JfDOivrqjwn9E54rzzBY5C3fR
         PEA9QNoj/XhC5ZHpVDnIVCgAGgQz4ireJ6uDlDAawWCAK2mrUiGL4ijBcyZuB/Kh/DCG
         u/hee/M8uD4QIh9JVEd6WcXGQeDXmRLNUgET8w8oUVKqfthsLBb539SMgbKsjE8KP3F1
         P4nA==
X-Gm-Message-State: AOJu0YyLA2YCgqRIyQahQanzhqdKFaRgrxuf5FBdmtXQ9uICJckQAJwX
	w51XGoNkE+yf1CF4XmcxRzMqbTJCXjfOpBeXF4JHTSmlyg44nX2Us9q2tt5m
X-Google-Smtp-Source: AGHT+IG+hZZWBpq34l8F2BWG39D6zeJNpJCk7oORnfDMudA7dF2SB6jklxrTF1z9cFw22n9dVSZElQ==
X-Received: by 2002:a05:6a00:22c3:b0:6ec:df4e:96f9 with SMTP id f3-20020a056a0022c300b006ecdf4e96f9mr2033191pfj.12.1712733043199;
        Wed, 10 Apr 2024 00:10:43 -0700 (PDT)
Received: from localhost ([14.191.223.174])
        by smtp.gmail.com with ESMTPSA id ks26-20020a056a004b9a00b006ea97dc8740sm9464454pfb.78.2024.04.10.00.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:10:42 -0700 (PDT)
Date: Wed, 10 Apr 2024 14:10:40 +0700
From: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] t9604: Fix test for musl libc and new Debian
Message-ID: <ZhY7cE7MtgIWBCfe@danh.dev>
References: <23a4298eababe54ca4b43d7b675b858605d20ec5.1712374021.git.congdanhqx@gmail.com>
 <20240410032812.30476-1-congdanhqx@gmail.com>
 <CAPig+cQ5MWXxwOvTWYthKXbzPa_SVZX6uXZ2ASQkz6Ec8-pitg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQ5MWXxwOvTWYthKXbzPa_SVZX6uXZ2ASQkz6Ec8-pitg@mail.gmail.com>

On 2024-04-09 23:37:16-0400, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Apr 9, 2024 at 11:28 PM Đoàn Trần Công Danh
> <congdanhqx@gmail.com> wrote:
> > CST6CDT and the like are POSIX timezone, with no rule for transition.
> > And POSIX doesn't enforce how to interpret the rule if it's omited.
> > Some libc (e.g. glibc) resorted back to IANA (formerly Olson) db rules
> > for those timezones.  Some libc (e.g. FreeBSD) uses a fixed rule.
> > Other libc (e.g. musl) interpret that as no transition at all [1].
> >
> > In addition, distributions (notoriously Debian-derived, which uses IANA
> > db for CST6CDT and the like) started to split "legacy" timezones
> > like CST6CDT, EST5EDT into `tzdata-legacy', which will not be installed
> > by default [2].
> >
> > In those cases, t9604 will run into failure.
> >
> > Let's switch to POSIX timezone with rules to change timezone.
> >
> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> > diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
> > @@ -3,11 +3,28 @@
> > +test_expect_success PERL,POSIX_TIMEZONE 'check timestamps are UTC' '
> >
> > -       TZ=CST6CDT git cvsimport -p"-x" -C module-1 module &&
> > +       TZ=CST6CDT,M4.1.0,M10.5.0 \
> > +       git cvsimport -p"-x" -C module-1 module &&
> >         git cvsimport -p"-x" -C module-1 module &&
> 
> Is this duplicated `git cvsimport` invocation intentional?

I have no idea whether that was intentional, it's there from the very
begining.  Apply this diff on top of my change, and tests still pass.
----- 8< ------

 t/t9604-cvsimport-timestamps.sh | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
index 2d03259729b5f..c51a9fa8b6ca6 100755
--- a/t/t9604-cvsimport-timestamps.sh
+++ b/t/t9604-cvsimport-timestamps.sh
@@ -25,11 +25,7 @@ test_expect_success PERL,POSIX_TIMEZONE 'check timestamps are UTC' '
 
 	TZ=CST6CDT,M4.1.0,M10.5.0 \
 	git cvsimport -p"-x" -C module-1 module &&
-	git cvsimport -p"-x" -C module-1 module &&
-	(
-		cd module-1 &&
-		git log --format="%s %ai"
-	) >actual-1 &&
+	git -C module-1 log --format="%s %ai" >actual-1 &&
 	cat >expect-1 <<-EOF &&
 	Rev 16 2006-10-29 07:00:01 +0000
 	Rev 15 2006-10-29 06:59:59 +0000
@@ -60,10 +56,7 @@ test_expect_success PERL,POSIX_TIMEZONE 'check timestamps with author-specific t
 	user4=User Four <user4@domain.org> MST7MDT,M4.1.0,M10.5.0
 	EOF
 	git cvsimport -p"-x" -A cvs-authors -C module-2 module &&
-	(
-		cd module-2 &&
-		git log --format="%s %ai %an"
-	) >actual-2 &&
+	git -C module-2 log --format="%s %ai %an" >actual-2 &&
 	cat >expect-2 <<-EOF &&
 	Rev 16 2006-10-29 01:00:01 -0600 User Two
 	Rev 15 2006-10-29 01:59:59 -0500 User Two
----- >8 ----------------

-- 
Danh
