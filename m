Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645BF1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 00:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932888AbeFFAiV (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 20:38:21 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39782 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932185AbeFFAiU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 20:38:20 -0400
Received: by mail-pg0-f67.google.com with SMTP id w12-v6so2074940pgc.6
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 17:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QH1mGUxwa7zcC9mrBl4O8QzRc9fl0l140HJ6OCAQoak=;
        b=lU3h4aWHhkzHvc2eKONT30wUYj+VWDEWzYH2Y64cu5Lqj7SoHz21xSkz2TRzoKKY92
         lhDonXnf2BVeZ4ak+eGejqNEEEgJgdQIpLgc44WRacBsp4d0J/FDmdgUrCvje77vQ6ce
         GjmkTG/ZcaeeKGE6TftnIyLgPWtG1QMW5jGG4JKYerHAsNZ+d9kHdNhq/mypIBHKIdFl
         jIbrWDR2ONgPgaRKZ5bhLl5GiaiYCGkHLYBrQ+YwPrtTy2yClcwog3j3QSyeJBmX/QSZ
         F2uiql3QThKkgO7aDx18pti0ebvTpXbrorm+gl7gYZguIQzrf5+SlwFKWKa0Uj2kvODF
         SQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QH1mGUxwa7zcC9mrBl4O8QzRc9fl0l140HJ6OCAQoak=;
        b=ZbUNPcohNy+3Z/efJJZfmZuX0zJtKGLaYmQb9kqrucYydFp3Ky8zku4lRVb7h4L/+G
         +Kcn12tT1dfH3MoWDT8wbOfoE6qKHOD0j9hqOEHjIM1MXeOgtDzW5s1U43iptwYPgMJh
         Hz9ugU8Yry6E9FZggJs75EQk8YTcJsXLhlWWCdGnYap1GAx+aJwfc86vHZH3yaGTZXH0
         9Rb1ThcZSerRiiZ29yH+EFahKQNH58sdMCk02q5We0vKW6l53zU5g5bAavEgnstgpP3M
         KDiP2b1RpZdRinEiEPpDgyIms0fnvRQ9qotUdvpQ3LUZ+XAWc5/oVs28Ri/1jBjTz+1F
         vLng==
X-Gm-Message-State: APt69E25ZPO385otpJAnKL68nG/tZeVZia1lymCSw6OyrnD9+jzDHOrS
        8dliP/cGkFAzz+gGB4r8DoNkd4qibqI=
X-Google-Smtp-Source: ADUXVKL8AeegBSvBMwgqurUPIcINrN5jbfr93osqZEpF7JzpfZ5SCr8yxTVHsKo7RSppB/4corDgMw==
X-Received: by 2002:a63:b505:: with SMTP id y5-v6mr686590pge.213.1528245500169;
        Tue, 05 Jun 2018 17:38:20 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id g12-v6sm10312665pfh.164.2018.06.05.17.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 17:38:19 -0700 (PDT)
Date:   Tue, 5 Jun 2018 17:38:18 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bmwill@google.com
Subject: Re: [PATCH 2/6] fetch-pack: truly stop negotiation upon ACK ready
Message-Id: <20180605173818.4d56cf328d81b29a2878c1f6@google.com>
In-Reply-To: <20180605231634.GD9266@aiede.svl.corp.google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
        <c79a6e6f96e2e453017669fabbed1a9fb4036cce.1527894919.git.jonathantanmy@google.com>
        <20180605231634.GD9266@aiede.svl.corp.google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 5 Jun 2018 16:16:34 -0700
Jonathan Nieder <jrnieder@gmail.com> wrote:

> Hi,
> 
> Jonathan Tan wrote:
> 
> > When "ACK %s ready" is received, find_common() clears rev_list in an
> > attempt to stop further "have" lines from being sent [1]. This appears
> > to work, despite the invocation to mark_common() in the "while" loop.
> 
> Does "appears to work" mean "works" or "doesn't work but does an okay
> job of faking"?

"Appears to work" means I think that it works, but I don't think I can
conclusively prove it.

> > Though it is possible for mark_common() to invoke rev_list_push() (thus
> > making rev_list non-empty once more), it is more likely that the commits
> 
> nit: s/more likely/most likely/
> or s/it is more likely that/usually/
> 
> > in rev_list that have un-SEEN parents are also unparsed, meaning that
> > mark_common() is not invoked on them.
> >
> > To avoid all this uncertainty, it is better to explicitly end the loop
> > when "ACK %s ready" is received instead of clearing rev_list. Remove the
> > clearing of rev_list and write "if (got_ready) break;" instead.
> 
> I'm still a little curious about whether this can happen in practice
> or whether it's just about readability (or whether you didn't figure
> out which, which is perfectly fine), but either way it's a good
> change.

I tried to figure out which, but concluded that I can't.

I think that in v2's commit message, I'll start with describing the
readability aspect.

> > @@ -1281,7 +1281,6 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
> >  		}
> >  
> >  		if (!strcmp(reader->line, "ready")) {
> > -			clear_prio_queue(&rev_list);
> >  			received_ready = 1;
> >  			continue;
> 
> I'm curious about the lifetime of &rev_list.  Does the priority queue
> get freed eventually?

No (which potentially causes a problem in the case that fetch-pack is
invoked twice), but I fix that in patch 4/6, so I didn't bother
addressing it here. I'll add a note about the lifetime of this priority
queue in v2.
