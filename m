Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF562208E3
	for <e@80x24.org>; Wed,  6 Sep 2017 00:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbdIFAyD (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 20:54:03 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:37678 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753115AbdIFAyC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 20:54:02 -0400
Received: by mail-pg0-f44.google.com with SMTP id d8so12361161pgt.4
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 17:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id
         :references:to:date;
        bh=hDcp2hdxOBNQqn98H0G3rQY7I4ckQw1ZKDKT4+bN2kc=;
        b=kJjMWB6/LZ5i2UYpufk9x4hXSTu9Ny9I4p5luedCDYDgeySJy0Mkalk4vm4A6akO39
         ueBtMVIKUp2riCV+9qKyKlo5796i/jsYtmLPENFVc/6e1wgKxQI7w3Mc5zwVjTTdb/Z4
         JcYU1iEPGGU7xCx2+mNIGJaSiSX+DWpABIFT2P9aY6jsTZ9AjKjTX/i3YnqsnoeyAbxh
         w4Rld4HF9lB/83XI+mdUDDvLFJDi8TRQD0ly77enNxABV5h3i7q+XonKQgn/JxvZG6iv
         yX9H38414JjGPHl0sDR+ljnhhkfwfDYM2vTnAextzohAKNhZvo5j1cw44c6KWP9v1yBd
         z8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:references:to:date;
        bh=hDcp2hdxOBNQqn98H0G3rQY7I4ckQw1ZKDKT4+bN2kc=;
        b=hBu8L1Hoza2Zl+lzXGDzr6n6pGC4E6sy6CU0lB7juaziBxHzI8VjjLHYzcpCIqy+Vr
         +xr/krgjvhru0boj1a5u1C0dfe2s1n1I9ru/3cMdt4J9i1HBMcelFhbpNvNcBEX00DJg
         me7QpULGwt7uYww88d+zaKBChnSA+uJgvNOX7r+IdfTKi3mOa2tbPZttn/br7yXlmEx5
         IlK5l+12UmEdfyq8n10JycI1CCM1YYNpR5zDxYTPKM9aXaSB+tJZD76Mb4Eei+7LSBo1
         InmgeBgBr+tyXpZ7PLy7Q4VTRW/9lmRW3fM5F0Y6OkZrVtKVlpxs/Pdp6oK4qirsKtB8
         5YTQ==
X-Gm-Message-State: AHPjjUiRDhUsRQ4oHQWoyyDLvkOI/kdpB+U6zdq5axqm1a0AjhShgc5F
        A/tiAOOrR9P92VXScVhRVA==
X-Google-Smtp-Source: ADKCNb5x6tCrstP8827Hdbb6svSHq2+l41mKiejMyInUUTUOEedQW1UxTFqxj/QIZ5LY01yo5bWnow==
X-Received: by 10.99.117.81 with SMTP id f17mr5730724pgn.181.1504659241675;
        Tue, 05 Sep 2017 17:54:01 -0700 (PDT)
Received: from [192.168.1.244] (c-73-189-131-80.hsd1.ca.comcast.net. [73.189.131.80])
        by smtp.gmail.com with ESMTPSA id t63sm210199pfd.140.2017.09.05.17.54.00
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Sep 2017 17:54:00 -0700 (PDT)
From:   Daniel Biran <dbiran@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: git merge algorithm question
Message-Id: <92605DF3-9274-45A6-88B7-6281D192203F@google.com>
References: <202EE2E2-1D0B-4772-85F7-7C7804905297@google.com>
To:     git@vger.kernel.org
Date:   Tue, 5 Sep 2017 17:53:59 -0700
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>> I'm trying to better understand one of the merge algorithms as I had =
some triumphs and tribulations with using a set of commands during a =
merge. tldr: can a git merge -s recursive -X patience; // result in a =
fast-forward merge? will --no-ff stop it
>>=20
>> So, the scenario is this:
>> 	- Merging a master branch into a feature branch that is 2+ years =
old
>> 	- We found this command was more beneficial when merging a large =
20k line text file:=20
>> 		- git merge -s recursive -X patience master
>> 	- In a recent merge using this approach the reflog shows that =
the merge was performed using a fast-forward from the feature branch's =
head
>> 		- 082517-1, feature/branch) HEAD@{23}: merge =
feature/branch: Fast-forward
>>=20
>>=20
>> My question is, is it possible for that command to use a fast-forward =
like this? (or did something else go horribly wrong? possibly an =
atlassian git GUI tool corrupting the work):
>> 	- If it is possible for the command to fast-forward the merge =
when making the commit does --no-ff force the command to never use =
fast-forward in this case
>>=20
>> Thanks for the help,
>> Daniel
>=20

