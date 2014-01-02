From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] t0000 cleanups
Date: Thu, 02 Jan 2014 14:41:06 -0800
Message-ID: <xmqqob3unh19.fsf@gitster.dls.corp.google.com>
References: <20131228092731.GA26337@sigill.intra.peff.net>
	<20131228222129.GE5544@google.com>
	<xmqqwqimry2j.fsf@gitster.dls.corp.google.com>
	<20131230185125.GI20443@google.com>
	<20131231103323.GA14823@sigill.intra.peff.net>
	<20140102222833.GR20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>,
	Thomas Rast <tr@thomasrast.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 23:41:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vyqx3-0006bj-9V
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 23:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbaABWlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 17:41:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54133 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833AbaABWlL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 17:41:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57CA75F3EF;
	Thu,  2 Jan 2014 17:41:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2zsaFxe1RGmPG22O++9QHiYPxiI=; b=NGPlo+
	yAAQPM/LFrQZixDS8LKIb8ncskUgQSTkjLFpBl/Ht3kGTm0WeVj26Hkw90RMt9/4
	EQost+f7O6rr0oLRcGRaNSXZWTtM1F9dlq78J2RRP+pzdqZe9hTSbRzcYf32mghC
	Wm9eQyic8hy7gTjlGCeFgWHsdbMTEqma2yEM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PYBHcdT9iwvnaAuh1ZhNVBihUX3oKRdx
	fJEwMrSAvavdWmLyelTl51iv44h/mgP53Wd/lU0jby1OCmieFFzfe5u1/ka+3Ier
	4kHJEYpP6A2enl7MpijrbgR4cYG+usqPj4oSA6RUZp941zJNB2FJoTU70FfrBh3U
	XqKa8kEIRv8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43E565F3EE;
	Thu,  2 Jan 2014 17:41:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97D475F3ED;
	Thu,  2 Jan 2014 17:41:10 -0500 (EST)
In-Reply-To: <20140102222833.GR20443@google.com> (Jonathan Nieder's message of
	"Thu, 2 Jan 2014 14:28:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FA1CC24C-73FE-11E3-B2D5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239893>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>> On Mon, Dec 30, 2013 at 10:51:25AM -0800, Jonathan Nieder wrote:
>
>>> 	These scratch areas for sub-tests should be under the t0000
>>> 	trash directory, but because the TEST_OUTPUT_DIRECTORY
>>> 	setting from the toplevel test leaks
> [...]
>> This is not exactly true. The TEST_OUTPUT_DIRECTORY setting does not
>> leak. t0000 sets $TEST_DIRECTORY (which it must, so the sub-scripts can
>> find test-lib.sh and friends), and then TEST_OUTPUT_DIRECTORY uses that
>> as a default if it is not explicitly set.
>
> So I should have said something like the following instead:
>
> 	These scratch areas for sub-tests should be under the t0000 trash
> 	directory, but because TEST_OUTPUT_DIRECTORY defaults to
> 	TEST_DIRECTORY which is exported to help sub-tests find test-lib.sh,
> 	the sub-test trash directories are created under the toplevel t/
> 	directory instead.  Because some of the sub-tests simulate failures,
> 	their trash directories are kept around.

I had a private rewrite queued already, but the above is easier to
read, so I'll replace it with this.

Thanks.

>
> 	Fix it by explicitly setting TEST_OUTPUT_DIRECTORY appropriately
> 	for sub-tests.
>
> Thanks for catching it.
>
> Jonathan
