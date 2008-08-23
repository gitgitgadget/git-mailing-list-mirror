From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: [PATCH RESEND] Do not override LESS
Date: Sat, 23 Aug 2008 10:28:51 +0200
Message-ID: <87k5e8i18c.fsf@cup.kalibalik.dk>
References: <1219407912-32085-1-git-send-email-mail@cup.kalibalik.dk>
	<7vvdxs2t03.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 10:30:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWoVU-0003Se-QH
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 10:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbYHWI24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 04:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbYHWI2z
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 04:28:55 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:47420 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851AbYHWI2w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 04:28:52 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 292B114062;
	Sat, 23 Aug 2008 10:28:52 +0200 (CEST)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 03ACB1405A;
	Sat, 23 Aug 2008 10:28:51 +0200 (CEST)
In-Reply-To: <7vvdxs2t03.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 22 Aug 2008 22\:35\:40 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93434>

Junio C Hamano <gitster@pobox.com> writes:

> Anders Melchiorsen <mail@cup.kalibalik.dk> writes:
>
>> Passing options to "less" with the LESS environment variable can
>> interfere with existing environment variables. There are at least two
>> problems, as the following examples show:
>>
>> 1. Alice is using git with colors. Now she decides to set LESS=i for
>> some reason. Suddenly, she sees codes in place of colors because LESS
>> is no longer set automatically.
>>
>> 2. Bob sets GIT_PAGER="less -RS", but does not set LESS. Git sets
>> LESS=FRSX before calling $GIT_PAGER. Now Bob wonders why his pager is
>> not always paging, when he explicitly tried to clear the F option.
>
> 3. Christ has been happily using git with his PAGER set to "less".  He
>    suddenly notices that output from git linewraps and the pager does not
>    exit when showing a short output, and gets very unhappy.

Well, I noted that point already, so I had hoped for a reply
explaining why it is a big problem. Maybe setting PAGER="less" is more
common than I think, as I have never seen it.

While I am wary of advocating a patch that makes Christ unhappy, the
"3." issue is easily fixed by him setting GIT_PAGER="less -FRSX".

My concern is that without reading the source, it can be confusing to
figure out what happens with less, $LESS and git. I think my patch
improves on that. On the other hand, predictability is not really
needed if the current setup DWIM. And maybe it does.

This is hardly a big issue either way, so now that I have response on
the patch, I will not pursue it further.


Thanks,
Anders.
