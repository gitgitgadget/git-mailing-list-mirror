From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fix MSVC compile errors and cleanup stat definitions
Date: Wed, 11 Sep 2013 11:11:44 -0700
Message-ID: <xmqqd2oftehr.fsf@gitster.dls.corp.google.com>
References: <522FA959.80108@gmail.com>
	<xmqqa9jjuypf.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOFYS-9+h0H3VD5X-EbZKX9nENaZfAZbLUm9zwDtr-3SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 20:11:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJotM-0003Do-GA
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 20:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685Ab3IKSLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 14:11:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58402 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753476Ab3IKSLs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 14:11:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E46E41A5F;
	Wed, 11 Sep 2013 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LDZxV8j+udP1Tt8pqWabUbeBS9s=; b=Tg19PS
	8bthXLPfokIUf/n3cJqBjaowX7qMnr4cLLkvl2+MJxTxW7jzq0u/MDNPS3K+TaUb
	7EpU9fG+v9bILJeuc/AqDZkLHe5fuftmQyzptff+mj2Y5i78wh83MNByn5JoLetn
	qt5TV/neOItyc2GKPbu1dj1yfb3eAECQpKmys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=brla209yvOZO8RvDXt9yyV23Na18CrQp
	dwS3n7+Qym+OLUi8xcHK8JIuZLFslwXvQIxze5bJkHvo7OjkIFwHWEIGYn8z2b8+
	yQD39t+F2AV6mNzq1tXBLWYjhcdfqK8p+uHmJWWKwS/xxtUwRoGkjf9260NEyIVj
	7N6LlNkgSNw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D04141A5E;
	Wed, 11 Sep 2013 18:11:47 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23CEE41A59;
	Wed, 11 Sep 2013 18:11:46 +0000 (UTC)
In-Reply-To: <CAHGBnuOFYS-9+h0H3VD5X-EbZKX9nENaZfAZbLUm9zwDtr-3SA@mail.gmail.com>
	(Sebastian Schuberth's message of "Wed, 11 Sep 2013 18:16:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9EC09F8A-1B0D-11E3-916B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234589>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Wed, Sep 11, 2013 at 6:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Karsten Blees <karsten.blees@gmail.com> writes:
>>
>>> A few minor fixes for the MSVC build.
>>>
>>> Also here: https://github.com/kblees/git/tree/kb/fix-msvc-stat-definitions
>>>
>>> Karsten Blees (3):
>>>   MSVC: fix compile errors due to missing libintl.h
>>>   MSVC: fix compile errors due to macro redefinitions
>>>   MSVC: fix stat definition hell
>>>
>>>  compat/mingw.h   | 21 +++++++++++++++++----
>>>  compat/msvc.h    | 15 ---------------
>>>  config.mak.uname |  1 +
>>>  3 files changed, 18 insertions(+), 19 deletions(-)
>>
>> I won't be a good person to review, suggest improvements on, and/or
>> judge these patches.  I'm Cc'ing regulars who work on mingw port for
>> their help and Ack.
>
> Acked-by: Sebastian Schuberth <sschuberth@gmail.com>

Thanks; will queue these three and your follow-up on top.
