Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94F5420248
	for <e@80x24.org>; Thu, 28 Feb 2019 06:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbfB1GDE (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 01:03:04 -0500
Received: from mail.javad.com ([54.86.164.124]:36835 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfB1GDD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 01:03:03 -0500
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Feb 2019 01:03:03 EST
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id D73783F3C1
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 05:54:24 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=T2X2qJQ0;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1551333265;
        bh=MI6rkC9+pb1h+lxIkSmaT+yYlYCvJ8Ki/2rEkeiZzRk=; l=960;
        h=Received:From:To:Subject;
        b=T2X2qJQ0XV75XLQvBSCAY1ccgM9Mc6kGr2TgF/fk0tl3lTfEZkHwaMHqYjYF0jA/P
         aiF2aDdX6hizbmV3T6KhfFdMaxnFeRFiRwdogDmU5JooILklfa9hCqF3Na8F3vVeMM
         Es6uzmDyrbEnvYofrub1L+oBrPzz1eVcosr6S8Ho=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1gzEeF-0005q5-2I
        for git@vger.kernel.org; Thu, 28 Feb 2019 08:54:23 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Subject: Tags from each remote in a separate "name-space"?
Date:   Thu, 28 Feb 2019 08:54:23 +0300
Message-ID: <87d0ncihkg.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

How do I configure git to handle tags from remotes in a manner similar
to branches?

Specifically, I want tag 'tag_name' from remote 'origin' to have local
name 'origin/tag_name', not 'tag_name', as it is by default. For a repo
with a lot of remotes[*] it would allow to keep track of what tag came from
where, as well as prevent name conflicts between tags from different
remotes (and/or local tags).

Fetch-only solution ('fetch', 'pull', and 'remote update' support only)
would do, though push support would be interesting to have as well, so
that, say

$ git push origin/tag_name

works as

$ git push origin origin/tag_name:refs/tags/tag_name

Am I dreaming, or is it already supported?

[*] I ran into it managing Linux kernel sources for different ARM
architectures. Mainstream Linux plus stable Linux plus 2 vendor-specific
remotes plus 3 our local remotes made a mess of various tags in the
repository.

-- Sergey
