From: Junio C Hamano <jch@google.com>
Subject: Re: [PATCH v7 4/4] git-rebase: add keep_empty flag
Date: Thu, 19 Apr 2012 12:05:56 -0700
Message-ID: <xmqqpqb3v8x7.fsf@junio.mtv.corp.google.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
	<1334776680-23460-1-git-send-email-nhorman@tuxdriver.com>
	<1334776680-23460-5-git-send-email-nhorman@tuxdriver.com>
	<4F8FE2CD.3070300@in.waw.pl> <873980q6vm.fsf@thomas.inf.ethz.ch>
	<xmqqty0fv97w.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Neil Horman <nhorman@tuxdriver.com>, <git@vger.kernel.org>,
	"Clemens Buchacher" <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 19 21:06:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKwg9-0007Yy-Mc
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 21:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346Ab2DSTGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 15:06:00 -0400
Received: from mail-fa0-f74.google.com ([209.85.161.74]:50028 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756297Ab2DSTF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 15:05:59 -0400
Received: by faaa19 with SMTP id a19so3853faa.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 12:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=iRh91n+06mN+6KtP9LIuOJH/fZrW2oZcWbC6VE0Kamw=;
        b=T3rxz0g0f2+dlmS+azOh7odhb39Qa8PoDolS5KNDBILBtD4U37hWNgayknuUenmqJM
         d9DcCLxPBd9cZvLN8rAS4lf/b3QH957pWCbKZKgHEwQw4fXwHsmUT9c0ATCFmtK/CDPA
         nCH9kmEDJS8ia5X4veSOPHRxbW0IRlAf+6BzpXTT8jfLQ8XFtbv9J4ZpD4ayL+/zie9x
         i8JRSLMjYuNWFL1SSvirfta7bm8Nbm66EVO+0+0KLHAfgkQfjwL4ZIaaaE8onEuMmRwN
         XgrwCAwW7X8cr3ZC/h8jDcg8XlAZyXI5TQNO6KmBkUsVKZmerGYjxfSPOUm3s5Pt6UGd
         oTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=iRh91n+06mN+6KtP9LIuOJH/fZrW2oZcWbC6VE0Kamw=;
        b=bq5s9/uiN7iNziP2O+guqTyUTz2QQGfzNsIjS+D0wRMiNQytCKTRR4GhOoUMhj/w8u
         IKljUnWYUAw7C/SBMyvQlRuBPd8j3hawWcFV6PY3oWxH0fAsKdL4j8UeDA+AnZXGnPTY
         AWrdp5bS9NhNCOuPqe1nYDMm+xfamOzaCcM1f8INKSVAFXbQdST1RHWEqXxjSs6YURUV
         x3LVn/S2vSiJhhJh50/5J59ilqVQ8ujTlxGuB3A7F5my6kgibj1WgKIbJL6J0mw7zYTJ
         c3grMnhAym7h2NvKbQbuOZbhXITENx7zUZ5qcbh+0j31g23JH6265yIXrQWKkD3a+l+8
         +yuw==
Received: by 10.14.100.207 with SMTP id z55mr922338eef.4.1334862357962;
        Thu, 19 Apr 2012 12:05:57 -0700 (PDT)
Received: by 10.14.100.207 with SMTP id z55mr922309eef.4.1334862357799;
        Thu, 19 Apr 2012 12:05:57 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id z52si2932349eeb.1.2012.04.19.12.05.57
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 19 Apr 2012 12:05:57 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 989FF20004E;
	Thu, 19 Apr 2012 12:05:57 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id DF6E7E1209; Thu, 19 Apr 2012 12:05:56 -0700 (PDT)
In-Reply-To: <xmqqty0fv97w.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 19 Apr 2012 11:59:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQn5R3V/v2oA9IqaZQVYt2601HCozKB9yl/XEzj44iPD/ZA7zvu/Zf+L+oKpD0rEBBNvyiSwo5GroqwXJmtlDESWpvtf0t+yNc7R2WlPZ8xbDCN4iyzSoiaMcgJDWvjVw1AjsoMmUcl8xMz4x3lINuKpbJoCIY3GUWUxnxnTHU7wwLnAoDg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195964>

Junio C Hamano <jch@google.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> Either way, it should simply be spelled as
>>
>> is_empty_commit() {
>> 	tree=$(git rev-parse "$1"^{tree})
>> 	ptree=$(git rev-parse "$1"^^{tree})
>> 	test "$tree" = "$ptree"
>> }
>
> Thanks; will squash in something like this:
> ...

Ehh, not like that.  But something like this, as we need to be able to
pick "root" (t3412 insists on it).

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 82042b1..de71543 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -168,9 +168,11 @@ has_action () {
 }
 
 is_empty_commit() {
-	tree=$(git rev-parse "$1"^{tree})
-	ptree=$(git rev-parse "$1"^^{tree})
-	return $(test "$tree" = "$ptree")
+	tree=$(git rev-parse "$1"^{tree} 2>/dev/null) ||
+		die "$1: not a commit that can be picked"
+	ptree=$(git rev-parse "$1"^^{tree} 2>/dev/null) ||
+		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+	test "$tree" = "$ptree"
 }
 
 # Run command with GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
