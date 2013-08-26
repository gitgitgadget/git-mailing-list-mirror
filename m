From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-remote-mediawiki: reset private ref after non-dumb push
Date: Mon, 26 Aug 2013 09:26:38 -0700
Message-ID: <xmqqmwo4ifk1.fsf@gitster.dls.corp.google.com>
References: <1376400700-8863-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2u1edB3g9GK_kak3Nc-fe4TDBjFU_JqskBW+J0Q9BJrg@mail.gmail.com>
	<vpqa9ka7mku.fsf@anie.imag.fr>
	<CAMP44s3jh4iEbgONaEU0WSCc5YiGYoK8edcgWU6qmUARToVRuw@mail.gmail.com>
	<vpqbo4o3jba.fsf@anie.imag.fr>
	<CAMP44s281qkdMXUM-2P6T+emFajASX6Jyj4nk8_cU5xYJYvdLA@mail.gmail.com>
	<vpq8uzr5y4v.fsf@anie.imag.fr>
	<xmqq61uumnsz.fsf@gitster.dls.corp.google.com>
	<vpqhaeckfbh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 26 18:26:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDzcw-0002Gl-CZ
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 18:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284Ab3HZQ0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 12:26:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47069 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143Ab3HZQ0p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 12:26:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FA193ACAE;
	Mon, 26 Aug 2013 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0iLC5SNxRslvW3jriERX9llRGQA=; b=Yx4Ig0
	htqigBs6+ZOi71oVB7MYAwr6qMutaud7o51WGkyLFR36+MLvL3y7sMNxmNKyjTYa
	Pb9dJfWAgZEOvBu4MGpeMpWToxA5urgGyNkJPvZcjW08VJOBhCr0++JmyFl9omFb
	OmblVb/ZixaK8NQue4rO5MuCQrxmnvHJS6NQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iYfu+w5kM0Zn/rigNOZ2AEr0TcdRj7yA
	eam+CkfINrYwOMbBifEoIJkcl1k7of2zazHqrETWjj/IBDexUBW5e0gOQWQrvJq1
	pIhsB3N1ODXe83/9MJ2QwkzJV/lhhGwBuwXDzya+wW+djMp4GmDAWAhuMNWkxb9I
	HiwGTb/GlRg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17BCB3AC9E;
	Mon, 26 Aug 2013 16:26:43 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 534463AC93;
	Mon, 26 Aug 2013 16:26:41 +0000 (UTC)
In-Reply-To: <vpqhaeckfbh.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	26 Aug 2013 10:48:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4A1703AA-0E6C-11E3-81B8-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233000>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Not updating was the default until 664059fb62 (i.e. until 1.8.4), so the
> default already changed once. I tend to agree with Felipe that doing the
> update by default makes sense.

OK.  Thanks.

> git-remote-mediawiki is kind of a special case, as the remote side uses
> a very different data model, hence it can make sense to export+reimport
> to get locally what the remote side received.

Hmm, I am not sure how export+reimport would not make sense for
others like cvs and p4.

> But when interacting with something closer to Git (bzr, hg, ...),
> the mapping should be close to 1-1 and re-importing wouldn't make
> sense.

I agree if your argument is that re-importing should result in an
identitical result hence is unnecessary.
