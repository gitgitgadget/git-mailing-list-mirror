From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 03/12] worktree.c: make find_shared_symref() return
 struct worktree *
Date: Thu, 21 Apr 2016 03:02:53 -0400
Message-ID: <CAPig+cTMRJYFwzRbsoyd06BKwKOLf0LJirnB5rp4fWDb09r6Fg@mail.gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	rethab.ch@gmail.com, Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 09:03:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1at8dh-0002r7-Em
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 09:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbcDUHC5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Apr 2016 03:02:57 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35626 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbcDUHC4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2016 03:02:56 -0400
Received: by mail-ig0-f181.google.com with SMTP id gy3so149548494igb.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 00:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=34wKt5pNunohbQ4Euud0YmOEOFiSWH6ma+KiSWtPze8=;
        b=wcOO+gk33yNvPDSmdjfLkXeuOejopHSXtyhf0ogTebneieO3jHEH1uc2x7OlH1O7ZD
         3pGejto9P0g2CgmutTza274aJqomdPAeOvD08qBe5EvWLK+EGzDm+5vz/CqRLQjgJIX2
         7EuIxKAmrEs61uuysKqG87tNQSRtxI9zIJWiOyN6dFdflANNJWpoVZs8yxOPvubGdY9u
         slSW0JXM6mVoPTgFqNhblmpTQ9xtHefibEmmnrfkZ5vRQFa4juDeWJcMiJ7FjgmCU93u
         CBD19bwcvDI0uzJ0mZn3acBI4e8t7LKu0Oqm1XrELX688CsqpJ809VubsywqOEtdWdil
         9VsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=34wKt5pNunohbQ4Euud0YmOEOFiSWH6ma+KiSWtPze8=;
        b=XI1VdB+QcAioiVG/TGWnsYOPzv9EtEitUga17N6B6G8rVGFJ7jegv4v5kZjsxknbaX
         kOw9uy4KZDBFkyemZnc7nMtW3shP3mXSDlQsYbyjk/R059tRLYiDyhS2mbEvWIObIoQM
         4VeRvUwqScxk/hp4r9v160kk9hyyfaO7zVyE+AJEamsdEcZ298407E0x9WM0uTILRkAX
         QLDNNbTY7VJAEFxcDQI1dt17y3fkA57DZD1v2edj4ruVWZVZa77hnARf8eHC0+cukVOR
         oU5RL1MgH/te82j5SeC5Sc2n3zuV6c9xZiJoVPzUhjsHpe3/+d2HBMYp/8KtyyP57cEq
         d5zg==
X-Gm-Message-State: AOPr4FVZpq3E5yy3iiwNh5j2YjK0BybtuRhabBrUD/EmO+3x8pnB0heCPUk24XG2fWmFKETwEi0340bMKamtjw==
X-Received: by 10.50.205.42 with SMTP id ld10mr1641044igc.17.1461222173707;
 Thu, 21 Apr 2016 00:02:53 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Thu, 21 Apr 2016 00:02:53 -0700 (PDT)
In-Reply-To: <1461158693-21289-4-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: Eq5LHl0bmqwiLGAxbuct94h6i9U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292096>

On Wed, Apr 20, 2016 at 9:24 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> This gives the caller more information and they can answer things lik=
e,
> "is it the main worktree" or "is it the current worktree". The latter
> question is needed for the "checkout a rebase branch" case later.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/worktree.h b/worktree.h
> @@ -36,9 +36,10 @@ extern void free_worktrees(struct worktree **);
>  /*
>   * Check if a per-worktree symref points to a ref in the main worktr=
ee
>   * or any linked worktree, and return the path to the exising worktr=
ee

Doesn't "return the path" become outdated with this patch?

Also (not a new problem): s/exising/existing/

> - * if it is.  Returns NULL if there is no existing ref.  The caller =
is
> - * responsible for freeing the returned path.
> + * if it is. Returns NULL if there is no existing ref. The result
> + * may be destroyed by the next call.
>   */
> -extern char *find_shared_symref(const char *symref, const char *targ=
et);
> +extern const struct worktree *find_shared_symref(const char *symref,
> +                                                const char *target);
