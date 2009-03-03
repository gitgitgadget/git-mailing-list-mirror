From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git filter-branch: Process commits in --date-order
Date: Mon, 02 Mar 2009 16:51:50 -0800
Message-ID: <7vbpsjl97d.fsf@gitster.siamese.dyndns.org>
References: <1236035454-12236-1-git-send-email-peda@lysator.liu.se>
 <alpine.DEB.1.00.0903030126530.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Rosin <peda@lysator.liu.se>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 01:53:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeIt3-0008Hl-VZ
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 01:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbZCCAwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 19:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbZCCAwF
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 19:52:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbZCCAwE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 19:52:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8CD8A2BD3;
	Mon,  2 Mar 2009 19:52:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DBA8A2BD2; Mon, 
 2 Mar 2009 19:51:57 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0903030126530.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 3 Mar 2009 01:28:10 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 81B6247A-078D-11DE-B503-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111985>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 3 Mar 2009, Peter Rosin wrote:
>
>> When converting an svn repository to git, I am filtering the commits
>> using --msg-filter. During this conversion I want to use the
>> .git-rewrite/map data to fill in references to other commits. In the
>> svn repo, there is a commit message e.g. "Cherry-pick r207", and I
>> want to append "r207 = <commit>" to the git commit message, as r207
>> no longer means very much. This works fine when the git commit
>> corresponding to r207 has been filtered before the current commit, and
>> is present in the map. When filtering in --topo-order, this is not
>> always the case, making it impossible to look up the git commit.
>
> I'd rather have this as an option.  God knows what breaks with time-skewed 
> repositories if you use date-order instead of topo-order, and I'd rather 
> not break that not quite uncommon case.

I am wondering if it even makes sense to allow users to disable
topological ordering.

Doesn't filter-branch have the same "child commits build on top of parent
commits" dependency as fast-export has?  And didn't you guys fix
fast-export recently?
