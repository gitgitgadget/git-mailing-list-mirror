From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] grep with textconv
Date: Fri, 19 Apr 2013 11:24:16 -0700
Message-ID: <7vhaj21ir3.fsf@alter.siamese.dyndns.org>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 19 20:24:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTFyy-0003D6-Bn
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 20:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab3DSSYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 14:24:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58486 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041Ab3DSSYT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 14:24:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E071159F7;
	Fri, 19 Apr 2013 18:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UKDfIh55zH56RWiCcLEddiowLVU=; b=oVPvFy
	V+0iW6EuK/SI0n2MjUzQx9ZDAHKLibKJg5JX4ZD6dKbE5qkTMhDHjfVMgpdpvpIL
	qiXvL76x8b9g1lue26v6kP3SuA3uMsZmSfloXmVrNH1ZYk8jNAU2YJydUJv3vfLv
	3zidKl2KuBuDG+eRh04mRHXl6Q3EUU1xTLW0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wnqV3U5895rRPzKq8/Rj8JVrdiWE1pad
	cjP4tppue6oeBu5/K60wc2OvBUwL2o6cEvhDPsiFPleVYcTZS1ednzQPJj1/U5bL
	cmkNgvLSfGrFpHZ3LMLQBBF7JQsTTAhT1Axehwk6n3tL/fk74chSbIIQDCCeqpkq
	0zJ5b8/5Zuk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31BDE159F6;
	Fri, 19 Apr 2013 18:24:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A943D159F2;
	Fri, 19 Apr 2013 18:24:17 +0000 (UTC)
In-Reply-To: <cover.1366389739.git.git@drmicha.warpmail.net> (Michael
	J. Gruber's message of "Fri, 19 Apr 2013 18:44:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58B6EBA4-A91E-11E2-A513-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221792>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This series teaches show and grep to obey textconv: show by
> default (like diff), grep only on request (--textconv).  We might
> switch the default for the latter also, of course.  I'd actually
> like that.
>
> Compared to an earlier (historic) series this one comes with tests.

It would have been nicer if you referred to the previous thread

cf.

  http://thread.gmane.org/gmane.comp.version-control.git/215385

>   grep: allow to use textconv filters

This looked mostly sensible except for one minor "eh, do we really
need to assume textconv output is text, or wouldn't using the same
codepath for raw blob and textconv result to make them consistently
honor opt->binary easier to explain?".

>   t4030: demonstrate behavior of show with textconv
>   t7008: demonstrate behavior of grep with textconv

It somehow felt they are better together in the patches that
implement the features they exercise.

>   show: obey --textconv for blobs
>   cat-file: do not die on --textconv without textconv filters
>   grep: obey --textconv for the case rev:path

I just let my eyes coast over these but didn't see anything
obviously wrong.

By the way, "git log --no-merges | grep obey | wc -l" shows that we
say "honor an option" a lot more than "obey an option".  We may want
to be consistent here.
