From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] git-cherry-pick: add allow-empty option
Date: Tue, 10 Apr 2012 13:32:44 -0700
Message-ID: <7v8vi3pbtf.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-2-git-send-email-nhorman@tuxdriver.com>
 <7v62d7qzu9.fsf@alter.siamese.dyndns.org>
 <20120410181317.GA17776@hmsreliant.think-freely.org>
 <7vfwcbpem5.fsf@alter.siamese.dyndns.org>
 <20120410200019.GC17776@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 22:32:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHhkE-0001TR-8j
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 22:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757314Ab2DJUct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 16:32:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43897 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757233Ab2DJUcs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 16:32:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 448D66E33;
	Tue, 10 Apr 2012 16:32:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hBZ+qNBHgXakz88ojYN20Ep4gTw=; b=QBBc++
	N2r/Wx++tVYU8yeIhKVc4r+K8+Vp4jXvZyB7R1zmRFTu6rp/QRFOIWBEIltb0G9A
	mPd8YT4CCrO5TaD6CBjW2pLn6odXdJqN350F1MC6SH+otieyWFR2zQ9wpgqQiNzA
	5UIXcNaWUP2LxJZTdl0cJ8nqA1283xPhx9SSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YC7kGH8PpWVSfGt6KYbt9/GkGkYW7wU2
	sf4Fle5WjL2VhWk+f9taBlUd5I0RSzTV0XIlI5qODZFoVVuYe8qh86st01h3Q/OZ
	gI1W8lipEkNfXXzalv0dQCWtr784Kk5qNDVZVbCyZgjO0+hGXuwuX98WMht06p3f
	7erUEEyurz8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B7466E32;
	Tue, 10 Apr 2012 16:32:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 590976E30; Tue, 10 Apr 2012
 16:32:46 -0400 (EDT)
In-Reply-To: <20120410200019.GC17776@hmsreliant.think-freely.org> (Neil
 Horman's message of "Tue, 10 Apr 2012 16:00:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54F2849A-834C-11E1-8947-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195127>

Neil Horman <nhorman@tuxdriver.com> writes:

> On Tue, Apr 10, 2012 at 12:32:18PM -0700, Junio C Hamano wrote:
>> Neil Horman <nhorman@tuxdriver.com> writes:
>> 
>> > On Tue, Apr 10, 2012 at 09:45:46AM -0700, Junio C Hamano wrote:
>> > ...
>> >>  (2) The message is given by the "git commit" command.  "If the commit was
>> >>      created empty" looks confusing.  Even though I can understand that
>> > Its coded within the git commit command code, but is only ever displayed if
>> > whence is GIT_CHERRY_PICK, so as far as I can see, from a users perspective,
>> > this will only be seen if they type git cherry-pick on the command line.
>> 
>> Here is what I tried, and I think you are wrong.
>> 
>> 	$ git cherry-pick $some_commit
>>         ... conflicts ...
>>         $ edit so that the working tree matches HEAD
>>         $ git commit -a
>>         ... message from status ...
>>         THE ADVICE IN QUEWSTION COMES HERE!!!
>> 
>> 
> Ok, I admit I didn't really think of that case, but that seems to me to be the
> trivial case, which is unlikely to be encountered.  If you do a git cherry-pick and
> have conflicts, you by definition don't have a commit that is resolved to empty...

Not at all unlikely, especially in a distributed world.

You may have seen two patches but they make sense as one so that you apply
to one branch as one change, while the branch you are cherry-picking from
may have these two changes as individual commits.  Neither of them will
apply cleanly to your tree, and your resolution will be "keep mine---I
already have this".
