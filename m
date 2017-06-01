Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2170420D12
	for <e@80x24.org>; Thu,  1 Jun 2017 00:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbdFAARt (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 20:17:49 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33340 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFAARs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 20:17:48 -0400
Received: by mail-pf0-f176.google.com with SMTP id e193so21392550pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 17:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zBZU7YArgclBvT5L7aIyu0OCM5hjATgjSTOOX+ANXIQ=;
        b=XjNqoiP4PRNFEbkvb/zg//kIcfNIF4oUFM6M+caLp1iNJPLYUu6YfTFj4mk7HvdOBY
         biHy8FLQ/Hm1kNKQ91QufbQpzBhDJiBzz/pclS05X+A3pUDD+rU5SI/ZxmZPDQVP6OHe
         0MOpS+FJKpm3P0gHKcS1UbLqsZp4bd2Xzx7zKDcilBvs1Kb5J2o5tky3auReRJxYJhZC
         dpK0ScdW4uA4wr8tPu7RxZMODDw4UDP56WXNI5FOwX0QJJLVbnTnAzMIkMF/GLs04VQD
         EgWEANxZ6Sv/6PLMPJEzJs6+HG/83DKrERpoxzmUEThHXUGJHEaAaA0x7wOlakl6ZU/b
         0qOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zBZU7YArgclBvT5L7aIyu0OCM5hjATgjSTOOX+ANXIQ=;
        b=uXBDDMBu//lPvdEtVYvREnHmaaIe0nH7OBA8Z6hq6lQOMA2HzaemFDQaZV9wf6JBeG
         aJfFsMqyfol0ST9Ohs8vTMFEmAPmumJPxByvEcKmzW6AtjsjqOWK/xo4MVJB7kAlHydg
         B7IQNLUakyHZRS7f3rcWOF5qitA7EhQxDviR3VmcqPJRZO/47+PzACSyXNxnzno9pTJ/
         MpuN+CnBuSVES6bUlW+jcF5rnOTVpwPP9G2ZC6S86F/BoiF3zrIwBP27TNIQJcX099tO
         ybxrO7RQi9QqKVhG9Ke0oMxtCWJxbWDbYxbIWv1tPyb1UqdMGn5Oj7mplqhA7zS8kIvj
         VogA==
X-Gm-Message-State: AODbwcCxSlBCGb4Itxl+qAe53b66FK+SGWWpmnvfjW0eVcHJuFCzDuuu
        Hnfa7+MXrIPUFg==
X-Received: by 10.99.2.68 with SMTP id 65mr35244637pgc.61.1496276267440;
        Wed, 31 May 2017 17:17:47 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:6469:e172:b5f4:6d97])
        by smtp.gmail.com with ESMTPSA id b14sm9450121pga.12.2017.05.31.17.17.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 17:17:45 -0700 (PDT)
Date:   Wed, 31 May 2017 17:17:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     git@vger.kernel.org, Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Brandon Williams <bmwill@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] send-email: Net::SMTP::starttls was introduced in v2.34
 (Re: [BUG] git-send-email broken: Can't locate object method "starttls")
Message-ID: <20170601001743.GF81679@aiede.mtv.corp.google.com>
References: <20170531222455.GD72735@gmail.com>
 <20170531224415.GC81679@aiede.mtv.corp.google.com>
 <20170531225708.GE72735@gmail.com>
 <20170531230156.GE81679@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170531230156.GE81679@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject: send-email: Net::SMTP::starttls was introduced in v2.34

We cannot rely on the starttls method being present in Net::SMTP until
c274b798e6881a941d941808c6d89966975cb8c8 (Merge branch 'ipv6_ssl' of
https://github.com/noxxi/perl-libnet into noxxi-ipv6_ssl, 2014-06-02),
which set the module version to 2.34.

This version was first shipped as part of perl in v5.21.5~169 (Update
libnet to CPAN version 3.01, 2014-10-10).

Noticed on an Ubuntu system with perl 5.18.2-2ubuntu1.1, which
provides Net::SMTP version 2.31. The error message is

  Can't locate object method "starttls" via package "Net::SMTP" at /usr/lib/git-core/git-send-email line 1410.

Reported-by: Brandon Williams <bmwill@google.com>
Reported-and-tested-by: Eric Biggers <ebiggers3@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> Thanks.  Mining through https://github.com/gbarr/perl-libnet, I find
[...]
> I think 2.35 is the correct minimum version.

Nah, I'm reading wrong.  The relevant commit is c274b798 (Merge branch
'ipv6_ssl' of https://github.com/noxxi/perl-libnet into
noxxi-ipv6_ssl, 2014-06-02), which bumped VERSION to 2.34.

Here's an updated patch.

Thanks,
Jonathan

 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 0d90439d9..d326238c0 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1354,7 +1354,7 @@ EOF
 		}
 
 		require Net::SMTP;
-		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("1.28");
+		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("2.34");
 		$smtp_domain ||= maildomain();
 
 		if ($smtp_encryption eq 'ssl') {
-- 
2.13.0.506.g27d5fe0cd

