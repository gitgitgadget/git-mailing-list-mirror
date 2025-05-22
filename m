Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA99176ADE
	for <git@vger.kernel.org>; Thu, 22 May 2025 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747898377; cv=none; b=MwzG4j+jR7Ajl0C5npZN98tZtwepn7DH3hUl9ltWBirX/KPJeX9jOsYryOx1M97QlPimD0q2U/IgCPGdCp9BILDYPAvgF0F2jbQGz80cOIc2Dn5eAPV2oY2OfoaKPsFZryjpYfxqLx4nZjNPKvAJ/f2xGOLhGKUyEZL8Ax0pv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747898377; c=relaxed/simple;
	bh=Wo3qEYUr+Nq7eRD/yZNSRKsqe9nTTn0J/jn5BIoDA+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzwRS27wcTr4JbdOsBK3XD9gxlKVlryeAL4FY4FqVTCJCco36RgxtOaVeGgmyEtghHrW0UGiiii/Oe7i4Q74nf2LandVP8bELiGKvtH4yAkDXqcixBK0FphYYxsVSzvNV0X8Cn8Q7C3vz0aZdqoAiy2n7HZym1yIIcRyn5r+Z2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jEvDnvzf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEvDnvzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747898373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UFMA45o5Hqm49kNu9mnGNT18DmztaEurBzdVUR8fd0=;
	b=jEvDnvzfTgfFWyL745jmrDtY7/VAXZwxLAi0tSDnrJNaMqRcmpqCzFHaMD11p7NzDSSTQA
	/VZkRp6+Z/6wJ0JILGpx4Y0r6KDeik3JjK3pY0zl+Z5U1z7hk5s1JKz99K1cid/IXqqjJV
	zQW9BbVe411A+482z1+N4oFFGSWEEM4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-WQUZnLweMCycf-frm4RFGA-1; Thu, 22 May 2025 03:19:31 -0400
X-MC-Unique: WQUZnLweMCycf-frm4RFGA-1
X-Mimecast-MFC-AGG-ID: WQUZnLweMCycf-frm4RFGA_1747898370
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ad540ac3219so532872466b.3
        for <git@vger.kernel.org>; Thu, 22 May 2025 00:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747898369; x=1748503169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UFMA45o5Hqm49kNu9mnGNT18DmztaEurBzdVUR8fd0=;
        b=LF/7JfjcF64O+ItLc8Zdi6RoS20drpL5agK0VbuPH9Qf7sXffSk5omyH5OeCkLqjQZ
         yyuIvXqR/55mh6pbdjKypAH47iwR9Zh4uK0h5oMY6S7DnF2f1ptuTtMPp7aDqTLAHrWG
         bjF/YSsk+C3GC786jRQ466Gu7YgcaTbEajRC937JorByuKrZXkqbymRmI/Yy55ku0TBq
         uq5NtIncPcSz5MlURBPjXYPigDT1pORvWE8YIBC2yJPOoLVc0QOxYtJX3Sj2cemD/Wt2
         LBsoqdtVKZahW0aysKqrGyfIttnpZ6buVXzHZ7d8+xdd3jQh1dP6SRiJKHeyzxoD78re
         dZVw==
X-Forwarded-Encrypted: i=1; AJvYcCULqxMZyQ5r9s0HgHYMgqYS9HEALb3woPLIFnE1HOl6eMxLjrPNEkNlbdmmpgriXeHzt6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMdwl38HRdQ47vjbFqrBb3PY0Xj31ztVzVlhBpbEPwekPW9fZk
	eMxRetjd8WZInSpLW+QIBPxTquxyWB4250Ww/Si6JF+ljgdaQBNCFaSPIcSaasxFWtWQMR3j2dL
	toY8nIp6SqT+HHSrLHW/SI1/VCyVuykfnKQCvX7wr3OIhwPmCbKN0ODQBScZXEv9SW9CNjilzEv
	7j2AWXAAQxsT4bsMASZk4oOxMaaOchKV/dyM05Q8i9zA==
