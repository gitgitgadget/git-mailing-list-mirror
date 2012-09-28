From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/21] git p4: work on cygwin
Date: Fri, 28 Sep 2012 12:17:40 -0700
Message-ID: <7vr4pmkld7.fsf@alter.siamese.dyndns.org>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 21:18:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THg4Y-000752-5z
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 21:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030718Ab2I1TRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 15:17:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030690Ab2I1TRo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 15:17:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ADEA8127;
	Fri, 28 Sep 2012 15:17:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X5HOrGLvkPs7RKVfGCHouCjiQzQ=; b=v35JKy
	rUUZw2nYAIIayAB5FCh9QsXSqy805MfSMKhqXt/dTngD2eTeD8vsOmtHx9Y6BqSG
	wFkFB93vvGmKqmhAU4Hh5MFzW8lUDfXwNmuejfu/QhpsqicNX9ojUOi0e3sxncCk
	4Qzs4A1KJInnWqPj4bxn97qfdfWCFbL71R7AM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gO/w5H6JsDKP/gxnvs+/molaMrAZdazn
	8sJtrg5GUfDVv2djfrq1WCKZHzAFOESDbV7jCbEydYVqLa+wBVX2PAKucM6Tih63
	J7pICTucnJxEumuIZkZ4hrsct1lCxbcW+3I4A6OZaPYWVw1qB2PMR205omceozTn
	mw7SKfihbS8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB9938126;
	Fri, 28 Sep 2012 15:17:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C5A88125; Fri, 28 Sep 2012
 15:17:42 -0400 (EDT)
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com> (Pete Wyckoff's
 message of "Fri, 28 Sep 2012 08:04:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2CF562EC-09A1-11E2-B7F1-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206596>

Pete Wyckoff <pw@padd.com> writes:

> This series fixes problems in git-p4, and its tests, so that
> git-p4 works on the cygwin platform.
>
> See the wiki for info on how to get started on cygwin:
>
>     https://git.wiki.kernel.org/index.php/GitP4
>
> Testing by people who use cygwin would be appreciated.  It would
> be good to support cygwin more regularly.  Anyone who had time
> to contribute to testing on cygwin, and reporting problems, would
> be welcome.
>
> There's more work requried to support msysgit.  Those patches
> are not in good enough shape to ship out yet, but a lot of what
> is in this series is required for msysgit too.
>
> These patches:
>
>     - fix bugs in git-p4 related to issues found on cygwin
>     - cleanup some ugly code in git-p4 observed in error paths while
>       getting tests to work on cygwin
>     - simplify and refactor code and tests to make cygwin changes easier
>     - handle newline and path issues for cygwin platform
>     - speed up some aspects of git-p4 by removing extra shell invocations
>
> Pete Wyckoff (21):
>   git p4: temp branch name should use / even on windows
>   git p4: remove unused imports
>   git p4: generate better error message for bad depot path
>   git p4: fix error message when "describe -s" fails
>   git p4 test: use client_view to build the initial client
>   git p4 test: use client_view in t9806
>   git p4 test: start p4d inside its db dir
>   git p4 test: translate windows paths for cygwin
>   git p4: remove unreachable windows \r\n conversion code
>   git p4: scrub crlf for utf16 files on windows
>   git p4 test: newline handling
>   git p4 test: use LineEnd unix in windows tests too
>   git p4 test: avoid wildcard * in windows
>   git p4: cygwin p4 client does not mark read-only
>   git p4 test: disable chmod test for cygwin
>   git p4: disable read-only attribute before deleting
>   git p4: avoid shell when mapping users
>   git p4: avoid shell when invoking git rev-list
>   git p4: avoid shell when invoking git config --get-all
>   git p4: avoid shell when calling git config
>   git p4: introduce gitConfigBool

Very nicely done.  I was impressed how easy to understand what the
problem each patch attempts to solve is and how it should be solved
only from the description and the changes apparently matched the
description.

I wish patches from everybody looked like these.
