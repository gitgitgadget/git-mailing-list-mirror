From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: git fsck exit code?
Date: Mon, 1 Sep 2014 13:54:40 +0200
Message-ID: <CAA787rmiiiWwz-n-PgP46_y6L2nhTZZgBtr2H2ZcCA7VA21KYg@mail.gmail.com>
References: <1409177412.15185.3.camel@leckie>
	<20140829185325.GC29456@peff.net>
	<xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
	<1409343480.19256.2.camel@leckie>
	<CAA787rmf7aNJ+ErXk6Lc_hLVDxMV8s2Lx_YmZud83yia4n0VKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 13:54:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOQCD-0003vm-TI
	for gcvg-git-2@plane.gmane.org; Mon, 01 Sep 2014 13:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbaIALyo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2014 07:54:44 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:33888 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525AbaIALyn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Sep 2014 07:54:43 -0400
Received: by mail-la0-f54.google.com with SMTP id b17so5970933lan.13
        for <git@vger.kernel.org>; Mon, 01 Sep 2014 04:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=fFNsNbCHqRypuQt0b0yrXrd9AHTDTyN0J/6RKZWq7LA=;
        b=v2bMzVTqSckMmiozTIvIozvoYzsJVeLG/cFX24R++ZTi43QkwBDCXgrhCvAOki587z
         AEHfl6Y2CT/vdiqT+2+lovboSu/KdxExwrw3cFHBGlqWWVEpDJAj4apusFiYJZ2918an
         4iCeUJNl6axDk9u6AZel+A8b4R6Ja3/kSgdXWTjTqRBkMOlBIfANLHdAc8hMGLTOOhNy
         xkMMKwFWuZnX7e3d7+KcB7EXDdaQX51aQoRTdBQcdb3KaUzo/iin/1+egTLzrg0vL40Q
         hzjHCMWO8+ra3vKbyx0w+7oFkBSdhOxL87VovFdJmL3mLMPpE5uGsSfnMC3OF73r9Ijq
         /+0Q==
X-Received: by 10.152.37.199 with SMTP id a7mr19720010lak.68.1409572480764;
 Mon, 01 Sep 2014 04:54:40 -0700 (PDT)
Received: by 10.112.140.73 with HTTP; Mon, 1 Sep 2014 04:54:40 -0700 (PDT)
In-Reply-To: <CAA787rmf7aNJ+ErXk6Lc_hLVDxMV8s2Lx_YmZud83yia4n0VKA@mail.gmail.com>
X-Google-Sender-Auth: Of84XNyh-EBFwr-g8TmiaLqwcEA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256305>

On 31 August 2014 20:54, =C3=98yvind A. Holm <sunny@sunbase.org> wrote:
> On 29 August 2014 22:18, David Turner wrote:
> > error in tree 9f50addba2b4e9e928d9c6a7056bdf71b36fba90: contains
> > duplicate file entries
>
> I don't think git fsck should return !0 in this case. Yes, it's an
> inconsistency in the repo, but it's sometimes due to erroneous
> conversions from another SCM or some other (non-standard)
> implementation of the git client. I've seen things like this (and
> other inconsistencies in repos, like wrong date formats, non-standard
> Author fields, unsorted trees, zero-padded file modes and so on), and
> the thing is, owners of public repos with these errors tend to avoid
> fixing it because it changes the commit SHAs. If git fsck starts to
> return !0 on these errors, it will always return error on that repo,
> which in practise means that the error code is rendered useless. IMHO
> git fsck should only return !0 on errors that can be fixed without
> changing the commit history, for example missing or invalid objects.

To elaborate on what I wrote: Of course, if the error is grave enough
that Git isn't able to work around it and it severely limits the
functionality of the repo, action needs to be taken regardless of
whether the history has to be changed or not. In that case it's OK to
return an error value too.

=C3=98yvind
