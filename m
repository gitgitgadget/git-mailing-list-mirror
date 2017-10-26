Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E64202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 21:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbdJZV1R (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 17:27:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45346 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbdJZV1R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 17:27:17 -0400
Received: by mail-pf0-f193.google.com with SMTP id d28so3417387pfe.2
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=9rHwH2GwWop9O7zzJdWyWPZJ1UkpOk1+soFz0frcEfE=;
        b=KaHsGQlOUKwvVgN+D5D/VpbBQYJbeS5pHgV4YAkFcpAEpMSuEb6hUTt3H1wEq57TIG
         1BjHIw4//Lvpky1DjxS3l9xFNVQh9gF3L6yoJXFPRWFJ4lFNGTi7ghZCXWnpxbdagFTT
         jxx9wJJcE41djFrACKdWFLkY8sjftkRsV43bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9rHwH2GwWop9O7zzJdWyWPZJ1UkpOk1+soFz0frcEfE=;
        b=njVbM0rw53YXP2/l4Xkq47m5vJyqUCMY2PZstZXpJGFpasPZkNVHlg/4vuevR+BRIk
         hNR+2mAB07Al4jYOvWxZB0wdwbrF771ANKONq0BKcgmwhHH6jn/dOefq9T1BvDti/N0R
         ikzspb2bjLuEcVMhIJ/822cHuShBseihiwxWwgimDw71/5cbcpDLvKw4AYBJ+9pVqhfC
         rNWgnSQkleWMNeGrPpcORP//CXLCXaL+N6pcjsZOVBmBuybNhSxlkGLZ+dNiqShILdkI
         G/k7dQDXOCSLJA+oyiX5mnrF+iOt1sTumtwSAqWtJC9vpnOcpc4EC3paLI+vONwPCc3G
         Q9hg==
X-Gm-Message-State: AMCzsaXAICoOACx2aphwggExuVu9YMb6eDWObysTf63BiedmnMDxFro1
        GxcIxDJZi1jDx0T7aFkKe8hH/g==
X-Google-Smtp-Source: ABhQp+Rw9zmdi6K0usHrrXChICWjEJ2Fes5YNT+quDwq6B1F7mGaud3n00Ye6QcdNwiwMFdFvYJ+SA==
X-Received: by 10.101.65.2 with SMTP id w2mr6316209pgp.131.1509053236263;
        Thu, 26 Oct 2017 14:27:16 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id z127sm11052593pfb.63.2017.10.26.14.27.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Oct 2017 14:27:15 -0700 (PDT)
Date:   Thu, 26 Oct 2017 14:27:07 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     Ben Peart <peartben@gmail.com>
cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/4] fsmonitor: Set the PWD to the top of the working
 tree
In-Reply-To: <5a389621-961d-48e3-339a-ef182d3ed628@gmail.com>
Message-ID: <alpine.DEB.2.10.1710261425390.9817@alexmv-linux>
References: <20171026013117.30034-1-alexmv@dropbox.com> <9af6d28ef43edbc99a9b7a9c41990de0989bfc76.1508981451.git.alexmv@dropbox.com> <5a389621-961d-48e3-339a-ef182d3ed628@gmail.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 26 Oct 2017, Ben Peart wrote:
> On 10/25/2017 9:31 PM, Alex Vandiver wrote:
> > diff --git a/fsmonitor.c b/fsmonitor.c
> > index 7c1540c05..0d26ff34f 100644
> > --- a/fsmonitor.c
> > +++ b/fsmonitor.c
> > @@ -121,6 +121,7 @@ static int query_fsmonitor(int version, uint64_t
> > last_update, struct strbuf *que
> >   	argv[3] = NULL;
> >   	cp.argv = argv;
> >   	cp.use_shell = 1;
> > +        cp.dir = get_git_work_tree();
> >   
>
> I'm not sure what would trigger this problem but I don't doubt that it is
> possible.  Better to be safe than sorry. This is a better/faster solution than
> you're previous patch.  Thank you!

See my response on the v1 of this series -- I'm curious how you're
_not_ seeing it, actually.  Can  you not replicate just by running
`git status` from differing parts of the working tree?
 - Alex
