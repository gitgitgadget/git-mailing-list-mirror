From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] completion: clarify ls-tree, archive, show completion
Date: Mon, 03 Jun 2013 10:58:31 -0700
Message-ID: <7vobbnf54o.fsf@alter.siamese.dyndns.org>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
	<1370181822-23450-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:58:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjZ1i-0004qG-Ip
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883Ab3FCR6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:58:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57235 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368Ab3FCR6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 13:58:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41BFF2465F;
	Mon,  3 Jun 2013 17:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=icTIPVx+dongxL4lfkI4i13AzRs=; b=OvI6JX
	lnxQ+frnr2vy+XQNEcHzHELPUtVlKLVKfke3rlGGo0wSgnFo/uSOG/FKbjxSwqu+
	T4Ss3RQ1QI/Ct6O60fcxRf3hC/rxnPebx5MzathbZUM/5Ib63Q7Fa0PtDigmeqsx
	U6SGIlxSd7sZ1Jq1qaUiCoKq1c+uwd54vztzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dNVdjtC7/wa9Uk1MFzyb2HUH8fp0n4hN
	1eBrkX9h805iUJdhQIMHPXXSDLJZve/9JK4KvSTRJQcC9cCGQjyC1bjxg9SN3D9U
	prFsCfKjP+/5q0PF3ecKgMHTX704XyPIXSb+sX/MnJGQEqj774frROXZA+XZQmfh
	8FhKmC6ZNRk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 340C02465E;
	Mon,  3 Jun 2013 17:58:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 905592465C;
	Mon,  3 Jun 2013 17:58:32 +0000 (UTC)
In-Reply-To: <1370181822-23450-7-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 2 Jun 2013 19:33:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34599A14-CC77-11E2-95FB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226252>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Currently, the 'git ls-tree', 'git archive', and 'git show' completions
> use __git_complete_file (aliased to __git_complete_revlist_file).
>
> In the case of 'git ls-tree' and 'git archive', they necessarily require
> a tree-ish argument (and optionally a pathspec filter, or "file
> argument"):
>
>   $ git ls-tree hot-branch git.c
>   $ git archive HEAD~4 git.c
>
> So, __git_complete_file is a misleading name.
>
> In the case of 'git show', it can take a pathspec and default the
> revision to HEAD like:
>
>   $ git show git.c
>
> (which is useful if git.c was modified in HEAD)
>
> However, this usage is not idiomatic at all.

More idiomatic is after seeing "git show --stat" doing "git show dir/".

But I do not think it really matters.

Just like "diff" and "difftool", "show" optionally takes revs and
paths, and because the current completion code does not do anything
fancy like "we have seen enough revs and there will appear no revs
hence we only complete paths from here on", complete_revlist_file is
the right helper to use for all of them.
