From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] test-lib: tests can have multiple prerequisites
Date: Mon, 26 Apr 2010 17:06:55 -0700
Message-ID: <7vpr1liwrk.fsf@alter.siamese.dyndns.org>
References: <20100421131255.GA2750@progeny.tock>
 <20100421133806.GA5595@progeny.tock>
 <20100426191703.GC10772@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Don Slutz <Don.Slutz@SierraAtlantic.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 27 02:07:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6YKa-0006nV-PI
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 02:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639Ab0D0AHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 20:07:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab0D0AHI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 20:07:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F60FAE501;
	Mon, 26 Apr 2010 20:07:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oy9BkpV9m3ajvomPoDIfZhbjEto=; b=LPyIEg
	+a0/zimbvdtiWJyKei0Sd6zVEMd+tv8HVA7qmbNtGXmqjz989pMdF9gQ7OK860sf
	UZ4z7+S/NR2ifZ7qVzOFBMzwEn9GvRlrvYqoRmoprcn8bzRtDfq/Udxf8srzXFJq
	/qb4xtLKR1GMki3MWFjUwFS6HYNaO/SPXbdX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DQ+BQ21j4osLcowq/yLa07w7v4J93Mji
	h8WQiFzZtYuSdl+D7bnaEsGND2GU8kOEq9IeMeNpFj0VZTH+WLSwoiE4QSG2i9LY
	lOQOOlfS09yl5Rai7Lr+2fjUszmPnXOqLhgB3qtHI5LF6a1iYCK1RUj+wKtmI6sS
	9FtY7p/keYw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13F5EAE4FE;
	Mon, 26 Apr 2010 20:07:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20427AE4F6; Mon, 26 Apr
 2010 20:06:56 -0400 (EDT)
In-Reply-To: <20100426191703.GC10772@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 26 Apr 2010 15\:17\:03 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CEC4442E-5190-11DF-8375-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145866>

Jeff King <peff@peff.net> writes:

> I do wonder if it might be less error-prone to have:
>
>   test_expect_success PREREQ1 PREREQ2 'desc' 'test'
>
> instead of
>
>   test_expect_success 'PREREQ1 PREREQ2' 'desc' 'test'

Spot what is wrong with this:

        test_expect_success make sure we have the repo '
                test -d .git
        '

I think "we may or may not have a single prereq word" would be less error
prone.  (you could make sure "test_have_prereq" gets no lowercase letter
to mitigate the issue, though).

I tend to like the comma myself, but quoted, space separated list is fine
by me.
