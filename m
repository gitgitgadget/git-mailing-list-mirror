From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: submodule: if $command was not matched, don't parse other args
Date: Mon, 24 Sep 2012 11:07:52 -0400
Message-ID: <50607748.6000204@xiplink.com>
References: <CALkWK0npySdS7FDt=6VKdtoNS2gqQH5WaTQ4H6TEmXdP9fuF=g@mail.gmail.com> <7v8vc13ilc.fsf@alter.siamese.dyndns.org> <505F489B.1000309@web.de>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 17:07:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGAGM-0000pm-Ca
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 17:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354Ab2IXPHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 11:07:48 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:59809 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756326Ab2IXPHq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 11:07:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp59.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 0A3523F0CB3
	for <git@vger.kernel.org>; Mon, 24 Sep 2012 11:07:46 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp138.ord.emailsrvr.com (smtp138.ord.emailsrvr.com [173.203.6.138])
	by smtp59.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTPS id DBF383F0C6D
	for <git@vger.kernel.org>; Mon, 24 Sep 2012 11:07:45 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp26.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 3F6FD1C00FD;
	Mon, 24 Sep 2012 11:07:11 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp26.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 941FD1C00A7;
	Mon, 24 Sep 2012 11:07:10 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <505F489B.1000309@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206283>

On 12-09-23 01:36 PM, Jens Lehmann wrote:
> Am 22.09.2012 22:31, schrieb Junio C Hamano:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>> diff --git a/git-submodule.sh b/git-submodule.sh
>>> index a7e933e..dfec45d 100755
>>> --- a/git-submodule.sh
>>> +++ b/git-submodule.sh
>>> @@ -1108,7 +1108,15 @@ do
>>>  done
>>>
>>>  # No command word defaults to "status"
>>> -test -n "$command" || command=status
>>> +if test -z "$command"
>>> +then
>>> +    if test $# = 0
>>> +    then
>>> +	command=status
>>> +    else
>>> +	usage
>>> +    fi
>>> +fi
>>
>> I personally feel "no command means this default" is a mistake for
>> "git submodule", even if there is no pathspec or other arguments,
>> but I am not a heavy user of submodules, so others should discuss
>> this.
> 
> The commit message of 97a5d8cce9 (git-submodule: re-enable 'status'
> as the default subcommand) back from 2007 indicates that Lars did
> back then think that "status" is a sane default. I agree with Junio
> that this is not optimal, but I'd rather tend to not change that
> behavior which has been there from day one for backward compatibility
> reasons. But if many others see that as an improvement too I won't
> object against changing it the way Ramkumar proposes (but he'd have
> to change the documentation too ;-).
> 
> Since diff and status learned to display submodule status information
> (except for a submodule being uninitialized) I almost never use this
> option myself, so I'd be interested to hear what submodule users who
> do use "git submodule [status]" frequently think.

I also almost never use "git submodule [status]", and I also agree that
git-submodule shouldn't have a default sub-command.

(Honestly, submodule's status sub-command has always felt more like plumbing
to me than something a user would work with directly.  Maybe it's just the
full-length SHA's that put me off...)

		M.
