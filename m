From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Where did Documentation/perf_counter disappear from
 linux-2.6-tip.git ?
Date: Tue, 22 Dec 2009 10:08:02 -0800
Message-ID: <7vmy1a3mrh.fsf@alter.siamese.dyndns.org>
References: <4B3099A5.6040808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 19:08:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN99d-0000aj-GI
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 19:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbZLVSIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 13:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbZLVSIM
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 13:08:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbZLVSIM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 13:08:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A5DE8AFF0;
	Tue, 22 Dec 2009 13:08:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dFvEWLwOXJ05V/bxuE9jplzHi0E=; b=V/aMHC
	vy7Wgy12TAr/QzLpeVXSttGq19bBdCtIbWQCtVx7ecabmYnSg9xzUCHOIg8afbI+
	Pe/ItTl8a3bHDTqm92pSnOJxmqPkO0Axoxpp1RngIu8CedWdmaWP9HDhzH2g5yuR
	pTEd4ziAwfXa2Vt5tTCZYY+RYqAl6gdhc3JqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZXWZ1a1U+KyAScVHjVYrNzXGhBLY7R+k
	+ptq6dU7tEaPyjP3ykJl8k8kcgVCP+zJS/+6Bxg2Z6BamciIq7KTKBdV2QyIueT8
	Hip0g5TJ8fXJRtoUSt8B3XJ1Z397O2NJ3L2eCITZwgY4NSgveav7RtMb5kIIRdcH
	fO1w1YXFhNs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1411D8AFEF;
	Tue, 22 Dec 2009 13:08:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32ED38AFEE; Tue, 22 Dec
 2009 13:08:04 -0500 (EST)
In-Reply-To: <4B3099A5.6040808@gmail.com> (Tomas Carnecky's message of "Tue\,
 22 Dec 2009 11\:04\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F4AB0584-EF24-11DE-BE3D-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135588>

Tomas Carnecky <tomas.carnecky@gmail.com> writes:

>  $ git --version
> git version 1.6.6.rc4
>
> # Documentation/perf_counter is missing from the master branch, so
> first let's find
> # out what the last commit was that touched that subdirectory:
> $ git log --all -1 -- Documentation/perf_counter
> commit 436224a6d8bb3e29fe0cc18122f8d1f593da67b8
> Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Date:   Tue Jun 2 21:02:36 2009 +0200
> ...
> M       Documentation/perf_counter/builtin-report.c
>
> # Great, let's look in which branch that commit is
> $ git branch --contains 436224a6d8bb3e29fe0cc18122f8d1f593da67b8
> * master
>
> # So, let's look at the log of master and limit it to that subdirectory:
> $ git log master -- Documentation/perf_counter
> $

Add --full-history so that you would get _all_ possible explanation of the
history, perhaps?

In a history with this shape:

    ---A---B---C---D---E
            \     /
             F---G

suppose that

 - commit F introduces a path;
 - commit G removes the path;
 - no other commit has the path in question.

Without --full-history, "log E -- path" is asked to give "_one_ possible
way to explain the current state of path in E" (iow, "why there is nothing
there right now at E?").

Two explanations are possible even in this vastly simplified toy history.

 - It didn't exist in A, and none of the subsequent commits B, C, D that
   lead to E did anything to change that.

 - F added it, but G changed mind and removed it.

When "log" encounters a merge commit while traversing the history
backwards (in this case D) with paths limiter, if there is a commit among
its parent whose tree matches its tree with respect to the paths, side
branches leading to all the other parents are culled and only that one
history is followed to explain the history.  In this case, neither C or D
has the path, so their trees with respect to the paths limiter match, and
git doesn't follow the side branch that has F and G without
--full-history.
