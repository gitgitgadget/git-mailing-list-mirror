Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC861FC46
	for <e@80x24.org>; Thu,  9 Feb 2017 07:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbdBIHMa (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 02:12:30 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:40065 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbdBIHM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 02:12:29 -0500
Received: from homiemail-a12.g.dreamhost.com (sub3.mail.dreamhost.com [69.163.253.7])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 88D8D7FFEF
        for <git@vger.kernel.org>; Wed,  8 Feb 2017 11:06:50 -0800 (PST)
Received: from homiemail-a12.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTP id C242F26206C;
        Wed,  8 Feb 2017 11:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=9HYms
        /u9LTLl6yOI/Z0GvDhwe/A=; b=ipFXPtpPE90Tm50t+EW03/ZHOT8Ush9OFvVhJ
        leqgS1YY8MTfjj26HYlR8LGq0IqXzHzzCk5OyqI0pY8MGMIUiQNgL/ircMycAOiO
        3Znn7lYT0dwKZJFPcE3H6SfyNkFMyhg1Lkai8Zg7Y6BiYkpkSkelrm8xLEAX1Rrk
        dDV7os=
Received: from [172.31.11.72] (gzac12-mdf2-1.aoa.twosigma.com [208.77.215.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTPSA id 39FAB262062;
        Wed,  8 Feb 2017 11:05:44 -0800 (PST)
Message-ID: <1486580742.1938.52.camel@novalis.org>
Subject: Re: "disabling bitmap writing, as some objects are not being
 packed"?
From:   David Turner <novalis@novalis.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Date:   Wed, 08 Feb 2017 14:05:42 -0500
In-Reply-To: <xmqqtw84wpag.fsf@gitster.mtv.corp.google.com>
References: <1481922331.28176.11.camel@frank>
         <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
         <CACsJy8ACy+Hv1Z3FgG-WFBozwWqmMuN-JnMWF-+rdpF0knFjqg@mail.gmail.com>
         <1486515795.1938.45.camel@novalis.org>
         <CACsJy8C81+D=UG4pZ4e+URQqKRCPG=5bLiCHbGCQamvE-2y2MQ@mail.gmail.com>
         <1486542299.1938.47.camel@novalis.org>
         <CACsJy8C4DO-GYREUhED3YU_WetoTZaB3MUq1kGfRjA3e-FOLYQ@mail.gmail.com>
         <xmqqtw84wpag.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-02-08 at 09:44 -0800, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On second thought, perhaps gc.autoDetach should default to false if
> > there's no tty, since its main point it to stop breaking interactive
> > usage. That would make the server side happy (no tty there).
> 
> Sounds like an idea, but wouldn't that keep the end-user coming over
> the network waiting after accepting a push until the GC completes, I
> wonder.  If an impatient user disconnects, would that end up killing
> an ongoing GC?  etc.

Regardless, it's impolite to keep the user waiting. So, I think we
should just not write the "too many unreachable loose objects" message
if auto-gc is on.  Does that sound OK?


