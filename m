Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E8362047F
	for <e@80x24.org>; Sun, 30 Jul 2017 05:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750782AbdG3Ffu (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 01:35:50 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36715 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdG3Fft (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 01:35:49 -0400
Received: by mail-qk0-f180.google.com with SMTP id d136so139381781qkg.3
        for <git@vger.kernel.org>; Sat, 29 Jul 2017 22:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A5rFItUxMQsBoVR4YjwVAu1f2oqOhccD4N7DmF18DVY=;
        b=E12dxGVxuK2W51uWnBvCukqsWAOOxuJCYsvjaFn6lv3Hg/xf+EkKemUgSVsqevdoqQ
         1wse4T5kJ/8u9uko2UWMK8BHVlriXz85HRcxPgyZecGJ96B5VcaX/+MryIyD1qW3pJZm
         iaFZUmoo5i/XRlXM6ytUbQBodZn4iXW8C8lkNVuAGpxIBmElNfbP4tT35r+WDTDAXR8M
         Jr+lgL6XfVtOvRuN86U2wIb3y6KbMUEx26hJU5nX1j5/BNW/EcS8bD0DDsDNStlsKzXN
         n5MzGdtKMtIWFmK8MY60iIcLe/iFooUE19+u4jq+mzWJ/h3cgH9/PQb5kDdfGLRZdyZm
         1whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A5rFItUxMQsBoVR4YjwVAu1f2oqOhccD4N7DmF18DVY=;
        b=JCRm9Pzxzfj5L94lyD2ScCcMVGrIwg2KtCHropEdwfW45jI8zInKPFTLZ7WhAg45OJ
         HQL3sPtsaTs7kR+reG5W6skNqF57haqAKPuJK5dPWaZzLVHQ/LEUdLnpZcc5RPmIb3bc
         3HXcaYGt//Z1b6F08Ql/y+jeXvE0QkbbVsxXppgIALHctTpOKcjVFXTOpdp+fl/p/OMk
         svl+c4P/T0C/3BSKkenQKVTg8D3k2RLI6p00ajcmB57oSfYLw6OSIbHcBSJ8b4UXyrmv
         XHG6aB3w0ah0kLGRwgpBLN1zcnh+PrwUa1SHRoUz6MQhsXPBMsBjsllYQU2J7e7mBbPX
         EMGA==
X-Gm-Message-State: AIVw112QB2MbmFe+kbJjV8USH8Mh9VZSV7wEvoaKJEDBvYUnDKWteVYR
        2oMcXl6ll/+zww/GGeh0dlC9BXc3oA==
X-Received: by 10.55.163.69 with SMTP id m66mr17180591qke.139.1501392948881;
 Sat, 29 Jul 2017 22:35:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Sat, 29 Jul 2017 22:35:48 -0700 (PDT)
In-Reply-To: <20170729222401.12381-5-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com> <20170729222401.12381-1-pc44800@gmail.com>
 <20170729222401.12381-5-pc44800@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 30 Jul 2017 07:35:48 +0200
Message-ID: <CAP8UFD23VmxHKaUFLkXSvEuze3QjiknaNPPgqn8CF-dx_Y_C4A@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 04/13] submodule: port submodule subcommand
 'status' from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 30, 2017 at 12:23 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:

> +static void print_status(struct status_cb *info, char state, const char *path,
> +                        const struct object_id *oid, const char *displaypath)
> +{
> +       if (info->quiet)
> +               return;
> +
> +       printf("%c%s %s", state, oid_to_hex(oid), displaypath);
> +
> +

Spurious new line.

> +       if (state == ' ' || state == '+') {
> +               struct argv_array name_rev_args = ARGV_ARRAY_INIT;
> +
> +               argv_array_pushl(&name_rev_args, "print-name-rev",
> +                                path, oid_to_hex(oid), NULL);
> +               print_name_rev(name_rev_args.argc, name_rev_args.argv,
> +                              info->prefix);
> +       } else {
> +               printf("\n");
> +       }
> +}

> +static void status_submodule(const struct cache_entry *list_item, void *cb_data)
> +{
> +       struct status_cb *info = cb_data;
> +       char *displaypath;
> +       struct argv_array diff_files_args = ARGV_ARRAY_INIT;
> +
> +       if (!submodule_from_path(null_sha1, list_item->name))
> +               die(_("no submodule mapping found in .gitmodules for path '%s'"),
> +                     list_item->name);
> +
> +       displaypath = get_submodule_displaypath(list_item->name, info->prefix);
> +
> +       trace_printf("the value of flag is %d\n", list_item->ce_flags);

Debugging left over.

> +       if (list_item->ce_flags) {
> +               trace_printf("for U the value of flag is %d\n", list_item->ce_flags);
> +               print_status(info, 'U', list_item->name,
> +                            &null_oid, displaypath);
> +               goto cleanup;
> +       }
