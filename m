Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57565C4332E
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 16:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1291D64F26
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 16:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhCOQdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 12:33:38 -0400
Received: from out2.migadu.com ([188.165.223.204]:33637 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233508AbhCOQdT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 12:33:19 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2021 12:33:19 EDT
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1615825630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4B+aDwWBrIFS6PtEltwCUu9LoMg5Ffo35X2RllQ1U0M=;
        b=YHWdr1hS7n1YzOfMnDesykugz14VGiHQaJAs72FdsPKU71GX9pdRPzW3Pb2GsVEirRcGm5
        kJheVGC+RfIE0gIT+0Ag44D3aLT77wNfbW8F3KvQyGTJY7XM90ZK/A0CSTsFBngOqEBM9w
        hDceuieLKI4yo/JmQA4mbpb7eY6Iub+uneoneFrtx91YubUeqld9ZHaiWdE5tMlgyNCmxI
        4Ir5sp2hN1utXQ8AzReuUvAPJeKyd45jIEQR3zPlDq31q8GJH+VEGC3B8MGC6RVikd9CL0
        gP1V9K+WBNy1ER2/kT0ew3Whdi6xHVvb3S0B2vlkP7mSrjvqn3Er8y6DCaymVQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 15 Mar 2021 12:27:08 -0400
Message-Id: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga>
To:     <git@vger.kernel.org>
Subject: Regarding the depreciation of ssh+git/git+ssh protocols
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

c05186cc38ca4605bff1f275619d7d0faeaf2fa5 introduced ssh+git, and
07c7782cc8e1f37c7255dfc69c5d0e3f4d4d728c admitted this was a mistake. I
argue that it was not a mistake.

The main use-case for the git-specific protocol is to disambiguate with
other version control systems which also use SSH (or HTTPS), such as
Mercurial, or simply downloading a tarball over HTTP.

Some things that are affected by this include package manager source
lists and configurations for CI tooling (the latter being my main
interest in this).

A lot of software already recognizes ssh+git or https+git for this
purpose, and in the latter case, rewrites it to https before handing it
off to git.

I would like to see this feature un-disowned, and https+git support
added as well.
