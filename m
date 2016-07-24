Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3785203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 13:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbcGXNqH (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 09:46:07 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34544 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbcGXNqG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 09:46:06 -0400
Received: by mail-lf0-f65.google.com with SMTP id l69so9878919lfg.1
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 06:46:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=JVKiam9d26bBv5G5OCDmwM4TIytddKfBfiv/LO7x6Hg=;
        b=Fb77C5fxas2frbdCy01NT/hVN2bASbs0DDn1JD/tXTFQMQQJyxJF7VcgzFTNNDRMyi
         SLldnpPadj+mrim84TcqF7f2MOZnY8LhAnYQZj4LeQDYnWh2ebt/9vf9jMJ6uJ2PhoEY
         BZDu5f4IosGF69GBlpPlrbYuShyW2EDhGqTZBvQT0xXC6dYTDsnFk8epWlmYUYCaahv+
         g2wYteRBb0NsIG5IXEQg7d5qth2O0c5pfYAO2iF78ofB0ogJrqnXcnj/+LB2MZTpfvn1
         XS2wpOWrjf6+bbr0HezVrfhaieLg9fqUW0l6sZ3ez7wBEzdwr7mbyfUx6RTwisICqYpa
         jxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=JVKiam9d26bBv5G5OCDmwM4TIytddKfBfiv/LO7x6Hg=;
        b=MHSKsr48iq0i9t5H59vf91JXDhao49tqoxv3i/52KqB42euDVDAJGYpTgHdQREtTTb
         2+pmMMEEjLOp8yM39oCp5K1Z6kkvcUgVZ9sNFgduMOKC1sPBkPdKzFNPEMvooOLc+iA5
         c82hlQi3moBRtwwxx6C2mshHvx1d2aegZdGBV0Mkhm0ZT6xtsaFhsc5VCtCoueL7/tyr
         KcRmgUjjSqlFXk1XlEuPrGfY/mvgJxbr1dzKAIbhhTw17CfAdJVfGVR3LWNjg2j53nQ2
         1Kt+wECg1y1gG+YetH3FbBE2w2AiTMLU9OmTIJSLMqP//waA7V9AOlzeFxpL9B1skUj2
         OyJA==
X-Gm-Message-State: AEkooutdh3+QR4OceWDAi95Ni02G8zRg8+gDC9qTGdITVAX68W5UfiPK8qLqBk9yHljgvQ==
X-Received: by 10.25.208.131 with SMTP id h125mr5356273lfg.214.1469367963300;
        Sun, 24 Jul 2016 06:46:03 -0700 (PDT)
Received: from photon.localnet ([213.24.125.224])
        by smtp.googlemail.com with ESMTPSA id i80sm4716584lfg.6.2016.07.24.06.46.02
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jul 2016 06:46:02 -0700 (PDT)
From:	Ilya Tumaykin <itumaykin@gmail.com>
To:	git@vger.kernel.org
Subject: Bug: "git log --format='format:%+s%+b'" doesn't insert newline before body
Date:	Sun, 24 Jul 2016 16:46:01 +0300
Message-ID: <8915446.47C9zkNvuX@photon>
User-Agent: KMail/4.14.10 (Linux/4.6.4-ACER-1830T; KDE/4.14.22; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello.

Steps to reproduce:
$ git init
$ >123
$ git add 123
$ git commit -v -m 'This is subject' -m 'And this is body'
$ git --no-pager log -1 --format='format:%+s%+b'

Actual results:
```

This is subject
And this is body
```

Expected results:
```

This is subject

And this is body
```

$ git --version
git version 2.9.2

Please fix.

-- 
Best regards.
Ilya Tumaykin.
