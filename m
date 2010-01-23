From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/7] Documentation: merge: add an overview
Date: Sat, 23 Jan 2010 03:42:46 -0600
Message-ID: <20100123094246.GE7571@progeny.tock>
References: <20100123092551.GA7571@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 10:43:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYcWI-0001Os-Kn
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 10:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654Ab0AWJmr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jan 2010 04:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570Ab0AWJmr
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 04:42:47 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:58951 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab0AWJmq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 04:42:46 -0500
Received: by iwn16 with SMTP id 16so820347iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 01:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QynxLbJX8V7y07xgqPzt5kiGAxLPsOXcycqTq/SJI5s=;
        b=xU3pnPuzJFUH9Vhrle5oxzJw9fA2eP7Z9UpyRHXuvsiy2OedryYPnmVn3jTnkLH/tr
         +cBYlEdcL4ZqqkCyTb/hWGqh9B0Tg/4o0xuqoBwDjy+GJfNKMouUj66ji+PURh9s/jOb
         AY8EEClcbDFxUne9TgWJVGZbXTl+X23S0GiPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=a6/toVHyZohbpjMv/3q/Qq+OMpvhg7VaJp+FBDXRby9ADB0dg6Ii3D7ErOLL8/mITc
         HRV6whJ0bNmnROWA68mgSjS5ELkSay50G3Dzgd/q0fqsOCez9x9XO3VV7u/qDSZQOHkQ
         W48830tz9D7vmEEuT6sgS6lb13S8bi8I+RaGI=
Received: by 10.231.150.2 with SMTP id w2mr5586053ibv.83.1264239764486;
        Sat, 23 Jan 2010 01:42:44 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2436738iwn.2.2010.01.23.01.42.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 01:42:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100123092551.GA7571@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137822>

The reader unfamiliar with the concepts of branching and merging
would have been completely lost.  Try to help him with a diagram.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The advice in [1] was very helpful.  I fear I=E2=80=99ve made a mess of
the language even so.  At least it does seem much clearer now.

Thoughts?

[1] http://thread.gmane.org/gmane.comp.version-control.git/136356/focus=
=3D136629

 Documentation/git-merge.txt |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 83bf3e7..a7a40c6 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -15,8 +15,32 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-Merges the history specified by <commit> into HEAD, optionally using a
-specific merge strategy.
+Incorporates changes from the named commits (since the time their
+histories diverged from the current branch) into the current
+branch.  This command is used by 'git pull' to incorporate changes
+from another repository and can be used by hand to merge changes
+from one branch into another.
+
+Assume the following history exists and the current branch is
+"`master`":
+
+------------
+          A---B---C topic
+         /
+    D---E---F---G master
+------------
+
+Then "`git merge topic`" will replay the changes made on the
+`topic` branch since it diverged from `master` (i.e., `E`) until
+its current commit (`C`) on top of `master`, and record the result
+in a new commit along with the names of the two parent commits and
+a log message from the user describing the changes.
+
+------------
+          A---B---C topic
+         /         \
+    D---E---F---G---H master
+------------
=20
 The second syntax (<msg> `HEAD` <commit>...) is supported for
 historical reasons.  Do not use it from the command line or in
--=20
1.6.6
