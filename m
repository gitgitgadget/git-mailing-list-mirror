From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] tests: use "git xyzzy" form
Date: Wed, 03 Sep 2008 13:01:56 -0700
Message-ID: <7v8wu9athn.fsf@gitster.siamese.dyndns.org>
References: <20080903175925.6117@nanako3.lavabit.com>
 <48BE6D1F.1060603@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Sep 03 22:04:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaya7-0004dp-Nt
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 22:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbYICUCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 16:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbYICUCo
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 16:02:44 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbYICUCn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 16:02:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 16E9E72C1D;
	Wed,  3 Sep 2008 16:02:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EC64572C16; Wed,  3 Sep 2008 16:01:59 -0400 (EDT)
In-Reply-To: <48BE6D1F.1060603@op5.se> (Andreas Ericsson's message of "Wed,
 03 Sep 2008 12:55:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 431AF984-79F3-11DD-AD09-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94846>

Andreas Ericsson <ae@op5.se> writes:

> Nanako Shiraishi wrote:
>> These four patches update test scripts to use "git xyzzy" format so that
>> they can serve as sample usage for git commands better.
>>
>>  [PATCH 1/4] tests: use "git xyzzy" form (t0000 - t3599)
>>  [PATCH 2/4] tests: use "git xyzzy" form (t3600 - t6999)
>>  [PATCH 3/4] tests: use "git xyzzy" form (t7000 - t7199)
>>  [PATCH 4/4] tests: use "git xyzzy" form (t7200 - t9001)
>
> Are you absolutely 100% certain that what you're testing is still
> the files in the build directory after applying these patches?

Very good point, but that issue has been with us forever before these
patches, because many command invocations do use "git foo" form already.
t/test-lib.sh is supposed to make sure the tests do not refer to installed
git.

My primary development box does not have any git installed on the system
path, and I keep a bunch of installations with prefix=$HOME/git-$variant/
where $variant are master, next, maint, plus things like v1.3.0, v1.4.4.4,
etc.

$PATH begins with "/home/junio/gitstuff/bin:/home/junio/git-active/bin:"
before the usual /usr/bin:/bin and friends.  "gitstuff" has things like
stgit, guilt and tig but no git in it.  $HOME/git-active is a symbolic
link to point at a specific variant installed, usually 'next' but switched
to 'master' during the -rc cycle.

I created a copy of installation from git-master in git-dontuse, replaced
all git and git subcommands with this shell script, and pointed at it with
$HOME/git-active:

    #!/bin/sh
    echo "DO NOT USE ME"
    echo "DO NOT USE ME" >&2
    exit 1

The test passes, with or without these four patches.
