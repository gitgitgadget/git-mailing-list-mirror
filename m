From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] [GSoC] diff:use is_dot_or_dotdot() in code
Date: Wed, 19 Mar 2014 04:21:04 -0400
Message-ID: <CAPig+cQF8p0qeNWhGOZ1tqzvEaUGwSd4S0-7FxcuXCvKNE33Kw@mail.gmail.com>
References: <1395210578-1532-1-git-send-email-ba.bourn@gmail.com>
	<1395210578-1532-2-git-send-email-ba.bourn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Brian Bourn <ba.bourn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 09:21:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQBkf-0003pE-Hm
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 09:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758172AbaCSIVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 04:21:09 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:53849 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817AbaCSIVE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 04:21:04 -0400
Received: by mail-yh0-f42.google.com with SMTP id t59so8249768yho.29
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8rcD0xCvOu+c91M34cxSEIXzovfxUPTpASpnieeOa5I=;
        b=hw1A2dF/vxinYerwIZBmEnfk2gIC5ZzziZM2jW22VeOK4lFP5iVEzn13nStUu3mx2e
         Zar6NBKHAO73+YuOOva4XljY2PxS1oWVs+06JbHrq3GdaIoq6cK3VrYQ/UQyUztYRagV
         /6GB3T4BHVOrmKWaYGyet4OiC4rAmnSsfEGNLTt73zRQipFqsA+U3Glhi1fNIOKLAruj
         QqGmxt2b2QbWwiLTAZUhD3txG2IH8wMcqgs9u6fMy9NgLzPLzH497n32Fq12RibaDDWG
         WYvVcMXBr73UZgikGxDesCt0F+46/M3Jy4ACCeOwprxxpujsnmu7grXzbboT9wL4VlEo
         UGvg==
X-Received: by 10.236.132.48 with SMTP id n36mr83833yhi.149.1395217264065;
 Wed, 19 Mar 2014 01:21:04 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 19 Mar 2014 01:21:04 -0700 (PDT)
In-Reply-To: <1395210578-1532-2-git-send-email-ba.bourn@gmail.com>
X-Google-Sender-Auth: x4t9zMLePM8J6PSKoluIgG4yQtg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244419>

On Wed, Mar 19, 2014 at 2:29 AM, Brian Bourn <ba.bourn@gmail.com> wrote:
> Subject: diff:use is_dot_or_dotdot() in code

Wrong subject. See below.

> From: Brian Bourn <ba.bourn@gmail.com>

Drop this. "git am" will grab your name and address automatically from
the email header when applying the patch.

> Subject: replace manual "."/".." check with is_dot_or_dotdot()

This should be the actual subject of this email; and the old, less
informative subject, which is still present, should be dropped. Stated
differently, make this text the first line of your commit message.
"git format-patch" will automatically extract that line as the email's
Subject:, and "git am" will convert the Subject: back to the first
line of the commit message (without the "Subject:" prefix) when
applying the patch.

Other than that, the patch looks fine.

> Signed-off-by: Brian Bourn <ba.bourn@gmail.com>
> ---
> Part 2 of my GSoC submission where the actual change is made
>  diff-no-index.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index ec51106..c554691 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -15,6 +15,7 @@
>  #include "log-tree.h"
>  #include "builtin.h"
>  #include "string-list.h"
> +#include "dir.h"
>
>  static int read_directory_contents(const char *path, struct string_list *list)
>  {
> @@ -25,7 +26,7 @@ static int read_directory_contents(const char *path, struct string_list *list)
>                 return error("Could not open directory %s", path);
>
>         while ((e = readdir(dir)))
> -               if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
> +               if (!is_dot_or_dotdot(e->d_name))
>                         string_list_insert(list, e->d_name);
>
>         closedir(dir);
> --
> 1.9.0
