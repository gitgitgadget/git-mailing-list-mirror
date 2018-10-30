Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C02611F453
	for <e@80x24.org>; Tue, 30 Oct 2018 02:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbeJ3LlE (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 07:41:04 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:2503 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeJ3LlE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 07:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1540867770; x=1572403770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JGxnp1qHjLLqTR15jnIPYDqoQ61b/PpT5QGTVRgNnAM=;
  b=hoXtEUVk//sG3XT4fkMGJb2bIjsKsgN1QAL09Ld9aZyNs462tpWoBhb4
   CfItoyyMV/jzxezxc716zdP9YbZ/tLpxLSnNal827jLjKeXbcrRCIMcWZ
   QK2DfR7PA1APFmNTaZTxPTKWFsH+ad1yQ815cvwz/qMpTBMy+RY3gYIgc
   4=;
X-IronPort-AV: E=Sophos;i="5.54,442,1534809600"; 
   d="scan'208";a="639171565"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Oct 2018 02:49:27 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9U2nOvg117484
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 30 Oct 2018 02:49:26 GMT
Received: from EX13D11UEE001.ant.amazon.com (10.43.62.132) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Oct 2018 02:49:26 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D11UEE001.ant.amazon.com (10.43.62.132) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Oct 2018 02:49:26 +0000
Received: from amazon.com (10.200.179.64) by mail-relay.amazon.com
 (10.43.62.226) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 30 Oct 2018 02:49:26 +0000
Date:   Tue, 30 Oct 2018 02:49:26 +0000
From:   Geert Jansen <gerardu@amazon.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
CC:     <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Petr Baudis" <pasky@ucw.cz>
Subject: Re: [PATCH 0/4] index-pack: optionally turn off SHA-1 collision
 checking
Message-ID: <20181030024925.GC8325@amazon.com>
References: <87lg6jljmf.fsf@evledraar.gmail.com>
 <20181028225023.26427-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181028225023.26427-1-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 28, 2018 at 10:50:19PM +0000, Ævar Arnfjörð Bjarmason wrote:

> I left the door open for that in the new config option 4/4 implements,
> but I suspect for Geert's purposes this is something he'd prefer to
> turn off in git on clone entirely, i.e. because it may be running on
> some random Amazon's customer's EFS instance, and they won't know
> about this new core.checkCollisions option.
> 
> But maybe I'm wrong about that and Geert is happy to just turn on
> core.checkCollisions=false and use this series instead.

I think that the best user experience would probably be if git were fast by
default without having to give up on (future) security by removing the sha1
collision check.  Maybe core.checkCollisons could default to "on" only when
there's no loose objects in the repository? That would give a fast experience
for many common cases (git clone, git init && git fetch) while still doing the
collision check when relevant.

My patch used the --cloning flag as an approximation of "no loose objects".
Maybe a better option would be to check for the non-existence of the [00-ff]
directories under .git/objects.
