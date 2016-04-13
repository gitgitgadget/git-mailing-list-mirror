From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1500-rev-parse: rewrite each test to run in isolation
Date: Tue, 12 Apr 2016 19:03:02 -0700
Message-ID: <xmqqk2k2l0yx.fsf@gitster.mtv.corp.google.com>
References: <1460200767-32864-1-git-send-email-rappazzo@gmail.com>
	<1460200767-32864-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, sunshine@sunshineco.com, pclouds@gmail.com,
	szeder@ira.uka.de
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 04:03:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqA9A-0000EG-6P
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 04:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbcDMCDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 22:03:07 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964861AbcDMCDG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2016 22:03:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1011555E28;
	Tue, 12 Apr 2016 22:03:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ICQICFboFLG7
	bo1e4e4TPBtBnHo=; b=lLa7SVRgpBgAwOq5BOlx7ujmjb/gveHeJHwcJo8QzxkQ
	mQJM5JNqDjEFrqPQOnDDdhVsJlzkhEXYKoIv35D26gSBd12DrlKVSU3x2Y220SNS
	gbEOib3/LUxWZY1jJ8XK7i+fz+uZJfae/l7MmPdOIXgNBLl4L4mLwV9XxqwMy3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B1lkMN
	Ew7YR2igGf2lxeUAi9u/kpc98SJ/WFcIl7npWbSwksE4KcuVgecNGITyMth3CyJJ
	/HgNHfjX0lxZ5O1a7Sz61zScqPEbqAERzvPpIdSNclSn2aGijv+93ua9zCgfZBRS
	ynoxS6YgkEkri+0yi81Bx/oCfoPx+/jEgS7e4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0695155E27;
	Tue, 12 Apr 2016 22:03:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6770955E24;
	Tue, 12 Apr 2016 22:03:03 -0400 (EDT)
In-Reply-To: <1460200767-32864-2-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Sat, 9 Apr 2016 07:19:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DB3A3808-011B-11E6-85A6-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291367>

Michael Rappazzo <rappazzo@gmail.com> writes:

> t1500-rev-parse has many tests which change directories and leak
> environment variables.  This makes it difficult to add new tests with=
out
> minding the environment variables and current directory.
>
> Each test is now setup, executed, and cleaned up without leaving anyt=
hing
> behind.  Tests which have textual expectations have been converted to=
 use
> test_cmp (which will show a diff when the test is run with --verbose)=
=2E
>
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---

Applying this patch on top of sg/completion-updates topic makes the
tests much more readable.  Given that sg/completion-updates topic is
planned to be rerolled ($gmane/287839), I think it would be better
to do this as a preparatory clean-up patch before it makes the tests
uglier by doing "add --absolute-git-dir" patch in the middle.

G=C3=A1bor, what do you think?
