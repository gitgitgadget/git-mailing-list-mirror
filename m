Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B4AD1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 21:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755406AbeFNVSr (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 17:18:47 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41649 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754749AbeFNVSq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 17:18:46 -0400
Received: by mail-pg0-f67.google.com with SMTP id l65-v6so3469506pgl.8
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y8O02HMmHKA3hE1VAJRLhAN41Q5fLyCOXvSVRssrQyA=;
        b=TXV+jSrySKKl55+3lOxca+EaBc23BpmOhmjH7PsWZeBG9cH5tcKXjEF2nzqKhIBqlt
         o6WjaA1v6hsdGNl5pqbP3/85irz2Ebssd1Lu2d2uBjOf1Mu1RR05ujFY6Qe8JxgemFVi
         vMa90Wmkh7Ph+wVmaeW3/BU+Zgm1FyMyDL2mJJDcTr+lELYJWDFRpe54UsA5ej9G/CJF
         pXxXtB07e4X7XEhyXeWv9kuiBoHTY+Gx4vD4WQSWJQLT/ABntAVzQYHPqaEOOK2IZUHx
         lC5GCKn51zl2Xi2uAXu5e+b+TwvPyWHK/CYLc8Vb0iqosTaU6dalUFLx47T5WWHB8Zx9
         Obng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y8O02HMmHKA3hE1VAJRLhAN41Q5fLyCOXvSVRssrQyA=;
        b=ORCh2N9yQ2P2KUfZMcwMUJYnhLKdjn+/960E2NNPdMdIk5c57uD5b1icydjf36S1Cs
         EFI9E3wce/smidgYmuGR/TiX1moozp7cVvWvUs6IPVMtaOGwL2Uex6UYlOD8im0TshC4
         P1hqYNXMCB/mZkSFxNeKln0xiY+VfAZ6QL095U0wgBdPgDW3beg0KwE33zXNidvZiu3+
         dBTOoXPTI0A2MLv+7sKBGA8708X3r2uZcFUy2Hv/unntI2oIkHby0eDc7pziZKuusUvq
         mL8UZBc/GAiiWEL71ZNAyyPNag8LbZEMW8JRyNWGojMSJy06ybH56C7UPzs2nekYQTl2
         bMng==
X-Gm-Message-State: APt69E2RzFR6yPektPk208BV6t8BLA/JoqjnBR/MiPVnoOXaryUIe9q3
        u/52LAdMPwATkfP5ULG/ebEvFw==
X-Google-Smtp-Source: ADUXVKJAjjvfAAN/zX9uKMHrD/9jpr7lVZg7CA3OMKnYGvcryb2vMrjQccRRFioCwnSLMvEfK1L8Hw==
X-Received: by 2002:a63:b609:: with SMTP id j9-v6mr3722849pgf.335.1529011125322;
        Thu, 14 Jun 2018 14:18:45 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p20-v6sm8794162pff.90.2018.06.14.14.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 14:18:43 -0700 (PDT)
Date:   Thu, 14 Jun 2018 14:18:42 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 8/8] fetch-pack: implement ref-in-want
Message-ID: <20180614211842.GA68349@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
 <20180613213925.10560-1-bmwill@google.com>
 <20180613213925.10560-9-bmwill@google.com>
 <CAGZ79kZGV7NeYGpt=BJTASZYva3pyY-2CxMmDMXXxuZeg4sfjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZGV7NeYGpt=BJTASZYva3pyY-2CxMmDMXXxuZeg4sfjQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/14, Stefan Beller wrote:
> On Wed, Jun 13, 2018 at 2:39 PM Brandon Williams <bmwill@google.com> wrote:
> 
> > +static void receive_wanted_refs(struct packet_reader *reader, struct ref *refs)
> > +{
> ...
> > +
> > +               for (r = refs; r; r = r->next) {
> > +                       if (!strcmp(end, r->name)) {
> > +                               oidcpy(&r->old_oid, &oid);
> > +                               break;
> > +                       }
> > +               }
> 
> The server is documented as MUST NOT send additional refs,
> which is fine here, as we'd have no way of storing them anyway.
> Do we want to issue a warning, though?
> 
>     if (!r) /* never break'd */
>         warning ("server send unexpected line '%s'", reader.line);

Depends, does this warning help out the end user or do you think it
would confuse users to see this and still have their fetch succeed?

> 
> 
> 
> > diff --git a/remote.c b/remote.c
> > index abe80c139..c9d452ac0 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -1735,6 +1735,7 @@ int get_fetch_map(const struct ref *remote_refs,
> >                 if (refspec->exact_sha1) {
> >                         ref_map = alloc_ref(name);
> >                         get_oid_hex(name, &ref_map->old_oid);
> > +                       ref_map->exact_sha1 = 1;
> >                 } else {
> >                         ref_map = get_remote_ref(remote_refs, name);
> >                 }
> > diff --git a/remote.h b/remote.h
> > index 45ecc6cef..e5338e368 100644
> > --- a/remote.h
> > +++ b/remote.h
> > @@ -73,6 +73,7 @@ struct ref {
> >                 force:1,
> >                 forced_update:1,
> >                 expect_old_sha1:1,
> > +               exact_sha1:1,
> 
> Can we rename that to exact_oid ?

I'll fix this.

-- 
Brandon Williams
