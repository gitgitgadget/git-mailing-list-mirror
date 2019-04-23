Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 937211F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 20:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfDWUVS (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 16:21:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37013 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDWUVR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 16:21:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so1706271wmf.2
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 13:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Alnx2tLLW/7nlvoq3G+34akhSgnw/lA2vJVrFoMmkgA=;
        b=OAHXxePbTzkCEpOMbU1nDMApN00rLVSz+0JDAr4BROWqa6Pmr9wSxW8GAZV6dCro1R
         vH4l3isKr0Q9UjFj4/0zCpBzH88LT35D02QY5KQL9ROXzO+gzwDjc54X2Igq9Tks3Lzf
         58VI6Ws4tjhHo/Xr8SLSO3kEPy9WeBWby5wBFC3mgOTg3fmPIcXW6oKd0DIk6Gpsrl/+
         R+1B3Wn7+dViG5Va/v/8TtOuRYNaq6FPCjlCng7vLLzCHYo9fXktD9pWQIGP7AK0JG4V
         BFpj+Irmani/fNPlgSFOxrOyWMEwCfepTn1g77L2iDmOtUDP7Jw9ci0Yt9EgFpbSZMXj
         0tYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Alnx2tLLW/7nlvoq3G+34akhSgnw/lA2vJVrFoMmkgA=;
        b=BFRG+PDwcL7bapeNDdy9tkK0WYkVxtU5JDDQwY+iR/0Ry3UrDA8/DSLv6sqTvnHuZ7
         oPQEse5z1J7njC7FriIMF1nUjXN+c4Qh3/XOg9OvXpXfUiH0rZzNQ92mJQFwEwy0Wuo7
         MASD5XtwVUc3n2LTtqBS5UjJQuPzHExd4M18ArL6TIEcktPGqzaR4KhdOWp0bl11r/Y9
         E6etcMQvsJSUl34yz8RDuX9+MWFhYvDaberdxcU0fQnQXxnQuFLNP7GcyDIpkTnmveJp
         xia/SH+4+X6Gt1k+8m73pxbbg9ozAvOzYNdWrDVe0yq2d3QkqKv8ckrgNUIysLhYbOp9
         eCPA==
X-Gm-Message-State: APjAAAXJkKtzWqXzRRtUAKy1HsaEudYxgdFACFydzfkFxI0jyWCYVrus
        M/VoDxwdWGSyfQuiDSCTtpU=
X-Google-Smtp-Source: APXvYqw4AHaRCpouTnVV0anZbw4VK7UnW4nd50w9oojZhggBXrEJ17m23rzETAjkx0aAxfwALKqIDg==
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr3603535wmi.2.1556050876247;
        Tue, 23 Apr 2019 13:21:16 -0700 (PDT)
Received: from szeder.dev ([213.208.157.40])
        by smtp.gmail.com with ESMTPSA id z140sm34701846wmc.27.2019.04.23.13.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 13:21:15 -0700 (PDT)
Date:   Tue, 23 Apr 2019 22:21:09 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH/RFC] Makefile: dedup list of files obtained from ls-files
Message-ID: <20190423202109.GA8695@szeder.dev>
References: <xmqqy343a43b.fsf@gitster-ct.c.googlers.com>
 <20190422144927.GA6519@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190422144927.GA6519@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 10:49:27AM -0400, Jeff King wrote:
> On Sun, Apr 21, 2019 at 10:19:04PM +0900, Junio C Hamano wrote:
> 
> >    I am not fan of adding the "| sort -u" of the whole thing,
> >    because there is no need to dedup the output of the $(FIND) side
> >    of the alternative, but "(ls-files | sort -u) || (find)" would
> >    obviously not work.  If we truly care, perhaps we should add a
> >    new option to ls-files to show each path only once, unless it is
> >    showing the stage number (i.e. "ls-files -s" or "ls-files -u"),
> >    but this gets the problem go away without code change, hence this
> >    RFC ;-)
> 
> FWIW, after reading your commit message my thoughts immediately turned
> to "why can't ls-files have a mode that outputs each just once", but
> then ended up at the same place as your patch: it's not that hard to
> just de-dup the output.
> 
> It _could_ be a sign that other scripts besides our Makefile would
> benefit from such an option, but I think I'd want to see at least one
> other example before going in that direction.

I remember being rather puzzled by 'git ls-files' listing the same
file more than once depending on its --options when I was working on
the git-aware path completion parts of our completion script.

