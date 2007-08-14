From: Thomas Gleixner <tglx@linutronix.de>
Subject: bisect / history preserving on rename + update
Date: Tue, 14 Aug 2007 10:38:01 +0200
Message-ID: <1187080681.12828.174.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 14 10:38:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKrvA-0003eX-21
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 10:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbXHNIiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 04:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490AbXHNIiH
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 04:38:07 -0400
Received: from www.osadl.org ([213.239.205.134]:54283 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753506AbXHNIiD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 04:38:03 -0400
Received: from [127.0.0.1] (debian [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id B34EA65C3EA
	for <git@vger.kernel.org>; Tue, 14 Aug 2007 10:38:01 +0200 (CEST)
X-Mailer: Evolution 2.10.1 (2.10.1-4.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55814>

Hi,

is there a built in way to handle the following situation:

file A is renamed to B
file A is created again and new content is added.

I found only two ways to do that, which both suck:

1)
	git-mv A B
	git-add A
	git commit

	results in a copy A to B and lost history of B

2)
	git-mv A B
	git commit
	git-add A
	git commit

	preserves the history of B, but breaks bisection because
	A is needed to compile

I have no real good idea how to solve this. After staring at the git
source for a while, I think that 1) is quite hard to solve. A sane
solution for 2) might be to add a flag to the second commit, which
bundles the two commits for bisection.

Any other solutions ?

	tglx
