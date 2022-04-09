Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3214EC433EF
	for <git@archiver.kernel.org>; Sat,  9 Apr 2022 06:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiDIGfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Apr 2022 02:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiDIGfl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Apr 2022 02:35:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4174A23AC9D
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 23:33:35 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h5so8671079pgc.7
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 23:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qRWhSZh+fVwP6q4IyfwGhW7O3tAl/uD0zEMLWtoQSRw=;
        b=Yd+vi/Lbjo70aWkY+xwUU+unLejSpgfXFEue2CE0v/jyFJXaTRFEbaKx8JT772lC2e
         XMQ/vKcphykR8GRbUdYlVhIVmI/oU4BBve7OIO93V1X6h0UwybyJ/mJq0ulf/p41T1Vr
         rl6X6zFDiBnMEE5sR5UMtDNvb4oFyGejSG6WiVtIkhwBYPc4Q9EpK42avQjaUsawBmdG
         AjagDHY/cozmU8wi7fWEfNdOL1Tr4aYxZ3pwPpcku3H/+Gh1NVnZKbg1cdKd3EhPbo4T
         qPNHZ7ZN29pzYz9Ywkl5B4KUU/skdTd6Ym47YocyM7BxIV9u3Boo2ySQVm9ub9l/FGpD
         hQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=qRWhSZh+fVwP6q4IyfwGhW7O3tAl/uD0zEMLWtoQSRw=;
        b=roHRBsGAox2qy8gVtd63iRT4VWK/KId6+z7LLuiOZIGJHgHRHeUDj4ZB3Jhhe4ftO0
         WJvgh/z4EVnOYo9PwFLdDsUUZllxBpFiqe5oTIFbvr+ABMyMqrnsGJZWs7l5ZxQVAitK
         ZbOTza2z1VG5qnpbo2dkO0Qk1vCSAhZIanj6erGT7LUcFT66jPMwyD7gugW9tZEMzCGy
         zl07hmx7QU9S1yI9VbiIUUTesypvBxysDC4GaP5BdRTytcttN5JtuVRB38hU2uf3ul6V
         T6NGY2xZCKOESauhmIuSy4sOuU6Sve0p4OVtzwNymshDk/QaND21EQj2jNDfw0ArhM9G
         mzXA==
X-Gm-Message-State: AOAM532nWNk5WEiFZndo3dyAHVtIbzNs6RGBLxCTfeBpqpxBVZ+c8QdA
        3qIT8OWpyevuxkD1ml8nShACYg==
X-Google-Smtp-Source: ABdhPJznyMgEGjIiuD+xmUVwj7QYNXhHf+efZV2PvZ+2Y+uxps7COSk1TExVS12zpainbcHVKrlpZw==
X-Received: by 2002:a63:d342:0:b0:381:fd6f:4792 with SMTP id u2-20020a63d342000000b00381fd6f4792mr18182212pgi.101.1649486014562;
        Fri, 08 Apr 2022 23:33:34 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:e11f:3ca:fe42:191e])
        by smtp.gmail.com with ESMTPSA id q14-20020aa7960e000000b0050595cd0238sm1759677pfg.99.2022.04.08.23.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 23:33:33 -0700 (PDT)
Date:   Fri, 8 Apr 2022 23:33:26 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        lessleydennington@gmail.com, gitster@pobox.com
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
Message-ID: <YlEotqSn/3Ie6FzD@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        lessleydennington@gmail.com, gitster@pobox.com
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
 <471ca70d-0da1-8c4f-16bc-3019706931bd@github.com>
 <Yjt6mLIfw0V3aVTO@nand.local>
 <220329.86lewt2kqp.gmgdl@evledraar.gmail.com>
 <YkO/5/TVQvqyVQly@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YkO/5/TVQvqyVQly@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.03.29 22:26, Taylor Blau wrote:
> On Tue, Mar 29, 2022 at 11:03:14AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >
> > On Wed, Mar 23 2022, Taylor Blau wrote:
> >
> > >  	/* Boolean config or default, does not cascade (simple)  */
> > >  	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
> > > +	repo_cfg_int(r, "commitgraph.generationversion", &r->settings.commit_graph_generation_version, 2);
> >
> > If this ends up being kept let's add it to its own commented "section",
> > the comment 2-lines above it is now incorrect.
> 
> Thanks for pointing it out; indeed that comment is definitely stale with
> respect to the newer code. This patch was just a sketch of an
> alternative approach for Josh to consider, so I can't guarantee that it
> isn't immune to nit-picks ;).
> 
> I think that Josh is planning on picking this up, so hopefully he
> doesn't mind applying these and any other touch-ups locally before
> resubmitting.
> 
> (Josh, if you do: thank you very much in advance!)
> 
> Thanks,
> Taylor

Done in V2, to be sent out shortly.
