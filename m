Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB5220282
	for <e@80x24.org>; Tue, 20 Jun 2017 21:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbdFTVKN (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 17:10:13 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35619 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751773AbdFTVKM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 17:10:12 -0400
Received: by mail-pg0-f51.google.com with SMTP id 132so34244599pgb.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 14:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sZ4N51rHZQYZnXjqz9IfbyQj5tIx77BY/YM7g1oSZ3Q=;
        b=Z+NaWve1vck45jMwX5mE+zQDar0Q/sEuOoWUHRWPhRE6xCDkT3YhvuZiwSBKrkrPJt
         GHmlP9FATBbUCs4g+8QlFiTFmVPIvWNP1amG0Ui5DxT/5VSM2GqaIxzlPo9pwP0ECbEH
         osuSDFcN3MoQdn6zmwjmM+3JnPeNlbe9Bl4Ty0o8CQprpQyXcnpJlHwg8xnaDittdYBi
         3NkNmGS6kWwfaHTO0MY3rFpaaH7CbUyDP/aiE8WcRhXVVuKlNEkHDqY9cigZHBfHkK+v
         UUJzHZNewBTsf2dACCyZSmTHakU+dVCUX6PFjj+DSvK6/NwnA2EcVU0JQx9ITtspO4q6
         8UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sZ4N51rHZQYZnXjqz9IfbyQj5tIx77BY/YM7g1oSZ3Q=;
        b=iznCTZ+5o4uzOHl6kGoLxeZixWgnL49a4C0Og2Ia2+DHovX0KHIpUrjUnR8QI7f/0c
         8XCNI2KLWxz3xfXRE3ES8prnD6q/x3iAqm3Srx3Qnh8gLCxw9BuL61w3axGCG9vDPh1O
         GfaCXEeVxFKSVPZnC+d+pP6SAYm3iRed7qN0QXTL60OXey0SBcQuLvwW4bBNgTEhI3rH
         ILynqm3XUfhY08P71k1b3bUGWPWBh0kiO0EB+erVz2e/I9yjhsr7i1KNNqRG6vB+B8/s
         CTn0eNxf93UOD3or5Q3avX6yAkzZtL5WhqVvEBVMGdGrAkTZXrpkwKNS3vsfufTHgW1Y
         ks+w==
X-Gm-Message-State: AKS2vOwGuTxm4XZRcEgIPlCxllVokP3Wy8rB3G5ikjafyum2JEoGsqAD
        VzwXcYhr/CXKmtYEfSmHAha2s9M4u789
X-Received: by 10.84.137.165 with SMTP id 34mr37377998pln.167.1497993011560;
 Tue, 20 Jun 2017 14:10:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Tue, 20 Jun 2017 14:10:11 -0700 (PDT)
In-Reply-To: <20170620191951.84791-12-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com> <20170620191951.84791-1-bmwill@google.com>
 <20170620191951.84791-12-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Jun 2017 14:10:11 -0700
Message-ID: <CAGZ79kY-x-i8U7KYsRRDzp2FjO7X27G2A6zctujx0xuDXi4L5A@mail.gmail.com>
Subject: Re: [PATCH v3 11/20] path: construct correct path to a worktree's index
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2017 at 12:19 PM, Brandon Williams <bmwill@google.com> wrote:
> When working with worktrees the git directory is split into two part,
> the per-worktree gitdir and a commondir which contains things which are
> shared among all worktrees (like the object store).  With this notion of
> having a split git directory, 557bd833b (git_path(): be aware of file
> relocation in $GIT_DIR) and c7b3a3d2f ($GIT_COMMON_DIR: a new
> environment variable) changed the way that 'git_path()' functioned so
> that paths would be adjusted if they referred to files or directories
> that are stored in the commondir or have been changed via an environment
> variable.
>
> One interesting problem with this is the index file as it is not shared
> across worktrees yet when asking for a path to a specific worktree's
> index it will be replaced with a path to the current worktree's index.
> In order to prevent this, teach 'adjuct_git_path' to replace the

adjust_git_path

> path to the index with the path recorded in a repository (which would be
> the current, active worktree) only when not asked to construct a path
> for a specific worktree.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  path.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/path.c b/path.c
> index 76a872297..c6832a30e 100644
> --- a/path.c
> +++ b/path.c
> @@ -372,13 +372,20 @@ void report_linked_checkout_garbage(void)
>  }
>
>  static void adjust_git_path(const struct repository *repo,
> +                           const struct worktree *wt,
>                             struct strbuf *buf, int git_dir_len)
>  {
>         const char *base = buf->buf + git_dir_len;
>         if (is_dir_file(base, "info", "grafts"))
>                 strbuf_splice(buf, 0, buf->len,
>                               repo->graft_file, strlen(repo->graft_file));
> -       else if (!strcmp(base, "index"))
> +       /*
> +        * Only try to replace the path '$gitdir/index' with the index file
> +        * recorded in the repository when not constructing a path for a
> +        * worktree.  This way we can retrieve the correct path to a particular
> +        * worktree's index file.
> +        */
> +       else if (!wt && !strcmp(base, "index"))
>                 strbuf_splice(buf, 0, buf->len,
>                               repo->index_file, strlen(repo->index_file));
>         else if (dir_prefix(base, "objects"))
> @@ -411,7 +418,7 @@ static void do_git_path(const struct repository *repo,
>                 strbuf_addch(buf, '/');
>         gitdir_len = buf->len;
>         strbuf_vaddf(buf, fmt, args);
> -       adjust_git_path(repo, buf, gitdir_len);
> +       adjust_git_path(repo, wt, buf, gitdir_len);
>         strbuf_cleanup_path(buf);
>  }
>
> --
> 2.13.1.611.g7e3b11ae1-goog
>
