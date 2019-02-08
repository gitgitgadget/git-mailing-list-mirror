Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 080D41F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfBHJHH (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:07:07 -0500
Received: from adoakley.name ([88.198.105.104]:55654 "EHLO adoakley.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbfBHJHH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QVJ/ewpb2q/qnbvsO+pU0PX9D/kxVizmkHtD5QCJa68=; b=Dg4KRO2pMMLB7O739v0KdKo5nh
        /a8pTbfoJ3eOVo1X8QgVuy4zMJ+4W5lXajMzTWgnvJTtsDKb2rJ3HuKL12TnnP6RO4J8dZCtZKTmj
        wb1Bspmx//Z/wKzVvE34S0TpXilIyZBWC2Dhe61DqIrBgl6iVU5eGjzSmfS6UUx0TiPw=;
Received: from ado-amd-gentoo.home.adoakley.name ([2001:8b0:14bb:e93b:b0a2:3603:6426:932f])
        by adoakley.name with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <andrew@adoakley.name>)
        id 1gs27l-0001uE-8x; Fri, 08 Feb 2019 09:07:05 +0000
Date:   Fri, 8 Feb 2019 09:07:04 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] git-p4: recover from inconsistent perforce history
Message-ID: <20190208090704.68154885@ado-amd-gentoo.home.adoakley.name>
In-Reply-To: <20190207080420.395c521be017dafb6561784b@diamand.org>
References: <20190206194219.15507-1-andrew@adoakley.name>
        <20190207080420.395c521be017dafb6561784b@diamand.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 7 Feb 2019 08:04:20 +0000
Luke Diamand <luke@diamand.org> wrote:

> On Wed,  6 Feb 2019 19:42:19 +0000
> andrew@adoakley.name wrote:
> 
> > From: Andrew Oakley <andrew@adoakley.name>
> > 
> > Perforce allows you commit files and directories with the same
> > name, so you could have files //depot/foo and //depot/foo/bar both
> > checked in.  A p4 sync of a repository in this state fails.
> > Deleting one of the files recovers the repository.
> > 
> > When this happens we want git-p4 to recover in the same way as
> > perforce.  
> 
> I'm finding the test fails for me on a clean git repo, although I
> can't see any obvious reason why.

This introduced a failure when client specs are being used.  I wasn't
populating the cache (update_client_spec_path_cache) before checking if
a file should be included (inClientSpec).  I can rearrange the code to
fix this.

Thanks

-- 
Andrew Oakley
