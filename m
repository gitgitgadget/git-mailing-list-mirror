From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log: invert --author and --committer
Date: Mon, 23 May 2016 12:26:05 -0700
Message-ID: <xmqq37p8a84y.fsf@gitster.mtv.corp.google.com>
References: <CAP=KgsSdX3pCRzeUVobrFWVGOGGSrwkO0MjFhUWruiajAxn38Q@mail.gmail.com>
	<xmqqmvngaedn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Mon May 23 21:26:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4vUV-00008N-Mc
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 21:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbcEWT0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 15:26:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55817 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751459AbcEWT0J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 15:26:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A8891C77A;
	Mon, 23 May 2016 15:26:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3rzaWlcokKW54ZXwczeH2iG53ms=; b=UqnNeR
	jPRK5YzoOPu7uW/m+8MR8YAyep0h82w2OLDoMY6LkwXtVTRWxBq5dbivsO6I5RhO
	SRuY6hpOe7SJBKFq5MZegIex3ggtdhAzY8Hm2LV4qnGd5bQ6QXHiLfQSMKzBoQBc
	VKPXtwH6ssh6Qu5eGBpizwI5WCu3qtRGS6jSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=snSbQXbFvCjzdVr8p2xIz1Iv6825SbLb
	bpOJRHDEiR2T1WBXNpBuH6gC55xmduIxOH9Egt/N+Ctp4lx9nXP1E+B0pbHn1JNS
	nIKzwl+V1+uppsRUsAQX3jueuWfs3VadUire0PfYAuFvTB/yZ9DTby9d3dT622Bn
	7brOOGvRGBs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 721AD1C779;
	Mon, 23 May 2016 15:26:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2E691C778;
	Mon, 23 May 2016 15:26:06 -0400 (EDT)
In-Reply-To: <xmqqmvngaedn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 May 2016 10:11:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 32612158-211C-11E6-87C4-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295353>

Junio C Hamano <gitster@pobox.com> writes:

> Per Cederqvist <cederp@opera.com> writes:
>
>>     git log --invert-grep --author cibot
>...
> Yeah, the author/committer search piggy-backs the more generic "grep
> in the log" machinery, but it is quite hidden and the document
> failed to tell the end users that is what is going on.  Mentioning
> that invert (or any tweak that works on the grep machinery) affects
> author/committer search is a good idea.
>
> Does "-i/--regexp-ignore-case" also need the same treatment?

It seems it does.

How about making this clarification not about --invert-grep but
about --committer/--author option, perhaps like this?

 Documentation/rev-list-options.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 4f009d4..3fca366 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -44,6 +44,10 @@ endif::git-rev-list[]
 	expression).  With more than one `--author=<pattern>`,
 	commits whose author matches any of the given patterns are
 	chosen (similarly for multiple `--committer=<pattern>`).
++
+Options that affect how a regular expression match is performed
+(such as `-i`, `-E`, `--invert-grep`) can also be used affect these
+options.
 
 --grep-reflog=<pattern>::
 	Limit the commits output to ones with reflog entries that
