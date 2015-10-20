From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/8] run-command: Initialize the shutdown flag
Date: Tue, 20 Oct 2015 15:43:45 -0700
Message-ID: <1445381030-23912-4-git-send-email-sbeller@google.com>
References: <1445381030-23912-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 00:44:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zofde-0001oW-VU
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 00:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbbJTWoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 18:44:09 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34241 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbbJTWoA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 18:44:00 -0400
Received: by padhk11 with SMTP id hk11so33927316pad.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 15:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9+MjYSwInPzKGut5++qb2v6SuZpjLB1keUgMJrg1w3U=;
        b=IckpwUR/CJXJX5WImHcyCkezaShtL3p2f+3g0qUcGP6xm4GOZReqqd+sN8rxqMPSQD
         cVYJuEbRBG8fOJFYSWIpgaGiL6yNQSzJP7etZw4WkNwLrTCWP19e9gRh29xir9n9y/Ly
         +JQLxZ2Joq4STlXnuaS7DZ9mDUB2S1K5nVMI3sOmTl0bAo1lDjxVKz3HKi3By3HXT5+P
         DI3WVtmVpH2mAlhZZWEl2+KD9e3W5LMl4s843BLrd0GR88faDBSeNWrzs3xQWL+1uyfS
         zjScwk86W1L0UJfvxEQ+Fga4k7qb0O884Y8I3ZVLWgzkS+07k/GyUOWCF3H7sJ+paOOr
         n+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9+MjYSwInPzKGut5++qb2v6SuZpjLB1keUgMJrg1w3U=;
        b=FFUwzc/y1lM1aB/+WqCcQqCwrv1/jG7dlniCI0p/n9vw+NCGJwDCMPUlFBzQPXs2Ce
         r1XbZJAKfd7Eormry4uv83nVCWleBd3EjUPqOBs7u+tGm3FpHOcPXJ/XtrJ3h9N66blA
         TKyJERLCj2RR4eHtD/4xMZdnh5StN5KyahhJQEwt+QTUURPRD9UVwRF2FU8dMD+I60JN
         Q2NHEzMcu7w6qtmQ2V3zE/ntboiHrQOU+95MSZV4Myk7/GSs2ry41FRb0iJuqErJxCAi
         ufj1jcyAv1QHuA1VdymcZKdcxUnjIhoprW6jfJCf1VkpBk75wOnLpDbnS6yiSA1EdvhQ
         GF4g==
X-Gm-Message-State: ALoCoQnujpiVTvFgWkYFtUKT813K50WbENyeiUZMaGfQqV8v+6t2PoxfK8SQDDonaTr7LjLN/nbU
X-Received: by 10.68.185.132 with SMTP id fc4mr6514836pbc.96.1445381040232;
        Tue, 20 Oct 2015 15:44:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:95b6:4bcd:ddcd:b6a3])
        by smtp.gmail.com with ESMTPSA id es4sm5598885pbc.42.2015.10.20.15.43.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Oct 2015 15:43:59 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.gbfc1651.dirty
In-Reply-To: <1445381030-23912-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279949>

It did work out without initializing the flag so far, but to make it
future proof, we want to explicitly initialize the flag.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/run-command.c b/run-command.c
index a5ef874..d354c01 100644
--- a/run-command.c
+++ b/run-command.c
@@ -962,6 +962,7 @@ static struct parallel_processes *pp_init(int n,
 
 	pp->nr_processes = 0;
 	pp->output_owner = 0;
+	pp->shutdown = 0;
 	pp->children = xcalloc(n, sizeof(*pp->children));
 	pp->pfd = xcalloc(n, sizeof(*pp->pfd));
 	strbuf_init(&pp->buffered_output, 0);
-- 
2.5.0.275.gbfc1651.dirty
