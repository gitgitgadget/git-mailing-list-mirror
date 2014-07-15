From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH] remove duplicate of is_branch
Date: Tue, 15 Jul 2014 16:02:37 -0700
Message-ID: <1405465358-27054-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:02:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7BkE-0001QF-SD
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759444AbaGOXCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:02:43 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:37576 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbaGOXCl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:02:41 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so16825yha.4
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=C0iSC2cZOqQLk7NlE6b5r96YZaJGyo/wfFn3gn/bOZ0=;
        b=aA2JoqFyOko5b/DZnpzsTbTiDFEDynUAYMIE+WLGkAuXXiECQM4Sh5Xq9VEmjq6eXY
         qTh/b3uH9Hnk3UhULB2S/cncbM8RNAZnn+LTE1H0tKR3UGKbU0BIbyG6US6ehHS95+R6
         /t9w1ww4w8y2YdmwI/O/vCssf73C22/igd9qtOR6gvTyYhr2zDnsKk4HS+Eda2TkVOyl
         daFWZ6WEx9lzROb2lFdXWl28pgeuaP9Itd4TUaW7gGXsYNTHO2nqWUM2AsSRG9UkRJfg
         reT6bB9NzF3xl2k2Yf485tQRJPkEt8Ssox9+dXnmvYU8wwQWL7VYG7ARDK8F5ooRH26+
         iFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C0iSC2cZOqQLk7NlE6b5r96YZaJGyo/wfFn3gn/bOZ0=;
        b=WH5xHxOvEdwj45y85mBCtegxzjs28g0TPRtaHjiVJIKXhbsK0splD4ls74NW273ZAl
         nepWRjRRs0qu0W8RipFhSgAgp9ICXEjLyIco8OIn9BgYFsGNLbGfDQSd8T+j19sTuic+
         C3m9kbfOYEys12ngyOHVt0AWCwD7VGCetlMBi+NnT9Fp4xz2kWXlxN7Y3dOUQ5bO6KPs
         IRIj3uUiNaO+CeBogX5qyc2r66KVhIzyTJu8n59jWvN7c6sNmZGDgzxZPTKX1xszUer/
         4ABy3+toaoplpviIST+X3jotgxB0qeG/RbQMPc+JV75TAjnW+36EXF6QETm/iRC4ZaAA
         DHAw==
X-Gm-Message-State: ALoCoQmsFVfd8gPXSnQOYnYqDxwl8eR74UXdw7ulDvuYjB0GHii8cVdsSizEj+YETWEfylBVInT5
X-Received: by 10.236.99.8 with SMTP id w8mr10726940yhf.31.1405465360624;
        Tue, 15 Jul 2014 16:02:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v12si1056012yhe.2.2014.07.15.16.02.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:02:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 73A435A425F;
	Tue, 15 Jul 2014 16:02:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 11925E0B27; Tue, 15 Jul 2014 16:02:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.442.g7fe6834.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253616>

Jun, List

Please find a trivial patch that makes refs.c:is_branch public.
This allows us to delete the identical copy of is_branch in fsck.c


Ronnie Sahlberg (1):
  refs.c: add a public is_branch function

 builtin/fsck.c | 5 -----
 refs.c         | 2 +-
 refs.h         | 2 ++
 3 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.0.1.442.g7fe6834.dirty
