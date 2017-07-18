Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D101FF30
	for <e@80x24.org>; Tue, 18 Jul 2017 21:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbdGRVjl (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 17:39:41 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33662 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752557AbdGRVjk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 17:39:40 -0400
Received: by mail-pg0-f46.google.com with SMTP id k14so19460777pgr.0
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qKg/m/AlDAICTrcjikZjzU1+7UWBzWpmwW0uR2slsZY=;
        b=t35DseInHBD2TPZogFlX9s6svsEYKChVKzVbK1PgVDLT8G/JAEyeDvwdixYFp2/IYD
         gF0+X+wWYIZdDxdXiYTMyDRJG8Q9S3vPFJ5p//JraQZzgMNYi9dg/L2jVWs2B0unAe/O
         IphoDCI0rOCyeyFEvV9ynkSNTdreUons+9J0fox8nAC9P3H1KsZxFdRpI2lTAdk/DNvo
         I3A/chzruG8e8S7bAwLR1ycOiySTCI1zi6JL/0Hxa8sSNkKa3y0NCoDbESrOurFluNFW
         /tNXaTNomfgolp7zhDAMoSZtLGa+UT8KkyRMwbWbGGT4XrLIMTZ6wzM4JPsNFck5wp50
         XGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qKg/m/AlDAICTrcjikZjzU1+7UWBzWpmwW0uR2slsZY=;
        b=dexRKewIHVINTQKN61MEj2TMjUVw7o+e88y7Q4TwEfwCLRbBdrzP3myp+EIC/oN6qK
         iLRfb2rIfJ8OS/gCv55ilIEpLDC9Zk9yp8Zck1hMSKpRBoD2uOgfz2D1XpKUrKN194Zk
         nzBY53qAP3FbU/gK3PI89E9Wjyu7/Hrb/GtxHMcJubXs5nVHsQtXPBiUZ1QRSt7lYVP2
         HRnFlXvg6xCJsYqCFJDHjifxdG+4FwbYXL3XNfQiiEEy31Ltt1Gx/6g8YEqlliQtxCqk
         8p0DsbnFDtbHQhyp1UNU9b2zWRLX8+Aval8fLp6Q1hLGxkWaiHlNDOerWYlLr2wDGcF4
         URbw==
X-Gm-Message-State: AIVw113nVs9+lxXrCL1qdqwR6GK3lHEHcrcEukl8bbGHnlTKmypFw/WZ
        2zcxpVN5WKxUSTzOxdPnpr90XRs+JaJ7
X-Received: by 10.84.232.74 with SMTP id f10mr3834680pln.154.1500413979607;
 Tue, 18 Jul 2017 14:39:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Tue, 18 Jul 2017 14:39:39 -0700 (PDT)
In-Reply-To: <20170718204904.3768-5-pc44800@gmail.com>
References: <20170718204904.3768-1-pc44800@gmail.com> <20170718204904.3768-5-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Jul 2017 14:39:39 -0700
Message-ID: <CAGZ79kb48kNggPv64ubbBNK-Sk8AW4eXxhZt=PZZCPKr9OiuLQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 4/8] submodule: port submodule subcommand 'status'
 from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 18, 2017 at 1:49 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> This aims to make git-submodule 'status' a built-in. Hence, the function
> cmd_status() is ported from shell to C. This is done by introducing
> three functions: module_status(), submodule_status() and print_status().
>
> The function module_status() acts as the front-end of the subcommand.
> It parses subcommand's options and then calls the function
> module_list_compute() for computing the list of submodules. Then
> this functions calls for_each_submodule_list() looping through the
> list obtained.
>
> Then for_each_submodule_list() calls submodule_status() for each of the
> submodule in its list. The function submodule_status() is responsible
> for generating the status each submodule it is called for, and
> then calls print_status().
>
> Finally, the function print_status() handles the printing of submodule's
> status.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  builtin/submodule--helper.c | 146 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  49 +--------------
>  2 files changed, 147 insertions(+), 48 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 80f744407..9c1630495 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -560,6 +560,151 @@ static int module_init(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> +struct status_cb {
> +       const char *prefix;
> +       unsigned int quiet: 1;
> +       unsigned int recursive: 1;
> +       unsigned int cached: 1;
> +};
> +#define STATUS_CB_INIT { NULL, 0, 0, 0 }
> +
> +static void print_status(struct status_cb *info, char state, const char *path,
> +                        char *sub_sha1, char *displaypath)
> +{
> +       if (info->quiet)
> +               return;
> +
> +       printf("%c%s %s", state, sub_sha1, displaypath);
> +
> +       if (state == ' ' || state == '+') {
> +               struct argv_array name_rev_args = ARGV_ARRAY_INIT;
> +
> +               argv_array_pushl(&name_rev_args, "print-name-rev",
> +                                path, sub_sha1, NULL);
> +               print_name_rev(name_rev_args.argc, name_rev_args.argv,
> +                              info->prefix);
> +       } else {
> +               printf("\n");
> +       }
> +}
> +
> +static int handle_submodule_head_ref(const char *refname,
> +                                    const struct object_id *oid, int flags,
> +                                    void *cb_data)
> +{
> +       struct strbuf *output = cb_data;
> +       if (oid)
> +               strbuf_addstr(output, oid_to_hex(oid));
> +       return 0;
> +}
> +
> +static void status_submodule(const struct cache_entry *list_item, void *cb_data)
> +{
> +       struct status_cb *info = cb_data;
> +       char *sub_sha1 = xstrdup(oid_to_hex(&list_item->oid));
> +       char *displaypath;
> +       struct stat st;
> +
> +       if (!submodule_from_path(null_sha1, list_item->name))
> +               die(_("no submodule mapping found in .gitmodules for path '%s'"),
> +                     list_item->name);
> +
> +       displaypath = get_submodule_displaypath(list_item->name, info->prefix);
> +
> +       if (list_item->ce_flags) {
> +               print_status(info, 'U', list_item->name,
> +                            sha1_to_hex(null_sha1), displaypath);
> +               goto cleanup;
> +       }
> +
> +       if (!is_submodule_active(the_repository, list_item->name)) {
> +               print_status(info, '-', list_item->name, sub_sha1, displaypath);
> +               goto cleanup;
> +       }
> +
> +       if (!lstat(list_item->name, &st) && !ce_match_stat(list_item, &st, 0)) {
> +               print_status(info, ' ', list_item->name, sub_sha1, displaypath);

The question from the last round still stands
https://public-inbox.org/git/CAGZ79kb18z5zc9iu3Vv5aVZWJmoZzmwbMVpy89VC-t-ei2M+bw@mail.gmail.com/

  I am not an expert in the diff area  and wonder how
  the cmd_diff_files functionality is achieved with just a stat call
  and then comparing it to  ce_match_stat. 'Using "dirty" ignores
  all changes to the work tree of submodules, only changes to the
  commits stored in the superproject are shown.' So I'd have
  expected ce->oid to be compared (is there an index entry differing,
  i.e. more than one stage?)
