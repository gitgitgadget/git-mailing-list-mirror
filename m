From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: properly handle decorations with chained tags
Date: Thu, 19 Dec 2013 10:44:22 -0800
Message-ID: <xmqqfvpofzp5.fsf@gitster.dls.corp.google.com>
References: <20131217004044.GB259467@vauxhall.crustytoothpaste.net>
	<1387254501-319329-1-git-send-email-sandals@crustytoothpaste.net>
	<xmqq38lrknbd.fsf@gitster.dls.corp.google.com>
	<20131219031809.GG259467@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Dec 19 19:44:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtiaL-0001Ob-Ni
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 19:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956Ab3LSSoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 13:44:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50962 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753937Ab3LSSod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 13:44:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BA9D5B822;
	Thu, 19 Dec 2013 13:44:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h0vrb3O1zU+pi5PUlq2YEazyTNE=; b=MDwW/Z
	qUkszaWmEikJlgeyqgWVMSNDH4XdFXC56P2/vovXDGGRKXilOdlIYaZwk/h5lB1J
	Byd1Qa7i/n1GLVjcXdYO/uuuwlP0Y7F3crV0brLHzgyZyAXD7lc2QyADUmDH7+ht
	FDcjmO6emue2yFnpeMCcPNU5Bf2Ifb9bNnezQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vb+XMmswURH8gjUgoHu9agzAgeTlWTe4
	8wainBF0RZXOJUyIUfAZARDgaYJXUAhUQSj1vkc24aE3eE7nhxMVAfF0tbe/jilM
	U+zJ2HwQfwcIGvwPArMI17zm5j1g6fWmojj+otXsVzNEic9Yxt2O3WWARwegOPkC
	ApTCC54qtno=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 696075B821;
	Thu, 19 Dec 2013 13:44:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CDEF5B820;
	Thu, 19 Dec 2013 13:44:26 -0500 (EST)
In-Reply-To: <20131219031809.GG259467@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 19 Dec 2013 03:18:09 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9604D92E-68DD-11E3-A119-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239530>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Tue, Dec 17, 2013 at 04:36:06PM -0800, Junio C Hamano wrote:
>> I think all we need to do, in addition to what the existing code
>> does, is to make sure that we _parse_ the object that the tag points
>> at, to avoid this problem.  Something like this, perhaps, instead?
>
> Yeah, that's the clean fix I was looking for, but couldn't quite come up
> with.  I'm going to re-roll with your fix instead of mine and my tests.
> Any objections to adding your sign-off?

I was actually planning to just squash 35a34ce281 as a fixup! to
your 5e65a201 and call it a day.  I think your proposed log message
in the latter clearly describes why the fix is correct.
