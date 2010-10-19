From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [BUG] git repack fails if .git/objects/pack is on a separate
 partition
Date: Tue, 19 Oct 2010 00:29:23 -0700 (PDT)
Message-ID: <1287473363910-5649843.post@n2.nabble.com>
References: <1287469706023-5649732.post@n2.nabble.com> <201010190859.43098.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 19 09:29:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P86db-0007xJ-PB
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 09:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758070Ab0JSH32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 03:29:28 -0400
Received: from kuber.nabble.com ([216.139.236.158]:33900 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239Ab0JSH31 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 03:29:27 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <marat@slonopotamus.org>)
	id 1P86dP-0007aQ-Ta
	for git@vger.kernel.org; Tue, 19 Oct 2010 00:29:23 -0700
In-Reply-To: <201010190859.43098.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159309>




> What's your git version?
> 
1.7.3.1



> It should only create and rename
> files within the pack/ subdirectory.
> 
It should, yep, but it doesn't.


Which is what you are implying
> in the above snippet, but this should never result in a cross-device
> rename, so maybe I'm missing something.
> 
That rename call attempts to put file in _current_ directory.

Proof:
mkdir foo && touch foo/bar && strace mv foo/bar baz 2>&1 | grep rename
outputs rename("foo/bar", "baz")


-- 
View this message in context: http://git.661346.n2.nabble.com/BUG-git-repack-fails-if-git-objects-pack-is-on-a-separate-partition-tp5649732p5649843.html
Sent from the git mailing list archive at Nabble.com.
