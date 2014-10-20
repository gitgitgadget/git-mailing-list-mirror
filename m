From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Copy mergetool "bc3" as "bc4"
Date: Mon, 20 Oct 2014 11:40:23 -0700
Message-ID: <xmqqfvei37qg.fsf@gitster.dls.corp.google.com>
References: <1413803017-30489-1-git-send-email-ocroquette@free.fr>
	<xmqq7fzu4rve.fsf@gitster.dls.corp.google.com>
	<xmqqtx2y3avx.fsf@gitster.dls.corp.google.com>
	<54455334.8000503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Olivier Croquette <ocroquette@free.fr>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 20:40:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgHse-0004ZG-S1
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 20:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbaJTSk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 14:40:28 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751181AbaJTSk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 14:40:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EA09167E1;
	Mon, 20 Oct 2014 14:40:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/yBs10oHNTytAIBAdqvCXNfpfRY=; b=tGTtkp
	c5O5NiPozO5dMcIJMSmUUU5/W7Ta64KAESrG/9SHo6M5z4n9K/LmFu0VDu5zWVZV
	5S1jBQAz8e0vEjDXDmO9nrtg90CCnnjDlldp4tpszM+GShOhc1/950EjOxMmlUrP
	0lWhAEJHMkk6eCO7E76bSgyCP1VnyqcSNSwus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SZt6xT4Fm8u5FsQrwUxUfx9oQpXzI1qw
	CDFpQo8nWSDRcVZPKbSp4e1RtTji+vQn5Y0rv10ebJyVseHY1Ic1xO7oLqyYfh2k
	aEw+2yA1LQ1SVFpVnFZenSlEOY2umbEekJkqgL+Y/jSjJ7gXwzlqaR0CTecxO+0C
	bCdobBq+YOw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 35A05167E0;
	Mon, 20 Oct 2014 14:40:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FC90167DE;
	Mon, 20 Oct 2014 14:40:24 -0400 (EDT)
In-Reply-To: <54455334.8000503@gmail.com> (Sebastian Schuberth's message of
	"Mon, 20 Oct 2014 20:23:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8DE511D2-5888-11E4-846C-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Schuberth <sschuberth@gmail.com> writes:

>> Perhaps something like this, so that existing users can still use
>> "bc3" and other people can use "bc" if it bothers them that they
>> have to say "3" when the backend driver works with both 3 and 4?
>
> That indeed sounds like the best approach.
>
>> --- a/git-mergetool--lib.sh
>> +++ b/git-mergetool--lib.sh
>> @@ -250,7 +250,7 @@ list_merge_tool_candidates () {
>>   			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
>>   		fi
>>   		tools="$tools gvimdiff diffuse diffmerge ecmerge"
>> -		tools="$tools p4merge araxis bc3 codecompare"
>> +		tools="$tools p4merge araxis bc bc3 codecompare"
>
> Why keep bc3 here?

I didn't carefully look at the code that uses this list to see if we
have to list everything or can list just the ones we recommend, and
erred on the safer side (unlike the one for completion where I
omitted bc3 as "deprecated").

I'll let mergetools experts decide when rolling the final patch ;-)

> And shouldn't we update git-gui/lib/mergetool.tcl, too?

Yes we should, but git-gui is not in my bailiwick, and shouldn't be
done relative to my tree anyway.  I'll Cc this message to Pat.

Thanks.
