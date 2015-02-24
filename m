From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] checkout: --to requires directory
Date: Tue, 24 Feb 2015 07:34:31 +0700
Message-ID: <CACsJy8Bn_cOGzNfPvaqwPztH3==+EVvN8eciYApMc36epbEz1g@mail.gmail.com>
References: <768eecca8711467b43fcc45403ce9ce91bb1550e.1424700971.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 24 01:35:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQ3Sx-0006cc-EL
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 01:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbbBXAfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 19:35:03 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33907 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbbBXAfC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 19:35:02 -0500
Received: by iecrp18 with SMTP id rp18so28171358iec.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2015 16:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TkvGcthoNueJPCrwgWExiiF9Rx0T+roYthz4riqsLQg=;
        b=yoGbw15DGiNmbbzjEvwOSu+sQ2RAKuCug4te+Ossmw3KpdVIaafOSOTIezYbSkjglq
         wqcFZV6XS89/mD9LuKTRJINelK+5VLQqNNk/jFikon5fjj94xN506MpZ8ke7402Tmaz9
         TQe3byJ8Nmlw0QqLxwOMxbha8PjqWQsyg/OS6RxiTYb+hvcLG1lnjq8Fx4zK+CCvxbI7
         dPEJO5y7tJB/FWsM/WLoYUq97BG/pQxmsHkeUceAQFiZQiJ5t3KDRgSns0FrvUBS2inq
         4kDlY/65Mn1dEHiUto/uqSgBg6E6HPY5Fk68sZk1tIYSDHhgT6fPDIR3PJoO+nkM6t1U
         oa+Q==
X-Received: by 10.50.107.36 with SMTP id gz4mr16778185igb.25.1424738101373;
 Mon, 23 Feb 2015 16:35:01 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Mon, 23 Feb 2015 16:34:31 -0800 (PST)
In-Reply-To: <768eecca8711467b43fcc45403ce9ce91bb1550e.1424700971.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264304>

On Mon, Feb 23, 2015 at 9:16 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> --to requires a directory, not a file. Say so in the usage string.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  builtin/checkout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 8b2bf20..8cdcd07 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1341,7 +1341,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>                          N_("do not limit pathspecs to sparse entries only")),
>                 OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
>                                 N_("second guess 'git checkout no-such-branch'")),
> -               OPT_FILENAME(0, "to", &opts.new_worktree,
> +               OPT_STRING(0, "to", &opts.new_worktree, N_("dir"),

Nack. OPT_FILENAME has hidden magic, see fix_filename(). If you want
to change the text, you'll have to fall back to using OPTION_FILENAME
directly.

>                            N_("check a branch out in a separate working directory")),
>                 OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
>                          N_("do not check if another worktree is holding the given ref")),



-- 
Duy
