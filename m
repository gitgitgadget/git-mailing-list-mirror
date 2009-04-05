From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-{diff,merge} refactor round 2
Date: Sun, 05 Apr 2009 02:45:53 -0700
Message-ID: <7vzlevv3fy.fsf@gitster.siamese.dyndns.org>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com>
 <200904050458.17708.markus.heidelberg@web.de>
 <20090405033443.GA16219@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	charles@hashpling.org, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 11:47:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqOx6-0007SC-83
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 11:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460AbZDEJqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 05:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756292AbZDEJqJ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 05:46:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100AbZDEJqG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 05:46:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 815B5A8E2D;
	Sun,  5 Apr 2009 05:46:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CDF5DA8E2C; Sun,
  5 Apr 2009 05:45:58 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 946C4524-21C6-11DE-ACAD-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115645>

David Aguilar <davvid@gmail.com> writes:

> On  0, Markus Heidelberg <markus.heidelberg@web.de> wrote:
>> David Aguilar, 01.04.2009:
>> > Here's the 2nd round of refactoring.
>> 
>> I just noticed that mergetool.<mergetool>.path doesn't work anymore.
>> git grep mergetool.*path only hits one line in git-difftool--helper.sh
>> Neither does it seem to work with difftool, but I'm gonna go to bed now.
>> 
>> Markus
>> 
>
> Oops.  Well, I have one final patch that removes the last bit of
> redundant code.  It also fixed this problem so I'll go ahead
> and send it (it's based on top of da/difftool mentioned in
> pu).
>
> Since the test cases didn't catch that breakage I added a test
> for it. 
>
> Look for a patch called:
>
> mergetool--lib: consolidate the last redundant bits in {diff,merge}tool

I'll try to queue all the outstanding da/difftool patches tonight, but I
think the patches in the series are getting to the point of needing a
fresh redoing.  Patches like "oops, these non-user scripts should have
been named with double-dash" can and should disappear.

Currently they are:

$ git log --oneline next..da/difftool
736e6b6 mergetool--lib: add new merge tool TortoiseMerge
b3ef7cc mergetool--lib: make (g)vimdiff workable under Windows
c4d690e mergetool--lib: consolidate the last redundant bits in {diff,merge}tool
def88c8 mergetool-lib: specialize opendiff options when in diff mode
bd52fab mergetool-lib: refactor run_mergetool and check_unchanged
e87266c bash completion: add git-difftool
04c3b54 {diff,merge}tool: rename helpers to remove them from tab-completion
2a83022 mergetool-lib: add diffuse as merge and diff tool
73c59d9 mergetool-lib: specialize xxdiff options when in diff mode
273e7a2 mergetool-lib: specialize kdiff3 options when in diff mode
99511d8 mergetool: use run_mergetool from git-mergetool-lib
37c48c7 difftool: use run_mergetool from git-mergetool-lib
4e314b5 mergetool-lib: introduce run_mergetool
588954e difftool: use valid_tool from git-mergetool-lib
8af4556 mergetool: use valid_tool from git-mergetool-lib
72286b5 difftool: use get_mergetool_path from git-mergetool-lib
d03b97f mergetool: use get_mergetool_path from git-mergetool-lib
c6afc72 Add a mergetool-lib scriptlet for holding common merge tool functions
6108b75 mergetool: use $( ... ) instead of `backticks`
73786e2 difftool: add support for a difftool.prompt config variable
472ff62 difftool: add a -y shortcut for --no-prompt
de2b85d difftool: use perl built-ins when testing for msys
9df990e difftool: add various git-difftool tests
8ac77f2 difftool: add git-difftool to the list of commands
