From: Pete Harlan <pgit@pcharlan.com>
Subject: [bug?] checkout -m doesn't work without a base version
Date: Sun, 04 Dec 2011 14:31:49 -0800
Message-ID: <4EDBF4D5.6030908@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 23:38:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXKho-0003oQ-BF
	for gcvg-git-2@lo.gmane.org; Sun, 04 Dec 2011 23:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854Ab1LDWig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Dec 2011 17:38:36 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:60245 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742Ab1LDWif (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2011 17:38:35 -0500
Received: from homiemail-a44.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 6A368184E21
	for <git@vger.kernel.org>; Sun,  4 Dec 2011 14:32:30 -0800 (PST)
Received: from homiemail-a44.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a44.g.dreamhost.com (Postfix) with ESMTP id 872CA11805C
	for <git@vger.kernel.org>; Sun,  4 Dec 2011 14:31:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pcharlan.com; h=message-id:date
	:from:mime-version:to:subject:content-type:
	content-transfer-encoding; q=dns; s=pcharlan.com; b=FKIKDRijyL2y
	+qpVnfO0Ih6YSFH8P6is9hIPZNgE8DVfF8VwncJaWPRysrcDv5EEJxXz8lw7XQ4X
	/aYpeqW5bH7WkHeDOPDcfVYoFuvxpM95YAPIU6QLQ0v0U7bTx3AJA2330xEEfj1w
	BFddnb0tSje2tniG6iL6u37u6/XtPuE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pcharlan.com; h=message-id
	:date:from:mime-version:to:subject:content-type:
	content-transfer-encoding; s=pcharlan.com; bh=fM4Fu6pwLBz4Jy2clu
	GKxzSCHVY=; b=Q4pVavKRpXUrJUxPp24UpbFyr9vOhMQV6D8b8ZlHWhwJ8fldIf
	TkTRDTe+U5ZPgjYtYsAZfVbafQ/WTci4zv9GruZiZucXXrIwoQuuoOs2A7ngFT/i
	yOc4yHkojD6/jcBNCg9yATJ1aPhjZDBlDk/PiOtF7ENUKFvdoWX5o8jJE=
Received: from [192.168.0.102] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pgit@pcharlan.com)
	by homiemail-a44.g.dreamhost.com (Postfix) with ESMTPSA id 70875118058
	for <git@vger.kernel.org>; Sun,  4 Dec 2011 14:31:51 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111124 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186274>

Hi,

If during a merge I've resolved conflicts in foo.c but want to start
over with foo.c to resolve them differently, I can say "git checkout
-m foo.c" to restore it to its un-resolved state.

But this only works if there's a base version; if foo.c was added in
each branch, we get:

   error: path 'foo.c' does not have all three versions

Git didn't need all three versions to create the original conflicted
file, so why would it need them to recreate it?

(The message is the same if I explicitly tell Git I don't want diff3
via "git checkout --conflict=merge foo.c".)

If this is considered a bug worth fixing I'll write a test that it
fails; if it's expected behavior I think the docs should mention
that.

Thanks,

Pete Harlan
pgit@pcharlan.com
