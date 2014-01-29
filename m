From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] builtin/commit.c: reduce scope of variables
Date: Wed, 29 Jan 2014 15:17:07 -0500
Message-ID: <CAPig+cR3DdPS3W_FNPnXG+NO0gUG2PSLH0qNmFUsoxJcy0MVsQ@mail.gmail.com>
References: <1391003311-11126-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 29 21:23:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8bfB-0002ee-3G
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 21:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbaA2UXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 15:23:04 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:51297 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaA2UXD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 15:23:03 -0500
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jan 2014 15:23:03 EST
Received: by mail-yk0-f177.google.com with SMTP id 19so11457130ykq.8
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 12:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ko7GEzkC225lc3bz8woUimmrTvZbH3HztjoLTjjv4ck=;
        b=OTYSK5y/gvgDmvJjgp/nGh55rlEVifTfP/LwpRzaa+T3sATlHmhMetZDsTbCJv3eWI
         TlggNnDls2Tx02fsXrSosTAZDqUWYeJs6Eg3zCN26iE4UUkiFeuZZBjyuaa6Iz+FYMD3
         u8Ft89jLeEvimeMu/OIkmFNLcBn7QQDaMxxsIUSoPKOn4yakN4G3Mk295HRQaNXKmv4r
         BQEODKjduxvrPwYdvLh/KFDHDWhwDxGcR5ohiU6xZEjwF7gs8nWewBOJVtwckxdarWCi
         ABDLvuO8Va6kALiJp+NTSjP3zs4Br0KCmYbzra84lOmRyZyO9BK6vDZ4FZuTMlrwt3i9
         29FA==
X-Received: by 10.236.181.137 with SMTP id l9mr2635675yhm.97.1391026627885;
 Wed, 29 Jan 2014 12:17:07 -0800 (PST)
Received: by 10.170.36.65 with HTTP; Wed, 29 Jan 2014 12:17:07 -0800 (PST)
In-Reply-To: <1391003311-11126-1-git-send-email-gitter.spiros@gmail.com>
X-Google-Sender-Auth: PumxojtAHB-NCgMw_pc_rgMtG2o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241222>

On Wed, Jan 29, 2014 at 8:48 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 3767478..eea4421 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1510,7 +1511,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>         struct ref_lock *ref_lock;
>         struct commit_list *parents = NULL, **pptr = &parents;
>         struct stat statbuf;
> -       int allow_fast_forward = 1;
>         struct commit *current_head = NULL;
>         struct commit_extra_header *extra = NULL;
>
> @@ -1576,6 +1576,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>                 }
>                 fclose(fp);
>                 strbuf_release(&m);
> +               int allow_fast_forward = 1;

This introduces a declaration-after-statement, which is frowned upon
in this project.

>                 if (!stat(git_path("MERGE_MODE"), &statbuf)) {
>                         if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
>                                 die_errno(_("could not read MERGE_MODE"));
> --
> 1.7.10.4