X-Gm-Gg: ASbGncviEZAo3kxjLh5FpAb2445zl8t1RAvITftlGZbMM+K4W2+GD6arqhIqGcu7n88
	GydqvTDq/jjBXLhM2odpVZmpZ04uqYoFpquFYEUWW4hkLZ6c/BcqgGp9MEvyjrKDa9KQ=
X-Received: by 2002:a17:906:3890:b0:ad5:501a:b3c6 with SMTP id a640c23a62f3a-ad5501abddamr1428155066b.32.1747898369429;
        Thu, 22 May 2025 00:19:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr5Y9qpdU6iuB/8Odx2TRXOe/ib+5eyyeXclRMAV8bIw6b6FTEA8lzo3HhXOUXRBDJOhehIkL0zWIni1iRc7o=
X-Received: by 2002:a17:906:3890:b0:ad5:501a:b3c6 with SMTP id
 a640c23a62f3a-ad5501abddamr1428153866b.32.1747898369030; Thu, 22 May 2025
 00:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
 <pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com> <xmqqh61ear4s.fsf@gitster.g>
 <xmqq1pshc2vs.fsf@gitster.g>
In-Reply-To: <xmqq1pshc2vs.fsf@gitster.g>
From: Ondrej Pohorelsky <opohorel@redhat.com>
Date: Thu, 22 May 2025 09:19:18 +0200
X-Gm-Features: AX0GCFt-837q1rjrI2oRoTHs7rSgswZu-L59fA93hvF8JAPiX48D-qg0UzrgUEI
Message-ID: <CA+B51BGLK-3R9ev4a8EwkGHQEBi2QhgxvAd0CHMbphrxPM74eg@mail.gmail.com>
Subject: Re: [PATCH v2] cvsserver: avoid precedence problem between ! and %s
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD_via_GitGitGadget?= <gitgitgadget@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 7:03=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Ond=C5=99ej Poho=C5=99elsk=C3=BD via GitGitGadget" <gitgitgadget@gmail=
.com>
> > writes:
> >
> >> From: =3D?UTF-8?q?Ond=3DC5=3D99ej=3D20Poho=3DC5=3D99elsk=3DC3=3DBD?=3D=
 <opohorel@redhat.com>
