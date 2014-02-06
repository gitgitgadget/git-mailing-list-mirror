From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t0003: do not chdir the whole test process
Date: Thu, 06 Feb 2014 12:25:48 -0800
Message-ID: <xmqqvbwsxa2b.fsf@gitster.dls.corp.google.com>
References: <xmqqvbwsyvn8.fsf@gitster.dls.corp.google.com>
	<1391712033-9443-1-git-send-email-gitster@pobox.com>
	<20140206194521.GU30398@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lasse Makholm <lasse.makholm@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 21:26:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBVWK-0007to-QQ
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 21:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbaBFUZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 15:25:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36591 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbaBFUZz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 15:25:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C69116A7C6;
	Thu,  6 Feb 2014 15:25:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ILhbc75NaaWG9zk3JvgXyHvuVq8=; b=RxrzET
	E9iOJbXq+t3axbHkGZwJjO/xmJmMBF/oCh6Wck+0PXmmRfYQCLl7N36UHRcVEZa+
	ukoesG2gevC6/X8qBguq7hREo+5O+CeWZeuH4bRKHW5olBmjR20ly4Xm9Apxo0Th
	uHf0FF5I/THlxEC9xZdx9Lc/hygIt5Fug3dkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vheraXia60jyo/naon7lb3CvB1fUlBbn
	lGMzF4TKIFHXlxsdijKsAO7YKlQHF2kXFotjKAIYsOWTaGT4Xm1UaPT0lhDJ6a6K
	WpCSRQyfeNvQeq5RtlJJ2j50RrxNalxO3T9ccUxWNHJqKfb+8fpcqSl/4xbtJPC6
	1pe2OGpTaDo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B408C6A7C5;
	Thu,  6 Feb 2014 15:25:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D81156A7C1;
	Thu,  6 Feb 2014 15:25:50 -0500 (EST)
In-Reply-To: <20140206194521.GU30398@google.com> (Jonathan Nieder's message of
	"Thu, 6 Feb 2014 11:45:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DED46A92-8F6C-11E3-9F1A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241741>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Moving to some other directory and letting the remainder of the test
>> pieces to expect that they start there is a bad practice.
>
> I agree with the above, and I like the patch...
>
>>                                                            The test
>> that contains chdir itself may fail (or by mistake skipped via the
>> GIT_SKIP_TESTS mechanism) in which case the remainder may operate on
>> files in unexpected places.
>
> ... but this logic seems wrong.  I don't think we've ever supported
> setup tests failing or being skipped in the past.

The first set-up test, yes, but something in the middle added as an
afterthought?
