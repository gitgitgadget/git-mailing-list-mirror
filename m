Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E94B91F461
	for <e@80x24.org>; Wed, 28 Aug 2019 23:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfH1XZT (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 19:25:19 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:48546 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbfH1XZT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 19:25:19 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1i37JT-0004Nf-Ha
        for git@vger.kernel.org; Thu, 29 Aug 2019 08:25:15 +0900
Date:   Thu, 29 Aug 2019 08:25:15 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: error: cannot cherry-pick during a revert
Message-ID: <20190828232515.bvghqlwe3i7sie7n@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This just happened to me while cherry-pick'ing:

$ git cherry-pick HEAD@{1}
error: could not apply 614fe5e629b84... try
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'
Recorded preimage for 'taskcluster/ci/build/linux.yml'

(... this is where I fix my conflict ...)

$ git add -u
$ git cherry-pick --continue 
error: cannot cherry-pick during a revert.
fatal: cherry-pick failed

So apparently, cherry-pick thinks it was doing a revert when it hit a
conflict?

(This is with git 2.23)

Mike
