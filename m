From: Junio C Hamano <gitster@pobox.com>
Subject: Interim "What's cooking"
Date: Wed, 10 Feb 2016 15:43:11 -0800
Message-ID: <xmqqsi10xhbk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 00:43:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTePn-0002nQ-74
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 00:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbcBJXnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 18:43:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750728AbcBJXnO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 18:43:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A3A3444E2B;
	Wed, 10 Feb 2016 18:43:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=9
	CEJ9wgqIfKFFT6Pt0LqfXpEzqI=; b=JI7jQzfL2AfcAV31fAkx2ERlFgfD3mQDj
	avfbTt88k6Hxstj7uOJFJgANB4CkhPrGZ5qvDGyIhNfQR+CJPFjiIJjt0Z7WqAhJ
	wNd22VwMpUdn6vmAKeGn/vHvsnnivNvxLUYMi19Xp928UqHaEWC7tXWImiFYIOyg
	GNDdLUXZ6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=GE/
	Hf+5WnS51vnIQv7ACYALx9dR4U3VKjUWR/bsialW84/UgImAv3HYZ6bupyfyKAFt
	yARL/CcdBdhWMDmA4rNFbDbheDbBDe1CsCPDVdJqPQ+HkdtyBI7X489KIyNogtnN
	lAF0Uqra1fpeKmbp63Zw7JNxelVQLXWfTrwsWFGs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A07044E2A;
	Wed, 10 Feb 2016 18:43:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1A84044E29;
	Wed, 10 Feb 2016 18:43:13 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C8DC822-D050-11E5-B17F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285941>

In today/tonight's pushout, the 'master' branch will have these
topics merged.

Thanks for contributing ;-)


[Graduated to "master"]

* aw/push-force-with-lease-reporting (2016-02-01) 1 commit
  (merged to 'next' on 2016-02-03 at facd28f)
 + push: fix ref status reporting for --force-with-lease

 "git push --force-with-lease" has been taught to report if the push
 needed to force (or fast-forwarded).


* cc/untracked (2016-01-27) 11 commits
  (merged to 'next' on 2016-02-01 at 8203631)
 + t7063: add tests for core.untrackedCache
 + test-dump-untracked-cache: don't modify the untracked cache
 + config: add core.untrackedCache
 + dir: simplify untracked cache "ident" field
 + dir: add remove_untracked_cache()
 + dir: add {new,add}_untracked_cache()
 + update-index: move 'uc' var declaration
 + update-index: add untracked cache notifications
 + update-index: add --test-untracked-cache
 + update-index: use enum for untracked cache options
 + dir: free untracked cache when removing it

 Update the untracked cache subsystem and change its primary UI from
 "git update-index" to "git config".


* ew/connect-verbose (2016-01-28) 1 commit
  (merged to 'next' on 2016-02-03 at ceac37e)
 + pass transport verbosity down to git_connect

 There were a few "now I am doing this thing" progress messages in
 the TCP connection code that can be triggered by setting a verbose
 option internally in the code, but "git fetch -v" and friends never
 passed the verbose option down to that codepath.

 There was a brief discussion about the impact on the end-user
 experience by not limiting this to "fetch -v -v", but I think the
 conclusion is that this is OK to enable with a single "-v" as it is
 not too noisy.


* jk/options-cleanup (2016-02-01) 6 commits
  (merged to 'next' on 2016-02-03 at a78d89d)
 + apply, ls-files: simplify "-z" parsing
 + checkout-index: disallow "--no-stage" option
 + checkout-index: handle "--no-index" option
 + checkout-index: handle "--no-prefix" option
 + checkout-index: simplify "-z" option parsing
 + give "nbuf" strbuf a more meaningful name

 Various clean-ups to the command line option parsing.


* js/test-lib-windows-emulated-yes (2016-02-02) 1 commit
  (merged to 'next' on 2016-02-03 at bf6b42c)
 + test-lib: limit the output of the yes utility

 The emulated "yes" command used in our test scripts has been
 tweaked not to spend too much time generating unnecessary output
 that is not used, to help those who test on Windows where it would
 not stop until it fills the pipe buffer due to lack of SIGPIPE.


* js/xmerge-marker-eol (2016-01-27) 2 commits
  (merged to 'next' on 2016-02-01 at 05d91a4)
 + merge-file: ensure that conflict sections match eol style
 + merge-file: let conflict markers match end-of-line style of the context

 The low-level merge machinery has been taught to use CRLF line
 termination when inserting conflict markers to merged contents that
 are themselves CRLF line-terminated.


* ls/clean-smudge-override-in-config (2016-01-29) 1 commit
  (merged to 'next' on 2016-02-03 at 5962354)
 + convert: treat an empty string for clean/smudge filters as "cat"

 Clean/smudge filters defined in a configuration file of lower
 precedence can now be overridden to be a pass-through no-op by
 setting the variable to an empty string.


* nd/do-not-move-worktree-manually (2016-01-22) 2 commits
  (merged to 'next' on 2016-01-26 at c539221)
 + worktree: stop supporting moving worktrees manually
 + worktree.c: fix indentation

 "git worktree" had a broken code that attempted to auto-fix
 possible inconsistency that results from end-users moving a
 worktree to different places without telling Git (the original
 repository needs to maintain backpointers to its worktrees, but
 "mv" run by end-users who are not familiar with that fact will
 obviously not adjust them), which actually made things worse
 when triggered.


* wp/sha1-name-negative-match (2016-02-01) 2 commits
  (merged to 'next' on 2016-02-03 at 89fa5ef)
 + object name: introduce '^{/!-<negative pattern>}' notation
 + test for '!' handling in rev-parse's named commits

 A new "<branch>^{/!-<pattern>}" notation can be used to name a
 commit that is reachable from <branch> that does not match the
 given <pattern>.
