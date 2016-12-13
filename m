Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28540206A4
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934111AbcLMPb7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:31:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:60288 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933841AbcLMPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MEWkb-1cNiwr2qhF-00Ficc; Tue, 13
 Dec 2016 16:31:12 +0100
Date:   Tue, 13 Dec 2016 16:31:11 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 15/34] sequencer (rebase -i): leave a patch upon error
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <091217525a7ff71794b3544680571ce9814a297f.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:f5yQCPHRvJKbMPnLgTf0uLle0rpUD+OcnWpc6pgQl9lkQRSvSM3
 zR3nbtRk00DqWUhXFtquw0FoPiUbZBorcJrVNMnRCNCMO3avPM8ZX4GPfKmal8j0oM9Fe8E
 tSCF2Gt588mnc0i5JOB7wD6V4Pi1N27PV3tTJNzIQric/3UAFC72hAKrbUHOrZp1jlr2Xek
 m1ivEP34yMvSJjszSPzmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oIXDVMMo9AM=:dVmbnWeFy+aY+ug5GmR8rH
 Qs32hogJ6ocA2o9VFhIcjB5STYa0wU/FiNCMdvNYoc+Isd+Uok54wxrgIr7VRoYkedKSZ/65N
 s5ojuWFoHS60noISU9IoiZ+8h1oJOFd1E1d+fkRKsEmv/UbvI9Lvtqz8AWSTTwXGB47vDTK/U
 iWpfNRt1A8VW4lfqHdiDIKUv/hX4lpsyCwlfQq9y+BZJpQUNVgIOr+EZN2J7OS82FFGNQXtfH
 mlPpKWzqPijj/Z3C5BdyiAVShv3lfxM8LQcqNoB8xxgmGiPixFlyBnZX2sOTBCS0xQL4cRVPH
 iW8IUVFyhD+beVydhzNgBeTk6wJiboVsWUnrGMXyNQqj2juCPvbEPaErrB4QJy43rDxFoGZ1e
 rjth1SGYuj5sM9y47ff81Ivdx9dbeHnsnxJFi86lkW/4XFwV+h2ekpfEI8Jqm+DXmXFImewUi
 AUP1Dm44NdQ5GPrKDeSZCun99jsl6JMc3434SnR0fYtcmN4sbu9ikoXvNV3RVQ34vHUGRcImS
 niLcoLnby5C7Dji3wJ0JOWg/6lRN1kFbwt8DIvHsvVFzisPWZmToggEv4bPBDLEHX8ZgQtUPG
 zjwvtJP/WRBjdrwjxorko0e6t7+tgb+YJ0dHdY75FBfp/5s7CW/M3ZJApX3whUZsPDmfl8C9i
 r3t7Q9TSJIZNZrIPK3VAiJGor+uYecJN2KlNCgckPkzfEr3prGE/i9vZzwWvv7qD2Ka5vIdU5
 WiyGAUufWgbh6T4b9LA9XlsXGnZNY9IOEWSGCbqHyJbSToGt4fByx0SG02cqRuAbmA+3U6fws
 wi6Uv+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When doing an interactive rebase, we want to leave a 'patch' file for
further inspection by the user (even if we never tried to actually apply
that patch, since we're cherry-picking instead).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index a4e9b326ba..4361fe0e94 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1777,6 +1777,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				return error_failed_squash(item->commit, opts,
 					item->arg_len, item->arg);
 			}
+			else if (res && is_rebase_i(opts))
+				return res | error_with_patch(item->commit,
+					item->arg, item->arg_len, opts, res, 0);
 		}
 		else if (item->command == TODO_EXEC) {
 			char *end_of_arg = (char *)(item->arg + item->arg_len);
-- 
2.11.0.rc3.windows.1


