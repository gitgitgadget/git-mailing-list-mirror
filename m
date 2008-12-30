From: jidanni@jidanni.org
Subject: git apply didn't catch error? [was Re: [PATCH] Documentation/diff-options.txt: unify options]
Date: Tue, 30 Dec 2008 08:02:35 +0800
Message-ID: <87r63q34ys.fsf_-_@jidanni.org>
References: <7vabafe5ai.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 30 01:07:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHS9N-0003T4-4R
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 01:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbYL3AGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 19:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbYL3AG3
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 19:06:29 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:33247 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751825AbYL3AG3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 19:06:29 -0500
Received: from jidanni.org (122-127-33-187.dynamic.hinet.net [122.127.33.187])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 6EF3DD2722;
	Mon, 29 Dec 2008 16:05:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104141>

JCH> $ wget http://article.gmane.org/gmane.comp.version-control.git/104017/raw
JCH> $ git apply raw
JCH> error: diff-options.txt: No such file or directory
JCH> $ echo $?
JCH> 1
$ cd Documentation
$ git apply ../raw
$ echo $?
0
So then one thinks "why of course, the changes we already applied."
However if one makes some sneaky changes:
$ diff ../raw.original raw
46c46
< index 5721548..b05503a 100644
---
> index 6721548..c05503a 100644
70c70
< +-w::
---
> +-w::ZZZZZZZZZZZZZZZZZZ
One gets the same $?=0. git apply should scream instead of silently
returning 0 and doing nothing. git version 1.6.0.6.
