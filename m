Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E95A1F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 02:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbdAZC6O (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 21:58:14 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34697 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbdAZC6N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 21:58:13 -0500
Received: by mail-pg0-f66.google.com with SMTP id 3so3510981pgj.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 18:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PbMjzxzQpIaEIta+Kwh9OcnJ78Erg/NYva7qIV/rS7A=;
        b=MGFQs1Jp3Y9eETTM6f5d5ks8ldTLChnhEXE+3QaQbo188fUIaaJL0pyJYqIpLjT6aj
         mueXeSAekeXexn6EhnsbKY/ngpptnwfSC34ndWlcW9w22Eja9n8oKCF9q5YCXhu6Nwhy
         yse75zZIiCxD9mmFJNltlN1tM3/K/+b/T16fdiUMDdtdcHVvkutRLG0OR5DOyHvr+hsk
         T5dKjGBHyrqhG64f3gLuhmITMnEt27m4P75pI8xtSS/uZqXayGVqjg2ho4KrXF3EpM4v
         JfJThgwnNinuI+1BAS4ZOmwySdIYd3HM/dDa0OpeB5ZT9yCU0OnJ6qMOndKIID7D2Pjs
         wu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PbMjzxzQpIaEIta+Kwh9OcnJ78Erg/NYva7qIV/rS7A=;
        b=Blf3u+Hx92OyXAN2flzlTS6uJa5PbKAoeVW0J+9IrLB4L5YIBvvSSBuOhx0gtWuUNO
         UZJseNTGfaXk6ukxNFK/2/Z9Ad99iyYKF5fZXZcClMOnCq1nxAQuMRGm0Yl+TmXu2iGJ
         ZgSyvLPmHAQSZGpwOwRjnMZWNdOjeRlxKQ17AVGEdOQiJwhzhJuiTygKNvJCHsbEpIxt
         D7SU8v17eovfY4mADuDWQU3EPS7DR7cGQcOEY2IcjkMuUgOdTwruVv/J7Tur87K0HPJ/
         yil5IDGnbQncYNAe7v5r36CjYbbZ1YCSenArOvhfzu2ycJyH27nO3sNmBmzHupefF69Q
         5SBg==
X-Gm-Message-State: AIkVDXKMgqXutg1+sAkfEcLJuaAIC73CUjxHxVR4yJ/J56op+bI7p0R452ShMoOEa3LlWg==
X-Received: by 10.98.14.84 with SMTP id w81mr671549pfi.168.1485399493031;
        Wed, 25 Jan 2017 18:58:13 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id r74sm209000pfb.67.2017.01.25.18.58.12
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jan 2017 18:58:12 -0800 (PST)
Date:   Wed, 25 Jan 2017 18:58:10 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Subject: mergetool and difftool inconsistency?
Message-ID: <20170126025810.GA3020@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I was wondering if there is any reason why 'git difftool' accepts the
'-g|--gui' whereas 'git mergetool' does not have an option to accept
that flag. Please let me know if this is intentional, otherwise I can
write up a patch to add the GUI flag to 'mergetool'.

Thanks!
