From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer.c: abbreviate hashs placed in the middle of messages
Date: Sun, 10 May 2015 12:17:30 -0700
Message-ID: <xmqqzj5cfdit.fsf@gitster.dls.corp.google.com>
References: <1431104035-2056-1-git-send-email-ralf.thielow@gmail.com>
	<CAPig+cSeNn0r7N6vp+qs4NTNwfYx5p-zUX3tkifuXLu+nB2yNQ@mail.gmail.com>
	<xmqqbnhvm1f5.fsf@gitster.dls.corp.google.com>
	<CAN0XMOKPbKUMwU5-T78m_knt=9O2GkKaqmXKViSi5k-Z7Damrg@mail.gmail.com>
	<xmqqtwvmlxlo.fsf@gitster.dls.corp.google.com>
	<CAN0XMO+ZY-oXb1aWK3TzUxDRuBEEoasxjdagYQQoB+JVheju9Q@mail.gmail.com>
	<xmqqa8xekeb2.fsf@gitster.dls.corp.google.com>
	<vpqwq0g2462.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun May 10 21:17:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrWjJ-0005nC-TY
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 21:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbbEJTRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2015 15:17:33 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751653AbbEJTRc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 15:17:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EB785030D;
	Sun, 10 May 2015 15:17:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hunNBHDFCv87dBv3f1mofmRpV6w=; b=bvspVO
	AvjlhdD/Wzn5AwFwDwVmtNUEKCoKROo9iMmVOad3l5vJqu+pund4ESEI35tnDkkm
	dvr8dqcpplwudIteheKXNRr8gMmRN9sr6fLARBoZNHObQ3oW5Z4nnZNQ1QisSDYi
	nK01m6VTfntChHLiTEGemhRDvBTQlJc4BaV28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nEMgJhTcXlFtUupHPWC2d7g+1CPmteF9
	iOeUpB5a8Unfe6npWGdnUIb/ubJ9fVhULTf/wYDFvtceX/Dq5S5XmPKFHOK0m+sB
	+UdAoTDvsMloD4lMNqyNmTBA777JJHRyLKN52yUsukMURk6zBUsGFedu9g84oK48
	dzEqHZytjj4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 260D95030C;
	Sun, 10 May 2015 15:17:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 908115030A;
	Sun, 10 May 2015 15:17:31 -0400 (EDT)
In-Reply-To: <vpqwq0g2462.fsf@anie.imag.fr> (Matthieu Moy's message of "Sun,
	10 May 2015 11:05:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 34A82522-F749-11E4-A87E-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268738>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I am not sure how that changes anything.
>>
>>     $ git cherry-pick 38e70713119c25ab5699df6b2fb13e4133d399ab
>>     error: that commit is a merge and you didn't give me -m <which-parent>
>>
>>     $ git cherry-pick 38e70713119c25ab5699df6b2fb13e4133d399ab
>>     error: the commit 38e707... is a merge and you didn't give me -m <which-parent>
>
> But ...
>
>     ./myscript.sh
>     error: that commit is a merge and you didn't give me -m <which-parent>

If myscript.sh did not take the user input, what would the first
thing you (who tried to run the script) would do?  At that point,
figuring out which wrong commit was fed to underlying cherry-pick
becomes a lot less important issue than figuring out _why_ the buggy
script fed a wrong commit to it, doesn't it?
