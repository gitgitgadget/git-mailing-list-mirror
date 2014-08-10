From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update hard-coded header dependencies
Date: Sun, 10 Aug 2014 16:39:08 -0700
Message-ID: <xmqqy4uv7w4j.fsf@gitster.dls.corp.google.com>
References: <20140808215825.GH12427@google.com>
	<xmqq38d39b2d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 01:39:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGchy-0004ZU-NJ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 01:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbaHJXjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 19:39:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53481 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbaHJXjR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 19:39:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 41E1831E66;
	Sun, 10 Aug 2014 19:39:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kk32HpfWw835wVQcHzECRKvr9vk=; b=xV0RGg
	0fjOCb32eAeuQT12o2vKswEGJNIAh4Xq4kKvsNl7U/HEPwGocM4Nc2B6HHG4Q4lg
	WEk780xUSwQDuL9Rqs45FshUJwmsvaBMCFVvHaxFmdc6kgc7sKa41tcC0DhjR0Er
	k7uZvXJH1owGdkqKTh4/tFVtHSu3/n/ZAGIGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bzDmcVGhTNu2OIHLZeosE/tgYwRZ0IXU
	by+ZiVs8w0Cj4dcdHh92c7KDsW3bhiRDMOYE3w31V1uuCmc6Ph4HjXHyRZ9dB6rS
	j+eClEvGHwmxA+e3bPCunPR22KYTsD1F31Qk2iuSZs0Pvee0c7wVrj2P9mvKaiXW
	NsnGV7CCAkE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3990031E65;
	Sun, 10 Aug 2014 19:39:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2BAB131E5A;
	Sun, 10 Aug 2014 19:39:10 -0400 (EDT)
In-Reply-To: <xmqq38d39b2d.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 10 Aug 2014 16:31:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 86F7F6A6-20E7-11E4-B9A1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255114>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> ?  People using ancient compilers that never change headers wouldn't
>> be hurt, people using modern compilers that do change headers also
>> wouldn't be hurt, and we could stop pretending to maintain an
>> up-to-date list.
>
> I agree that it is very tempting to declare that we do not manually
> "maintain" the dependency list and force people without -MMD to
> recompile whenever any unrelated header changes.  Especially that
> this patch only works on the 'master' branch and upwards, and does
> not even work on 'maint', let alone 1.9 or 1.8.5 maintenance tracks.
>
> Let's consider the merit of that approach after 2.1 is out.  Thanks.

Actually "upwards" is not even true; the 'next' branch already wants
e.g. trace.h to build credential-store.o, which is not needed for
the 'master' branch.
