From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2011, #05; Fri, 14)
Date: Sun, 16 Oct 2011 10:17:10 -0700
Message-ID: <7vvcrorh49.fsf@alter.siamese.dyndns.org>
References: <7vd3dzximu.fsf@alter.siamese.dyndns.org>
 <20111016165329.GA14226@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 16 19:22:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFUPq-00088B-Bc
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 19:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835Ab1JPRRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 13:17:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38550 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754751Ab1JPRRR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 13:17:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7582D5F50;
	Sun, 16 Oct 2011 13:17:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W/U9uTwrY/2lw6mwLqV9acXAHas=; b=a4rbjd
	d7/tdJV3NNnrcEmnybrOK+ftxONkiJY9lH+TfzHUc4HErtnWrBR5aiHVx0osnT9K
	/QYWDkNYVG7GB6cKg25sHi2bz9ZYz90zBBTTQV4YZYL68piKGHp/ewQHty8zeLvo
	0zG3xBGmTm7r/Ob3Pu+bqD9r6QZszDR0xqkrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M2Me0ZciMBJdriTgOv4Kw/WNtmAGgV+l
	tsaKwmFnJi6qUCxyZW8ImU7R0m9tDRstL7uRtONCw5P/lKRC3IoAtKaieMEQsw5e
	blZsglCS2bleNrKyosagy/Rb0c8F2iUnNFD+p+p1TLWj3ectzPEdfINUn/caePfI
	fh7ExOPc5zg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D5E95F4F;
	Sun, 16 Oct 2011 13:17:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0035C5F4E; Sun, 16 Oct 2011
 13:17:15 -0400 (EDT)
In-Reply-To: <20111016165329.GA14226@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 16 Oct 2011 12:53:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1FD240A-F81A-11E0-BE8F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183727>

Jeff King <peff@peff.net> writes:

> On Fri, Oct 14, 2011 at 04:23:21PM -0700, Junio C Hamano wrote:
>
>> * jk/pull-rebase-with-work-tree (2011-10-13) 1 commit
>>  - pull,rebase: handle GIT_WORK_TREE better
>> 
>> Looked reasonable.
>> Will merge to 'next'.
>
> I'm not so sure. Didn't you demonstrate that cd_to_toplevel as-is will
> not actually go to the toplevel if we're outside of the work tree?
>
> And changing it is non-trivial, because there may be weird cases that
> rely on staying there? See my final note in the thread:
>
>   http://article.gmane.org/gmane.comp.version-control.git/183519

Hmm, I might be mistaken, but my impression was that sane people do not do
so, that the discussion that originated this proposed patch was not such a
use case, and most importantly that fixing unsane ones is just the matter
for them to set GIT_WORKING_TREE correctly. So if anything, wouldn't
getting this in as early as possible to 'master' or at least 'next' help
catching a flaw in the above logic and possible downside in the real
world?

>> * jk/daemon-msgs (2011-10-14) 1 commit
>>  - daemon: give friendlier error messages to clients
>> 
>> Will merge to 'next'.
>
> I'm happy to tweak the "access denied" message if other people want. I
> kind of hoped it wouldn't matter, and that most sites would use
> --informative-errors.

I've already updated it with the "not exported" bit from Sitaram.

Thanks.
