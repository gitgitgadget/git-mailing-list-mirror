From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] worktree.c: add find_worktree_by_path()
Date: Mon, 23 May 2016 00:11:39 -0400
Message-ID: <CAPig+cRnt4ELACEitEkiZxbVT9Uk8hzdj0Ts7cwZwh2qPoa1cA@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160522104341.656-1-pclouds@gmail.com>
	<20160522104341.656-2-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 06:11:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4hDV-0002wn-Vd
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 06:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbcEWELl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2016 00:11:41 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:34664 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbcEWELk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2016 00:11:40 -0400
Received: by mail-ig0-f196.google.com with SMTP id lp2so1830494igb.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 21:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=pRh0n9H1afaHnF4s3cu746FdsFUXn7DQE1UQ2MrEXkc=;
        b=MCnqkwWLkVUdGcxW5Vs4Jw8W8W2aTBReT2pDQYtosmeUWOsg9VIEVayhySuyDMI/Ht
         PpYkxH4gjaG+tyT+41e+pm2SW1/fwdkr3RxKU0zZMXHgfJTQ1N/rQK1S2r/fhffsMDtS
         zp36692SWY41TRA9XBSC+gIvd0U/0bvm0STFqrx4LQMZaHJQO3sLYM2WUNXXbaHDfpe8
         UyQKpXhk2lnSi4lDClkAiW4i8GD0KFqVrUHJKjYRJx3oFxXJfBG0WIps+iTJ2P8DQetX
         mPtW9fCAZlO6/mnSBgFZoKIpUw3f9ty9WrWSxjYQ58Npa26Q+/y5VlR+ohiMVMINSN5z
         njQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=pRh0n9H1afaHnF4s3cu746FdsFUXn7DQE1UQ2MrEXkc=;
        b=lyHstzgvRXf9lLAjVdBQXFXjMB6zzEJeVCZaN/XlePtlmcpJ9LgmY6d2GMCaHVCzfI
         8wXaaMHqsKHh6g9Ic0/hF5Cg9ooWQsEbmy/lzhQ1CN1JmJe2+xxblgGSyi35ReD0mM6R
         /cc6U9HyGFNop9aFipm/tRc1UbFQxs3LzydygOM0y/7rlW58bAH864COGBrXk0VWXDOl
         4ca3CDWY/zOkoxAVHa+uuBWT7BQB0Bo9m3N+abQ22z/ErFAk76t/ICJKC7V7jGetETyA
         lzDOkHWpMiGcleiiFUX0bYBrtf7yDjkiqK2xzkitFoaiaYNgMltJWz8u4qZxWB6WdRs0
         hDeg==
X-Gm-Message-State: AOPr4FUVBpIDvLHEdnNgu6jFh4k+NKfnKYGQzA56Wv1XBpGEiHH9yhENkvl3AdT3TQfIO7YsHBGZrqPiMXjPdQ==
X-Received: by 10.50.36.9 with SMTP id m9mr11441537igj.91.1463976699862; Sun,
 22 May 2016 21:11:39 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Sun, 22 May 2016 21:11:39 -0700 (PDT)
In-Reply-To: <20160522104341.656-2-pclouds@gmail.com>
X-Google-Sender-Auth: lNalhRp03laSum7M-Jru6-vgufU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295303>

On Sun, May 22, 2016 at 6:43 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> So far we haven't needed to identify an existing worktree from comman=
d
> line. Future commands such as lock or move will need it. There are of
> course other options for identifying a worktree, for example by branc=
h
> or even by internal id. They may be added later if proved useful.

Beyond the above methods for specifying a worktree, [1] adds
$(basename $path) as a possibility if not ambiguous. Excerpt:

    For git-worktree commands such as "lock", "mv", "remove", it
    likely will be nice to allow people to specify the linked
    worktree not only by path, but also by tag, and possibly even by
    $(basename $path) if not ambiguous.

[1]: http://article.gmane.org/gmane.comp.version-control.git/275528

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
