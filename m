Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91C5D2070D
	for <e@80x24.org>; Fri,  8 Jul 2016 19:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427AbcGHTZS (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 15:25:18 -0400
Received: from imap.thunk.org ([74.207.234.97]:34624 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbcGHTZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 15:25:16 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=SjOtuv6SDowefSZI6bENZigSPbLhGdqp5hsqZRFJe/Q=;
	b=Ow8ClgPTIxeG50ZosyKZxIi6Amdq/4O4+xX5aE0AwXhjFmU73NTLMSkRWmkn02izUH9ctR56wDK0wbNgTWATiu8sE791tAK1IPZ/1dvF106PRwGPArHkVwvKYep8OuCg2ySmlN7uUydjtcHQxE2u2aWATgk9Ch7nxWR6xME2AVs=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84_2)
	(envelope-from <tytso@thunk.org>)
	id 1bLbOb-0006h1-P7; Fri, 08 Jul 2016 19:25:05 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id E8CB182F7F6; Fri,  8 Jul 2016 15:25:04 -0400 (EDT)
Date:	Fri, 8 Jul 2016 15:25:04 -0400
From:	Theodore Ts'o <tytso@mit.edu>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
Message-ID: <20160708192504.GL19871@thunk.org>
References: <20160708025948.GA3226@x>
 <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com>
 <20160708064448.GA18043@x>
 <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 08, 2016 at 10:14:33AM -0700, Junio C Hamano wrote:
> 
> It cannot be "anything directly under .git that has all-caps name
> that ends with _HEAD".  The ones we write we know are going to be
> removed at some point in time (e.g. "git reset", "git bisect reset",
> "git merge --abort", etc.).  We do not have any control on random
> ones that the users and third-party tools leave behind, holding onto
> irrelevant objects forever.

What about anything that is all-caps and ends in _HEAD which has a
mod-time within the last N days?  (Where N is 2-7 days.)  If it's
older than that, it's almost certainly stale...

						- Ted
