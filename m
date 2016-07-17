Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47BC61FEAA
	for <e@80x24.org>; Sun, 17 Jul 2016 04:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbcGQEmL (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 00:42:11 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35262 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbcGQEmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 00:42:09 -0400
Received: by mail-pf0-f180.google.com with SMTP id c2so53491380pfa.2
        for <git@vger.kernel.org>; Sat, 16 Jul 2016 21:42:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=ugg66r/nOpRl7TYSBgQMnVVDe5JXJd25w7pjxqxI1HE=;
        b=G3ZqLyfuujt29PcT9zl0x28MUqAL5CbrRA/RODOJjiqSq/WgPZOc+5OWxQxTPyx13k
         tewstR5Kyai7C/ynIEtwv5ELP9gmonALxHMlRReZzySEqab72j4wQJy9UIgQo7NcoZuQ
         pCtMuaCmkVa98jxJHVfy/1T0gkEsju3tQFNYAKm3612vWWVU+sDshITFvsnkQGcZkT5a
         MoNQ1tt7iJJCklDAzp5yLMaH9GmQXuiSAxbcIcqlOiGDF49QY7e/KR2hJTz6elxCiCIF
         LGUqdBcpTFMTw43Zw/mhQzQp7ijW0/Tx+WGWTJkvlndg9opkKu4MWr23dgLGMKL8iCcx
         Tk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=ugg66r/nOpRl7TYSBgQMnVVDe5JXJd25w7pjxqxI1HE=;
        b=btbGx1ZmCp2a3Mjy9Xlc3Io2aejVoGmqkn8phuNzuTQ9uqIyPc7S3n5akZJIvjA5AB
         EUmI2UFMoGJUfFkPWRQwJu5frRessZRDGmzVq+ew4xzsrzg3Nq/ziFKLp2JCT36o0QOM
         lXefwtN0Nu7f2vwK2mUmebUOcxA9LmiPuAl6QDmuWPc2vUsy0ptia9GtBBt1gMSEaKcC
         f0KL6W4NjF4L2pOa299fUaiYdDZxZ4xcDC9xBG49RRPBiz6CVk7pXaJ26IjCwYk3+oq+
         w0zz3cRtIZQF4pZ0a+eRCQr+4P5M4/n8BWsGhFJ+hd4RxE4LkASYpw2Prmwvljvzx3NL
         8zUw==
X-Gm-Message-State: ALyK8tJ1tYbTzf2jCcfP84EyQRcNXWHzLvqQhtypr2OvBDGp3ydFue5DwgOvd6ksezuzXg==
X-Received: by 10.98.200.29 with SMTP id z29mr35024731pff.143.1468730528681;
        Sat, 16 Jul 2016 21:42:08 -0700 (PDT)
Received: from [192.168.1.139] ([114.23.225.154])
        by smtp.googlemail.com with ESMTPSA id d3sm2272222pfk.37.2016.07.16.21.42.06
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jul 2016 21:42:08 -0700 (PDT)
To:	git@vger.kernel.org
From:	mappu <mappu04@gmail.com>
Subject: proposal: allow git clone for http-hosted bundles
Message-ID: <2841ce89-9c46-c3f2-53d8-afef6e1e5b01@gmail.com>
Date:	Sun, 17 Jul 2016 16:41:54 +1200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi list,

Right now it's possible to git clone a repository over http, and git 
clone a bundle from the local filesystem, but it's not possible to git 
clone a bundle hosted on http.

Would it be possible to allow this in the future? Hopefully it's only a 
minor refactor in `builtin/clone.c`.

Regards

mappu


(Back story: I'm stuck with a git frontend that only ever calls `git 
clone ${target}` - that's Golang's `go get` - but bundles are a bit 
better fit for my request patterns than raw repositories).

