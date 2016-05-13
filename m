From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/5] worktree.c: add find_worktree_by_path()
Date: Fri, 13 May 2016 12:29:59 -0400
Message-ID: <CAPig+cSu08BaEu22iGouM_7q6yrKbVtqNrfJsWo6aYuPAeWq0w@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160510141729.23063-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 18:30:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1FyZ-0006dC-JP
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 18:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbcEMQaB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2016 12:30:01 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34713 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597AbcEMQaA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2016 12:30:00 -0400
Received: by mail-io0-f195.google.com with SMTP id d62so4470793iof.1
        for <git@vger.kernel.org>; Fri, 13 May 2016 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=4C3CCXNxX/30Z6lHFB6yC8Tnjyg1Tr9vYaHXq23EA20=;
        b=J5yjiC2KhjeD+205dayJsq+a4NsXR9Mlm6fbgA4nzxvbtoZCsV9SdrnFZi/dgMq+ey
         JMFg7gn3et9ke+ZeSRZikCLne9f+jX+3do+zfiPJg9dCDra5Liq5mYE2Os0GSBF2Xhhz
         bgbepqeVVxytFzlvYEnP7VuNIRcdxasQcodNt/Fz9muUenqiIE3DGJY1SVmn6MeqSsjE
         Xs2Y0gkTy6qwCWNmDcBXHvw8J81YkbO58WJ/7ijUnrEzuzNRoE4mA+XVb5IwGyGUkQA1
         sQl2wZaHkHBuz09BzXJUm0Cu1790+g1q13AhTq4vYqIVRR+47sPL9Cs+aau+FdlwZbEM
         6JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=4C3CCXNxX/30Z6lHFB6yC8Tnjyg1Tr9vYaHXq23EA20=;
        b=D3N1oMcP6gZdQN8XWZu7+vwbu3nq7YcWGnlwz2PxhJrvEQyBWMt1qVH84zBGxX0Y4O
         sNPgEPEnKDtBb+ZirhDkzfTFW/HrIMrbOykYbnzxazBxZ0qn3znhLgpLhQR+e5Q4fcq/
         mxe0Ni3ZdPjlVUogpsYXiqRzg8xEFqJ+LcFCS8XiJ04vIHLtheXCQO6AbTwDHdyrlM5o
         BocF+clIdBzH7+WpzaDTQv7dvCh+ozDKpsTSWYzZDqVXBEc6mHs8jr9shXSrY5IG4fnC
         6Xr9gzg20EV/1O2Fnx81oJ4tG+/ksw3iFjau5iQwXjUnICH8NrX70crbIDDuRcQ4uN6S
         Psog==
X-Gm-Message-State: AOPr4FV1GdQmJaGUkUs7+9m6M/N/XjEjPWrFkGCZv7cm0OOqbiu+Eqeoc0dqFxb3c6hP1ah1PS0u59lnV5BB9g==
X-Received: by 10.107.47.37 with SMTP id j37mr11811956ioo.168.1463156999756;
 Fri, 13 May 2016 09:29:59 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Fri, 13 May 2016 09:29:59 -0700 (PDT)
In-Reply-To: <20160510141729.23063-1-pclouds@gmail.com>
X-Google-Sender-Auth: MUkAxcpijEQMZB8DrWkMe66l0QE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294540>

On Tue, May 10, 2016 at 10:17 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> So far we haven't needed to identify an existing worktree from comman=
d
> line. Future commands such as lock or move will need it. There are of
> course other options for identifying a worktree, for example by branc=
h
> or even by internal id. They may be added later if proved useful.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -222,6 +222,22 @@ const char *get_worktree_git_dir(const struct wo=
rktree *wt)
> +struct worktree *find_worktree_by_path(struct worktree **list,
> +                                      const char *path_)
> +{
> +       char *path =3D xstrdup(real_path(path_));
> +       struct worktree *wt =3D NULL;
> +
> +       while (*list) {
> +               wt =3D *list++;
> +               if (!fspathcmp(path, real_path(wt->path)))
> +                       break;
> +               wt =3D NULL;
> +       }
> +       free(path);
> +       return wt;
> +}

Very slightly shorter and perhaps idiomatic (but not at all worth a re-=
roll):

    for (; *list; list++)
        if (!fspathcmp(path, real_path((*list)->path)))
            break;
    free(path);
    return *list;
