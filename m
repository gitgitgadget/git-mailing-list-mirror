From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Local unset override global options
Date: Mon, 12 Apr 2010 11:18:35 -0700
Message-ID: <7vvdbwk004.fsf@alter.siamese.dyndns.org>
References: <z2kfbd9d3991004092354y21d3ac3fgf1f0675cdb5c51a8@mail.gmail.com>
 <m3pr25f3ye.fsf@localhost.localdomain>
 <7v1vekn05h.fsf@alter.siamese.dyndns.org>
 <201004121902.08345.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Hajnoczi <stefanha@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 20:18:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1ODn-0008UB-Db
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 20:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab0DLSSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 14:18:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab0DLSSt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 14:18:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C849CAAA5C;
	Mon, 12 Apr 2010 14:18:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ShhHBm9ZDHguc6kyqbTClJ5T+sY=; b=sxgCBX
	TkzDOv6dHTVD5IWEBpKgcl9lKznrWI5EvRnig6EPbHsw2UAfLpfGMvyFhSv4vN4G
	OuYehg7Ps5ekD48g5zUFDnG0Ko1TTVNjW0KnZ6QbNXfjsxdlLRb788ghpOOAh200
	y84MnIUDzHqwxpn5c5Lfk0G83mlzuvS5id8eU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rAFASQ8nBJncJ989tEfKqNORda6Z8x0y
	yELhfn120fbbyM54HHs6ATRz0dRlBLceFLR3pctjMFcT1/wAcJ0oL+uiSqayWeWd
	l3f4tq3Sle3Le0iq2MvByY+W6L8KORSR9vU/2Jl9uuAb1FmTDwVINCbRpZtlbL/n
	McH/6tZfiTc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 801F8AAA36;
	Mon, 12 Apr 2010 14:18:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DCB7AAA27; Mon, 12 Apr
 2010 14:18:37 -0400 (EDT)
In-Reply-To: <201004121902.08345.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon\, 12 Apr 2010 19\:02\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3473AB0-465F-11DF-85AA-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144763>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>> > How does special case of no value, i.e.
>> >
>> >    [sendemail]
>> >         smtpuser
>> 
>> That is not a special case; that is "boolean true".
>
> Well, it is "boolean true" *if* git-config is used with '--bool'.
>
> If git-send-email.perl used "git config -l -z" to read all its config 
> variables at once into hash, like gitweb.perl does in the 
> git_parse_project_config() subroutine, it would be able to distinguish 
> between those the case of no value:
>
>     [sendemail]
>          smtpuser

If sendemail is ever re-written in C and use git_config() API, the above
will become boolean.  Besides, even if you are sticking to sendemail.perl
forever, you are still inventing another convention that "boolean true
means no I don't want it".  And it is clearly a lot less intuitive than
"empty means no I don't want it", isn't it?
