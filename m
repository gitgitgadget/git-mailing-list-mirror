From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a "git reset --keep <sha1> || git reset --hard <sha1>" alternative?
Date: Wed, 20 Apr 2016 12:03:42 -0700
Message-ID: <xmqqvb3cumpd.fsf@gitster.mtv.corp.google.com>
References: <CACBZZX6k6sFv2GWOzu0Ow1T+5ci2gmMOvaD37bvbm1_qfetr8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 21:04:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asxPr-00062w-JN
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 21:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbcDTTDz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 15:03:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751790AbcDTTDv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 15:03:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AA95C13F42;
	Wed, 20 Apr 2016 15:03:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NUjDqYLZ9DKf
	/PryQxuSJO6PwBM=; b=PKaNBr50xbO9/fuzaNf1LcU0pZ4fN4gdA64iMVxmGXEV
	rS5S09KHN20sn/LskH6CY4ra6wvu+WG2u1DGJGAKQFYTPPWMlbKRNJtAmxvs0sNT
	U1KVlbKcUNx8TOpLbZM973rNys9t1chYCGx7EV/+1G6b6ogP6h6pVL2NwSu95Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Rr5umt
	+TPhvMLfOOsrfmN+ShtuNuj7QsxM+CEEdWhQAvpUCRSfJjzGIezZNUs1yKbHwX+R
	nh9sRSG1eWQzMhgfHiWgjLZbEyT3f2IDTttx9C+IiDZM2Mrck3J9XK13eI7/F7fS
	POZHOOyJkrso+JLnTax7zUMsexcPM34h7z8x0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A1B9213F41;
	Wed, 20 Apr 2016 15:03:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1EBBA13F3F;
	Wed, 20 Apr 2016 15:03:44 -0400 (EDT)
In-Reply-To: <CACBZZX6k6sFv2GWOzu0Ow1T+5ci2gmMOvaD37bvbm1_qfetr8Q@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 20 Apr
 2016 19:18:14
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9A601360-072A-11E6-93A2-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292058>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>     $ ls -l INSTALL ; chmod 600 INSTALL ; git reset --hard @{u} ; ls =
-l INSTALL
>     -rw-r--r-- 1 avar avar 9147 Apr 20 17:11 INSTALL
>     HEAD is now at e6ac6e1 Fifth batch for post 2.8 cycle
>     -rw-r--r-- 1 avar avar 9147 Apr 20 17:12 INSTALL

A quick question.  What happens when you did this instead?

	chmod 600 INSTALL
        git update-index --refresh
        git reset --hard

Does it match what you want to see?

The reason I ask is because I recall making a deliberate design
decision around this area.
