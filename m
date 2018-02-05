Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C571F404
	for <e@80x24.org>; Mon,  5 Feb 2018 19:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeBETeT (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 14:34:19 -0500
Received: from forward102p.mail.yandex.net ([77.88.28.102]:56386 "EHLO
        forward102p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750784AbeBETeS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Feb 2018 14:34:18 -0500
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Feb 2018 14:34:17 EST
Received: from mxback10j.mail.yandex.net (mxback10j.mail.yandex.net [IPv6:2a02:6b8:0:1619::113])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id E857A43045E9
        for <git@vger.kernel.org>; Mon,  5 Feb 2018 22:26:58 +0300 (MSK)
Received: from smtp4j.mail.yandex.net (smtp4j.mail.yandex.net [2a02:6b8:0:1619::15:6])
        by mxback10j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id aWLVxGzUKD-Qw00540h;
        Mon, 05 Feb 2018 22:26:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1517858818;
        bh=p7WmjxdiXTZL4vDT3XgdChkLfNX+PQG2VVsluFLTSHA=;
        h=To:From:Subject:Message-ID:Date;
        b=nUz7ev/97X62Rp9erKoEUyegmqTxAjTDCl2ECQONWm7o7d8ow81PX2MVvd803UjDI
         A1YczVN33pJ1QH+m+RB0pt4JrgTHiumVJyEHf5Rtnotn7xumSQW0Frz0y3N6hKwX2C
         jAtKnNd6zZbA44PMCLXKEv+UIg9yuzaf7Hx7WxY4=
Received: by smtp4j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id S3EWaV1i05-QwKq2AMK;
        Mon, 05 Feb 2018 22:26:58 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1517858818;
        bh=p7WmjxdiXTZL4vDT3XgdChkLfNX+PQG2VVsluFLTSHA=;
        h=To:From:Subject:Message-ID:Date;
        b=nUz7ev/97X62Rp9erKoEUyegmqTxAjTDCl2ECQONWm7o7d8ow81PX2MVvd803UjDI
         A1YczVN33pJ1QH+m+RB0pt4JrgTHiumVJyEHf5Rtnotn7xumSQW0Frz0y3N6hKwX2C
         jAtKnNd6zZbA44PMCLXKEv+UIg9yuzaf7Hx7WxY4=
Authentication-Results: smtp4j.mail.yandex.net; dkim=pass header.i=@yandex.ru
To:     git@vger.kernel.org
From:   Bulat Musin <mbulatka@yandex.ru>
Subject: [bug report]: error doing_rebase
Message-ID: <d4246fa9-5ca2-33c9-d7b6-07adfd9b55a6@yandex.ru>
Date:   Mon, 5 Feb 2018 22:26:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

To reproduce:

git init testrepo

cd testrepo

echo 1 >> file

git add file

git commit -m'1'

echo 2 >> file

git add file

git commit -m'2'

echo 3 >> file

git add file

git commit -m'3'

Now there are 3 sequential commits, I want to squash them into 1:

git rebase -i HEAD~2

In editor I changed all "pick" to "squash", saved file, I got:

error: cannot 'squash' without a previous commit
You can fix this with 'git rebase --edit-todo' and then run 'git rebase 
--continue'.
Or you can abort the rebase with 'git rebase --abort'.

However, 2.14.1 from Ubuntu's repo does the job - squashes 3 commits into 1.

Thanks.




git version 2.16.1.72.g5be1f00a9

