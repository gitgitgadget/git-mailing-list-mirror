From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Splitting files merge with branches
Date: Tue, 05 Nov 2013 11:19:53 -0800
Message-ID: <xmqq8ux2ac6e.fsf@gitster.dls.corp.google.com>
References: <CALZVapmJDEWyUcgdJ0C0V0bKpSyukHZ=ei9GgVh-Z0yfb8x8tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 05 20:20:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdmAW-0000T1-8F
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 20:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866Ab3KETT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 14:19:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61255 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754638Ab3KETT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 14:19:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C8AC4E2CF;
	Tue,  5 Nov 2013 14:19:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=204YLxoOVkif7orkCFRgF/T45sU=; b=XTNKXh
	FDWE2DS/l3ZAccYqzRn8lZvQa/yNecAJaRImd+Mq8rQAo6Ru2UDN08Ov4gSWINkk
	uidv9HlPx+LXAN1Ye00XGkoERbZ870GyuQTYi6biGihs3BU9al2lGuNaUG8AC15H
	1Avef0EuybrIZVQ3caTBXmOV8zWvq1EYc1SOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VQmI9xWX16gApiomPnCEwFRrJ2fdx23j
	kB5amhCR7WIMYS+Yz+c4oJqBP204+kMM6QFB7aHWtioeAQgimxcniu4yZIJj1/7g
	Biqx6Plgy15AjenKhDX4BXXRpGL7+klB+g/8oBG54y7YWIqrXZI8jWs1KNDF+HDZ
	JIe12/l597M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D4234E2CD;
	Tue,  5 Nov 2013 14:19:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A67A4E2C6;
	Tue,  5 Nov 2013 14:19:55 -0500 (EST)
In-Reply-To: <CALZVapmJDEWyUcgdJ0C0V0bKpSyukHZ=ei9GgVh-Z0yfb8x8tQ@mail.gmail.com>
	(Javier Domingo's message of "Tue, 5 Nov 2013 10:38:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 40C7E70E-464F-11E3-A2E9-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237337>

Javier Domingo <javierdo1@gmail.com> writes:

> I have been using git for now 4 years, and one feature I miss a lot,
> that would increase the usability of git in many cases, would be
> having it detect "inter-file" movements, so that if I, in a single
> commit just part one file into many, git can track that change.
>
> I suppose this is quite difficult, as would mean having extra features
> in diffs, and I don't know how could it be implemented,...

Sounds like $gmane/217 to me.

http://thread.gmane.org/gmane.comp.version-control.git/27/focus=217

Some of the pieces that are needed to immplement the "drilling down"
Linus envisioned in the message are already there, e.g. you can ask
"log -S<block of text> -1" to find the last commit that touched the
block of text in question.  Once you find that commit, you can
inspect "git show -m -p <that-commit>" and find "Ahh, that block of
text that appeared in the new tree came from five copies of similar
blocks of text in the old tree".  Nobody wrote that last piece of
the logic yet, though.
