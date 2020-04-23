Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC39DC54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 17:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8962098B
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 17:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgDWRYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:24:13 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:34607 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbgDWRYN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 13:24:13 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 497PL32MJMz5tlQ;
        Thu, 23 Apr 2020 19:24:10 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 017412817;
        Thu, 23 Apr 2020 19:24:09 +0200 (CEST)
Subject: Re: [PATCH v2] ssh: add 'ssh.keyfile' option
To:     "Raymond E. Pasco" <ray@ameretat.dev>
References: <20200423064110.77258-1-ray@ameretat.dev>
 <20200423112110.45405-1-ray@ameretat.dev>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d26f8556-ed9b-5145-735b-d348449bb31d@kdbg.org>
Date:   Thu, 23 Apr 2020 19:24:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423112110.45405-1-ray@ameretat.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.04.20 um 13:21 schrieb Raymond E. Pasco:
> When a specific private key needs to be used with a repository, manually
> specifying it via 'core.sshCommand' is not ideal. This option allows a
> keyfile to be specified in the local configuration. If a keyfile is
> specified, SSH agents are disabled for the command.

You can do this without modifying Git. Say, your key file is
~/.ssh/id_other_ed25519, then do this:

Rename your remote to use an invented host name:

  git remote set-url origin git@other.github.com:other/repo

Then attach the invented name to the real host name and the identity in
your ~/.ssh/config:

  Host other.github.com
    Hostname github.com
    Identity ~/.ssh/id_other_ed25519

-- Hannes
