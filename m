From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git rm -u
Date: Mon, 25 Feb 2013 11:47:14 -0800
Message-ID: <7v621gxjjx.fsf@alter.siamese.dyndns.org>
References: <50FB1196.2090309@gmail.com> <1358632037-ner-2564@calvin>
 <CALWbr2zhxkZEGWc5iN-8MivzV7viEdfwV_Q-iH0xSUWkwnSmyQ@mail.gmail.com>
 <50FB1673.8020808@gmail.com> <7vzjys28a0.fsf@alter.siamese.dyndns.org>
 <CALWbr2x9=+PEaGTpGWoqGiiupGsPhLoPcGknPb1WtSgxdpBkdQ@mail.gmail.com>
 <vpq7glw5i20.fsf@grenoble-inp.fr>
 <CALWbr2y-CN9A346avc4AG+FN9NHgPXKvWuU-nbcyjt08DavVjw@mail.gmail.com>
 <vpqliac41zf.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:47:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA41X-0002e9-GK
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 20:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758849Ab3BYTrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 14:47:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757420Ab3BYTrR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 14:47:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85EA8B7B7;
	Mon, 25 Feb 2013 14:47:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yBHoZXHVRCc5e5I8D7JsDGkCv2c=; b=QP2jnX
	kGW73ouHXJ3BCKSKK7OtdGIp6pBE+RULJMtY3M+3GGkDFiVSP83f8RPSCNuv8yDn
	XXcczpQMw7uzrHlj2uiQ0zfklbaz5Bvg5aiUm5I5D9YGPVFXMtAChx1OSGhvWmqT
	Odiqovz/s7iS+KelxOScSiCMIpE53L8TY+u7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BzgSCLF1GJmJZTBfig37xy9yrSfM/En/
	fCXP6tJC5prSqmcxL5KjA+hRlr/KEedd+i7xPSGdFXtZQjPUDq2W5MR5RWmTamyZ
	9pYtRQl8tLQ14fIjjpHwDEkgqRZQMrrAQF24R+Ph2zvxSSVagT2xY4+Y+vqs2eIe
	eTo7qUnY7Co=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79F61B7B6;
	Mon, 25 Feb 2013 14:47:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6D18B7B4; Mon, 25 Feb 2013
 14:47:15 -0500 (EST)
In-Reply-To: <vpqliac41zf.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 25 Feb 2013 20:39:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 280D1320-7F84-11E2-A995-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217097>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Antoine Pelisse <apelisse@gmail.com> writes:
>
>>> "git rm" really seems to be a better place for removing files from the
>>> index.
>>
>> Then, I don't exactly understand the meaning of git-rm but being a
>> _shortcut_ for "remove and stage".
>
> "git rm --cached" is exactly "remove from index".
>
> And even without --cached, as you notice yourself, it does a "remove and
> stage [removal]", so why would it be inappropriate to stage a removal?

I do not think "git rm" is a bad place to add the feature; I was
questioning if "-u" is an appropriate option.  The option "-u" given
to "git add" is internally called "take worktree changes", and we
would need the option to "git rm" with that internal meaning.  The
superficial meaning "updated" that "-u" in "add -u" stands for does
not really match what "git rm --take-worktree-changes" wants to do,
as we obviously do not want to remove all updated/modified files.
