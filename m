Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B02741FCA9
	for <e@80x24.org>; Sat, 17 Sep 2016 12:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756383AbcIQMwG (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Sep 2016 08:52:06 -0400
Received: from [195.159.176.226] ([195.159.176.226]:38496 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1755022AbcIQMwG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2016 08:52:06 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1blF68-00087b-0B
        for git@vger.kernel.org; Sat, 17 Sep 2016 14:52:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: Two bugs in --pretty with %C(auto)
Date:   Sat, 17 Sep 2016 12:51:50 +0000 (UTC)
Message-ID: <nrje96$q7s$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.3.4-20160628 ("Newton") (UNIX) (FreeBSD/10.2-STABLE (i386))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All!

First bug:

	git log -3 --pretty='%C(cyan)%C(auto)%h%C(auto)%d %s'

prints %h with the default color (normal yellow), but

	git log -3 --pretty='%C(bold cyan)%C(auto)%h%C(auto)%d %s'

shows %h with bold yellow, as if only the color was reset, but not
the attributes (blink, ul, reverse also work this way). %d and %s are
printed with the right color both times.

Second bug, maybe related to the first one:

	git log -3 --pretty='%C(bold cyan)%h%C(auto)%d %s %an %h %h %s'

The first line looks as expected. Well, almost: the '(' of %d is bold
yellow.

The second line looks like this:

* %h, %s, %an with bold cyan;
* %h with bold yellow;
* %h with normal yellow and %s with normal white (default colors).

PS git version 2.9.2

-- 
Mit freundlichen Grüßen,
Anatoly Borodin

