From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 0/3] request-pull: do something if $3 is passed
Date: Mon, 16 Feb 2015 19:16:05 +0100
Message-ID: <1424110568-29479-1-git-send-email-bonzini@gnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 19:16:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNQDZ-00089z-I3
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 19:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075AbbBPSQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 13:16:19 -0500
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34500 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736AbbBPSQR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 13:16:17 -0500
Received: by mail-wg0-f41.google.com with SMTP id b13so30937882wgh.0
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 10:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Vr+w8hHX9c2aIFa+K2L4d1HwZBH8C/GRXYJLkeJJ1CY=;
        b=AmxyFeEwMgpe5rwIMtwJPnHe754oF/FIPXQRFSA8JoQ5LP3YyUPKvSELPS0Pei3teq
         fcif1yux7s1WzfKkPSb3Fa4r/cEUCpt00VRZqZtlL/a+3gTEb9m3Wr6k7+xqxrXyMfPc
         3wkuI6OKtMsD1JxLLHmu/qQlUtdDqq8DAw4OZVxSGrHip2cf659bfnpXKqjl0NhOYxBA
         TITdxE+o4VvT7liTtxpYvYAr9gY9Sdq+NwDhEwpzPGNSyS7deUcUxO4ZHigp/BtWwDya
         8/Y4JLYsrmjttd3sC64mGt6oESvxNDs2K6zDSLMW2XPFegws6RYOYES7WLM3re7z9YPy
         v65Q==
X-Received: by 10.194.120.132 with SMTP id lc4mr54049221wjb.92.1424110576680;
        Mon, 16 Feb 2015 10:16:16 -0800 (PST)
Received: from donizetti.redhat.com (net-93-66-73-217.cust.vodafonedsl.it. [93.66.73.217])
        by mx.google.com with ESMTPSA id et4sm23920115wjd.15.2015.02.16.10.16.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Feb 2015 10:16:15 -0800 (PST)
X-Mailer: git-send-email 2.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263906>

From: Paolo Bonzini <pbonzini@redhat.com>

After updating to git 2.3.0, "git request-pull" is stubbornly complaining
that I lack a matching tag on the remote side unless I pass the third
argument.  But I did prepare and push a signed tag.

This looks like a bug to me; when $3 is not passed git will try to use
"HEAD" as the default but it cannot be resolved to a tag, neither locally
(patch 2) nor remotely (patch 3).

Patch 1 is a simple testcase fix.

Paolo

Paolo Bonzini (3):
  request-pull: fix expected format in tests
  request-pull: use "git tag --points-at" to detect local tags
  request-pull: find matching tag or branch name on remote side

 git-request-pull.sh     | 15 +++++++++++----
 t/t5150-request-pull.sh |  5 ++---
 2 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.3.0
