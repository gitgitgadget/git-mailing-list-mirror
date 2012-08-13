From: y@google.com
Subject: [PATCH 0/4] Re: cherry-pick and 'log --no-walk' and ordering
Date: Sun, 12 Aug 2012 23:27:16 -0700
Message-ID: <50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 08:27:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0o7x-0007LB-2G
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 08:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312Ab2HMG1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 02:27:38 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:63571 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab2HMG13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 02:27:29 -0400
Received: by obbwc20 with SMTP id wc20so2563651obb.1
        for <git@vger.kernel.org>; Sun, 12 Aug 2012 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=szPDFHRY4tqgFGG1nlyD+Ikz/IxZHpxgM64WMTGy9o0=;
        b=esq421HFocpC+WZ2g5IvOv5pWJG79aVqy1UYSnLvjW4CdozLw8xBharrygFGAmVsr+
         ZwHn5gAuIWUwV16Z+O5UedCj0Sd8ZxvudmAgdQlfLulM/zhW5RE79AjglV8ZHLz3/c/h
         A6e0artlfVPXYw57B/Rs/18KbnlmuHKL7yf3TgG/4V0qXYKLS+eLHCycxA7EZxWmPHx3
         ilZOMAq4cGrefUrEa/PMYJUm/Z7/TuMAraeTYL1jTLCk3MhMLS9GutEcwjv60Cg1tD8m
         adVb0emr4L1RLPMWAMwlJuxB4d60BFYvjtjlLLRTZyfgjIQeAzB+Et+qf5Bnt9bk5Pqx
         TwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=szPDFHRY4tqgFGG1nlyD+Ikz/IxZHpxgM64WMTGy9o0=;
        b=WmbWLqU/fqZCiSFoZnWo04fFKg9C880FzWudZVUPA8e4qXulV8UVcvpMqmqG/QIZ/M
         WjNh4uFTKyjqnMWHUdvhkQVMCrB9o3vj8WXiBataVLvf4bz416+VyMvIZCAc4Am4FchH
         qAShQomPyKFvsxdezZc4guTtVQwaEMPgX3PSVTW5XFwYf+QRelHfdJh/Sm2cgkPqM8SI
         SN55WreD5rtX9YLzos9xL8/d2eYEWyE6FeU/OuOCRcRa9M69kuhXpjNgcA4VV17a++xZ
         SdLrbKJBe4NQlsK20xGwb+D5VkqWqfJMUdLVkiGlCA6Wx7ZNM0L/JSX9uxy5Bda0zmJm
         mTxQ==
Received: by 10.42.73.129 with SMTP id s1mr2788057icj.21.1344839249133;
        Sun, 12 Aug 2012 23:27:29 -0700 (PDT)
Received: by 10.42.73.129 with SMTP id s1mr2788046icj.21.1344839248798;
        Sun, 12 Aug 2012 23:27:28 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id bg4si1911496igb.3.2012.08.12.23.27.28
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sun, 12 Aug 2012 23:27:28 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 6975E1E0043;
	Sun, 12 Aug 2012 23:27:28 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id C5E25C1A16; Sun, 12 Aug 2012 23:27:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQnSWWwFLFTarLXY+VlsQhuSPjq0NAdmXGtYCMfl0WpeIjapGKDRREF5KERwH8uMIj9z9dFO1rcP4L/OtKdcOLd0lAz4hpmEsyldk7DEXPi2GziZUUu7OBGZZAhYzK03lIjTqouQGillhocU5v22f3foo5vZn3lGXDvGCoK25xxPITvxCYS86cadzKZpCGxY2PyKhSUe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203326>

From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>

This series adds supports for 'git log --no-walk=unsorted', which
should be useful for the re-roll of my mz/rebase-range series. It also
addresses the bug in cherry-pick/revert, which makes it sort revisions
by date.

On Fri, Aug 10, 2012 at 11:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Range limited revision walking, e.g. "git cherry-pick A..B D~4..D",
> fundamentally implies sorting and you cannot assume B would appear
> before D only because B comes before D on the command line (B may
> even be inside D~4..D range in which case it would not even appear
> in the final output).

Sorry, I probably wasn't clear; I mentioned "revision walking", but I
only meant the no-walk case. I hope the patches make sense.


Martin von Zweigbergk (4):
  teach log --no-walk=unsorted, which avoids sorting
  revisions passed to cherry-pick should be in "default" order
  cherry-pick/revert: respect order of revisions to pick
  cherry-pick/revert: default to topological sorting

 Documentation/git-cherry-pick.txt   |  2 +-
 builtin/log.c                       |  2 +-
 builtin/revert.c                    |  3 ++-
 revision.c                          | 18 +++++++++++++++---
 revision.h                          |  6 +++++-
 t/t3508-cherry-pick-many-commits.sh |  2 +-
 t/t3510-cherry-pick-sequence.sh     |  4 ++--
 t/t4202-log.sh                      | 10 ++++++++++
 8 files changed, 37 insertions(+), 10 deletions(-)

-- 
1.7.11.1.104.ge7b44f1
