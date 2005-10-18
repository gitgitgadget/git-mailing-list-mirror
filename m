From: David Ho <davidkwho@gmail.com>
Subject: git-diff-tree rename detection for single file
Date: Tue, 18 Oct 2005 15:56:06 -0400
Message-ID: <4dd15d180510181256i1c5a82d9ld62acaedb493cf71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Oct 18 21:58:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERxZF-0008Fg-Gc
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 21:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbVJRT4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 15:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbVJRT4I
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 15:56:08 -0400
Received: from qproxy.gmail.com ([72.14.204.197]:10691 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751487AbVJRT4H convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 15:56:07 -0400
Received: by qproxy.gmail.com with SMTP id o12so91848qba
        for <git@vger.kernel.org>; Tue, 18 Oct 2005 12:56:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dCrb0yl2kkWsXdWn8ueCFHGuF64KagzpdFBVyivXxmwup37hPNWh/1kQ6OibuGdFRVkhxEJTzh6fKShiHUnFPeSnrCCISTN2rzzXDrBTLPGwg4cvIfq8DvSiW3oGBvXA5U6yh6sPjgXVB+4Ib5d0hBNaVP6dGXixljGsZp0i6kc=
Received: by 10.64.209.15 with SMTP id h15mr888749qbg;
        Tue, 18 Oct 2005 12:56:06 -0700 (PDT)
Received: by 10.65.22.3 with HTTP; Tue, 18 Oct 2005 12:56:06 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10225>

Hi,

I have a small suggestion to make the diff of a renamed file a bit
more meaningful.  I have a file that is renamed-edited and commited. 
git-diff-tree -M -p <commit> shows one result and git-diff-tree -M -p
<commit> <filename> shows another.  If they both show a rename
occurred then I think the single file git-diff-tree will be more
useful.

Any strange idea I have is to make git-diff-tree traverse the list of
commits (assuming the list is returned from git-rev-list) to trace
renames of the file to its origin.  Of course I don't know how useful
this is to most.

David

[davidho@penguin git-tutorial]$ git-diff-tree -r -M -p \
8c77fe87790276b4e0b2650d7c5799eb893ac3ed
8c77fe87790276b4e0b2650d7c5799eb893ac3ed
diff --git a/goodbye b/ciao
similarity index 83%
rename from goodbye
rename to ciao
index 0561cce..d8259f5 100644
--- a/goodbye
+++ b/ciao
@@ -4,3 +4,4 @@ Play, play, play
 Work, work, work
 Eat, eat, eat
 Drink, drink, drink
+Chew, chew, chew


[davidho@penguin git-tutorial]$ git-diff-tree -r -M -p \
8c77fe87790276b4e0b2650d7c5799eb893ac3ed ciao
8c77fe87790276b4e0b2650d7c5799eb893ac3ed
diff --git a/ciao b/ciao
new file mode 100644
index 0000000..d8259f5
--- /dev/null
+++ b/ciao
@@ -0,0 +1,7 @@
+Hello World
+It's a new day for git
+Play, play, play
+Work, work, work
+Eat, eat, eat
+Drink, drink, drink
+Chew, chew, chew
