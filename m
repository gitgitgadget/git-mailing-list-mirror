Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D63D1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 13:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfIQNjw (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 09:39:52 -0400
Received: from smtp.soverin.net ([159.69.232.142]:47535 "EHLO smtp.soverin.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbfIQNjw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 09:39:52 -0400
Received: from soverin.net by soverin.net
From:   Zeger-Jan van de Weg <git@zjvandeweg.nl>
To:     git@vger.kernel.org
Cc:     Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: [PATCH 0/1] git-config --add allows values from stdin
Date:   Tue, 17 Sep 2019 15:31:34 +0200
Message-Id: <20190917133135.190145-1-git@zjvandeweg.nl>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.3 at c03mi01
X-Virus-Status: Clean
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When adding or updating configuration values using git-config, the
values could all be observed by different processes as these are passed
as arguments. In some environments all commands executed are also all
logged. When the value contains secrets, this is a side effect that
would be great to avoid. At GitLab we use Rugged/libgit2 to circumvent
this property[1].

The following patch allows a value to be set through stdin when the user
passes a `--stdin` flag.

[1]: https://gitlab.com/gitlab-org/gitaly/blob/8ab5bd595984678838f3f09a96798b149e68a939/ruby/lib/gitlab/git/http_auth.rb#L14-15

Zeger-Jan van de Weg (1):
  Git config allows value setting from stdin

 Documentation/git-config.txt |  5 ++++-
 builtin/config.c             | 23 +++++++++++++++++++++--
 t/t1300-config.sh            | 11 +++++++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

--
2.23.0

