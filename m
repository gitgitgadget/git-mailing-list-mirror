Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 166861F51C
	for <e@80x24.org>; Thu, 24 May 2018 11:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969105AbeEXLhJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 07:37:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:39902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969063AbeEXLg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 07:36:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 718D1ABEA
        for <git@vger.kernel.org>; Thu, 24 May 2018 11:36:57 +0000 (UTC)
Date:   Thu, 24 May 2018 13:36:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     git@vger.kernel.org
Subject: unexpected "unresolved merge conflict" for a new file
Message-ID: <20180524113657.GD20441@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
`git commit' fails on a newly added file with the following
*
* You have some suspicious patch lines:
*
* In Documentation/core-api/gfp_mask-from-fs-io.rst
* unresolved merge conflict (line 27)
Documentation/core-api/gfp_mask-from-fs-io.rst:27:=======

$ git status --porcelain 
A  Documentation/core-api/gfp_mask-from-fs-io.rst

$ git --version 
git version 2.17.0

from debian.

Btw. the suspicious line is
$ sed -n '27p' Documentation/core-api/gfp_mask-from-fs-io.rst
=======

I believe this is a bug because a new file cannot have a conflict by
definition and also there are no <<<<< in the file so there is no
unresolved conflict there. So I guess the heuristic should be more
clever.

Thanks!
-- 
Michal Hocko
SUSE Labs
