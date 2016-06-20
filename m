Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493BE1F744
	for <e@80x24.org>; Mon, 20 Jun 2016 05:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbcFTFbI (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 01:31:08 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38360 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbcFTFbG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 01:31:06 -0400
Received: by mail-wm0-f48.google.com with SMTP id r201so44843280wme.1
        for <git@vger.kernel.org>; Sun, 19 Jun 2016 22:31:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVLJVLFaX+kxc1Eo3I5xqsQNKBHnrgKqSBoVQJlegZE=;
        b=hpJ0tOOw++YXHHspomQZEXb0iSSZgA+e7tS6Qgzzu43wB1btWlUn4Dgj4Zm4l5CJ7h
         yIKwTStWIPz9eZC2wI+jc61IwdmkN+IYyToSEo+ELXGBWWDvZ/J8e9OvUzYQ4AARNNug
         izB4p3Avc1CBJlLOu/lBACXsOQlnjGkDPUrS4HiZtJCJ/1SRnly6FbfAyZmz7GOiyLL8
         ttVHlAMZCeuSORIhhxtFS7I/cUnh0Z6M8T6y90CQkp2I3/Fhm+CziX1CcPa2RTXhvJWl
         MnFgPDd6ZvUg4BVDZiZdQNs5nG9iHJCNFj6Ng2ELMUsGszS3tNxxCzrHAjSNTAweZvsu
         /P/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVLJVLFaX+kxc1Eo3I5xqsQNKBHnrgKqSBoVQJlegZE=;
        b=doucLYW55+F3cAhDlkLu0uLjZRma7MiMK2nAjxyOfUVQObBT5aa8lCStiOvjCz3Kb4
         UUGf3et/G0kT3/SMwyRtKomSgXiv9jByc4lJ2pzdbFbDYGYgOmixuVSlLBTb2tv8Kins
         se7oJi//GSpXSPpkZqc6JJF522L+DUbuATwB2fbPT0X0A3GLw5NOz1Qz7EaPsRUTu621
         f7n6sX4yc8EoupCIds/MHZlLLrTnYll4fp2aTQ37H5d+6Zbo5hNlkITMW/2yffNC+0fh
         JxzYZ0fFvvZJn5G71Luzk80LHWdmVJb0lLjVi/uM7bff7xpGIIpn3oQ0i6DhNNyCJzkG
         rBbA==
X-Gm-Message-State: ALyK8tIFy8pzQpGVtGFjV5eiyyq8dkcxgLN/PWCaLV43YviMKjPo7zpfwLov4wU1JYn0qw==
X-Received: by 10.28.221.4 with SMTP id u4mr9667680wmg.32.1466400664874;
        Sun, 19 Jun 2016 22:31:04 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id uq7sm61484435wjc.19.2016.06.19.22.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jun 2016 22:31:04 -0700 (PDT)
Message-ID: <1466400663.20305.0.camel@kaarsemaker.net>
Subject: Re: [BUG REPORT] git 2.9.0 clone --recursive fails on cloning a
 submodule
From:	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Vadim Eisenberg <VADIME@il.ibm.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Date:	Mon, 20 Jun 2016 07:31:03 +0200
In-Reply-To: <CAGZ79kZ9NF57EyEZ4PgOhJw50ujt=QmHs+w1ZNFeDO4zitksVQ@mail.gmail.com>
References: <OFC76C15DC.FC882C57-ONC2257FD7.00261552-C2257FD7.002660FC@LocalDomain>
	 <OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com>
	 <20160619100051.GA14584@sigill.intra.peff.net>
	 <xmqq7fdkx5oz.fsf@gitster.mtv.corp.google.com>
	 <20160620001332.GA10101@sigill.intra.peff.net>
	 <CAGZ79kZ9NF57EyEZ4PgOhJw50ujt=QmHs+w1ZNFeDO4zitksVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On zo, 2016-06-19 at 18:09 -0700, Stefan Beller wrote:

> How often do we see a depth != 1 in practice?

Travis clones with --depth=50

D.
