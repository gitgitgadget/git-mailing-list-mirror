From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Wed, 06 Feb 2013 14:12:05 -0800
Message-ID: <7vzjzh9jnu.fsf@alter.siamese.dyndns.org>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu> <20130205083327.GA4931@elie.Belkin>
 <5110DF1D.8010505@alum.mit.edu>
 <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org> <5112D028.4050005@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:16:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3DHp-0005Ef-88
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 23:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204Ab3BFWPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 17:15:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932227Ab3BFWMP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 17:12:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE14CC4F5;
	Wed,  6 Feb 2013 17:12:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jYpsvCN2pOK2mOUqt7vglwIGUMU=; b=YXOwvp
	uQJ1LkSefIAnEMdmkSR5Xw9gLrbuEXl5ieoXtjWw86znF9qXb9h1L66bX9xRT/Rc
	eVfth4SM+NTLYTDFqfKgdbp1WSY2KowPkWYMVH47nJms4EuC3+vBQrfB0O89PHXU
	yO+FRqS2L/p2KZ9Sl3VkTFvts3sMByPO73PAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D76OlqdSnBfWMr7BTCFsh42z9Ql5m1hq
	6PRO4FaTt7LSZXkgAy3VBdj2tbsQZDWRUK8FNRuCNvtuyNk0adLO9YzBqW95UQmn
	8qeaVyT5GIlesXLYrYQp1ozTacFAhsihH8Vi7zfe5411gIoTi1ANfy65gSdeouG+
	NAl7Yvn7tfE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1B53C4F3;
	Wed,  6 Feb 2013 17:12:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CA8FC4EF; Wed,  6 Feb 2013
 17:12:07 -0500 (EST)
In-Reply-To: <5112D028.4050005@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 06 Feb 2013 22:50:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3EB650C0-70AA-11E2-BE56-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215651>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/06/2013 08:17 PM, Junio C Hamano wrote:
> ...
>
> Yes, the first three patches sound much more reasonable if this is the
> goal.
> ...
> I think that a more useful interim solution would be to make it easy to
> have two URLs accessing a single git repository, with different levels
> of reference visibility applied to each.

I think you said "more reasonable" without understanding what you
are saying is "more reasonable", then.  The mechanism is about
server side wanting to use refs to protect its own metadata from gc
without having to expose them; there is no "different levels".

> ...
>     GIT_CONFIG=config-with-hidden-refs git upload-pack ...
> or
>     git -c transfer.hiderefs=refs/pull upload-pack ...
>
> But this is a bit awkward ...

It is awkward to use hammer to drive screws in wood, too.  You want
to use a screwdriver.  The first three patches are to drive a nail
with hammer, OK?  Screws you keep bringing up is to be handled by
delayed ref advertisement.
