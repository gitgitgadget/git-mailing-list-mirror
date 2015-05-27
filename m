From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] verify_lock(): report errors via a strbuf
Date: Wed, 27 May 2015 12:48:45 -0700
Message-ID: <xmqqk2vtls2q.fsf@gitster.dls.corp.google.com>
References: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
	<1432337697-29161-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 27 21:48:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxhJw-0003lu-Sv
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 21:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbbE0Tsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 15:48:51 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34875 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbbE0Tss (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 15:48:48 -0400
Received: by igbyr2 with SMTP id yr2so94513154igb.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wTboLZf7hZ4GDcp721SBgdZlZo6xNrBdw6W7yVQe/ro=;
        b=CBP8kuw6MWQMR6jCuT7XJlcK82oaw5I51wpdPJjlAKh8Zo5NEvWz/bAUcyJ0BzE0BZ
         1DKuNZZ4XobWZ1yCT2hKEzi26p2DPf8heCxBPo7ZQr5tMdQJOYv/yLfq55Ie8Dy7+/aW
         ql2ymvvkbq35yvrV7/mOZsq4OWu8tJK+Fu0inbBTDi+nK9oYNuahk3yAYKUQi9t98lOB
         y4ZP7ub/8EYJJSu1Wl0dtX40C7D6gdBQUx46YRI9xx9yR63EBsPuj53/HpFOm6fOXI2o
         +kKhFrA30c2nsHux3t0/uUnmNN5gFRy+X1+Qrf0qTzs2Tj6rA4by/ZQEwmLfiwTe8rLv
         gXNQ==
X-Received: by 10.50.33.19 with SMTP id n19mr15312671igi.8.1432756126803;
        Wed, 27 May 2015 12:48:46 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id qs10sm321168igb.14.2015.05.27.12.48.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 12:48:46 -0700 (PDT)
In-Reply-To: <1432337697-29161-4-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Sat, 23 May 2015 01:34:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270074>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Instead of writing error messages directly to stderr, write them to a
> "strbuf *err". In lock_ref_sha1_basic(), arrange for these errors to
> be returned to its caller.

I had to scratch my head and view long outside the context before
realizing that the caller lock_ref_sha1_basic() already arranges
with its caller that errors from it are passed via the strbuf, and
this change is just turning verify_lock(), a callee from it, follows
that already established pattern.

Looks sensible, but the last sentence was misleading at least to me.

	The caller, lock_ref_sha1_basic(), uses this error reporting
	convention with all the other callees, and reports its error
        this way to its callers.

perhaps?
