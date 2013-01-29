From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Tue, 29 Jan 2013 08:15:15 -0800
Message-ID: <7vsj5krmng.fsf@alter.siamese.dyndns.org>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <7v38xm12kk.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7sQKDNPpaFJi+en479TF=aLXL2pvXODeo6CC3xD1KMGw@mail.gmail.com>
 <7vr4l6yrd3.fsf@alter.siamese.dyndns.org>
 <CAJDDKr75K3RGgU79nrznbpjQMLQGkDs=W8XEofURNsS1X1bvjg@mail.gmail.com>
 <20130128210136.GC7498@serenity.lan>
 <7vk3qxugdg.fsf@alter.siamese.dyndns.org>
 <20130128222147.GD7498@serenity.lan> <ke8de9$lk5$1@ger.gmane.org>
 <20130129120923.GE7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joachim Schmitz <jojo@schmitz-digital.de>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jan 29 17:15:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0DqY-00010F-Py
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 17:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650Ab3A2QPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 11:15:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52735 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809Ab3A2QPT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 11:15:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A6DCCC37;
	Tue, 29 Jan 2013 11:15:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qU0wAwbYfaPtO9INbEFekwQ3NdE=; b=CypKtv
	XAHW9OB8Nk0OO1vb2X9E25CRNE0IwkFYZtK6kn5AnmMnXSTimerCY0JI4/jKeML0
	uruEHwhn3YFN7zOf7Q0p6C3QbMwAw1bLrY+0c18u73ol2RU7KuYDOQzcHLP6zlhj
	sN3VhD2PGXu0/fws0nFNPMpfy+A0/r+/BHm0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mLDgoGJQAknN20xf9ZyacmDOE6dkQIA4
	ic3DsUWZNQobVzPum642koS2HCLd4UdmYDwbLyKAXT5zz2LnvMAI8CBf0lva2/cf
	RupQLrdNWfdbfvGbNC9bEU8oPf22/Gi7Jzfb5v/1cgwNRiPEasnS0SoT/WjKaHFr
	9VzAFNQj7zU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F7A8CC36;
	Tue, 29 Jan 2013 11:15:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB11DCC34; Tue, 29 Jan 2013
 11:15:17 -0500 (EST)
In-Reply-To: <20130129120923.GE7498@serenity.lan> (John Keeping's message of
 "Tue, 29 Jan 2013 12:09:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12638050-6A2F-11E2-9794-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214943>

John Keeping <john@keeping.me.uk> writes:

> On Tue, Jan 29, 2013 at 12:56:58PM +0100, Joachim Schmitz wrote:
>> John Keeping wrote:
>> > Currently I'm extracting the command word using:
>> >
>> >    cmd=$(eval -- "set -- $(git config mergetool.$tool.cmd); echo
>> > \"$1\"")
>> 
>> Shouldnt this work?
>> cmd=$((git config "mergetool.$tool.cmd" || git config "difftool.$tool.cmd") 
>> | awk '{print $1}')
>
> That doesn't handle paths with spaces in, whereas the eval in a subshell
> does:
>
>     $ cmd='"my command" $BASE $LOCAL $REMOTE'
>     $ echo "$cmd" | awk '{print $1}'
>     "my
>     $ ( eval -- "set -- $cmd; echo \"\$1\"" )
>     my command

I'd rather not to see you do any of the above.

With any backend that is non-trivial, it would not be unusual for
the *tool.cmd to look like:

     [mergetool]
     	mytool = sh -c '
        	... some massaging to prepare the command line
                ... to run the real tool backend comes here, and
     		... then ...
                my_real_tool $arg1 $arg2 ...
	'

and you will end up detecting the presence of the shell, which is
not very useful.

I think it is perfectly fine to say "you configured it, so it must
exist; it may fail when we try to run it but it is your problem".
It is simpler to explain and requires one less eval.

        
                
