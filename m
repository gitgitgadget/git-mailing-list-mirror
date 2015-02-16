From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should "git log --decorate" indicate whether the HEAD is detached?
Date: Mon, 16 Feb 2015 15:15:46 -0800
Message-ID: <xmqqa90d4fdp.fsf@gitster.dls.corp.google.com>
References: <CACdBeKmNazMtzK4hdd7WXMPDr7HdPe+EFpyd3M-TPBAUEY+HpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Julien Cretel <j.cretel@umail.ucc.ie>
X-From: git-owner@vger.kernel.org Tue Feb 17 00:16:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNUth-0006hT-4a
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 00:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbbBPXQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 18:16:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751277AbbBPXPt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 18:15:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 72DD438C93;
	Mon, 16 Feb 2015 18:15:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=45v4YQivqVQ6ORzQ1RpMIMVkaOI=; b=tlLDZ1
	4c4lvUDuOjB1dPUBpP9CuiDXqFKgOHzbUHRYh1s8+HUt8bNUmRrl+px1oaDQun+i
	a8dypkUP7nbpwObpYQUmyhShwCZeHLVC7cAnv5M/kbBTUW4m9Glb0IhAQVm4xLPL
	mMV3jEpsrVS0iXMPEaIAGUwI+ThP3fwQKO6LU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xKk8Jnxakrb877d+IzRH/RvZnqE3ZQRc
	93OjyZ5akASZk4HvFxjeshUhywAPqNtU2HcegEDGEJaFbc0w7JLFnmwAxDCExWTs
	F29trlQW6DBy/sCR6dPXaLrQHa/Hc1ceYNdf0wdqSmdmKI58DA8w7zFVVvc6pGji
	Ty6LMqBNbfE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 68F9338C92;
	Mon, 16 Feb 2015 18:15:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8D8738C91;
	Mon, 16 Feb 2015 18:15:47 -0500 (EST)
In-Reply-To: <CACdBeKmNazMtzK4hdd7WXMPDr7HdPe+EFpyd3M-TPBAUEY+HpA@mail.gmail.com>
	(Julien Cretel's message of "Mon, 16 Feb 2015 22:42:27 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BD9FD2A2-B631-11E4-9B8C-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263923>

Julien Cretel <j.cretel@umail.ucc.ie> writes:

> As of Git 2.3.0, the output of "git log --decorate" is ambiguous as to
> whether the HEAD is detached or not.

It sounds as if you are reporting some regression, but has any
version of Git ever done so, or is this just a new feature that
does not exist yet?

> More specifically, consider the following output of "git log --decorate":
>
>     4d860e9 (HEAD, master, dev) Remove trailing whitespace
>
> Whether the HEAD is attached to master or detached, the output is the same.
> Could/should "git log --decorate" be modified to provide this information?
> Perhaps something along the lines of
>
>     4d860e9 (HEAD -> master, dev) Remove trailing whitespace
>
> or
>
>     4d860e9 (HEAD = master, dev) Remove trailing whitespace
>

I personally do not see a need for such a differenciation.  Why does
one even need to know, and is it worth the cost of computing at the
runtime?

Most of the time when I am on detached HEAD it is either a few
commits behind a tip, or a few commits ahead of a tip.
