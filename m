Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E6F20248
	for <e@80x24.org>; Sat, 30 Mar 2019 14:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbfC3O2J (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 10:28:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35184 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbfC3O2J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 10:28:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so2400305pfe.2
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Csi5sqWrLVj4u3nXKne1LVlxHnXYvaydXevcEbn+3A=;
        b=vFwacNrWxDDhp8JR3zNTua3MIqKklfM80E5tkw28en2D3qOiEm6vBkhLEtmcg+CVJl
         b8wjtjZNO1l9evBf9jWgGC7SF+dogPM9D4xYVQ9+xezTRIdmczK6+3baTceCv2LwHDY1
         crEamzu7khbxYjQkyX29CYh9elM+tB7PD7Ci91s/R6fB9C794hCdz3mQZ+4WblW+QymW
         ioNevhkna1mgTmCOU4v7kevLOkbL9j5qSLOJd3bmRM4BknHzeGkti1D55nS4z0dJ/oa4
         BxzzjTvybiSwToXj/dbRycRMkQ326Znks226NSgJUpkU3TMHRfDs6x2KFLMXet12BE/K
         ybYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Csi5sqWrLVj4u3nXKne1LVlxHnXYvaydXevcEbn+3A=;
        b=umv5GMfhkuuVnpbnIjk6c9zJ2i8Hov8eBFzdSjfT/h0fyW2L88qD8ygDX6nvqWq9az
         Bdp2QA2QJGqYmM58njk6wyRWAl0FS6AMxM1Z4xWshBuhdU2/HVmETo2lT5tSIlNQscwL
         QvYNV7TTKvJE+gxe5n0/DlMPiaqKKKvjQEi7JCwKC5dbiOO1KAOcr6x7LLT8/k1jiAeo
         1D+0SfouTsOH0GbsJKdHfLt2hkdCHB+nc3Lee+cEY2USqpzAMb2oJ9QxDRgTG67WyXJ5
         uCwKl8TeU5mheUJKvQPeEkZm7jwzvc7CdgxDXTjuStvGy8Pxaj20j6Bsy3tWLY5r1Q/P
         G88Q==
X-Gm-Message-State: APjAAAXQjrq1QFNnYouVf817v2/XXjnG5Xsl5XP930IElJfi1d2feVr+
        JKD5ZOunih2Yj8IlP2yal5aGTTJpbtA=
X-Google-Smtp-Source: APXvYqztNVob0vhEX4aBYyVYcc6Q/sexHpbDDX3jDu90Ew25BvHznU1puJcRCw1QXLV195meXjqaUw==
X-Received: by 2002:a63:4815:: with SMTP id v21mr51995017pga.412.1553956088449;
        Sat, 30 Mar 2019 07:28:08 -0700 (PDT)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id v12sm6621737pfe.148.2019.03.30.07.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Mar 2019 07:28:07 -0700 (PDT)
From:   Jonathan Chang <ttjtftx@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [GSoC][PATCH v4 0/5] Avoid using pipes
Date:   Sat, 30 Mar 2019 22:27:53 +0800
Message-Id: <cover.1553954776.git.ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I added 2 additional patches that modernize style, based on discussion
in [1].
Also added description in commit message as suggested in [2].


[v1]: https://public-inbox.org/git/20190309154555.33407-1-ttjtftx@gmail.com/
[v2]: https://public-inbox.org/git/20190310080739.63984-1-ttjtftx@gmail.com/
[v3]: https://public-inbox.org/git/cover.1552835153.git.ttjtftx@gmail.com/

[1]: https://public-inbox.org/git/87imwha1o3.fsf@evledraar.gmail.com/
[2]: https://public-inbox.org/git/20190317200609.GA1216@hank.intra.tgummerer.com/


Jonathan Chang (5):
  t0000: fix indentation
  t0000: avoid using pipes
  t0000: use test_line_count instead of wc -l
  t0000: use test_cmp instead of "test" builtin
  t0000: make use of the test_must_be_empty function

 t/t0000-basic.sh | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

Range-diff against v3:
1:  768bf373d0 = 1:  86146182b7 t0000: fix indentation
2:  8ee5e073a2 ! 2:  1ca1168f91 t0000: avoid using pipes
    @@ -6,6 +6,10 @@
         using it. By writing out the output of the git command to a file, we can
         test the exit codes of both the commands.
     
    +    This commit doesn't make any additional simplifications, such as using
    +    the test_line_count function for counting the lines in the output. These
    +    simplifications will be made in subsequent commits.
    +
         Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
     
      diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
3:  68590a40d7 = 3:  28986ed000 t0000: use test_line_count instead of wc -l
-:  ---------- > 4:  731463ed98 t0000: use test_cmp instead of "test" builtin
-:  ---------- > 5:  53f58a4f89 t0000: make use of the test_must_be_empty function
-- 
2.21.0

