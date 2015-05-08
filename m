From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/subtree: portability fix for string printing
Date: Fri, 08 May 2015 10:49:38 -0700
Message-ID: <xmqqy4kzklhp.fsf@gitster.dls.corp.google.com>
References: <xmqqmw1gp7aa.fsf@gitster.dls.corp.google.com>
	<1431046619-2340-1-git-send-email-danny0838@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git develop <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Danny Lin <danny0838@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 19:49:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqmPC-0007z7-Fr
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 19:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbbEHRtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 13:49:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50183 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752628AbbEHRtl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 13:49:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 633A44EB0B;
	Fri,  8 May 2015 13:49:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n2WN6KrAafqaHkl4thaVcekNruQ=; b=ULbj84
	edq6amg4wLx8KS4H6qE7SyQtTHPFj5+FgMebWWWlzchjkbXJcWNdskCzmI8gxy5Z
	F2rOBYKE/B52SF+udzJzm5JsQNPI7CKEMBROt9HcCaYb0882auod0t0/6prUul/w
	0OszcX/rbxs35DHavS1+40n9xgZYueZrc8x68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FFGikTtgWkiWqhfBl26S1Z8MqfWYvifj
	uWR50/JsdPxltzf7B20IM3ouvZn2cgW8NvVyRoQCMpvgwLAAjbGGr0zwLRqe0dTt
	gMhTkxZJBn31Hkb7IBZtxpEv1psimcsPl4M1hcElPWb1OyUe/SMdG/mYlkDqhW0O
	IXI2yYHXJsI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C6734EB0A;
	Fri,  8 May 2015 13:49:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA41C4EB09;
	Fri,  8 May 2015 13:49:39 -0400 (EDT)
In-Reply-To: <1431046619-2340-1-git-send-email-danny0838@gmail.com> (Danny
	Lin's message of "Fri, 8 May 2015 08:56:59 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99A760BE-F5AA-11E4-B7F9-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268633>

Danny Lin <danny0838@gmail.com> writes:

> Replace echo using printf in debug() and say() for
> better portability.
>
> Also re-wrap previous 'say -n "$str<CR>"' using a new
> function progress() to prevent CR chars included in the
> source code, which could be mal-processed in some shells.
> For example, MsysGit trims CR before executing a shell
> script file in order to make it work right on Windows
> even if it uses CRLF as linefeeds.
>
> Signed-off-by: Danny Lin <danny0838@gmail.com>
> ---

Thanks, this looks good.  Will apply with a little bit of tweak in
the log message.

Just for future reference, when shooting many iterations of the same
patch in a short timeframe, please be aware that the recipient may
not get the messages in the order you sent, and that it may not be
apparent to the recipients what changed between the iterations.
What we commonly do around here to address these issues is to
mention what changed from the previous one below the "---" line
before the diffstat.  I would have done something like this if I
were doing this patch, for example:

        ...
        even if it uses CRLF as linefeeds.

        Signed-off-by: Danny Lin <danny0838@gmail.com>
        ---

        * The previous one still used "log" helper by mistake even
          though I removed the implementation of it and decided to
          use "echo" for non-tricky cases.  This fixes it.

          contrib/subtree/git-subtree.sh | 13 ++++++++++---
        ...
