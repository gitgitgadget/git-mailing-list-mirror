From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/5] worktree.c: add is_worktree_locked()
Date: Fri, 13 May 2016 12:52:06 -0400
Message-ID: <CAPig+cQR40u4nMEP1wz74ubA=wW5m+KiCZnpZwuWAyYvXsPHrw@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160510141729.23063-1-pclouds@gmail.com>
	<20160510141729.23063-3-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 18:52:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1GJx-0001qn-Ln
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 18:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbcEMQwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2016 12:52:09 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35958 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbcEMQwH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2016 12:52:07 -0400
Received: by mail-io0-f193.google.com with SMTP id k129so15789161iof.3
        for <git@vger.kernel.org>; Fri, 13 May 2016 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=Z0tzg7PR10dJyvnOyymvZODFlldIRz1WTZ0eupvblYU=;
        b=cUqWuQJ5Qzv5u6Ot8BJiJ3Ga8hunvkWr9EmZknTV/dhp/MtuTLDwHhyq8u/lQe+uwl
         2lLJPaSuUHwfZPXYqGCXI0ywYXNpgQdusXixlt2c93BOoM58qdQI3TTfEnB2FZN3UHrH
         2RW6910gRH8Nnz/a7MumV68BQjRjYcXoA/2VTcfaNsxk9F1Ky1mjZNCfx4QeOQ1EcfUe
         fvFR/gUOQ9F4BTh5JzwE6HG95xTCH1gyYaPjpdCAcT5od5pPFCbHXignBSQVYua6dvYL
         x5uksQjPUEs1VKQGAJ2slfD4CvGuWv/NDWAO+mNKRLgtPMN5K6uXnKr47v2bZEq6C2sB
         4abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=Z0tzg7PR10dJyvnOyymvZODFlldIRz1WTZ0eupvblYU=;
        b=BQOMuvszTSYF/rG359r7GNYn3c4Fw6cL+ZnF5d+Wbmeh17JXvQ9oCB4wumH2cY9Ild
         91L7aVYin7Sh3BynTOmriizkPppyegifs54T9O4EoW0a3GWWrq3ypHiV5gkU9mvJthaq
         iPsVn+TeDoT+wgpvDZpJ8MFlq1XOpBTZw/d9dZt7fHUhkAVUSvj6OilfTU1SoSHEUy1q
         gwXSdgdZaxq0dHsd8dpBm+E2ATntjJ3H+WNaUuW+KsVPW2Xlxvao0wRvb8KQvSD0iE7x
         X9DbfWGuNLKJsZGqVcODJFvBLABC55poQjYoby6ALU3Zid+v1Wj92bg2xj8h+dsWir5O
         wRXQ==
X-Gm-Message-State: AOPr4FW33NXB/v4MSnuPiUzEmU1odQQtVZOT3QNYMGJIScljnvBdv4+SFnOYt5FIZkyjEfmp9Qbd+JWugTIaaA==
X-Received: by 10.107.47.37 with SMTP id j37mr11870380ioo.168.1463158326209;
 Fri, 13 May 2016 09:52:06 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Fri, 13 May 2016 09:52:06 -0700 (PDT)
In-Reply-To: <20160510141729.23063-3-pclouds@gmail.com>
X-Google-Sender-Auth: auHQqVFQ_4cXoo6TaY456CGvnYI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294545>

On Tue, May 10, 2016 at 10:17 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> This provides an API for checking if a worktree is locked. We need to
> check this to avoid double locking a worktree, or try to unlock one w=
hen
> it's not even locked.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -243,6 +243,24 @@ int is_main_worktree(const struct worktree *wt)
> +const char *is_worktree_locked(const struct worktree *wt)
> +{
> +       static struct strbuf sb =3D STRBUF_INIT;
> +
> +       if (!file_exists(git_common_path("worktrees/%s/locked", wt->i=
d)))
> +               return NULL;

The git_common_path(...) invocation is textually lengthy and repeated
three times in this function. If you instead assign the result to a
variable (possibly xstrdup'ing it if needed), then the below
strbuf_read_file() would likely fit on one line, thus be easier to
read.

> +
> +       strbuf_reset(&sb);
> +       if (strbuf_read_file(&sb,
> +                            git_common_path("worktrees/%s/locked", w=
t->id),
> +                            0) < 0)

It's too bad that strbuf_read_file() doesn't guarantee anything about
'errno', such as indicating that the file did not exist, in which case
the !file_exists() check would not be needed, and a bit of raciness
eliminated, but that's outside the scope of this series.

> +               die_errno(_("failed to read '%s'"),
> +                         git_common_path("worktrees/%s/locked", wt->=
id));
> +
> +       strbuf_rtrim(&sb);

Since this file is presumably human-editable (historically and at this
point in the series) in order to specify the lock reason, should this
be doing a full trim() rather than only rtrim()?

> +       return sb.buf;
> +}
> diff --git a/worktree.h b/worktree.h
> @@ -40,6 +40,12 @@ extern struct worktree *find_worktree_by_path(stru=
ct worktree **list,
> +/*
> + * Return the reason string if the given worktree is locked. Return
> + * NULL otherwise.
> + */

Does this need to mention that the returned "locked reason" string is
only guaranteed valid until the next invocation?

Actually, I recall that when I suggested the idea of 'struct worktree'
and get_worktrees() to Mike that it would be natural for the structure
to have a 'locked' (or 'locked_reason') field, in which case the
reason could be stored there instead of in this static strbuf. In
fact, my idea at the time was that get_worktrees() would populate that
field automatically, rather than having to do so via a separate
on-demand function call as in this patch.

> +extern const char *is_worktree_locked(const struct worktree *wt);

I was wondering if builtin/worktree.c:prune_worktree() should be
updated to invoke this new function instead of consulting
"worktrees/<id>/locked" manually, but I see that the entire "prune
worktrees" functionality in builting/worktree.c first needs to be
updated to the get_worktrees() API for that to happen.
