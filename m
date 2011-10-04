From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion: offer references for 'git reflog'
Date: Tue, 04 Oct 2011 10:05:55 -0700
Message-ID: <7v7h4kd6vg.fsf@alter.siamese.dyndns.org>
References: <4E7F05A6.30505@elegosoft.com> <4E8AC85A.2070009@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 19:06:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB8RU-0007gJ-0v
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 19:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932974Ab1JDRF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 13:05:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50054 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932791Ab1JDRF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 13:05:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C71074459;
	Tue,  4 Oct 2011 13:05:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IROv4ZHMm5ZntMb2MU/9OAo9uBw=; b=JDkGND
	VP8sPozl0BabakCWuGswfItDHZBwh1TCy11i0Va/AGO/XYAIrxAxgKfq91BdqGvU
	3A6PQrQGDZION1Lnle21/+5cJVYfF5uNksx6nzolr1+gNQzSajS7FqisPjj+Z58t
	KTRntK9SkmXjHp7pL8qDDOJJN5OqLMdYM86MU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TjQelYHRi2MwDc330ht/EEBXoSnVJ9qk
	8yBqHO7UbQKlvUbaxx3S7sqrH+f492cCMtxk+zckZKfbreeTWyqtES1hrs34H/4F
	jasUu2aFcaE6VW/c+WMcZ827lOyJZygTgH2jcZ3X6xQa8PMj4+uFuCJaKeGPwJ6W
	ORHJf6vrf/Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE23C4458;
	Tue,  4 Oct 2011 13:05:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37BB64456; Tue,  4 Oct 2011
 13:05:57 -0400 (EDT)
In-Reply-To: <4E8AC85A.2070009@elegosoft.com> (Michael Schubert's message of
 "Tue, 04 Oct 2011 10:48:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2073BB20-EEAB-11E0-97CA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182777>

Michael Schubert <mschub@elegosoft.com> writes:

> On 09/25/2011 12:42 PM, Michael Schubert wrote:
>> 'git reflog <ref>' is a valid command, therefore offer reference
>> completion.
>> 
>> Signed-off-by: Michael Schubert <mschub@elegosoft.com>
>> ---
>>  contrib/completion/git-completion.bash |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 8648a36..63d0f08 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1774,7 +1774,7 @@ _git_reflog ()
>>  	local subcommand="$(__git_find_on_cmdline "$subcommands")"
>>  
>>  	if [ -z "$subcommand" ]; then
>> -		__gitcomp "$subcommands"
>> +		__gitcomp "$subcommands $(__git_refs)"
>>  	else
>>  		__gitcomp "$(__git_refs)"
>>  	fi
>
> Ping.?

Personally I think this change will give much less pleasant user
experience.  This is what I currently get:

    $ git reflog <TAB>
    delete  expire  show
    $ git reflog

and after learning the "show" subcommand exists, this is what I would get:

    $ git reflog show <TAB>
    Display all 626 possibilities? (y or n)

With your change, I would get:

    $ git reflog <TAB>
    Display all 629 possibilities? (y or n)

and do not even have a chance to remind myself if the subcommand to drop
a reflog was "delete" or "remove".

At least when I know that I want to be reminded of refs to $verb (use one
of the three subcommands I currently get in place of the "$verb"), I can
say

    $ git reflog $verb <TAB>

and at that point, I am willing to wade thru list of 600+ refs.
