Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F04A81FD09
	for <e@80x24.org>; Wed, 31 May 2017 22:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdEaWZB (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 18:25:01 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36737 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbdEaWY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 18:24:58 -0400
Received: by mail-pf0-f171.google.com with SMTP id m17so19298248pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=90u+GLhSrh81K97qKjOAXOh1xMlfa7McjSeQJLmDzOk=;
        b=ieIvX8TfbA1BtBIAhddNnf07xEt6zyEDkUlE/0Ey5MPeI9K+P1av63TCSS+Bjp0Gwm
         DGF7Dyr9dlPmmpaD8Qip2srmRVQVGQa1kPEet8F2jbw2T4RNq+FupdhhlH530SkCDQ4T
         aWF6U50CIxKW7jiXvBSqnLOGBRiN87CQnLuRrLVNRyU1Lc8Au8iSZvejxE/HucY4rPBH
         tvLnO6vNb+kNUURVNEfvxar8LNomXI+kpCSUYa9iceIyY26m3eGj0Kt71wFYgF2A0OcI
         TunS+ex4BmT4IULwDtlTSAd864pFqWtwKIzEFfr3Av+Zj+eAuspM3leqyTA79Scv4WHY
         bU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=90u+GLhSrh81K97qKjOAXOh1xMlfa7McjSeQJLmDzOk=;
        b=tP9fdRiS3fdphLH6yb9S4j77p9N6pkDvrAHm8wHWOTqNTd60axehhg8yRDHJOCtHAZ
         j7lRMNYJoO6kFU91E1hzwevN0r0PWzk48Ndn51biStw0ZvBTHeSqz4X1O6E+nzWWzIQV
         cbWbzHGrgLCPwz3OmoNYIU/UBr8OuI4iBdQInKg/B5L/c36KohNd+Wg206B663/JJm2R
         NojS7FNuEdEsdohhjIvKrS8YSMCz6qqE1JMRrR9kx/G0Q+00W0SLBUWpD9YZ4IlYrXoL
         HWx7PHD68x7YbOn1rhGuutxloXrWs+4UjpUtDwHDjPniMSlo9Pxb089gtf/K+2RMut0G
         jg6A==
X-Gm-Message-State: AODbwcDGif2Ejiezf+LwB7r0s57pVY3DZodx9H+OhV2mreycKxovat/I
        fZ9zJIrMUkLvX22rx0o=
X-Received: by 10.98.43.206 with SMTP id r197mr32439164pfr.202.1496269498028;
        Wed, 31 May 2017 15:24:58 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:7d83:2ad9:ff5e:9a6f])
        by smtp.gmail.com with ESMTPSA id v188sm27157236pgv.51.2017.05.31.15.24.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 15:24:57 -0700 (PDT)
Date:   Wed, 31 May 2017 15:24:55 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [BUG] git-send-email broken: Can't locate object method "starttls"
Message-ID: <20170531222455.GD72735@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

There seems to be a bug in 'git send-email' caused by this commit:

    commit 0ead000c3aca13a10ae51a3c74c866981e0d33b8
    Author: Dennis Kaarsemaker <dennis@kaarsemaker.net>
    Date:   Fri Mar 24 22:37:32 2017 +0100

        send-email: Net::SMTP::SSL is obsolete, use only when necessary

When running git send-email I get the following error:

	Can't locate object method "starttls" via package "Net::SMTP" at /usr/lib/git-core/git-send-email line 1410.

The perl version is 5.18.2, and the Net::SMTP version is 2.31.

I suspect the following line of code which appears to assume that starttls() is
present in Net::SMTP >= 1.28:

	my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("1.28");

... but in fact it appears to have been added by the following commit to perl,
which bumped the Net::SMTP version from 2.34 up to 3.01:

	https://perl5.git.perl.org/perl.git/commit/2e1731446cd265cddae2ea6c43a375168fdb6f56

Eric
