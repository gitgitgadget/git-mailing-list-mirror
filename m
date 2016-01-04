From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: git bisect merge to usable base
Date: Mon, 04 Jan 2016 12:31:44 -0800
Message-ID: <xmqqa8olnl1r.fsf@gitster.mtv.corp.google.com>
References: <CALCETrUgsawpwkkjO_BpPHyOaH7NsJNU-4mF97a6NAxCMB5aUA@mail.gmail.com>
	<xmqqsi2jem15.fsf@gitster.mtv.corp.google.com>
	<CALCETrUO2Gx9vRqkGLaGWLsuMs98k5d3PKEPfx3RZf4+fpko4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andy Lutomirski <luto@kernel.org>, git@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 21:31:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGBnE-0002Zr-Id
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 21:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbcADUbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 15:31:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753297AbcADUbr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 15:31:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A81C37D9A;
	Mon,  4 Jan 2016 15:31:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XC33DfoAOh5+nd2sxrsAU/6Jk1E=; b=b9L9qK
	JFk6w/05iRkE3R6jkyXYBt4JJRamtr+mJ//yRjB7U8Ph1uuiPZxw69VTfT9GXM82
	7p9FOmATZ2Fefp5Wxa+5QGfB1tVNneHpmKcOZzKWMqSPpN4tOy7GW9XCPiS8vbdf
	y4d0mMAiqMFD0O8pzDeaJ+304u69OkozQi8gA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qwuSeR54xfiM9WUfo1PBGVYutdNf22ol
	hTsHyIAKYG4MUxFJ8S4tB+yFwSibJeHqfVB9kwWYmHm4IfO/AmFI/sUPakOL5fUX
	GbDbrFtQkIqn4UgV9BOLhnDQL/VOQWHsvTgoExqscsLP8otnMEDXgnI5p+Wa/dlU
	yq79ro3g4U4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5146F37D99;
	Mon,  4 Jan 2016 15:31:46 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C7DA637D96;
	Mon,  4 Jan 2016 15:31:45 -0500 (EST)
In-Reply-To: <CALCETrUO2Gx9vRqkGLaGWLsuMs98k5d3PKEPfx3RZf4+fpko4Q@mail.gmail.com>
	(Andy Lutomirski's message of "Mon, 4 Jan 2016 10:15:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2C4F1F26-B322-11E5-891E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283322>

Andy Lutomirski <luto@amacapital.net> writes:

> git bisect run is great, but it's not so great when the test process
> is "sudo make modules_install && sudo make install && reboot", then
> boot new kernel, then run emacs, then see if it worked...  There
> doesn't appear to be a 'git bisect run' option to pause and wait for
> an explicit user request to continue, unfortunately.

That is expected to be part of your run script, as that is a custom
and specialized need your bisection has.

It still will not work when the test procedure involves rebooting,
but "git bisect" does not require you to install and reboot the same
machine you are running the bisection on, i.e. the test process
could be "build && scp there && ssh there reboot && see if comes up"
;-)
