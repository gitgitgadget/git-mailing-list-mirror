From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 16/21] bisect: make total number of commits global
Date: Wed, 13 Apr 2016 15:23:57 +0200
Message-ID: <CAP8UFD1oYtXogrmTVTXMne2p24JoNhE0F=Rfg1GC+dTK7Fbinw@mail.gmail.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-17-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 15:24:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKm5-0000Fb-4A
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbcDMNYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 09:24:00 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37640 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbcDMNX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:23:59 -0400
Received: by mail-wm0-f47.google.com with SMTP id n3so77991703wmn.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=oHYm7usF78MskUm1dlOoQB564PPJ9+a7PzkbuVR9gjM=;
        b=BQIC4Jub+mRDp7YM3+g81TFLQJkNU7tde4/7AVdVNmxv+FtpuCrIlr89qJPzEVCFyb
         rjRBYEwrSAPptt2l8ac/NNaxt/1PL6M0ZthgTdUu6y/BsveQzvM3wG0h8RQB/Cm7EoA3
         QoNzwlRQiHILGGuYHInilGMC/JkblOFOMyu8qn4WCkiuGVOQ+b6MYbsbOC3kdNRtjVi4
         ljYLc7pdcOqj2N06jBxANBzz+21Sxqq7E18LnRLWnKS39Yi2oQke14ZiBXxD+5vrQa47
         dVpbycX86EpwgsRXe9RhnRmypYmt4WOX+A9FWLYDjP/pANhAnXRsh4O+kcFVj65P9G8O
         Asww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=oHYm7usF78MskUm1dlOoQB564PPJ9+a7PzkbuVR9gjM=;
        b=e4E8oJWFMqiALZbFU7Aq0E5upDq3KedvfXClMgBlbsGp1oLHeLl96sZsXAjxHZiyHF
         BSpkkqX65WoRK/vW8L9TvlIXFwPmzfyj69yMayd5WX/XfRq3GX1mEn7eoBMupkT0oU90
         GcfbbvuZOMWUoiBMFB+rsdGP8uDtb+Ll+SH1SeJNG2pPoma/xVjt88Gah2fm9riAfBbI
         pFuTM1k56t7+fVi1jJD2/CgFk2LZkIKEFGzpisn6JOn0+u9cAxEiv4ImkEh64vQK/5aO
         fndRNGHqat1TJeR3rZCOxg1nQv864gM/aDRuxVcdOyA+6XrYQt+wiYBBvkUJVmarbWGZ
         FNmg==
X-Gm-Message-State: AOPr4FWoixZnwl7GJVas9e9fC7gXjT6bGGuOlINofJpH7V/odJdvNJQcEOpAnA+JP83Su/LWZPvxvDJWEKdJzw==
X-Received: by 10.194.235.39 with SMTP id uj7mr9587256wjc.78.1460553837940;
 Wed, 13 Apr 2016 06:23:57 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Wed, 13 Apr 2016 06:23:57 -0700 (PDT)
In-Reply-To: <1460294354-7031-17-git-send-email-s-beyer@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291448>

