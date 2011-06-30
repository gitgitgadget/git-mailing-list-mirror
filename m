From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should 'git status' understand a .git containing "gitdir: dir"?
Date: Thu, 30 Jun 2011 08:49:00 -0700
Message-ID: <7vsjqrqpzn.fsf@alter.siamese.dyndns.org>
References: <4E0C3C1D.1050406@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 17:49:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcJUM-0006P2-NH
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 17:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360Ab1F3PtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 11:49:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab1F3PtD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 11:49:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F50C5602;
	Thu, 30 Jun 2011 11:51:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VXy4S7U1PyCBscAelWcfqg29Ex8=; b=TLZaiU
	vCD1n/9GTdxqWY0ItfaWonanJC3kzsQqk5Hpk5CtUcr+OKntduOPDGyQlgMvW1W5
	31v0ss94w4qKY7vfQwRy20ngpnCRaP0VOXluw+xm11RfaW1L+/mv0voF8zBnYsOk
	5Fq66xFouhhGplZx9JxI7beavHvVXT6Nn7KQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hcraqhYWjoKdNAJbjQUJ1seSgo7hEn4D
	le/xE6Qzp8etx2coVmS7rgxbmGl4LLTqZ8QcgWH0mrbNEjzsMNWDWuaEy+dVWlSO
	UJCSOQpDg1yhrx0FS/gzkHGijw9IBRzjXewSmn85T0QAHEov5KD8kWo3XUx3zlMI
	Z2xlea19ptM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 58CA55601;
	Thu, 30 Jun 2011 11:51:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AB3345600; Thu, 30 Jun 2011
 11:51:16 -0400 (EDT)
In-Reply-To: <4E0C3C1D.1050406@nextest.com> (Eric Raible's message of "Thu,
 30 Jun 2011 02:04:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA315CA6-A330-11E0-916A-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176488>

Eric Raible <raible@nextest.com> writes:

> The following sequence sets up a trivial repo that uses "gitdir:":
>
> $ git init gitdir-test
> $ cd gitdir-test
> $ mv .git real-git-dir
> $ echo "gitdir: real-git-dir" > .git
> $ git status
>
> Fine so far.  But git-status shows that "real-git-dir" is untracked:
>
> $ git status -sb
> ## Initial commit on master
> ?? real-git-dir/
>
> Which strikes one as a bit inconsistent (since other pars of git-status
> knows to look in real-git-dir to find the index).
>
> Sorry - no time to investigate.

You could even have a real git dir of some completely unrelated repository
in your working tree, it will get reported as untracked, and you would
probably not want to track its contents, either (or you might want to if
you are trying to be funny, I dunno).

So I do not see there is anything to investigate. What you observed looks
perfectly expected to me, except for the "mv .git real-git-dir" bit that
makes a situation that confuses yourself (but not git).
