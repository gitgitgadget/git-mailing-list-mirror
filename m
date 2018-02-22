Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E95E1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933689AbeBVST0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:19:26 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41274 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933668AbeBVSTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:19:25 -0500
Received: by mail-pl0-f67.google.com with SMTP id k8so3330264pli.8
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jCt00lEAPpioeiXtUZiudlvL1wCTygficg9A5uDbGzg=;
        b=AzDEReC69LxTBoSiYmTnYRpQ5Ty8rsSXl+2EgAfRJZo0DB7p4TNarldWmpILqvMP1p
         6CiUgCm6R0CIUt78WxblxN5aQBWok5vXiX341VIneCMWTBGAOAlSdbLWAa263Nhd7p04
         U8rwrkmn+qI87kNPT/SniAvODpYdDziyZhKyWsA8yJ2QxkHc3ZjKUeMoqBUEUxqmwyg7
         hJ+i6F4Z/kmk/EG4Z6GMiwknCNgY/6RoVvn1YzN9xkzzhiktRgT7VXKjY+RM5zodzBWa
         4xqb/TQBxEytRoKnc2Y0KVPBoKeMlOaHA1A1O0JI9W4PNRcModocpb2CiTKRFr/dGLim
         LH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jCt00lEAPpioeiXtUZiudlvL1wCTygficg9A5uDbGzg=;
        b=RM8bYFuMZl4HHiMaW2ffe7Z3itSfBldSADqxt8cv3PNcf4L/lZ9dndEI/1sdY3UrFg
         q2Z9n4yBYKytdUhZu8xC2jzb9NmNtVM5wH05h5WdbvJc0bUq1M1ES4wVXCoZoptAYBaq
         GsMvbEhZbMTUZLyId3hyaX8vJ7dmKzTwHA7Gz+1gZ79SrKyFG0FVA8pc3apJQAm4H+Pj
         qQEXkUb5WcLlUYtih0opYCGnA71RT245cL2OLVsRBDZ0R3lAbQWRVzEgd59obX5nNbc+
         DiNlFVfCofkEFxGq+nB3nRc512e4UGzh3Rw1gf4oI7eFSf2fFJwKSZCx/HfjmZXTKE1Q
         HEWw==
X-Gm-Message-State: APf1xPCZLOvtOCPjBUt9ZLS2sP5sWkp/LVS2uP1aEMC5W5AW0ZgQdL4k
        yxHZ2mf9v/6BbTjJTFOBTqYz/9hTgrc=
X-Google-Smtp-Source: AH8x225FRgYBY7ZozzNS64r6XEY2O2E8X1O0hC8KtrlDa+uaYnHNlmJHQfCPE4CrDyRz2m+9Exge4Q==
X-Received: by 2002:a17:902:b686:: with SMTP id c6-v6mr1841211pls.339.1519323564712;
        Thu, 22 Feb 2018 10:19:24 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id r80sm1358088pfe.170.2018.02.22.10.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 10:19:23 -0800 (PST)
Date:   Thu, 22 Feb 2018 10:19:22 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 14/35] connect: request remote refs using v2
Message-ID: <20180222181922.GD185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-15-bmwill@google.com>
 <20180221145411.35b2ea84747518a499276bdd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221145411.35b2ea84747518a499276bdd@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/21, Jonathan Tan wrote:
> On Tue,  6 Feb 2018 17:12:51 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > +extern struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
> > +				    struct ref **list, int for_push,
> > +				    const struct argv_array *ref_patterns);
> 
> I haven't looked at the rest of this patch in detail, but the type of
> ref_patterns is probably better as struct string_list, since this is not
> a true argument array (e.g. with flags starting with --). Same comment
> for the next few patches that deal with ref patterns.

Its just a list of strings which don't require having a util pointer
hanging around so actually using an argv_array would be more memory
efficient than a string_list.  But either way I don't think it matters
much.

-- 
Brandon Williams
