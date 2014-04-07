From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: explicitly specify that HEAD is a revision
Date: Mon, 07 Apr 2014 15:37:27 -0700
Message-ID: <xmqqioqklqag.fsf@gitster.dls.corp.google.com>
References: <20140407131911.GB17654@ixro-vdogaru.ixiacom.com>
	<20140407220916.GA3635@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vlad Dogaru <vdogaru@ixiacom.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 00:37:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXIAZ-0000OI-RJ
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 00:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336AbaDGWha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 18:37:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58890 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755034AbaDGWha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 18:37:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4EE07C29B;
	Mon,  7 Apr 2014 18:37:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lIbdz136xY0JPWXgI9qWHEWQrRk=; b=WjN+ba
	NgBQs5k81phmqr14uSI9pHKvI916qhXs+jto/70iRUF6KvcXqR0MZNz+KjFxhoOm
	NxV+E9U8L8Dxq4RKiALNRzQ6EKJtkDCSTt+6BtqhowEzOIUSDPLJlmyNB36TKXod
	XouO9EaATdzL+xlpKGHLFHdNlFbeBer4mD/f8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kZg5wQk2EO1Z4WCYqhH0OmX7fovqeHVh
	MzVYSgivCpOWUCybXe6ewhbLa0cSSnjt3WcjDMYkXoNpTnNots/Nm2mQkA/ZPytb
	Yz6NcgnagUKE84qr3V43BMA1x/99semyZ9tEHGhYJhazK2MuzuQrRpGH9s3V/sVz
	dOG823JYI+A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A13617C29A;
	Mon,  7 Apr 2014 18:37:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF9037C296;
	Mon,  7 Apr 2014 18:37:28 -0400 (EDT)
In-Reply-To: <20140407220916.GA3635@padd.com> (Pete Wyckoff's message of "Mon,
	7 Apr 2014 18:09:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 33176660-BEA5-11E3-8517-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245912>

Pete Wyckoff <pw@padd.com> writes:

> vdogaru@ixiacom.com wrote on Mon, 07 Apr 2014 16:19 +0300:
>> 'git p4 rebase' fails with the following message if there is a file
>> named HEAD in the current directory:
>> 
>> 	fatal: ambiguous argument 'HEAD': both revision and filename
>> 	Use '--' to separate paths from revisions, like this:
>> 	'git <command> [<revision>...] -- [<file>...]'
>> 
>> Take the suggestion above and explicitly state that HEAD should be
>> treated as a revision.
>> 
>> Signed-off-by: Vlad Dogaru <vdogaru@ixiacom.com>
>
> This looks obviously good to me, thanks!
>
> Junio, could you carry it into the next release?  As a trivial
> fixup.
>
> Acked-by: Pete Wyckoff <pw@padd.com>

Thanks; will apply directly on 'master'.

>
>> ---
>>  git-p4.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/git-p4.py b/git-p4.py
>> index cdfa2df..8d11b25 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -3086,7 +3086,7 @@ class P4Rebase(Command):
>>          print "Rebasing the current branch onto %s" % upstream
>>          oldHead = read_pipe("git rev-parse HEAD").strip()
>>          system("git rebase %s" % upstream)
>> -        system("git diff-tree --stat --summary -M %s HEAD" % oldHead)
>> +        system("git diff-tree --stat --summary -M %s HEAD --" % oldHead)
>>          return True
>>  
>>  class P4Clone(P4Sync):
>> -- 
>> 1.8.5.2
>> 
>> 
