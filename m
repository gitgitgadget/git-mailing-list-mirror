From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] remote-hg: add shared repo upgrade
Date: Fri, 09 Aug 2013 14:47:57 -0700
Message-ID: <7vbo564jua.fsf@alter.siamese.dyndns.org>
References: <1376078581-24766-1-git-send-email-felipe.contreras@gmail.com>
	<1376078581-24766-3-git-send-email-felipe.contreras@gmail.com>
	<CALWbr2yAitLSNGj2qwz4C8Ugm8wHnGTf4ndZSbPcFToczWaWEA@mail.gmail.com>
	<CAMP44s3KkwWnTb7=w-oviGRrsXk+g_L0yL9=xyywSpobmeExOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>,
	=?utf-8?Q?J=C3=B6rn?= Hees <dev@joernhees.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 23:48:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7uXW-0003CP-9p
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 23:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031256Ab3HIVsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 17:48:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031253Ab3HIVsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 17:48:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE18C3719F;
	Fri,  9 Aug 2013 21:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tfxyvS38J8inz8jBddReIC9euB8=; b=Yl484F
	BD4Wa4RKZzNKJyAWISKvpz0fU6clhUHBhlRXOl3+oliXuv6bgB4V1AViNxNuvbtT
	DaoPZgPCDknH+Fu/Jq6uMMlatlt7xph9jL2VkN8CX67ZSBWSfiXFO2T13fMBwtqZ
	7upJsS2/yJ14lOHUOINLNclqZeTD+PFgcTSTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H2jvrQNyJsvrnmhWgmDOgcz7NqGmi5jN
	PsmI31Sb8F3P3X7FzWlOWa8NfDiYo/aEvsZdrBDzJJE6ObIUHz0g4KXsTHF9nDKc
	eHPC6dhp22JKhak0Ny6iq4nbeCkpPuiwZ6/yWCtb572nW/ZkAK1APfIH++IS6HBI
	fzYXPtAmQXg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D516A3719E;
	Fri,  9 Aug 2013 21:47:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31A2C3719C;
	Fri,  9 Aug 2013 21:47:59 +0000 (UTC)
In-Reply-To: <CAMP44s3KkwWnTb7=w-oviGRrsXk+g_L0yL9=xyywSpobmeExOw@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 9 Aug 2013 15:24:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B9178F4-013D-11E3-ABCD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232039>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, Aug 9, 2013 at 3:19 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>> On Fri, Aug 9, 2013 at 10:03 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> 6796d49 (remote-hg: use a shared repository store) introduced a bug by
>>> making the shared repository '.git/hg', which is already used before
>>> that patch, so clones that happened before that patch, fail after that
>>> patch, because there's no shared Mercurial repo.
>>
>> Does that still hold ? You are creating the shared_path repository
>> just below, so it should work without the patch.
>> The real reason for this patch is to avoid having to re-clone from a
>> potential slow source, is it not ?
>
> Yeah, that's true.

So both of you are happy if we apply 1/2

Message-ID: <1376078581-24766-2-git-send-email-felipe.contreras@gmail.com>

and this one with an updated log message?
