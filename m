From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log: teach --invert-grep option
Date: Tue, 13 Jan 2015 10:25:00 -0800
Message-ID: <xmqqfvbeedxf.fsf@gitster.dls.corp.google.com>
References: <xmqq61cjo6lq.fsf@gitster.dls.corp.google.com>
	<1421112812-13578-1-git-send-email-ottxor@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christoph Junghans <ottxor@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 19:25:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB69X-0008LW-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 19:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbbAMSZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 13:25:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753337AbbAMSZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 13:25:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B39A62C7A5;
	Tue, 13 Jan 2015 13:25:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s71o1OOwVWceYWtX6r9OE0iSgww=; b=nWN5iH
	tfkGb4FBg2vv3EFooTZq7fx+AdqeXPTX6qrdm3b1d3GorEX6sYjxYqZ1C5a6hj1h
	oUXNudm8AEJsEkISsMDdo66gbws9ITU1s10h48VGbJtIkO3eTW2MoTWUeBjNRkbS
	LlP09uEQbok0525sRWt3Drhkm1xd0+Z4pNjHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bOg/Kx+Alk5LHE5YKKhnbHq55cJm3ezL
	dZ0/7idUvgTUOgCid57GbaPczUaoPYX/UZVRahaKcyN3YQAxDEyXrDhXNspyIZvO
	OmQ6pjsy0fEKXEUujGF+ZhtrtyZEVtEbILpyVSTG2YUPCzMxbluHJHm02WteRra5
	Moj/OHF/olM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A9DC72C7A4;
	Tue, 13 Jan 2015 13:25:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0833B2C79E;
	Tue, 13 Jan 2015 13:25:01 -0500 (EST)
In-Reply-To: <1421112812-13578-1-git-send-email-ottxor@gentoo.org> (Christoph
	Junghans's message of "Mon, 12 Jan 2015 18:33:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7D0B57FC-9B51-11E4-BC6F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262344>

Christoph Junghans <ottxor@gentoo.org> writes:

> "git log --grep=<string>" shows only commits with messages that
> match the given string, but sometimes it is useful to be able to
> show only commits that do *not* have certain messages (e.g. "show
> me ones that are not FIXUP commits").
>
> Originally, we had the invert-grep flag in grep_opt, but because
> "git grep --invert-grep" does not make sense except in conjunction
> with "--files-with-matches", which is already covered by
> "--files-without-matches", it was moved it to revisions structure.
> To have the flag there expresses the function to the feature better.
>
> When the newly inserted two tests run, the history would have commits
> with messages "initial", "second", "third", "fourth", "fifth", "sixth"
> and "Second", committed in this order.  The commits that does not match
> either "th" or "Sec" is "second" and "initial". For the case insensitive
> case only "initial" matches.

I see you moved the two bits meant only to be useful during the
review to the commit message proper.  The reason why I omitted the
"Originally, ..." part was because those who are reading "git log
-p" output would not know what the earlier draft had.

I do not mind it either way, though, so let's take this version.

However, I'd have to drop gitk-git/ bit; that part of the tree is
maintained separately and comes from Paul's gitk repository.  I'll
forward only that part of the patch to him when this feature
graduates to 'master'.

Thanks.
