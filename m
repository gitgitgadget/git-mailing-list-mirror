Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C981C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 15:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiLIPIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 10:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiLIPIC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 10:08:02 -0500
X-Greylist: delayed 423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Dec 2022 07:07:59 PST
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1374AF3A
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 07:07:58 -0800 (PST)
From:   Toon Claes <toon@iotcl.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1670598052;
        bh=H2/Gej28kOfnVY832jQ8wIYlXSZS9scotKNYvaMFcuM=;
        h=From:To:Subject:Date:Message-Id:Mime-Version:
         Content-Transfer-Encoding:From:Subject:To:Date:Sender:Content-Type:
         Content-Transfer-Encoding:Content-Disposition:Mime-Version:
         Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=MI02zdsz0MmzH4uSmR1/ERmAbhyaGSjKEu9mUcK8apxNMawqM8tMsossOIywJE7+L
         wy+miADk+7EWu76+sNL1K7XCPFx+vRtd+8yBnKzDLAK745Q98rps5AMG1N1E7lbs/S
         ArlFgqb7gcQz+OOzEB3g+co6rU5eqK8k5ELO4syERQvsKTJmHlxx5CWYWFn5x0CBZC
         0eG9n+ENljIFyWtqum2to+PtDjlaZgxpsovhKSxoY9UNyuOID6TABWHWTsa5vo5uR2
         ZSWfXryL0CGVElHIRc8d35954Sc6G/hdwKQ/DUfKdFQNlhOOjp9TiFTFTBJqVOHtG1
         cMF0WWvoEdy2w==
To:     git@vger.kernel.org
Cc:     Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/1] cat-file: quote-format name in error when using -z
Date:   Fri,  9 Dec 2022 16:00:47 +0100
Message-Id: <20221209150048.2400648-1-toon@iotcl.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

While we at GitLab have been implementing the use of option `-z` for
`git-cat-file` with `--batch` we discovered an extreme edge-case when passing
paths with newlines to the command. In case the object is not found the error
message include the path in the output and thus the error message might get
spread over multiple lines.

The provided patch sanitizes the output, making is easier machine-parse it.

Toon

Toon Claes (1):
  cat-file: quote-format name in error when using -z

 builtin/cat-file.c  | 10 ++++++++++
 t/t1006-cat-file.sh |  8 ++++++++
 2 files changed, 18 insertions(+)


base-commit: 2e71cbbddd64695d43383c25c7a054ac4ff86882
--
2.39.0.rc0.57
