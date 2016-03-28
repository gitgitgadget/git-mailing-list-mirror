From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] branch -d: refuse deleting a branch which is currently
 checked out
Date: Mon, 28 Mar 2016 12:51:21 -0400
Message-ID: <CAPig+cSzTwup6ojboVkP8nMR91-ZUU9FCbAK5NcrcohfFh2taQ@mail.gmail.com>
References: <CAPig+cSCC+OzotkTx89iS+t4DRd3F+QoHP4n-v_+rxXU2R+2LA@mail.gmail.com>
	<cbc5116e5069f20545d66e12e082e0e17f4ecced.1458927521.git.k@rhe.jp>
	<1459149771-14790-1-git-send-email-k@rhe.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Kazuki Yamaguchi <k@rhe.jp>
X-From: git-owner@vger.kernel.org Mon Mar 28 18:51:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akaO3-0000Kq-EH
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 18:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbcC1QvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 12:51:24 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36824 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185AbcC1QvW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 12:51:22 -0400
Received: by mail-vk0-f65.google.com with SMTP id z68so15872818vkg.3
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 09:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=pztErl7SOsj14hmYw+1TkOfz74M4XYGzjx+2YmmG+SQ=;
        b=Zqfu9YDxjA4KwL5tZFSkXlG4ne+zRu/gfB26KPwSRDbj9UBiO85iAJWVYVDA2aYavj
         lhhEcQSdVguKVxmSOm22QdJEwZicAKI5hzL76ZWiHNi5/xO9XmWxOkYIzZ0niCj6Bc9m
         tIi6lM4f5djtJFjYswFx9R8z7f2AMas82ByZIdu41kQ52owe6Z07Cwhzeo+ToELZsDoI
         sxqtdLVtqHTmzjyG0om85aLi0DE9k23orUyACBNHThoFnsf4yL+8wRnK4TzZwIia1Mel
         Jx1CpGE1DTCpkaOKBckJpVNp/HF6D8qssDEkoRhgj4rfcMZLAEE7BZKbxohE9Rui1TP9
         EaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=pztErl7SOsj14hmYw+1TkOfz74M4XYGzjx+2YmmG+SQ=;
        b=mAAtiawodzSaR72Dm6/YNXvixGxWVyT7638LhLZ6KUsoXU2/GA/s08J0VQk0dSPoqR
         v4AWCBsF4jUvkIZVko+EV0u5aMojq/XSt2UbyOL3BI8EX74sRBL+3RVc6cP5W+oemAcM
         wKmjc+NvB9Yd4g3ghLDIb5e9m2PSC4UrE32sHBwxnHEzUHmNRXQkTi8c4SNqMkQwq/sw
         lt+6N0vkGYcMI4Wr6+fpH2NbK2VFDzVnVa0o96O/QA2r1cSrRAO5XPIwyZ6LpoEjsyKw
         Nsw+cTX3SWw8mS6tlA2EeXpnQmfJGXTAjFqC4fpkdWNBOlCKTeezxMtC/6el1zqVug+t
         esQw==
X-Gm-Message-State: AD7BkJKADOsgmCdoLy9kj8s9uBLjWFMTY71jndewAUE9pEp6d4CO43VAg4jf/8nHi8ylv0CoGVpYiWDiTWEH3Q==
X-Received: by 10.176.6.193 with SMTP id g59mr13416074uag.67.1459183881128;
 Mon, 28 Mar 2016 09:51:21 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Mon, 28 Mar 2016 09:51:21 -0700 (PDT)
In-Reply-To: <1459149771-14790-1-git-send-email-k@rhe.jp>
X-Google-Sender-Auth: rXPO_UXgdiDfqGVwRjI0Ld0Lhp8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290047>

On Mon, Mar 28, 2016 at 3:22 AM, Kazuki Yamaguchi <k@rhe.jp> wrote:
> When a branch is checked out by current working tree, deleting the
> branch is forbidden. However when the branch is checked out only by
> other working trees, deleting is allowed.

It's not quite clear from this description that it is bad for deletion
to succeed in the second case. Perhaps:

    s/deleting is allowed/deletion incorrectly succeeds/

would make it more clear.

> Use find_shared_symref() to check if the branch is in use, not just
> comparing with the current working tree's HEAD.

This version of the patch is nicer. Thanks. See a couple minor
comments below which may or may not be worth a re-roll (you decide).

> Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
> ---
>
>   % git worktree list
>   /path/to      2c3c5f2 [master]
>   /path/to/wt   2c3c5f2 [branch-a]
>   % git branch -d branch-a
>   error: Cannot delete the branch 'branch-a' which is currently checked out at '/path/to/wt'

Thanks for an example of the new behavior. It's also helpful to
reviewers if you use this space to explain what changed since the
previous version, and to provide a link to the previous attempt, like
this[1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/289413/focus=289932

> diff --git a/builtin/branch.c b/builtin/branch.c
> @@ -215,16 +216,21 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>                 int flags = 0;
>
>                 strbuf_branchname(&bname, argv[i]);
> -               if (kinds == FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
> -                       error(_("Cannot delete the branch '%s' "
> -                             "which you are currently on."), bname.buf);
> -                       ret = 1;
> -                       continue;
> -               }
> -
>                 free(name);
> -
>                 name = mkpathdup(fmt, bname.buf);
> +
> +               if (kinds == FILTER_REFS_BRANCHES) {
> +                       char *worktree = find_shared_symref("HEAD", name);
> +                       if (worktree) {
> +                               error(_("Cannot delete the branch '%s' "
> +                                       "which is currently checked out at '%s'"),

This could be stated more concisely as:

    "Cannot delete branch '%s' checked out at '%s'"

> +                                     bname.buf, worktree);
> +                               free(worktree);

Would it make sense to show all worktrees at which this branch is
checked out, rather than only one, or is that not worth the effort and
extra code ugliness?

> +                               ret = 1;
> +                               continue;
> +                       }
> +               }
> +
>                 target = resolve_ref_unsafe(name,
>                                             RESOLVE_REF_READING
>                                             | RESOLVE_REF_NO_RECURSE
