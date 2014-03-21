From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] diff-no-index.c: rename read_directory()
Date: Fri, 21 Mar 2014 15:09:03 -0400
Message-ID: <CAPig+cSfNdGaDinK9E3AcqqXj_Sz+Ouq361tCAUf-3yx60i_Xw@mail.gmail.com>
References: <1395428217-7669-1-git-send-email-mandrei.dinu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Andrei Dinu <mandrei.dinu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 20:09:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR4oY-0000wi-PV
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 20:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbaCUTJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 15:09:07 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:37461 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbaCUTJE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 15:09:04 -0400
Received: by mail-yh0-f48.google.com with SMTP id z6so2798481yhz.21
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 12:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7am+SzkOY8Nsxzc7zuk+5iDZoUl0s7UBCmMaM2oWYAM=;
        b=eCzs1waVGvovmbHyxMEzcSkx48QP6luV6O3htB+c5SJJoVIH0RAQYAbofSZEIKiLC8
         c5aWOE3sNRjBpATqCBhnsyN2J91yC76tLebrgqz+c/Pk22VtLSsnEdCm6/QIc1BNlWzz
         5ivKI/cSmYS1FAb4CbBakCANtAyrNCsuLLlRvAnfVl3zEHvgPUmR8D8A7P/W3u/YdyFW
         coNWdqMC1gv09pD5HUPe8ItCs3vFQh5Qj0ed0IPpVHmK2GW4y4fRdXRZgesb/QJYWLKf
         A4U1SxG9BRk3NJT/h0jpPy1mXG45w7P+ntwm6Njtpqw9zpWJKJzWmuk1CDA0PGKeOzB+
         jHnA==
X-Received: by 10.236.122.99 with SMTP id s63mr44976492yhh.19.1395428943489;
 Fri, 21 Mar 2014 12:09:03 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Fri, 21 Mar 2014 12:09:03 -0700 (PDT)
In-Reply-To: <1395428217-7669-1-git-send-email-mandrei.dinu@gmail.com>
X-Google-Sender-Auth: v0xrGXbbqIPKFsVyNJNRWerqz30
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244728>

On Fri, Mar 21, 2014 at 2:56 PM, Andrei Dinu <mandrei.dinu@gmail.com> wrote:
> Subject: [PATCH 1/2] diff-no-index.c: rename read_directory()

It is helpful to reviewers if you indicate that this is a resubmission
by placing 'vN' inside [...], where N is the reroll number. For
instance, if this is your fourth version of the patch, you would say
[PATCH v4 1/2]. The -v option of "git format-patch" can help.

> A subsequent patch will include dir.h in diff-no-index.c to
> access is_dot_or_dotdot(), however, dir.h declared a

s/declared/declares/

> read_directory() which conflicts with a (different)
> read_directory() defined in diff-no-index.c. Rename
> read_directory() from diff-no-index.c to avoid the conflict.
>
> Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>
>
> ---
>
>  I plan on applying to GSoc 2014
>
>  I received your feedback and I resend the patches from the bug that I
>  solved in the past

Other than the minor comment above about vN and the typo, both patches
look fine. Thanks.

No need to resend.

>  diff-no-index.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 8e10bff..5e4a76c 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -16,7 +16,7 @@
>  #include "builtin.h"
>  #include "string-list.h"
>
> -static int read_directory(const char *path, struct string_list *list)
> +static int read_directory_path(const char *path, struct string_list *list)
>  {
>         DIR *dir;
>         struct dirent *e;
> @@ -107,9 +107,9 @@ static int queue_diff(struct diff_options *o,
>                 int i1, i2, ret = 0;
>                 size_t len1 = 0, len2 = 0;
>
> -               if (name1 && read_directory(name1, &p1))
> +               if (name1 && read_directory_path(name1, &p1))
>                         return -1;
> -               if (name2 && read_directory(name2, &p2)) {
> +               if (name2 && read_directory_path(name2, &p2)) {
>                         string_list_clear(&p1, 0);
>                         return -1;
>                 }
> --
> 1.7.9.5
