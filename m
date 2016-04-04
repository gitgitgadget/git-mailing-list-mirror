From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Out Of Place Capitalization In Stash Feedback
Date: Mon, 04 Apr 2016 10:50:40 -0700
Message-ID: <xmqq8u0t5klr.fsf@gitster.mtv.corp.google.com>
References: <CAE3c8OtZx33q+gsYFgq9Rn9EtEAnSREkxL9TkTOK_n489Yh+Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Saxon Knight <knight.saxon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 19:50:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an8eG-0007VB-Ks
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 19:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741AbcDDRuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 13:50:44 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751902AbcDDRun (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 13:50:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 92FFF4F7D3;
	Mon,  4 Apr 2016 13:50:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qu0yURWLKzbQgaym3Wv7hj4xM6Q=; b=XBbOs6
	D4fwt92I60iMBbS6b9lZKq6ZM+MEv4EO5kDJphf3V/GemaX86gu5TXMElG4s07Lo
	CJlb2uQRmbmzXGAwRLWVB4yzXAmYp1Abn6kBy82ZcflA7J9s3Yk4u8r4Arj1WOZt
	hJpXipWw2yrEJ9VmP0kVfPMsh9yi4S1rzAqTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O0nfm/xWqlGzM8tC0dRDwbSNoWJrd3a9
	/W+1J9v3gwzi84XJ5AcPIzawsF0Fcl/N6Uw3jLMSL3X3GDAmQu8bi5+RsRaZaV2h
	YPfb9X0TVU/DFm9W560TbL6GOjvPNzJSipqPBe+7K+Ikp/bqoWuLtmXw7QMY4PSz
	wJ8L/LBuJZ8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 89BE14F7D2;
	Mon,  4 Apr 2016 13:50:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F0CF84F7CD;
	Mon,  4 Apr 2016 13:50:41 -0400 (EDT)
In-Reply-To: <CAE3c8OtZx33q+gsYFgq9Rn9EtEAnSREkxL9TkTOK_n489Yh+Ww@mail.gmail.com>
	(Saxon Knight's message of "Sun, 3 Apr 2016 12:09:14 -1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BFCE67F4-FA8D-11E5-A327-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290710>

Saxon Knight <knight.saxon@gmail.com> writes:

> I recently did a git stash save "working on main", and in the
> feedback, I noticed that "On" was capitalized ("...state On
> master...").
> I don't think this is intentional, so I figured I'd try to let someone know.
>
> Here is the output (quotes included by me):
>
> "Saved working directory and index state On master: working on main"

"git stash list" at this point would show

    stash@{0}: On master: working on main

In other words, the title of the stash entry is "On master: working
on main", and that is what is shown in the feedback.

I guess the output could quote the title in quotes to avoid this
puzzlement, i.e.

    Saved working directory and index state 'On master: working on main'

 git-stash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index c7c65e2..6d8eb22 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -266,7 +266,7 @@ save_stash () {
 	create_stash "$stash_msg" $untracked
 	store_stash -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
-	say Saved working directory and index state "$stash_msg"
+	say "Saved working directory and index state '$stash_msg'"
 
 	if test -z "$patch_mode"
 	then
