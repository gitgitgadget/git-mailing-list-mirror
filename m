From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/test-lib: print pretty msg when git isn't built
Date: Tue, 18 Sep 2012 01:00:17 -0700
Message-ID: <7vr4pzoj5a.fsf@alter.siamese.dyndns.org>
References: <1347901579-5545-1-git-send-email-artagnon@gmail.com>
 <1347901579-5545-2-git-send-email-artagnon@gmail.com>
 <7v7grstlp9.fsf@alter.siamese.dyndns.org>
 <CALkWK0k9P9-K5R2Amipujq2DFvJTXy8T3ZyfFa31CcxeKSFL2g@mail.gmail.com>
 <7v627bq0gx.fsf@alter.siamese.dyndns.org>
 <CALkWK0kbeLtU-5_9QnmQKS1yO02SvCW3ERvami9bmCa0Vym8oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:00:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDsjQ-0003Sw-TU
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 10:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab2IRIAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 04:00:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664Ab2IRIAV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 04:00:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7B094E0D;
	Tue, 18 Sep 2012 04:00:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vyVkb1tgo0qvF9U3OXHcah0fMv0=; b=YHdNH1
	mrRO84bgOjhLYr5Ap8pA8+WMUd4ozUd/69Q3HLLVNRJyMjBMrNgK/w39KGXcqB1N
	MzQMPYeSXyJAaaze7OXHM4Ok2UQTRBYOR3KCNbdBZ+GN70F92iPDVf99WEVXKPHf
	ypeSGKY7I0dDUX4Jn11kGEJ1vEk2lr21cp1CI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sxp6fzWv6CqiVPY2m5f8qnMBqM2ezumy
	hgA8ohevLJR7p5AjSdyqZ39cvsOetShIfXOvPkfrXYX5K/BPYog4hAYbSP7TGtBg
	E7AKBWltfanpoqQG7Ldl7YqAq8uMwxpsWJuHkhx9yHkpdG5nCCmd8aC64xhx3mzn
	GtzRdLMBW34=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B40C64E0C;
	Tue, 18 Sep 2012 04:00:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A4E64E0A; Tue, 18 Sep 2012
 04:00:18 -0400 (EDT)
In-Reply-To: <CALkWK0kbeLtU-5_9QnmQKS1yO02SvCW3ERvami9bmCa0Vym8oQ@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 18 Sep 2012 12:47:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E38D1114-0166-11E2-B0A8-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205809>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi,
>
> Junio C Hamano wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>>> Hi Junio,
>>>
>>> Junio C Hamano wrote:
>>>> Is this a sufficient replacement for what you removed from 0000?
>>>> Can the BUILD-OPTIONS file exist when your build of git failed?
>>>
>>> Oops, I didn't realize that BUILD-OPTIONS would be written when the
>>> build fails.  How about something like this instead:
>>
>> Yeah, but why change it so much?  Wouldn't writing
>>
>>         "$GIT_BUILD_DIR/git" >/dev/null
>>         if test $? != 1
>>         then
>>                 : You haven't built git!
>>         fi
>>
>> just like the original in 0000 be sufficient??
>
> Because that emits an ugly
> ./test-lib.sh: 54: /home/artagnon/src/git/t/../git: not found

Don't you deserve it? ;-)

The full message would read

    ./test-lib.sh: 54: /home/artagnon/src/git/t/../git: not found
    error: you do not seem to have built git yet.

which looks perfectly sensible to me.  It makes it clear where on
the filesystem the test script expects your "git", which is an added
benefit.
