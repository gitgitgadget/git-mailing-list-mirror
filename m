Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 813DB20899
	for <e@80x24.org>; Thu, 17 Aug 2017 17:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbdHQRuR (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 13:50:17 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33557 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbdHQRuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 13:50:11 -0400
Received: by mail-pg0-f46.google.com with SMTP id t3so19439268pgt.0
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 10:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/nK5C9+2t512YWe90N6QvlOFaO36TVeRvqe13wEifmc=;
        b=qFRz6i/xfPB2t9EuLCxKdBkBZaLr3eXIAK4aZn9wW24MN19VPq41t+iv68EKXIoDMB
         1SpBfd43ZBeqQg5cxUaO1ucWWhRLyMcz3WEaU01AuD5+1XT6yHwVJfEOO9ZlYwVM7p0m
         mOe9e6tU2VkOqv3/qJkhEXMRU2N4tEs0nlt9UEKY2D+S2bBVGPEvHWH/OgUa7oo1H86U
         NExqxv6aRFVYSuTsMPq2QsxrmVZWlwXTfZrdVsffzKk9e7aF160UXjJcpSX//PX7I8Kp
         lENcQg02NLLsumIywM0r20wBgzwjvcvYvU1g9wwsEOv9dDz7QWIviJrk29ZxOt9yMBQ7
         lflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/nK5C9+2t512YWe90N6QvlOFaO36TVeRvqe13wEifmc=;
        b=oDhgWEaZs3aKiX5AWUGrspOwyc7Nc0ZjZxgLIOoLH+8y/XIEpjPcgUt44uDOhk3rkC
         lA5KfhAjp/8gOk9Rt11QvwMtWCEmGRydTUxfRZuf/RJlx5SoE1I6O67fuUKuURMWOAdk
         nZo89Bm1Tpfkf52h20q73MuR9366XozdchW3bFoJ0DwA6pVMGSNf1IeH0h8HY9pKaoH9
         HEc8K1w9Hc+PMWbaCCDwZZwZHZ4XtYevoQmVwJIjs78iQzMuqSixcVNp7mZy/1Lswblf
         fMs4ZrTpHnRJWJenM0q3l/Fm5Nzt62PS2rBt0R9Ng/aHFAWVxJChfy2iyq+nX3rVJz2C
         dpLA==
X-Gm-Message-State: AHYfb5geBAZjje1OL6PZs++RTaNG3Z0HT7BjEMgcmI+eTiNDb9a+ABdh
        twJxbuXRy5AixvQH
X-Received: by 10.99.115.2 with SMTP id o2mr5741909pgc.48.1502992210345;
        Thu, 17 Aug 2017 10:50:10 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:dc1f:8c2d:b088:2ecf])
        by smtp.gmail.com with ESMTPSA id b184sm8155329pfb.53.2017.08.17.10.50.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 10:50:08 -0700 (PDT)
Date:   Thu, 17 Aug 2017 10:50:07 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 2/2] submodule: simplify decision tree whether to or
 not to fetch
Message-ID: <20170817175007.GA109680@google.com>
References: <20170817105349.GC52233@book.hvoigt.net>
 <20170817110013.GD52233@book.hvoigt.net>
 <CAGZ79kZ2oOK_=jdKa9EMMUO8pi+v+f6tn83sSvafO1Jg5YOjew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ2oOK_=jdKa9EMMUO8pi+v+f6tn83sSvafO1Jg5YOjew@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/17, Stefan Beller wrote:
> On Thu, Aug 17, 2017 at 4:00 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > To make extending this logic later easier.
> >
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> > ---
> > I am quite sure I replicated the same logic but a few more eyes would be
> > appreciated.
> 
> A code cleanup is appreciated!
> 
> I thought Brandon had a series in flight doing a very similar cleanup here,
> but in master..pu there is nothing to be found.

Yeah there are 2 series in flight which will probably conflict here.
bw/grep-recurse-submodules and bw/submodule-config-cleanup

> 
> > Cheers Heiko
> 
> The code looks good to me.
> 
> Cheers!
> Stefan
> 
> >
> >  submodule.c | 55 +++++++++++++++++++++++++++----------------------------
> >  1 file changed, 27 insertions(+), 28 deletions(-)
> >
> > diff --git a/submodule.c b/submodule.c
> > index 3ed78ac..a1011f4 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -1171,6 +1171,21 @@ int submodule_touches_in_range(struct object_id *excl_oid,
> >         return ret;
> >  }
> >
> > +static int get_fetch_recurse_config(const struct submodule *submodule, int command_line_option)
> > +{
> > +       if (command_line_option != RECURSE_SUBMODULES_DEFAULT)
> > +               return command_line_option;
> > +
> > +       if (submodule && submodule->fetch_recurse != RECURSE_SUBMODULES_NONE)
> > +               /* local config overrules everything except commandline */
> > +               return submodule->fetch_recurse;
> > +
> > +       if (gitmodules_is_unmerged)
> > +               return RECURSE_SUBMODULES_OFF;
> > +
> > +       return config_fetch_recurse_submodules;
> > +}
> > +
> >  struct submodule_parallel_fetch {
> >         int count;
> >         struct argv_array args;
> > @@ -1203,37 +1218,21 @@ static int get_next_submodule(struct child_process *cp,
> >                 if (!submodule)
> >                         submodule = submodule_from_name(&null_oid, ce->name);
> >
> > -               default_argv = "yes";
> > -               if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
> > -                       if (submodule &&
> > -                           submodule->fetch_recurse !=
> > -                                               RECURSE_SUBMODULES_NONE) {
> > -                               if (submodule->fetch_recurse ==
> > -                                               RECURSE_SUBMODULES_OFF)
> > -                                       continue;
> > -                               if (submodule->fetch_recurse ==
> > -                                               RECURSE_SUBMODULES_ON_DEMAND) {
> > -                                       if (!unsorted_string_list_lookup(&changed_submodule_names,
> > -                                                                        submodule->name))
> > -                                               continue;
> > -                                       default_argv = "on-demand";
> > -                               }
> > -                       } else {
> > -                               if ((config_fetch_recurse_submodules == RECURSE_SUBMODULES_OFF) ||
> > -                                   gitmodules_is_unmerged)
> > -                                       continue;
> > -                               if (config_fetch_recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) {
> > -                                       if (!unsorted_string_list_lookup(&changed_submodule_names,
> > -                                                                        submodule->name))
> > -                                               continue;
> > -                                       default_argv = "on-demand";
> > -                               }
> > -                       }
> > -               } else if (spf->command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
> > -                       if (!unsorted_string_list_lookup(&changed_submodule_names,
> > +               switch (get_fetch_recurse_config(submodule, spf->command_line_option))
> > +               {
> > +               default:
> > +               case RECURSE_SUBMODULES_DEFAULT:
> > +               case RECURSE_SUBMODULES_ON_DEMAND:
> > +                       if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
> >                                                          submodule->name))
> >                                 continue;
> >                         default_argv = "on-demand";
> > +                       break;
> > +               case RECURSE_SUBMODULES_ON:
> > +                       default_argv = "yes";
> > +                       break;
> > +               case RECURSE_SUBMODULES_OFF:
> > +                       continue;
> >                 }
> >
> >                 strbuf_addf(&submodule_path, "%s/%s", spf->work_tree, ce->name);
> > --
> > 2.0.0.274.g6b2cd91
> >

-- 
Brandon Williams