> >>
> >> With perl-5.41.4 and newer, git-cvsserver fails to build because of
> >> possible precedence problem[0]
> >
> > What is the exact symptom?  As Perl is not a language to compile and
> > run separately, "fails to build" does not look like what exactly is
> > going on.  "gives a warning and then refuses to run"?  "gives a warning
> > before running"?  Something else?
>
> Stepping back a bit, the original that the new warning complains
> about is this:
>
> -    if(! $refName=3D~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
>
> And the complaint is that due to operator binding precedence, this
> does
>
>     (!$refname) =3D~ /pattern/
>
> Unless the behaviour has changed as well as warning, which is highly
> unlikely, doesn't it mean that the code was wrong, with or without
> the warning, all along?  The intent of the code was to see if the
> refname conformed to dotted decimal, and if it does not, the refname
> gets munged in the block guarded by that if (condition).  But the
> condition was a total nonsense.  !$refname would most likely to be
> an empty string (unless $refname contains '0' or an empty string),
> which would not match the /^[1-9][0-9]*(\.[1-9][0-9]*)*$/ pattern,
> so we probably have always munged the $refName in escapeRefName sub.
>
> Which I do not see used anywhere in the program, though.  There is a
> call to unescapeRefname method, but it seems to me that
> escapeRefName is never called.
>
> What made you send a patch for this program?  Do you or anybody you
> know use git-cvsserver?  Unless I am reading the program
> incorrectly, despite the claim in front of that escapeRefName sub
> that we avoid sending a tag whose name is not something CVS would be
> happy with, we did not sanitize the refs and relied solely on the
> users' repository to use only safe characters in the refs to keep
> CVS clients happy, and the fact that this expression used as if()
> condition is totally broken does not really make any difference,
> since it is in an unused sub.  I have to wonder if (1) it is a
> better fix to just remove the unused sub, and/or (2) perhaps nobody
> uses cvsserver to allow cvs clients to talk to a Git repository?
>


What I meant by 'does not build' is that the warnings that were added
in the newest Perl release populate the cvs.log when running the test
suite.
This causes some tests from t9402-git-cvsserver-refs.sh to fail, which
then fails the whole build in Fedora.
Tests that are affected are t9402.30, t9402.31, t9402.32, t9402.34.


> >> Added parentheses avoid this issue.
> >
> > We phrase such "this is how the patch addresses the issue" statement
> > in imperative, as if we are telling the codebase to become-like-so,
> > e.g., "Enclose the pattern matching =3D~ in parentheses to force the
> > right order of binding", or something like that.
>


I'll rephrase the commit message to meet this requirement.


On Wed, May 21, 2025 at 7:03=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Ond=C5=99ej Poho=C5=99elsk=C3=BD via GitGitGadget" <gitgitgadget@gmail=
.com>
> > writes:
> >
> >> From: =3D?UTF-8?q?Ond=3DC5=3D99ej=3D20Poho=3DC5=3D99elsk=3DC3=3DBD?=3D=
 <opohorel@redhat.com>
> >>
> >> With perl-5.41.4 and newer, git-cvsserver fails to build because of
> >> possible precedence problem[0]
> >
> > What is the exact symptom?  As Perl is not a language to compile and
> > run separately, "fails to build" does not look like what exactly is
> > going on.  "gives a warning and then refuses to run"?  "gives a warning
> > before running"?  Something else?
>
> Stepping back a bit, the original that the new warning complains
> about is this:
>
> -    if(! $refName=3D~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
>
> And the complaint is that due to operator binding precedence, this
> does
>
>     (!$refname) =3D~ /pattern/
>
> Unless the behaviour has changed as well as warning, which is highly
> unlikely, doesn't it mean that the code was wrong, with or without
> the warning, all along?  The intent of the code was to see if the
> refname conformed to dotted decimal, and if it does not, the refname
> gets munged in the block guarded by that if (condition).  But the
> condition was a total nonsense.  !$refname would most likely to be
> an empty string (unless $refname contains '0' or an empty string),
> which would not match the /^[1-9][0-9]*(\.[1-9][0-9]*)*$/ pattern,
> so we probably have always munged the $refName in escapeRefName sub.
>
> Which I do not see used anywhere in the program, though.  There is a
> call to unescapeRefname method, but it seems to me that
> escapeRefName is never called.
>
> What made you send a patch for this program?  Do you or anybody you
> know use git-cvsserver?  Unless I am reading the program
> incorrectly, despite the claim in front of that escapeRefName sub
> that we avoid sending a tag whose name is not something CVS would be
> happy with, we did not sanitize the refs and relied solely on the
> users' repository to use only safe characters in the refs to keep
> CVS clients happy, and the fact that this expression used as if()
> condition is totally broken does not really make any difference,
> since it is in an unused sub.  I have to wonder if (1) it is a
> better fix to just remove the unused sub, and/or (2) perhaps nobody
> uses cvsserver to allow cvs clients to talk to a Git repository?
>
> >> Added parentheses avoid this issue.
> >
> > We phrase such "this is how the patch addresses the issue" statement
> > in imperative, as if we are telling the codebase to become-like-so,
> > e.g., "Enclose the pattern matching =3D~ in parentheses to force the
> > right order of binding", or something like that.
>


--=20

Ond=C5=99ej Poho=C5=99elsk=C3=BD

Software Engineer

Red Hat

opohorel@redhat.com