On Sun, Apr 10, 2016 at 3:19 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> The total number of commits in a bisect process is a property of
> the bisect process. Making this property global helps to make the code
> clearer.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>  bisect.c | 74 ++++++++++++++++++++++++++++++++++------------------------------
>  1 file changed, 39 insertions(+), 35 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index f737ce7..2b415ad 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -23,6 +23,8 @@ static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
>  static const char *term_bad;
>  static const char *term_good;
>
> +static int total;
> +
>  static unsigned marker;
>
>  struct node_data {
> @@ -38,7 +40,7 @@ static inline struct node_data *node_data(struct commit *elem)
>         return (struct node_data *)elem->util;
>  }
>
> -static inline int get_distance(struct commit *commit, int total)
> +static inline int get_distance(struct commit *commit)
>  {
>         int distance = node_data(commit)->weight;
>         if (total - distance < distance)
> @@ -54,7 +56,7 @@ static inline int get_distance(struct commit *commit, int total)
>   * Return 0 if the distance is halfway.
>   * Return 1 if the distance is rising.
>   */
> -static inline int distance_direction(struct commit *commit, int total)
> +static inline int distance_direction(struct commit *commit)
>  {
>         int doubled_diff = 2 * node_data(commit)->weight - total;
>         if (doubled_diff < -1)
> @@ -107,25 +109,25 @@ static int count_interesting_parents(struct commit *commit)
>         return count;
>  }
>
> -static inline int halfway(struct commit *commit, int nr)
> +static inline int halfway(struct commit *commit)
>  {
>         /*
>          * Don't short-cut something we are not going to return!
>          */
>         if (commit->object.flags & TREESAME)
>                 return 0;
> -       return !distance_direction(commit, nr);
> +       return !distance_direction(commit);
>  }
>
>  #if !DEBUG_BISECT
> -#define show_list(a,b,c,d) do { ; } while (0)
> +#define show_list(a,b,c) do { ; } while (0)
>  #else
> -static void show_list(const char *debug, int counted, int nr,
> +static void show_list(const char *debug, int counted,
>                       struct commit_list *list)
>  {
>         struct commit_list *p;
>
> -       fprintf(stderr, "%s (%d/%d)\n", debug, counted, nr);
> +       fprintf(stderr, "%s (%d/%d)\n", debug, counted, total);
>
>         for (p = list; p; p = p->next) {
>                 struct commit_list *pp;
> @@ -157,7 +159,7 @@ static void show_list(const char *debug, int counted, int nr,
>  }
>  #endif /* DEBUG_BISECT */
>
> -static struct commit_list *best_bisection(struct commit_list *list, int nr)
> +static struct commit_list *best_bisection(struct commit_list *list)
>  {
>         struct commit_list *p, *best;
>         int best_distance = -1;
> @@ -169,7 +171,7 @@ static struct commit_list *best_bisection(struct commit_list *list, int nr)
>
>                 if (flags & TREESAME)
>                         continue;
> -               distance = get_distance(p->item, nr);
> +               distance = get_distance(p->item);
>                 if (distance > best_distance) {
>                         best = p;
>                         best_distance = distance;
> @@ -195,10 +197,10 @@ static int compare_commit_dist(const void *a_, const void *b_)
>         return oidcmp(&a->commit->object.oid, &b->commit->object.oid);
>  }
>
> -static struct commit_list *best_bisection_sorted(struct commit_list *list, int nr)
> +static struct commit_list *best_bisection_sorted(struct commit_list *list)
>  {
>         struct commit_list *p;
> -       struct commit_dist *array = xcalloc(nr, sizeof(*array));
> +       struct commit_dist *array = xcalloc(total, sizeof(*array));
>         int cnt, i;
>
>         for (p = list, cnt = 0; p; p = p->next) {
> @@ -207,7 +209,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
>
>                 if (flags & TREESAME)
>                         continue;
> -               distance = get_distance(p->item, nr);
> +               distance = get_distance(p->item);
>                 array[cnt].commit = p->item;
>                 array[cnt].distance = distance;
>                 cnt++;
> @@ -243,7 +245,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
>   * or positive distance.
>   */
>  static struct commit_list *do_find_bisection(struct commit_list *list,
> -                                            int nr, struct node_data *weights,
> +                                            struct node_data *weights,
>                                              int find_all)
>  {
>         int n, counted;
> @@ -262,7 +264,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>                                 node_data(commit)->weight = 1;
>                                 counted++;
>                                 show_list("bisection 2 count one",
> -                                         counted, nr, list);
> +                                         counted, list);
>                         }
>                         /*
>                          * otherwise, it is known not to reach any
> @@ -278,7 +280,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>                 }
>         }
>
> -       show_list("bisection 2 initialize", counted, nr, list);
> +       show_list("bisection 2 initialize", counted, list);
>
>         /*
>          * If you have only one parent in the resulting set
> @@ -300,15 +302,15 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>                         node_data(p->item)->weight = count_distance(p->item);
>
>                         /* Does it happen to be at exactly half-way? */
> -                       if (!find_all && halfway(p->item, nr))
> +                       if (!find_all && halfway(p->item))
>                                 return p;
>                         counted++;
>                 }
>         }
>
> -       show_list("bisection 2 count_distance", counted, nr, list);
> +       show_list("bisection 2 count_distance", counted, list);
>
> -       while (counted < nr) {
> +       while (counted < total) {
>                 for (p = list; p; p = p->next) {
>                         struct commit_list *q;
>                         unsigned flags = p->item->object.flags;
> @@ -334,40 +336,41 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>                                 node_data(p->item)->weight++;
>                                 counted++;
>                                 show_list("bisection 2 count one",
> -                                         counted, nr, list);
> +                                         counted, list);
>                         }
>
>                         /* Does it happen to be at exactly half-way? */
> -                       if (!find_all && halfway(p->item, nr))
> +                       if (!find_all && halfway(p->item))
>                                 return p;
>                 }
>         }
>
> -       show_list("bisection 2 counted all", counted, nr, list);
> +       show_list("bisection 2 counted all", counted, list);
>
>         if (!find_all)
> -               return best_bisection(list, nr);
> +               return best_bisection(list);
>         else
> -               return best_bisection_sorted(list, nr);
> +               return best_bisection_sorted(list);
>  }
>
>  struct commit_list *find_bisection(struct commit_list *list,
>                                           int *reaches, int *all,
>                                           int find_all)

If you really want to use a global variable, then you should probably
have removed the "int *all" argument too...

>  {
> -       int nr, on_list;
> +       int on_list;
>         struct commit_list *p, *best, *next, *last;
>         struct node_data *weights;
>
> +       total = 0;
>         marker = 0;
>
> -       show_list("bisection 2 entry", 0, 0, list);
> +       show_list("bisection 2 entry", 0, list);
>
>         /*
>          * Count the number of total and tree-changing items on the
>          * list, while reversing the list.
>          */
> -       for (nr = on_list = 0, last = NULL, p = list;
> +       for (on_list = 0, last = NULL, p = list;
>              p;
>              p = next) {
>                 unsigned flags = p->item->object.flags;
> @@ -378,23 +381,24 @@ struct commit_list *find_bisection(struct commit_list *list,
>                 p->next = last;
>                 last = p;
>                 if (!(flags & TREESAME))
> -                       nr++;
> +                       total++;
>                 on_list++;
>         }
>         list = last;
> -       show_list("bisection 2 sorted", 0, nr, list);
> +       show_list("bisection 2 sorted", 0, list);
>
> -       *all = nr;
> +       *all = total;

... that would remove the above line...

>         weights = (struct node_data *)xcalloc(on_list, sizeof(*weights));
>
>         /* Do the real work of finding bisection commit. */
> -       best = do_find_bisection(list, nr, weights, find_all);
> +       best = do_find_bisection(list, weights, find_all);
>         if (best) {
>                 if (!find_all)
>                         best->next = NULL;
>                 *reaches = node_data(best->item)->weight;
>         }
>         free(weights);
> +
>         return best;
>  }
>
> @@ -931,7 +935,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
>  {
>         struct rev_info revs;
>         struct commit_list *tried;
> -       int reaches = 0, all = 0, nr, steps;
> +       int reaches = 0, nr, steps;
>         const unsigned char *bisect_rev;
>
>         read_bisect_terms(&term_bad, &term_good);
> @@ -945,7 +949,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
>
>         bisect_common(&revs);
>
> -       revs.commits = find_bisection(revs.commits, &reaches, &all,
> +       revs.commits = find_bisection(revs.commits, &reaches, &total,
>                                        !!skipped_revs.nr);

...and simplify the above call.
