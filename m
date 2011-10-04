From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [PATCH] git-completion: offer references for 'git reflog'
Date: Tue, 04 Oct 2011 21:34:25 +0200
Message-ID: <4E8B5FC1.3080902@elegosoft.com>
References: <4E7F05A6.30505@elegosoft.com> <4E8AC85A.2070009@elegosoft.com> <7v7h4kd6vg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 21:35:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBAlo-0002JW-Pu
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 21:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933217Ab1JDTfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 15:35:10 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:54978 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932752Ab1JDTfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 15:35:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id CD6EDDE7D3;
	Tue,  4 Oct 2011 21:35:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O1urUC4TJU9P; Tue,  4 Oct 2011 21:35:04 +0200 (CEST)
Received: from [192.168.1.101] (g230120021.adsl.alicedsl.de [92.230.120.21])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id CD73EDE7D7;
	Tue,  4 Oct 2011 21:35:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20111001 Thunderbird/7.0.1
In-Reply-To: <7v7h4kd6vg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182790>

On 10/04/2011 07:05 PM, Junio C Hamano wrote:
> Michael Schubert <mschub@elegosoft.com> writes:
> 
>> On 09/25/2011 12:42 PM, Michael Schubert wrote:
>>> 'git reflog <ref>' is a valid command, therefore offer reference
>>> completion.
>>>
>>> Signed-off-by: Michael Schubert <mschub@elegosoft.com>
>>> ---
>>>  contrib/completion/git-completion.bash |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>>> index 8648a36..63d0f08 100755
>>> --- a/contrib/completion/git-completion.bash
>>> +++ b/contrib/completion/git-completion.bash
>>> @@ -1774,7 +1774,7 @@ _git_reflog ()
>>>  	local subcommand="$(__git_find_on_cmdline "$subcommands")"
>>>  
>>>  	if [ -z "$subcommand" ]; then
>>> -		__gitcomp "$subcommands"
>>> +		__gitcomp "$subcommands $(__git_refs)"
>>>  	else
>>>  		__gitcomp "$(__git_refs)"
>>>  	fi
>>
>> Ping.?
> 
> Personally I think this change will give much less pleasant user
> experience.  This is what I currently get:
> 
>     $ git reflog <TAB>
>     delete  expire  show
>     $ git reflog
> 
> and after learning the "show" subcommand exists, this is what I would get:
> 
>     $ git reflog show <TAB>
>     Display all 626 possibilities? (y or n)
> 
> With your change, I would get:
> 
>     $ git reflog <TAB>
>     Display all 629 possibilities? (y or n)

Yeah, that would be a tradeoff. IMHO the current behaviour is pleasant
for newcomers, but (I guess) most users would rather enjoy "the short form".

> and do not even have a chance to remind myself if the subcommand to drop
> a reflog was "delete" or "remove".
> 
> At least when I know that I want to be reminded of refs to $verb (use one
> of the three subcommands I currently get in place of the "$verb"), I can
> say
> 
>     $ git reflog $verb <TAB>
> 
> and at that point, I am willing to wade thru list of 600+ refs.
