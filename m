From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 0/3] daemon: plug memory leak
Date: Sat, 31 Oct 2015 10:16:57 +0100
Message-ID: <56348709.9080207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 10:17:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsSHr-0003ZQ-2F
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 10:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbbJaJRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 05:17:17 -0400
Received: from mout.web.de ([212.227.17.11]:61057 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645AbbJaJRP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 05:17:15 -0400
Received: from [192.168.178.36] ([79.253.163.201]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Maaur-1aCbav2TKD-00KBMG; Sat, 31 Oct 2015 10:17:00
 +0100
X-Mozilla-News-Host: news://news.gmane.org:119
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
X-Provags-ID: V03:K0:EMvIDVsmWyPjfwYA8Vn9wBGsKvGEe7TIDMzKRqhIf1SFD5gm0eY
 aGwZ3gpOkyOMs7vzx+xR7AJi77U++voLlxglcqBPHRM0Bd9v4FhyLR+U7yz8uacKFF6PL13
 uOgSMoy1rTPAj+jeG5DF630XCs1Lq1K9LU3XSRZeXZuGYPNuFnDMfmOgdKbFmJkVVM74FW3
 Kk5+6UGw2XQargXHyvCBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pA607A7I8FA=:iQ3FzYQr69Wxlc81zAh2wQ
 /lmEjZaUwW1pBUEo99++LBHlhj0HGoED+id38I6Sp6OgZh4hfEat0ypwpDhnv6Zv8SyADjtQt
 kfQJlXDEpf7hNnC66nGSIs6VSWROmGKOjK72lgjJ7hwCsiFJfOckCtknVxjEb59DTL0Az9ad2
 mhDpJUhz/ZEIVtJiw/YoVnZkYGmYqh65WYSGaN2B9XVj0EZu+lI5suvcGlcFbCav98Ora7BBw
 /hYuZMgxogStkrqNfCeXLoxHCNxVwK/pBKBby3MI0OEidkiWOKYbNy5NsoU0/v7BOHN/hp1SZ
 SKCI60loKb4nAhy4QzYzZuHagxohq+jRQi2wxqVBbZ+NkpPLRcj4TNjkUfs7u3Xjq3xG7aIIY
 tCDn52cAyKAzQYYNrpZ6XFpHaP3EstxZc3YGlX+mx5G97/jrnjH50RxBkDPCGwngh4TX7UGr+
 c5qg5Nsf/hoDUP1HH828OyJ+Mn9t6zS0Y7qo64QKu3p88QeQYOsf04HxzVUYVdvk0OHqIHv4L
 rHVhNcm1jCb3CRq7EHegDC/MJwnmna942+vR2klkQQbwaRxsLiMDvhTSrWviQNIFXjW//L6hl
 UlD+sD6M01uf9vP1fmMUZyNA0gcqLOKmewrglr4jhPJV09dlTpJkNpR3K5kHyJyTZ5Tl9/tst
 ATHkFZrGgLDLJMNyCQn7J3Y5t2QSpvL0J9oh9M2ljldqsBiJKZbUb2YhB2Kv6mW2BnP+ZAIm9
 ESRVh0Z0z4ztVQyaOrtMRwTxva1GmZX26i4svsAIigNh+Ls4k0JFXgkN/yn+xICiNa2NC2fR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280571>

Changes since v1:
- Rebased on next, which already has a cleanup function.
- Added first patch for renaming it.

Rene Scharfe (3):
   run-command: name the cleanup function child_process_clear()
   run-command: export child_process_clear()
   daemon: plug memory leak

  Documentation/technical/api-run-command.txt |  7 +++++++
  daemon.c                                    |  1 +
  run-command.c                               | 12 ++++++------
  run-command.h                               |  1 +
  4 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.6.2
