From: Junio C Hamano <gitster@pobox.com>
Subject: Re: patch-2.7.3 no longer applies relative symbolic link patches
Date: Tue, 27 Jan 2015 12:39:11 -0800
Message-ID: <xmqqa914klg0.fsf@gitster.dls.corp.google.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	<xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Tue Jan 27 21:39:21 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YGCut-0000jX-QX
	for glk-linux-kernel-3@plane.gmane.org; Tue, 27 Jan 2015 21:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772AbbA0UjP (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 27 Jan 2015 15:39:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932613AbbA0UjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2015 15:39:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0512C32218;
	Tue, 27 Jan 2015 15:39:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=io1GcQnBtA8KUgA5olOrlf7J9Rg=; b=mE6zM9
	LFAz7FoEjeoMFjkhcrXw+VdJtQCtAJ9h+7g9kJfJVDeMBNlCNXFkOp/5CaBe9Uul
	1IkDp4Xfil0phbM8LjSVgBWgiHPO5b7ChrLkilnBlnkch5SmCCb7fulIXKnb6VJC
	lLhiisjMRO5261/ZpVbKUvmrA77xx6LTbYlwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bHy3zc3fSp0BG/dN2aiBEYBzhBZwWPeN
	NyIhHkznvh/yxTmzSZ7lWerbDVMm292hpK5nTO6IAH8JlXZIMarlvF2sNQGUl23e
	wA7c/WrrDk1OLhAi1tkA5/AIoeg7/WXEMTSVMXGt5yS3VURvX0s4EMn7h31bQxuB
	Rd9o9qD07cE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ECD8332217;
	Tue, 27 Jan 2015 15:39:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5624D32213;
	Tue, 27 Jan 2015 15:39:12 -0500 (EST)
In-Reply-To: <xmqqzj94lx7z.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 26 Jan 2015 19:27:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8D3A71E4-A664-11E4-B9F6-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263089>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> Ugh. I don't see anything we can do about this on the git side, and I
>> do kind of understand why 'patch' would be worried about '..' files.
>> In a perfect world, patch would parse the filename and see that it
>> stays within the directory structure of the project, but that is a
>> rather harder thing to do than just say "no dot-dot files".
>
> It is unclear to me why "limit to the current directory and below"
> is such a big deal in the first place.
>
> If the user wants to apply a patch that touches ../etc/shadow, is
> the tool in the place to complain?"

Let me take this part back.

I think "git apply" should behave closely to "git apply --index"
(which is used by "git am" unless there is a very good reason not to
(and "'git apply --index' behaves differently from GNU patch, and we
should match what the latter does" is not a very good reason).  When
the index guards the working tree, we do not follow any symlink,
whether the destination is inside the current directory or not.

I however do not think the current "git apply" notices that it will
overwrite a path beyond a symlink---we may need to fix that if that
is the case.  I'll see what I can find (but I'll be doing 2.3-rc2
today so it may be later this week).

Thanks.
