From: Sam Vilain <sam@vilain.net>
Subject: is git-unpack-objects now redundant for 'git-push' and friends?
Date: Wed, 11 Oct 2006 02:23:52 +1300
Message-ID: <452B9EE8.5020702@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 10 15:24:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXHam-00041y-UV
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 15:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWJJNYR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 09:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWJJNYR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 09:24:17 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:52449 "EHLO
	magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S1750741AbWJJNYO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 09:24:14 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 2B6791380D8; Wed, 11 Oct 2006 02:24:12 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id D1C411380C2
	for <git@vger.kernel.org>; Wed, 11 Oct 2006 02:24:01 +1300 (NZDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28630>

When pushing or pulling to/from a repository, why unpack the objects?
Why not just fsck and then throw the pack into $GIT_DIR/objects/pack?

If you're pushing the entire repository, for instance, currently you
might create 10,000's of files, which will just be thrown away later
when you `git-repack -d'.

I suspect that this was never changed, because there never used to be
more than one packfile allowed, correct?

If the server *does* send us duplicates of objects we already have for
some reason, well that's what `git-repack -a -d' is for.

I'm just wondering if there are any good reasons to do this any more.

Sam.
