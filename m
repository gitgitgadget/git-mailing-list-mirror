From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Modified the default git help message to be grouped by
 topic
Date: Tue, 02 Dec 2008 16:10:07 -0800
Message-ID: <7vfxl6m84g.fsf@gitster.siamese.dyndns.org>
References: <20081201173037.GA41967@agadorsparticus>
 <20081201183258.GB24443@coredump.intra.peff.net>
 <7v7i6jqriv.fsf@gitster.siamese.dyndns.org>
 <d411cc4a0812012210h4cb59974sbda71abd2c64f93b@mail.gmail.com>
 <885649360812021211u3d547982i8e1c3070972363e8@mail.gmail.com>
 <alpine.DEB.1.00.0812022353410.27091@racer>
 <20081202233004.GA22379@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	James Pickens <jepicken@gmail.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 01:11:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7fL7-0000JE-8J
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 01:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbYLCAKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 19:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753771AbYLCAKU
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 19:10:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbYLCAKT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 19:10:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 817E517F99;
	Tue,  2 Dec 2008 19:10:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0817117F95; Tue, 
 2 Dec 2008 19:10:08 -0500 (EST)
In-Reply-To: <20081202233004.GA22379@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 2 Dec 2008 18:30:04 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C3686226-C0CE-11DD-9841-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102191>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 02, 2008 at 11:55:03PM +0100, Johannes Schindelin wrote:
>
>> If the whole thing gets longer than 24 lines, we have to leave some things 
>> out.  Personally, I consider rm and mv unimportant enough that they could 
>> be shown in an extended list, but be left out of the summary page.
>
> For the record, the current output is 26 lines, plus you probably want
> to account for 1 line of the user's next shell prompt. So we are 3 lines
> over already.
>
> Scott's proposal is about grouping the commands more sensibly. Many of
> the complaints are about the length of the output. Maybe we should scrap
> having a list of commands altogether and just point at section-specific
> documentation, each of which could discuss basic commands related to it.
>
> I think there has been mention of task-oriented documentation pointers
> before, and I think this is a place where we would want it.

It might not be a bad idea to make this "top page help" into an
interactive hierarchical help topic browser.  You would start a page that
might look like this:

    Bootstrapping -- preparing an area to work in
        init, clone
    Basic -- review, undo and record your changes
        diff, status, checkout <path>, add, reset, commit
    History -- inspect what you have now, and what happened before
        log, blame, grep, show
    Branching and Merging -- build and use alternate histories
	branch, checkout -b, merge, rebase
    Working with Others
	remote, fetch, pull, push

with each of the command and the heading being a "link" (use ncurses for
that).  If you choose the leaf-level command (say, 'diff'), you will get
the git-diff(1) manual page.  If you pick one of the headings, say,
"Basic", you may get a more extended description of commands in the
category, that may include other basic commands not in the front page,
perhaps, like this:

    (review)
    diff HEAD: view what you did since the last commit
    diff: view what you did since you last added
    diff --cached: view what you already added
    status: list what are added and changes yet to be added

    (undo)
    checkout path...: checkout a copy from the staging area
    checkout HEAD path...: checkout a copy from the last commit
    reset: undo earlier "git add" to the staging area
    reset path...: do so only for the named paths

    (record)
    mv path1 path2: move the state of path1 to path2
    rm path2: remove path2
    rm --cached path2: do so without losing the copy in the working tree
    add: add the contents to the staging area
    add -p: do so interactively, hunk by hunk
    commit: record the changes you added to the staging area
    commit path...: record all the changes to the paths, ignoring
    	changes you added to the staging area for other paths.

and again each element can be a "link".
