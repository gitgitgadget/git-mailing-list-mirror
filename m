From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fix misleading error message after 'exec
 no-such' instruction
Date: Tue, 18 Sep 2012 13:29:20 -0700
Message-ID: <7vtxuvkrbz.fsf@alter.siamese.dyndns.org>
References: <505857CE.3050909@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 22:29:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE4QG-0005hA-1v
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 22:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097Ab2IRU3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 16:29:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33058 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755044Ab2IRU3X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 16:29:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 298588AE3;
	Tue, 18 Sep 2012 16:29:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZJNmbPbOClzeTk9glDcYhvCVeLk=; b=DF6uPZ
	7SBmHD32dZuVOw8PJRT0bfmuCMuALu8pamTkVMCYinYpWgPmtDYp5GtBdGb94OB/
	9j9RCaXduDQbGSILtvObagLp9ubmw8I3xymLPqxXq0QbK/l/RE2Rr6XFZS6hkxgq
	0ZV9FGgguXZIyWFJ7ofqtUWzDo8tQ18tknsas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tomn9vzmRVXRmioZuaPvtBYaC4JNN091
	rAhuJ3ZnTiM5cnER7gAcGRreneN949il1f9DPCkkN9EURfXjBCGb+VXvzhrR/Ug9
	H9lCh4t1smSEFmlQnwoeTqA1g4/CkGXCRh/yqSp2nxOBfeDQaM1QVUZLykoWTj3+
	p/xgm94Vp4M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1701F8AE2;
	Tue, 18 Sep 2012 16:29:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8291F8AE1; Tue, 18 Sep 2012
 16:29:21 -0400 (EDT)
In-Reply-To: <505857CE.3050909@viscovery.net> (Johannes Sixt's message of
 "Tue, 18 Sep 2012 13:15:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 875D40DA-01CF-11E2-A589-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205867>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> When the todo sheet of interactive rebase instructs to run a non-existing
> command, the operation stops with the following error:
>
>   Execution failed: no-such
>   You can fix the problem, and then run
>
>           git rebase --continue
>
>   fatal: 'rebase' appears to be a git command, but we were not
>   able to execute it. Maybe git-rebase is broken?
>
> The reason is that the shell that attempted to run the command exits with
> code 127. rebase--interactive just forwards this code to the caller (the
> git wrapper). But our smart run-command infrastructure detects this
> special exit code and turns it into ENOENT, which in turn is interpreted
> by the git wrapper as if the external command that it just executed did
> not exist.

That's a funny one ;-)
Will queue.  Thanks.
