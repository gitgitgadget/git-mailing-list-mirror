Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1CF6208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 18:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755492AbdHYSzJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 14:55:09 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33819 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754717AbdHYSzI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 14:55:08 -0400
Received: by mail-pg0-f50.google.com with SMTP id a7so3470511pgn.1
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 11:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PGFVk1niufUX0AOHaGBNfo/loLnY8Er3JL1iATIGSyc=;
        b=t8x1d7DFORwU2WoMDCCLDoaZ4xiK17A7csDG5rlr1+QYr2tXIN8CCLgzWZqH+qC2jO
         3ZZmajcumkjg5NBrG2Dii8zjKMy3vq+nnazXEqRBunw5d3CFBxqdvrVKxSKPlnirs5cw
         2f+c2PeZ7XZU77QoQ+01G7CtwOG3aIbOlRXWuCTDmcLjwwM3YvzB7NORyIh+/UHRud1V
         506jvS6eZuJTfrwENHIXrD49UZz+b7VBdBt6yngAfVgJzIyMrw8A4COHqYiC+raUH7UN
         K1ASbx6QIzX8wvipKhm+mRhL7b02G5GYsmWeVBPhaVOwVjMyvNvum4ORrNDQOBOS+4ui
         RmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PGFVk1niufUX0AOHaGBNfo/loLnY8Er3JL1iATIGSyc=;
        b=G7SxY+M/zZR8tL+woVGAsw4DOolznk6DkrNmH6wjIc+W63gx6UHOKLHsmxKkP3AVLv
         SKm08BOznW3y1TDEVFw5t+ToGaCYvUXadbJ75WaBD/Hdyj3jyMwXVrpfpRXHU+Cob3EL
         u89hGLA3u1WHDTyysKjfRS/BH40RWckCIg+bP1dKgP6Wux5qq96WzKobdd+WaUfB59h7
         eZ+Wj3BtTdXWp9DEvSisRr8993XUiDGveVyPRlh0cpe89VJVQEaDaL+zyhf4XaNnGlcW
         ReNvxwENC4uuZ6SCVjtgxig8/Fg68mRhCMiu5OpSikhidxsZQLUdSebUpxt9MQ/2WxkE
         KE7w==
X-Gm-Message-State: AHYfb5gPV0ej2wrCfOXxeVKlu7xoxZdrzLpoY+nhbkd2SaSEbPjQYWds
        FB5t+0ZbN2wL6cyi
X-Google-Smtp-Source: ADKCNb4O2B7TwmH8rNQwzYnslRgE59byeBLhb2wsTxnKBu7AaFlKlWr+PnJwAyK7XM29OpSJ34yjwA==
X-Received: by 10.84.229.136 with SMTP id c8mr11758710plk.27.1503687308307;
        Fri, 25 Aug 2017 11:55:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:f5e9:c606:d78a:b54a])
        by smtp.gmail.com with ESMTPSA id q185sm11978338pfb.119.2017.08.25.11.55.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Aug 2017 11:55:07 -0700 (PDT)
Date:   Fri, 25 Aug 2017 11:55:06 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        sbeller@google.com, jonathantanmy@google.com
Subject: Re: [RFC 3/7] protocol: tell server that the client understands v2
Message-ID: <20170825185506.GC103659@google.com>
References: <20170824225328.8174-1-bmwill@google.com>
 <20170824225328.8174-4-bmwill@google.com>
 <xmqqtw0vsfrz.fsf@gitster.mtv.corp.google.com>
 <20170825185321.GB103659@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825185321.GB103659@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/25, Brandon Williams wrote:
> On 08/25, Junio C Hamano wrote:
> > Brandon Williams <bmwill@google.com> writes:
> > 
> > > +		/* If using a new version put that stuff here after a second null byte */
> > > +		strbuf_addch(&request, '\0');
> > > +		strbuf_addf(&request, "version=%d%c", 2, '\0');
> > > +		/* subsequent supported versions can also be added */
> > > +		strbuf_addf(&request, "version=%d%c", 3, '\0');
> > 
> > Isn't this last one meant only as a comment?
> 
> Sorry since this was structured as an RFC I didn't go back through the
> code with a fine tooth comb to ensure I removed or commented out any
> debugging statements.  Stefan also pointed out to me that I left in an
> if (0) statement somewhere haha.

Oh one more thing about this line.  I added it to show (and check) that
git-daemon would be able to cope with more than one field being added as
I wanted to avoid the issue we had when adding the 'host' field where
additional fields aren't allowed as they aren't gracefully ignored by
the server.

-- 
Brandon Williams
