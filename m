From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pre-commit hook should ignore carriage returns at EOL
Date: Tue, 24 Jun 2008 16:59:14 -0700
Message-ID: <7v4p7i9ygd.fsf@gitster.siamese.dyndns.org>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com>
 <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site>
 <39C2861E-F800-40AE-8C15-4FC3BB51EF16@gmail.com>
 <7v3an2bh3b.fsf@gitster.siamese.dyndns.org>
 <930163B6-4A7E-49C7-B9D5-F7B37699C2A9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Holtje <docwhat@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 02:00:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBIR4-0001iw-5k
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 02:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbYFXX72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 19:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752659AbYFXX71
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 19:59:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbYFXX71 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 19:59:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 824429CBC;
	Tue, 24 Jun 2008 19:59:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 62EE99CB9; Tue, 24 Jun 2008 19:59:21 -0400 (EDT)
In-Reply-To: <930163B6-4A7E-49C7-B9D5-F7B37699C2A9@gmail.com> (Christian
 Holtje's message of "Tue, 24 Jun 2008 19:25:40 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9244D9BC-4249-11DD-80A1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86188>

Christian Holtje <docwhat@gmail.com> writes:

> On Jun 24, 2008, at 6:31 PM, Junio C Hamano wrote:
> ...
>> It's an ancient sample hook that is not be enabled by default.  I do
>> not want people to be wasting too much time on the relic.
>
> Part of the reason I'm fixing this is because it *is* enabled by
> default in windows.  I don't know why, but cygwin always marks it with
> executable.

That's a packaging issue, and I've always wanted to see fixes related to
platform specific packaging issues come from people who _need_ fixes on
their platforms.  I have been waiting forever for that to happen without
complaining to them.  I was hoping some enlightened people will emerge
even from Windows camps, waiting patiently.

But I ran out of patience, and I am finally fed up waiting.

How about doing this everywhere, not just on Windows, for 1.6.0?

-- >8 --
[PATCH] Ship sample hooks with .sample suffix

We used to mark hooks we ship as samples by making them unexecutable, but
some filesystems cannot tell what is executable and what is not.

This makes it much more explicit.  The hooks are suffixed with .sample
(but now are made executable), so enabling it is still one step operation
(instead of "chmod +x $hook", you would do "mv $hook.sample $hook") but
now they won't get accidentally enabled on systems without executable bit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/githooks.txt                         |    3 ++-
 ...applypatch-msg => hooks--applypatch-msg.sample} |    0
 ...{hooks--commit-msg => hooks--commit-msg.sample} |    0
 ...ooks--post-commit => hooks--post-commit.sample} |    0
 ...ks--post-receive => hooks--post-receive.sample} |    0
 ...ooks--post-update => hooks--post-update.sample} |    0
 ...pre-applypatch => hooks--pre-applypatch.sample} |    0
 ...{hooks--pre-commit => hooks--pre-commit.sample} |    0
 ...{hooks--pre-rebase => hooks--pre-rebase.sample} |    0
 ...commit-msg => hooks--prepare-commit-msg.sample} |    0
 templates/{hooks--update => hooks--update.sample}  |    0
 11 files changed, 2 insertions(+), 1 deletions(-)
 rename templates/{hooks--applypatch-msg => hooks--applypatch-msg.sample} (100%)
 mode change 100644 => 100755
 rename templates/{hooks--commit-msg => hooks--commit-msg.sample} (100%)
 mode change 100644 => 100755
 rename templates/{hooks--post-commit => hooks--post-commit.sample} (100%)
 mode change 100644 => 100755
 rename templates/{hooks--post-receive => hooks--post-receive.sample} (100%)
 mode change 100644 => 100755
 rename templates/{hooks--post-update => hooks--post-update.sample} (100%)
 mode change 100644 => 100755
 rename templates/{hooks--pre-applypatch => hooks--pre-applypatch.sample} (100%)
 mode change 100644 => 100755
 rename templates/{hooks--pre-commit => hooks--pre-commit.sample} (100%)
 mode change 100644 => 100755
 rename templates/{hooks--pre-rebase => hooks--pre-rebase.sample} (100%)
 mode change 100644 => 100755
 rename templates/{hooks--prepare-commit-msg => hooks--prepare-commit-msg.sample} (100%)
 mode change 100644 => 100755
 rename templates/{hooks--update => hooks--update.sample} (100%)
 mode change 100644 => 100755

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 4f06ae0..262a4f1 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -17,7 +17,8 @@ Hooks are little scripts you can place in `$GIT_DIR/hooks`
 directory to trigger action at certain points.  When
 `git-init` is run, a handful example hooks are copied in the
 `hooks` directory of the new repository, but by default they are
-all disabled.  To enable a hook, make it executable with `chmod +x`.
+all disabled.  To enable a hook, rename it by removing its `.sample`
+suffix.
 
 This document describes the currently defined hooks.
 
diff --git a/templates/hooks--applypatch-msg b/templates/hooks--applypatch-msg.sample
old mode 100644
new mode 100755
similarity index 100%
rename from templates/hooks--applypatch-msg
rename to templates/hooks--applypatch-msg.sample
diff --git a/templates/hooks--commit-msg b/templates/hooks--commit-msg.sample
old mode 100644
new mode 100755
similarity index 100%
rename from templates/hooks--commit-msg
rename to templates/hooks--commit-msg.sample
diff --git a/templates/hooks--post-commit b/templates/hooks--post-commit.sample
old mode 100644
new mode 100755
similarity index 100%
rename from templates/hooks--post-commit
rename to templates/hooks--post-commit.sample
diff --git a/templates/hooks--post-receive b/templates/hooks--post-receive.sample
old mode 100644
new mode 100755
similarity index 100%
rename from templates/hooks--post-receive
rename to templates/hooks--post-receive.sample
diff --git a/templates/hooks--post-update b/templates/hooks--post-update.sample
old mode 100644
new mode 100755
similarity index 100%
rename from templates/hooks--post-update
rename to templates/hooks--post-update.sample
diff --git a/templates/hooks--pre-applypatch b/templates/hooks--pre-applypatch.sample
old mode 100644
new mode 100755
similarity index 100%
rename from templates/hooks--pre-applypatch
rename to templates/hooks--pre-applypatch.sample
diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit.sample
old mode 100644
new mode 100755
similarity index 100%
rename from templates/hooks--pre-commit
rename to templates/hooks--pre-commit.sample
diff --git a/templates/hooks--pre-rebase b/templates/hooks--pre-rebase.sample
old mode 100644
new mode 100755
similarity index 100%
rename from templates/hooks--pre-rebase
rename to templates/hooks--pre-rebase.sample
diff --git a/templates/hooks--prepare-commit-msg b/templates/hooks--prepare-commit-msg.sample
old mode 100644
new mode 100755
similarity index 100%
rename from templates/hooks--prepare-commit-msg
rename to templates/hooks--prepare-commit-msg.sample
diff --git a/templates/hooks--update b/templates/hooks--update.sample
old mode 100644
new mode 100755
similarity index 100%
rename from templates/hooks--update
rename to templates/hooks--update.sample
