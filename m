Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D25220986
	for <e@80x24.org>; Wed, 28 Sep 2016 04:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750833AbcI1EkK (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 00:40:10 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32811 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbcI1EkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 00:40:09 -0400
Received: by mail-qt0-f194.google.com with SMTP id z36so1010827qtc.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 21:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jggoe2Q2wAe38A/xIeCM+rCw3KLAomvUWcuL6TX0TUE=;
        b=OCatV3fab7OY/M6Z4+scB2pXU4O8X3VzmILAFx+PtwS+Nttwlw0pus5hHeKt1QCoQP
         IhBiI69vBeY1v+ZSYgPje2m3Gs0QB0d2dm07SoulT8as1ABU3jGxP07M3KiTJozM5DyL
         u8bnHX3ii1rRfXdIekNrL9xYnS/YECKklsi86rccvPSeNqHBDr+wdRt2JgE27vsROZA6
         a/Vx9KmG9MFc6+VRujfSWOuOLWcTupSEBYojhII3/3z7CCoUeESIXxbeoeEptckgjd/E
         y6MoE9c7eaQV7tTC9voZrBNFFoG4Iwy/PCWLPHhRC3bDTnJ5vd1/hLpoDAEeV2Ir9I47
         jNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jggoe2Q2wAe38A/xIeCM+rCw3KLAomvUWcuL6TX0TUE=;
        b=USITOhg9PpGujnt/aDZtt1gp2J6NHQohdi+a42Y1du8byAdO+NVnzj43zFeEQNykd1
         PFXYLR+pa3QUBm3IPp2mYmlh4zibFoOXTwFnCR8nchtfd8zaDENTldixPfo/RpACO3ES
         yg8/MmjXCb57OsMeJ+tgDT7Umq+gTmYSOE97K/lUn4yx2nFdZeNJaJFMVYaa/ehjFoY3
         NdlZULh2X4IWYJz73rMQXLTcTAneBCyyI+QSI16HzuKTpXm5e0ys7GNW13Rxt/czHnVL
         1RX0T3IF9erSvnJtdHV5/yL13dMOdmPWLHB1A4EDnI71etyMHjV4+BARlWExAiSrtoWb
         HQ+Q==
X-Gm-Message-State: AA6/9RnfQiTgwKx0JK3XNZJfvLAfkE+bA9ceZgtZoWhI9K6MnC31f/x8H7gfGnTUzBx3IA==
X-Received: by 10.237.50.65 with SMTP id y59mr32033746qtd.147.1475037608347;
        Tue, 27 Sep 2016 21:40:08 -0700 (PDT)
Received: from kwern-HP-Pavilion-dv5-Notebook-PC (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id r5sm3021901qkf.34.2016.09.27.21.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 21:40:07 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
X-Google-Original-From: Kevin Wern <kwern@kwern-HP-Pavilion-dv5-Notebook-PC>
Date:   Wed, 28 Sep 2016 00:40:05 -0400
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Wern <kevin.m.wern@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 01/11] Resumable clone: create service git-prime-clone
Message-ID: <20160928044005.GA3762@kwern-HP-Pavilion-dv5-Notebook-PC>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
 <1473984742-12516-2-git-send-email-kevin.m.wern@gmail.com>
 <xmqqzin7in2c.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzin7in2c.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 01:53:15PM -0700, Junio C Hamano wrote:
> Kevin Wern <kevin.m.wern@gmail.com> writes:
> 
> > Create git-prime-clone, a program to be executed on the server that
> > returns the location and type of static resource to download before
> > performing the rest of a clone.
> >
> > Additionally, as this executable's location will be configurable (see:
> > upload-pack and receive-pack), add the program to
> > BINDIR_PROGRAMS_NEED_X, in addition to the usual builtin places. Add
> > git-prime-clone executable to gitignore, as well
> >
> > Signed-off-by: Kevin Wern <kevin.m.wern@gmail.com>
> > ---
> 
> I wonder if we even need a separate service like this.
> 
> Wouldn't a new protocol capability that is advertised from
> upload-pack sufficient to tell the "git clone" that it can
> and should consider priming from this static resource?

The short answer is yes, it could be done that way. Both methods--extending
upload-pack and creating a new service--were suggested in different
discussions.

However, my thought was to implement the separate service because:
	- It is much easier for an admin trying the feature to sanity check the
	  output of an executable, compared to passing messages to upload-pack.
	- In the other scenario, upload-pack might get too expansive in size
	  and scope--not only codewise, but in terms of config namespace if
	  "uploadpack" concerns too many things that are only tangentially
	  related (the properties of the primer resource).
	- The transport_prime_clone API can be called independent of other
	  transport API functions, which might prove useful when revisiting or
	  refactoring code.
	- You favored the creation of a service in our original discussion [1].
	  I'm not sure if your reasoning was similar to mine.

It definitely was a tight decision--for me, ultimately weighing the value added
in usability (point 1) against the need for a "failsafe" implementation. All
the other points are more speculative, IMO, but the first was strong enough for
me.

What do you think?

[1] http://www.spinics.net/lists/git/msg269992.html

> Two minor comments:
> 
>  - For whom are you going to localize these strings?  This program
>    is running on the server side and we do not know the locale
>    preferred by the end-user who is sitting on the other end of the
>    connection, no?
> 
>  - Turn "}\n\s+else " into "} else ", please.

These are fair points. Changing for the revised version.

- Kevin
