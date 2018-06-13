Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F1751F403
	for <e@80x24.org>; Wed, 13 Jun 2018 19:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935432AbeFMTab (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 15:30:31 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:39446 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935365AbeFMTa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 15:30:27 -0400
Received: by mail-yw0-f194.google.com with SMTP id 81-v6so1286247ywb.6
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+Klkkd1ELKv5/KGf2XwtzloeJTOmY0+b1gu+Rgl3uU=;
        b=ZZLJmVEL6EdSA/swqaWdGYtM1MC6WodJBIr2ZLQ56OQ6SRN2kki+0lZqEhk23KoMEo
         sW2M34OkftKtildEyPuaBVZn9BfxWlqAWhdwy6N6tG5RXEKpFUJXt1QT0m73sGlQaaEh
         ztKHf0rsP9wAsZ9O5MP+R/ceyZSmuRUpmORB3qkiKBtUcFlRp5kFI5f7b1yurqgSnJtF
         tjyH+RWftOtoJowzEnBJMyXkdQlvPnrEYmMB9N9e+7k2QikvCQGRozNAJaL2vvTukARc
         psiPo50DCXsGBcyedygZPjmbITJUV9nk/5S3X73Javt5t0x6E8+yS37xpf9WSThRUSZS
         whfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+Klkkd1ELKv5/KGf2XwtzloeJTOmY0+b1gu+Rgl3uU=;
        b=fhUZnAxHAaEp9na8Ug7VPetZcrwICDg2VSw6siCv/6YUaBmKdHmtYyl4m4dKLlm+zX
         Wzmc2Je8T2wGJccf1U2ecGFkwMm+EuKseLUxAXVzNHU3IdZ2fHJu6dosIQw2G98JIJaq
         QllFLiAAgahgkDTV5bpWKFVAbhqLDlU5BfgpIVDeSYes9WTKjDQi3MzG8b6gU7WZhy0o
         AkYnhumU2TPi9FOUW/7k0PSom/G1Yg1W8x1W8Zryic1s3s0tCPm17iTQjhhhFWrk3Pr4
         5tR3dfuiG85/4qd9P/3sg8ToOFFDXQ7FBWSz3NQnWcWCEtwOTWo26AwuW9sxWNN2IZtI
         WnLA==
X-Gm-Message-State: APt69E2k8M6kqeLzhXRuLoYPvPmqMBGNZ1uTb/vxWF30DNkTxkVnwCZ/
        dKM8HSPIviycziHjthZxsgjsvE38P/dSW9uj8k0rUA==
X-Google-Smtp-Source: ADUXVKJOdWukB2iIXarUDdWZEvuviwq1n3QkZ9PxGMxrJvw9GAGkkSe683zeeGkXbsHonpriR4QYkSWQ325r0c5s66A=
X-Received: by 2002:a0d:d304:: with SMTP id v4-v6mr3068665ywd.500.1528918226785;
 Wed, 13 Jun 2018 12:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180530004810.30076-1-sbeller@google.com> <20180530004810.30076-4-sbeller@google.com>
 <CACsJy8C=YNRmawuR3SZDMpmkKHMp=kPJsDjffCrcONe+CDpJ_g@mail.gmail.com>
In-Reply-To: <CACsJy8C=YNRmawuR3SZDMpmkKHMp=kPJsDjffCrcONe+CDpJ_g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 13 Jun 2018 12:30:15 -0700
Message-ID: <CAGZ79kY97np6ZJv1_CBx_ZqPF-AQJh2U8uW8sFxJZMAHnhPrpg@mail.gmail.com>
Subject: Re: [PATCH 03/35] object: add repository argument to lookup_unknown_object
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 12:38 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, May 30, 2018 at 2:47 AM, Stefan Beller <sbeller@google.com> wrote:
> > diff --git a/object.c b/object.c
> > index 4de4fa58d59..def3c71cac2 100644
> > --- a/object.c
> > +++ b/object.c
> > @@ -177,7 +177,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
> >         }
> >  }
> >
> > -struct object *lookup_unknown_object(const unsigned char *sha1)
> > +struct object *lookup_unknown_object_the_repository(const unsigned char *sha1)
>
> I'm looking at your branch and this function (with the _the_repository
> suffix) is still there. Did you forget to send a patch to convert this
> function?

This and parse_commit and parse_commit_gently have not been converted.

I stopped with this series as soon as I hit the commit-graph code, which needs
to be updated, too. I'll start redoing this series soon and will fix
those conversions.
