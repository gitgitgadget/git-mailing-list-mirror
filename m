Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 137C21F859
	for <e@80x24.org>; Wed,  7 Sep 2016 23:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbcIGXgy (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 19:36:54 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33655 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbcIGXgw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 19:36:52 -0400
Received: by mail-pa0-f47.google.com with SMTP id cm16so10815623pac.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=R5smEcjzJFiOwccjAoFjPqjRwOUNMqH77XikhyNTxCo=;
        b=aQWKND4qTmB7NqRKKTHzDdOG/itW+m0zxB7eoDNMTP1+Ogb+L8TdFZ5hv5WL7gSy3E
         0N3/aLuqSZjJmEpQLKn+fYYyf9/ql9CouG2w1JOEO0HxA3/FQ0wlN2JWejhOPCweV/qO
         WIgNs8qxCqw71mg4kP2jda2xpA/LvYzlUF4we/C5PtStW9LdU9Bwpz/FlyzOOXL+ueUI
         aXSYULj2QKGN9utTQHPbhj7oRA2QTvic/s6v0hae2dam3tvBxqFgscJ3MAONvisWMX+q
         ClHaDXv7Sbwq/cMTdPQ5E+/HTBw3kllI2qrldEp+OfWDFPFeQihcuG/Ty5zCrY50QUfO
         aBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R5smEcjzJFiOwccjAoFjPqjRwOUNMqH77XikhyNTxCo=;
        b=TZwyEB4rfiWnSVAnclo+U4sT11YZGIWK12+fNj6eqbu1yAkbLVCMW95Xt0t1OTnvrL
         L+ElvoKaSlxqpy6uu2BwKLcnpq9GVk7V+zUoLoWR8S6D4ajq9hK8/jb57vzkNcE6LCUm
         3iSLxAOJpWTxcy36rfeZMRHoHFs3voY0TNB+wed5+kevRBsTR69ys5dgspYpap1AC1/w
         ifRKFLZy3cg6rwdytETq0LL6t/IteqysY3TUldS2RztkAVY3IUOsTfhpEoYgn/TljY1f
         7rfI/dsJ1oZaHo/56zK3n0EL7Q4dXL6pqrN6ihpk87+mlEMB2SlBka4LQ2kKVHuNWIlX
         aRyQ==
X-Gm-Message-State: AE9vXwNLBGvlyEAltrr25A/dKW+FIsff0tUBiYxiuY113nyIU4AU7R7FoXXiOdMgYcJ9n36l
X-Received: by 10.66.189.199 with SMTP id gk7mr87958788pac.158.1473291412088;
        Wed, 07 Sep 2016 16:36:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f111:face:c1e2:bcdc])
        by smtp.gmail.com with ESMTPSA id r90sm29188397pfi.16.2016.09.07.16.36.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 16:36:51 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] preparatory diff improvements for moved color detection
Date:   Wed,  7 Sep 2016 16:36:43 -0700
Message-Id: <20160907233648.5162-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.2.g0676c79.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Motivated by the feedback on the "[PATCHv4] diff.c: emit moved lines
with a different color"[1], I started refactoring the fn_out_consume function
in diff.c.  This lead to a huge amount of tiny patches so far, but nothing
to present as an end result.

These patches are preparatory for this effort and I want them out such that
I do not need to worry about them later.

Thanks,
Stefan

[1] https://public-inbox.org/git/20160906070151.15163-1-stefanbeller@gmail.com/



Stefan Beller (3):
  diff.c: use diff_options directly
  diff: omit found pointer from emit_callback
  diff: remove dead code

 diff.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

-- 
2.10.0.2.g0676c79.dirty

