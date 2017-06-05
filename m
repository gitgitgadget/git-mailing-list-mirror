Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C467320D11
	for <e@80x24.org>; Mon,  5 Jun 2017 10:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbdFEKdp (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 06:33:45 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38874 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdFEKdn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 06:33:43 -0400
Received: by mail-wm0-f47.google.com with SMTP id n195so72153371wmg.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 03:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=ZsfCz7s6DFnYAF0R6vt6SD9ESGRkD6jmVtFT1ViTQUo=;
        b=myezbJaJxI+/iEfXaeFqzvRUPHYWtt4uB+bBNBAqmhD62swQZkau2VJ8UOv+qwtsu7
         CxXQdtGTMzMTK7DMyMQ9l2Dw/dGPQ2LUBZaLMrfbSPJ0+KawBmipdayVem0HYvRpK/TK
         ydusZv+ctpTqGRUE7D9mfu7pL4DPmqklVvtx8o+bcsKBAw+koVzmm6SdgWcwnap3C/JV
         +wFILwwf59rBH6f8w0QNsm7Jy0ukiZWFhI/3ucz3xwtsrkRS9ZAH3Er10WGVJ1LOMRJF
         lxi4oAbezHqRTilPqThhE7HjLT5cgdlTPzOU7YdG/mA9zq2Z+IKXNwOoFzjsePy08WAI
         rZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=ZsfCz7s6DFnYAF0R6vt6SD9ESGRkD6jmVtFT1ViTQUo=;
        b=Y2NcoL6hz7vSVr7VHgFzJA3UJQGZBpYqb3TEQ2ur/529mocfk8h8PVkTk1xFlFuwQG
         9Qd8cDQQg2nZz5hCDq4GwGfkdy009sto5BUW8/8v8FxyPHBN/tlZE1Kjr+E4jAHLBL23
         IQUkFX1/qwMlJ1ZE1bI/u7J7+3PrcTJBSmdo1woI+gNKxi0R7PGtJnRRkhFXw/uxfssz
         +tEIdDwe2GmZ2taQ7EzI8+aa5KmsvjSpgu+SGnf7HnvWF+Q7mXzw3CfKL0Pj0j9Bj+Bu
         2Xb6Gyx0SiGGQIucwnLd8je+a+UNBXHlG7Nqr5FmY7gIIhms3+AF7ZJhK/8b1FCuEUsq
         wnpA==
X-Gm-Message-State: AODbwcCyjOF5JVvrDnW3AvYFoVEkv4YhpCG3a1lUsxCOoNMEueOevskg
        2cM7cIEg4mvmGtKvYik=
X-Received: by 10.28.131.213 with SMTP id f204mr7132680wmd.26.1496658822305;
        Mon, 05 Jun 2017 03:33:42 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB44EB.dip0.t-ipconnect.de. [93.219.68.235])
        by smtp.gmail.com with ESMTPSA id e19sm10425968wma.25.2017.06.05.03.33.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 03:33:41 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: t5313-pack-bounds-checks.sh flaky?
Date:   Mon, 5 Jun 2017 12:33:44 +0200
Message-Id: <9A7C995F-ED4F-4AEB-B2B7-00FF05B80E84@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
To:     Jeff King <peff@peff.net>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

t5313.7 failed recently on master [1]. Are you aware of any flaky parts
in this test?

Here is the output:

expecting success:=20
	# We need two objects here, so we can plausibly require
	# an extended table (if the first object were larger than 2^31).
	do_pack "$object $(git rev-parse HEAD)" --index-version=3D2 &&

	# We have to make extra room for the table, so we cannot
	# just munge in place as usual.
	{
		dd if=3D$idx bs=3D1 count=3D$(($(ofs_table 2) + 4)) &&
		printf "\200\0\0\0" &&
		printf "\377\0\0\0\0\0\0\0" &&
		dd if=3D$idx bs=3D1 skip=3D$(extended_table 2)
	} >tmp &&
	mv tmp "$idx" &&
	clear_base &&
	test_must_fail git cat-file blob $object &&
	test_must_fail git index-pack --verify $pack

1084+0 records in
1084+0 records out
1084 bytes (1.1 kB) copied, 0.00119315 s, 909 kB/s
40+0 records in
40+0 records out
40 bytes (40 B) copied, 6.9825e-05 s, 573 kB/s
74
test_must_fail: command succeeded: git cat-file blob =
fff0a2476aa5c8e60a3ef21cfc66e0cc670920be


Cheers,
Lars


[1] https://travis-ci.org/git/git/jobs/239451919=
