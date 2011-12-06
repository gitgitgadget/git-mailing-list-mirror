From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Tue, 06 Dec 2011 10:35:25 -0800
Message-ID: <7vhb1dh7ki.fsf@alter.siamese.dyndns.org>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
 <20111206055239.GA20671@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 06 19:35:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXzra-0003k3-4P
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 19:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab1LFSf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 13:35:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36047 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565Ab1LFSf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 13:35:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96A9950A5;
	Tue,  6 Dec 2011 13:35:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IX0oh77eSt5y43kTcOgNMl9noAc=; b=Vf9Maa
	iDlqyc0wVFY8bYpfWvHcmSLvyYTRVMLNYvDG6k9Xxqk3936yLFISbjfV9lSyBtmQ
	HhZx23H9xz5MgyyzEP0dKYQ2wH6uunRBgiIs9mC8J4IMCy7G7EHHefNQmIVohGVl
	+224rpuABrqIBRCu3VaRqRnmx1JDHQobBlZw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jfk1mONgowd0wrNIMiJneHIFD+AOiyr+
	+2V7P1ughQ5irqxEZxxhAw08SVNq9IOmptS5U4F3BDzjFoXGaxTW2e4P2YkzoAeo
	0kI2yeT/5WstZzlfIB30AsgIQQXPR2lRY3HGNhY+CJQj8pJTBgn8Jmfbp8gr9qNs
	uxUGb7sUEm0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D6B050A4;
	Tue,  6 Dec 2011 13:35:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA40D50A3; Tue,  6 Dec 2011
 13:35:26 -0500 (EST)
In-Reply-To: <20111206055239.GA20671@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 6 Dec 2011 00:52:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 110BFB24-2039-11E1-BBB4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186366>

Jeff King <peff@peff.net> writes:

> Also, let's drop the top git_getpass bits from the topic for now (they
> will not be part of my rebase). They are a separate topic that can go on
> top, but I think there was some question from Erik of whether we should
> simply roll our own getpass().

Sounds sensible.

I suspect that there may be a codepath where we could ask both username
and password; instead of making two consecutive calls to getpass() or
git_prompt(), the series may want to give a higher level abstraction, so
that GUI can show a dialog with two input fields (single-line input and
password input) and interact only once with the user. Such an input widget
could _show_ the username, and optionally even let it edited (there may be
ramifications depending on how the codepath uses the username), while
asking for the corresponding password.

>> * jk/maint-1.6.2-upload-archive (2011-11-21) 1 commit
>>  - archive: don't let remote clients get unreachable commits
>>  (this branch is used by jk/maint-upload-archive.)
>> 
>> * jk/maint-upload-archive (2011-11-21) 1 commit
>>  - Merge branch 'jk/maint-1.6.2-upload-archive' into jk/maint-upload-archive
>>  (this branch uses jk/maint-1.6.2-upload-archive.)
>> 
>> Will merge to 'next' after taking another look.
>
> Thanks. I also have some followup patches to re-loosen to at least
> trees reachable from refs. Do you want to leave the tightening to the
> maint track, and then consider the re-loosening for master?

I was planning to first have the really tight version graduate to 'master'
and ship it in 1.7.9, while possibly merging that to 1.7.8.X series. If we
hear complaints from real users in the meantime before or after such
releases, we could apply loosening patch on top of these topics and call
them "regression fix", but I have been assuming that nobody would have
been using this backdoor for anything that really matters.
