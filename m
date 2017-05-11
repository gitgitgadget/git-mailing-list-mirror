Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D455420188
	for <e@80x24.org>; Thu, 11 May 2017 06:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753785AbdEKGLE (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 02:11:04 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35304 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbdEKGLD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 02:11:03 -0400
Received: by mail-pg0-f43.google.com with SMTP id o3so9320236pgn.2
        for <git@vger.kernel.org>; Wed, 10 May 2017 23:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CY8PElSJJCbwwzrFJ8fbVmY9glHzwh2cOgwlaIsvQwI=;
        b=DZL756Y/Kg/ZLDNplJGm6o5Fy5dKPDmrKfrsYRNAAXpRIeWgVDHiMmtyTVGsXNXgAI
         RpxN9aytMv4WoFLQCvGwzXcANgqpltflaQZAeETe8kTMDnXuIdy2lYcWWrHVaz5hCUNQ
         Hw67AZcNswIi6icNOUmJSJ3e1sPFeJW+ZIdFZSLKaMPAbOXVyFH0nnaGXVrsxa3WA6V8
         Wr4ON1wD9V1m83pMc5jj/PDGVo4yS9EPKVHgDWVnuHlABGGhpCmtULIpM/0dDp3pBUDF
         rii+6Gelp5kPPpFMN3UMU/IcdGHggGauzjd0rAnTKS/H0pTpsqD97mIiTxsjyDva/REL
         KW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CY8PElSJJCbwwzrFJ8fbVmY9glHzwh2cOgwlaIsvQwI=;
        b=NPMhL7DWk1yqssxqeLwQ/5V7VWYeMhduVVZgWcHTiVivBwutwFqg0Zk1kW+VKhP1UC
         wZbnNAGkbscV+8bculzXTlv8y8OeNcsI30Wkm0/R9S/dLiSqvaBgDow8is+7+J9CoD64
         r5wHvrhcB5A+nKJIHklTeGEAoL8IEwevEbwT26ZUiZ4zJiCHhpfZR8sz6xz84Am1iKJZ
         EXiorCvzIiTHTEFDJunnk0l8VwUc9vsbrxv6M0n4ZeV3wKWN8WOrobhmzQ+A8IBiWASg
         oDg0ZTYkN858xENI6Hx4xWe3NLnMIfPOSKhgrt+6hgkKLWzpIy/drBK0WytfxqDbcAK1
         U5BA==
X-Gm-Message-State: AODbwcD5iuH6BfeeBAoydhW5VY/jEN11iOAoPDThWc3+4EKlpvDwVNax
        lQhU/70TuaXelnPy4O4vn8HgYBdus7vMduI=
X-Received: by 10.99.250.69 with SMTP id g5mr8488776pgk.11.1494483062746; Wed,
 10 May 2017 23:11:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.141.87 with HTTP; Wed, 10 May 2017 23:11:02 -0700 (PDT)
From:   Nazri Ramliy <ayiehere@gmail.com>
Date:   Thu, 11 May 2017 14:11:02 +0800
Message-ID: <CAEY4ZpMJbS+-xDKcwbOHCWxAdjOVuTN9DFJNHVqHw0r06CwKJg@mail.gmail.com>
Subject: Should "git submodule update" accepts --init?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The command "git submodule update" accepts an "--init" flag to
initialize an uninitialized submodules.

Shouldn't it also accept "--sync" flag in order to sync and unsync'd submodule?

Otherwise it seems like I'll have to do "git submodule update" twice
in order to update an already initialized submodule whose upstream
repo url has been updated in .gitmodules to point to somewhere new,
like so:

$ cd superproject
$ git pull
$ git submodule update --init --recursive
fatal: reference is not a tree: c21784553dcd15e1534773fe3177f39cbb93be65
Unable to checkout 'c21784553dcd15e1534773fe3177f39cbb93be65' in
submodule path 'path/to/submodule'
Failed to recurse into submodule path 'path/to/submodule'
$ git submodule sync
$ git submodule update --init --recursive

If the submodule update subcommand accepts the "--sync" flag then
above can then be simplified to this:

$ cd superproject
$ git pull
$ git submodule update --init --sync --recursive

So the "--init" and "--sync" flags tells git to initialize an
uninitialized submodule, and syncs any out-of-sync submodules.

nazri
