From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] format-patch: introduce option to suppress commit hashes
Date: Mon, 07 Dec 2015 00:22:01 -0800
Message-ID: <xmqq8u56oehi.fsf@gitster.mtv.corp.google.com>
References: <1449440196-991107-1-git-send-email-sandals@crustytoothpaste.net>
	<xmqqh9jvnfbp.fsf@gitster.mtv.corp.google.com>
	<20151207033020.GA990758@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 09:22:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5r3o-0006B7-3z
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 09:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbbLGIWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 03:22:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753232AbbLGIWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 03:22:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 998DA2CD14;
	Mon,  7 Dec 2015 03:22:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sTN/KKAwf1UNqq7nFXUduLaIkmw=; b=BRhVSs
	4PSPQtA4xDpujZloDsgZewRfEyU2vtTCgjG67D6nYeyVGOZKbcnedSB2A9UZPqnN
	KVgkZqz8APy/ZCVhnHmGnWWpT766LGPvFMaRGKxxLWjdEv6r8XmKOZnXWanvVUp9
	4SLRSA9Xa6GHBVVETDIDSYH7m7DWf//QmRJas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ylw0rpgbkqacMWjW5EFEAJzzRs64FGSs
	pRsriXyn6IX2p+e6Kd0Wyf4zxVFUn0nRj5ZYVqW3H9IwyGawWDoCWbGYAJTro8w1
	DWWI48LZrB/8QTve0HpztfHcyONlYA+8tgUy/97O0/d3YuEAgKFvQERtniWxr6P8
	9qs0x9TfSaY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 910232CD13;
	Mon,  7 Dec 2015 03:22:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 05DD32CD12;
	Mon,  7 Dec 2015 03:22:02 -0500 (EST)
In-Reply-To: <20151207033020.GA990758@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 7 Dec 2015 03:30:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9829CDE0-9CBB-11E5-84A7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282087>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The hash of the source file isn't generally as much of a problem,
> because the patch tends to change, even incidentally (line numbers and
> such), when the hash of the file changes.  It's also something that we
> have in our history, whereas the temporary branch we rebased in is not.

That is exactly the kind of workflow specific reasoning that tells
you "object name of the commit that the patch was taken from is the
only thing that is undesired" that makes me wonder if the feature is
too workflow specific.  You do something on a temporary branch without
worrying about producing unnecessary object name churn, and end up
wanting not to see object names.

But I can buy that a step in the workflow to rebuild the history on
a temporary branch before going to the next step is a common thing
to have, so let's decide to accept the goal as a good thing to have,
and see how well the patched code implements, documents and tests
the advertised new feature.

Thanks.
