From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: merging a tag is a special case
Date: Thu, 21 Mar 2013 13:10:45 -0700
Message-ID: <7vehf8a4ze.fsf@alter.siamese.dyndns.org>
References: <1363704914.6289.39.camel@test.quest-ce.net>
 <7vfvzrjrad.fsf@alter.siamese.dyndns.org>
 <1363802033-26868-1-git-send-email-ydroneaud@opteya.com>
 <7vboadevpk.fsf@alter.siamese.dyndns.org>
 <7vmwtwa5xa.fsf@alter.siamese.dyndns.org> <20130321195624.GH29311@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Droneaud <ydroneaud@opteya.com>, Git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 21:11:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIlpU-0003zh-Az
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 21:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab3CUUKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 16:10:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42762 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276Ab3CUUKr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 16:10:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55B7BA0EB;
	Thu, 21 Mar 2013 16:10:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ck14xxzooMru9e/9w3xwPkCsUKc=; b=H0ydpY
	yOq5MgFp7f9IlZbUh0t7Wzwktu1dmdpE0hVP0x4G4N67HDM5jrguxyS0zQDTPjSk
	FuSi6airZb1Fm4DLU5k46GC67VrOWGfk0kGoZxLOpaYjLZNE/GZLG2ZOR+N4m5u6
	hSGjciLT09jmKsISarexlXzZp/96T03WFmrts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gSVoRalcwU6qN5vBtS5He4VxSQRsmr08
	TttES8YhUM6Q38Ew4LOwG4XYPUJD+qAQl+/dAzGN2TQ7vVpFv3rw96dFoLpjRw8R
	WHxfCJvlx4iZZQV+IkpWBTasn+qsHZlZoTA2eXMldHxQv6w2I47G8x/ToUwD0jQl
	gmYdn8ZwWKY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 484CEA0EA;
	Thu, 21 Mar 2013 16:10:47 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5DC6A0E8; Thu, 21 Mar 2013
 16:10:46 -0400 (EDT)
In-Reply-To: <20130321195624.GH29311@google.com> (Jonathan Nieder's message
 of "Thu, 21 Mar 2013 12:56:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6ADDDFDA-9263-11E2-A0A7-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218754>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nice and clear, but doesn't this contradict b5c9f1c1b0ed (merge: do
> not create a signed tag merge under --ff-only option, 2012-02-05)?

It does X-<.  Here is a replacement.

The "--ff-only v1.2.3 will fail" can be left unsaid because it would
fail (and succeed) under the same condition "-ff-only v1.2.3^0"
would.

 Documentation/git-merge.txt | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index df2d28d..d1f3df9 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -179,19 +179,18 @@ the commit message template is prepared with the tag message.
 Additionally, the signature check is reported as a comment
 if the tag is signed.  See also linkgit:git-tag[1].
 
-Consequently a request `git merge --ff-only v1.2.3` to merge such a
-tag would fail.
-
 When you want to just integrate with the work leading to the commit
 that happens to be tagged, e.g. synchronizing with an upstream
-release point, you may not want to make an unnecessary merge commit
-especially when you do not have any work on your own.  In such a
-case, you can "unwrap" the tag yourself before feeding it to `git
-merge`, e.g.
+release point, you may not want to make an unnecessary merge commit.
+
+In such a case, you can "unwrap" the tag yourself before feeding it
+to `git merge`, or pass `--ff-only` when you do not have any work on
+your own. e.g.
 
 ---
 git fetch origin
-git merge [--ff-only] v1.2.3^0
+git merge v1.2.3^0
+git merge --ff-only v1.2.3
 ---
 
 
