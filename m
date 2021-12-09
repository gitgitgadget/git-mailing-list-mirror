Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAECC433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhLIUCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:02:53 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:42231 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhLIUCw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 15:02:52 -0500
Received: (Authenticated sender: ralf@linux-mips.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B549F100003
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 19:59:16 +0000 (UTC)
Date:   Thu, 9 Dec 2021 20:59:14 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     git@vger.kernel.org
Subject: Issue with git clone via http/https and alternates
Message-ID: <YbJgEnvuKm+GGXkd@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm hosting a number of largish repositories which being very similar
are using git's alternates feature to save disk and memory.  Cloning via
git:// or ssh for users with accounts on the server works as expected but
cloning via http or https results fails as follows:

$ git clone http://git.linux-mips.org/pub/scm/linux-mti.git
Cloning into 'linux-mti'...
warning: alternate disabled by http.followRedirects: http://git.linux-mips.org/pub/scm/ralf/linux.git/
error: Unable to find e4add961d4aaeb19f607f6d7bea8d59e1bd39ff0 under http://git.linux-mips.org/pub/scm/linux-mti.git
Fetching objects: 11, done.
Cannot obtain needed object e4add961d4aaeb19f607f6d7bea8d59e1bd39ff0
while processing commit 9e2bf7cf7d9003c0f06736be5218ed79234f254c.
error: fetch failed.

Adding -c http.followRedirects=true will make the clone succeed. Question,
shouldn't the default of http.followRedirects=initial already suffice?

Anyway, what I'm looking for is something I can do serverside so users
cloning the repository are not bothered with this http.followRedirects
business.  Is there anything I can do?

Thanks,

  Ralf
