From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Notes in format-patch
Date: Tue, 13 Nov 2012 08:56:35 -0800
Message-ID: <7vzk2le918.fsf@alter.siamese.dyndns.org>
References: <50A0B896.8050700@drmicha.warpmail.net>
 <a35a8f44b908bded0b475b02e7917011fb3bf90b.1352728712.git.git@drmicha.warpmail.net> <50A2213B.4060505@drmicha.warpmail.net> <7vhaotfou6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 17:56:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYJnA-000184-0V
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 17:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070Ab2KMQ4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 11:56:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754907Ab2KMQ4h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 11:56:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EAEEAF95;
	Tue, 13 Nov 2012 11:56:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y8Y6ueZEJklW76qQhCB36GvYd9k=; b=lCq5bu
	t58wWA+/X8IqAS8fBTJngvlUwHe/QjvTeTYBQm1dUJYErETQEbYswhxGaKKkqA+m
	Rk12VuXyNJablGejqywyGPbAZDbxqNx07/2nkXkehosn68VbEL3mJ2gqYM32M4XH
	BwRlMs2ntz+vHDHZUuCSLaZ9n7Ncz/LTkGCFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k/vEEbPDP5IGyAdmpyJgQEsm5BwhKwwe
	PAI6V5jJtVggJKS2G3HeiqAxmPTJGKFDpoZ+Kf1hMUeUg+Be/6AlJPbmbrMFgqjo
	qfNduhWeefYXoEJqB0eEBE0CuLt/Cn4jONe1HgEpGfCtwNGl0yLu2KuKHc45D8Kp
	gXUHSM+duRY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D012AF93;
	Tue, 13 Nov 2012 11:56:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D966EAF92; Tue, 13 Nov 2012
 11:56:36 -0500 (EST)
In-Reply-To: <7vhaotfou6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 13 Nov 2012 08:29:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 162D17F4-2DB3-11E2-BE1F-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209640>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> Michael J Gruber venit, vidit, dixit 12.11.2012 15:18:
>>> 'git replace' parses the revision arguments when it creates replacements
>>> (so that a sha1 can be abbreviated, e.g.) but not when deleting
>>> replacements.
>>> 
>>> Make it parse the argument to 'replace -d' in the same way.
>>> 
>>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>>> ---
>>> 
>>> Notes:
>>>     v3 safeguards the hex buffer against reuse
>>>  builtin/replace.c  | 16 ++++++++++------
>>>  t/t6050-replace.sh | 11 +++++++++++
>>>  2 files changed, 21 insertions(+), 6 deletions(-)
>>> 
>>> diff --git a/builtin/replace.c b/builtin/replace.c
>>
>> By the way - Junio, is that the intented outcome of "format-patch
>> --notes"? I would rather put the newline between the note and the
>> diffstat...
>
> I do not mind (actually I personally would prefer to see) a blank
> line between the three-dash and "Notes:", but I agree that we should
> have a blank line before the diffstat block.

As the topic seems to be already in Peff's next, here is a trivial
fix for this in incremental form.

-- >8 --
Subject: format-patch: add a blank line between notes and diffstat

The last line of the note text comes immediately before the diffstat
block, making the latter unnecessarily harder to view.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 log-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git i/log-tree.c w/log-tree.c
index 712a22b..9303fd8 100644
--- i/log-tree.c
+++ w/log-tree.c
@@ -683,6 +683,7 @@ void show_log(struct rev_info *opt)
 			opt->shown_dashes = 1;
 		}
 		strbuf_addstr(&msgbuf, ctx.notes_message);
+		strbuf_addch(&msgbuf, '\n');
 	}
 
 	if (opt->show_log_size) {
