From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] stash: It looks like a stash, but doesn't quack
 like a stash...
Date: Wed, 04 Aug 2010 16:31:37 -0700
Message-ID: <7v1vaeeyzq.fsf@alter.siamese.dyndns.org>
References: <1280831775-30759-1-git-send-email-jon.seymour@gmail.com>
 <1280831775-30759-2-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ams@toroid.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 01:32:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgnRa-00018b-4Z
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 01:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759463Ab0HDXcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 19:32:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404Ab0HDXcM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 19:32:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E79AA516;
	Wed,  4 Aug 2010 19:32:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gfSQw7rFAhyuHnXM3Qrp+IyckhU=; b=xFHWjM
	PSiES2HqKvRt4bJzbsIWBjEHfzaM0IXsZEuUH2e+lHZnH/gr3HcxDiF/HB6qo2Im
	C06BlDleYm0uWRSuMp6DwiCcZboMRj5GhKcMrzMUY8eyzMCOrPFYJRtVjhvyIFLn
	ZB/SyfANM7WMdVB7p8n0UtoXPT90xJLLtzanc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xcFQXvJicvmas1ro8FRFApqpBRgOrnCM
	MhQe9EmEc73sFTGql79wbBpVGPgVxVVGZzx6ksdl0Hb+XN4qKIF+hH6ujxgbcro+
	cAtxlc9upuoVCVoSfghN/o/mxjtVy3kmDLJOE/4CW87jgLkJXYiIAQ16BIcSI2fh
	HxYu/bDo0Nk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 25A57507;
	Wed,  4 Aug 2010 19:31:57 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A4C14F4; Wed,  4 Aug
 2010 19:31:39 -0400 (EDT)
In-Reply-To: <1280831775-30759-2-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Tue\,  3 Aug 2010 20\:36\:13 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 791D3114-A020-11DF-8FBD-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152610>

Jon Seymour <jon.seymour@gmail.com> writes:

> In particular, a stash created with git stash create cannot be used as
> an argument to git stash branch because of two separate reasons.
>
> 1. a pre-condition assumes that there is always a stash on the stack when git stash branch is called,
> which is not necessarily true
>
> 2. the cleanup code assumes the specified stash is a stash reference, rather than an arbitrary commit.

Hmm, I don't use the command myself so I ended up reading the description
of "stash branch".  To me it is clear that it wants to use a stash entry,
not just an arbitrary stash-looking commit, from "... then drops the
<stash>".

So I wouldn't call these tests "expect-failure"; rather, I would suggest
swapping the order of patches so that they test the new feature that
allows "git stash branch" to take an arbitrary stash-looking commit.

The documentation also needs to be updated to make the "then drops" part
conditional (perhaps "then drops...if the stash was on the list").

Are there any other stash subcommand that ought to be able to act on a
stash-looking commit but doesn't, or is "branch" the only one?
