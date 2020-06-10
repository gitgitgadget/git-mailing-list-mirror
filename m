Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB192C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7411720801
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD3kVE/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgFJXbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJXbc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 19:31:32 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D40FC03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 16:31:32 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id w90so3265560qtd.8
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 16:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9D0fUffVRw+pNJwNZkQqb+pZrNOvXXWqkK0qE9KtaDI=;
        b=aD3kVE/nEAMr1aYFqgOYQJ2nrrWIX7RurBF0LQWKNfy2VCXy4ZguYRy4noAnPofe7i
         LvrzXLQ3JGdVTXy4OqohHlYWF5fVvUZfSep79+CPJYp81cWDLt87sySRp/W/F8g3F1yA
         II5fuU6ZfiCrXJ1UvV9Nq2BTNO3sW4ybWxqObbBISjTBStOZORsjvemlrvH+Vcd9JQd4
         rQnu6OQu5Y/88m8aA0MVrS/XBLl+UQGwDEDsSG7ITsADysKbeQdYPQ7yundw+luWW212
         ETPQG2KfDD8VeWgUhheXsalOB0qNcOj6emIYHv17lwqH8TFrvYGU2umW+Vw9p69VMF2r
         A9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9D0fUffVRw+pNJwNZkQqb+pZrNOvXXWqkK0qE9KtaDI=;
        b=rLyyzNUQW5vCkS9N3YfMHIVJ48aPqsqKvCGBdoXlLHhlgNl7I3BMZblqzCSlx7sSN8
         8FM19NZVA+7TRKdvq39hwN4J7MIonrAmeqW6n3y+AnE5+lvfTJ/Q92e0K7jfqVFNJQmO
         8+1HzOCOrQHzNzJFy3lMyFpis5fysHCWmsMDvz59e6unC/ELrWjXuzXRGKHnPx0NGCxo
         Ay7Chcciq9xPxZDreQXXfFxBm9TzmBke0GSdhTkRpQgBAVUTmrE2kgI2oUrvI7+9wxWG
         QlAf04YwYhMrpc7RALuquviBV5b1tFdih64R5DzI0IGJjSTppRtE+85apcqv8POW92YN
         nFTw==
X-Gm-Message-State: AOAM530aSYkNur8UDi0Tiwe+WyShO6qJK8rVQn4N8NKBt//WXVOwMiy4
        0i+qQWG+2vmNZHpJvqiw0oM65Iu+
X-Google-Smtp-Source: ABdhPJzk55t3bZOdbPKAh7gsGMO0G3W3umCxEPEqBjMNmtah3lGKNNjmIVJ5JrCn+g4A0BPZsPr+TA==
X-Received: by 2002:ac8:3267:: with SMTP id y36mr6058912qta.241.1591831890746;
        Wed, 10 Jun 2020 16:31:30 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id u205sm953315qka.81.2020.06.10.16.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 16:31:30 -0700 (PDT)
Date:   Wed, 10 Jun 2020 19:31:27 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: CFT: imaps://public-inbox.org/INBOX.comp.version-control.git.7
Message-ID: <20200610233127.GA51956@generichostname>
References: <20200610184147.GA1887@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610184147.GA1887@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, Jun 10, 2020 at 06:41:47PM +0000, Eric Wong wrote:
> Hey all, I've been busy with public-inbox work this year.
> I started working on a read-only IMAP/IMAPS server, and I expect
> kernel.org to eventually host a v2 copy, too; and hopefully
> other folks get interested in mirroring.
> 
> For now, you can access git@vger archives through 8 IMAP
> mailboxes sliced into ~50K messages to not overload clients.
> They go from 0..7, with 7 being the most recent:
> 
> imaps://public-inbox.org/INBOX.comp.version-control.git.0
> imaps://public-inbox.org/INBOX.comp.version-control.git.1
> imaps://public-inbox.org/INBOX.comp.version-control.git.2
> imaps://public-inbox.org/INBOX.comp.version-control.git.3
> imaps://public-inbox.org/INBOX.comp.version-control.git.4
> imaps://public-inbox.org/INBOX.comp.version-control.git.5
> imaps://public-inbox.org/INBOX.comp.version-control.git.6
> imaps://public-inbox.org/INBOX.comp.version-control.git.7
> 
> When more messages show up,
> imaps://public-inbox.org/INBOX.comp.version-control.git.8
> should exist.
> 
> I've tested with mutt, offlineimap and mbsync (isync).
> 
> It's not yet complete (when is software ever?), but it's a
> usable start, I think.  Some more info about it over on
> meta@public-inbox.org:
> https://public-inbox.org/meta/20200609113442.GA16856@dcvr/
> https://public-inbox.org/meta/20200610070519.18252-1-e@yhbt.net/
> And maybe JMAP is coming, too...

Exciting news! Since I'm not actually subscribed to the mailing list,
public-inbox has been integral in my workflow by letting me reply to
messages that I'm not CC'd on. The IMAP gateway is a great development.

I fetched your message via IMAP just now ;)

-Denton
