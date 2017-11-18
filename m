Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4393320437
	for <e@80x24.org>; Sat, 18 Nov 2017 22:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162457AbdKRWZJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 17:25:09 -0500
Received: from nuclearsunshine.com ([81.187.79.3]:44756 "EHLO
        nuclearsunshine.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161543AbdKRWZI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 17:25:08 -0500
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Nov 2017 17:25:08 EST
Received: from desktop.internal.chaoschild.com (desktop.internal.chaoschild.com [192.168.1.2])
        by chaoschild.com (Postfix) with ESMTPSA id 292D02A0076
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 22:16:41 +0000 (GMT)
Message-ID: <1511043401.28381.11.camel@nuclearsunshine.com>
Subject: git archive --remote should generate tar.gz format indicated by -o
 filename
From:   git-scm@nuclearsunshine.com
To:     git@vger.kernel.org
Date:   Sat, 18 Nov 2017 22:16:41 +0000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.2 (3.26.2-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git archive -o name.tar.gz generates a gzipped file without needing an
explicit --format switch.

However, git archive -o name.tar.gz --remote [url] generates a tar
file, which is unexpected, bandwidth-heavier, and additionally in some
cases it's not immediately obvious that this has happened.

git archive -o name.tar.gz --remote [url] --format tar.gz generates a
gzipped file, so there's obviously no limitation with e.g. git-upload-
archive.

Given the above, either git archive or git-upload-archive should apply
the same tar.gz filename heuristic and generate the expected format.

Presumably e.g. tar.xz support when using --remote would be more
problematic since, in the local case, it involves specifying an
arbitrary command.
