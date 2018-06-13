Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 911FC1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 20:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935667AbeFMUzY (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 16:55:24 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45474 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935524AbeFMUzX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 16:55:23 -0400
Received: by mail-yw0-f196.google.com with SMTP id v190-v6so1365175ywa.12
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 13:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zrloeNFLRMlVSZm9Y6RclXkvsS4/Q28GD3n6489KlZU=;
        b=Omhed6qIsleA3hxxdAh/6eD7scGU/LsrR7yF55j2iyMS7aO+Dio03ta/x1M5Gj97s+
         0vr3zrZ+uKJ3HalAslQkev19KwWiTd4s0yegMV4QxtTkTkbY2T98gZ7OEdoseFyEJuwo
         enr50kTKAcOTHWV6thKpsUawyV26ewVTg5aJ34Mqj6+C9mITtQVIPnDP3BxVtCkAoHgg
         7z6/3BQ1+9+pa++UXx4qrePWqafDmM0I45vjkO2xQSvZqa5tD7zSfwL/OMfKBZa/bUqg
         CmJVMjZPi8/sVDfStNLC5yIIAZQuskD7U/mY3lhQIWLGnoOTizynFg4KcBoF4F8rkhvy
         I3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zrloeNFLRMlVSZm9Y6RclXkvsS4/Q28GD3n6489KlZU=;
        b=aN7joDNruO+0D+9XcWoxZm3G2ao5ITcRPMFvoyd5pGtDRImBURnvz2WQS1MNo33+48
         1rO6BF2I4N5fFXT8eHSCUjMsSjwA/MTk6rWqYNvcB69RUJu5Oat+ZaaiT8lKXZf4Cgjg
         yTA/YpwtvB2+lqoeaUnHNeJ/bYNh6q+1E4RosIC0/d7ffXsr/whkXlpK5uuOS3LAby1l
         4wG9hlJ0NVPZY67hrwlPsoV21rwSjOU3ftOrwp50+8S0IbNjepyPRKOGrB1Vfa1c2/OI
         zBxxR2DztpaDsyxbd1QKcx53Hm7vL9q+MIaaoW4S1h6t5zkS7HIOExu54ImPG68EGr4o
         3cpw==
X-Gm-Message-State: APt69E3yCtXuNCdFUX5MERV0SOYkJb1S03weZPrap6F4LOTyNbMN6g1C
        N+B5T6I1On3mXUSb4BUFeH+qNL9AliazGNKmHE/50A==
X-Google-Smtp-Source: ADUXVKIBNb02JJwPoiH5FWWAxy9N7L7ywOCJj3WxPsnMa62rIjxrhLSonYqRvg1olyT0B5/mQne1JYodCkN9bDRFEuQ=
X-Received: by 2002:a81:4d43:: with SMTP id a64-v6mr3221785ywb.33.1528923322321;
 Wed, 13 Jun 2018 13:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180530004810.30076-1-sbeller@google.com> <20180530004810.30076-29-sbeller@google.com>
 <CACsJy8BQGqNDkoL0ykNdbgAx75MjPzW3Ki5+rbHxxJ8TNWDZcw@mail.gmail.com>
In-Reply-To: <CACsJy8BQGqNDkoL0ykNdbgAx75MjPzW3Ki5+rbHxxJ8TNWDZcw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 13 Jun 2018 13:55:11 -0700
Message-ID: <CAGZ79kYxttQvoyg-QuMw3Wwm_j=MSw_ut2bY6vHHfDv4qgB7jA@mail.gmail.com>
Subject: Re: [PATCH 28/35] commit.c: migrate the commit buffer to the parsed
 object store
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 12:32 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >  define_commit_slab(buffer_slab, struct commit_buffer);
>
> struct buffer_slab is defined locally here...
>
...
> > +struct buffer_slab *allocate_commit_buffer_slab(void);
>
> So you would need a forward declaration of struct buffer_slab in
> commit.h before it's referenced here?

Will do so in a resend; as well as in object.h
