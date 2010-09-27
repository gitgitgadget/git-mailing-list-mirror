From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2010, #05; Wed, 15)
Date: Sun, 26 Sep 2010 20:52:15 -0700
Message-ID: <7vocbjn8r4.fsf@alter.siamese.dyndns.org>
References: <7viq266461.fsf@alter.siamese.dyndns.org>
 <20100925143008.14dfbfa6@laptop.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Sulfrian <alexander@sulfrian.net>
X-From: git-owner@vger.kernel.org Mon Sep 27 05:54:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P04ne-0000LR-Kg
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 05:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652Ab0I0DwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 23:52:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647Ab0I0DwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 23:52:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 84C44D9C2C;
	Sun, 26 Sep 2010 23:52:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lmjZZvwhjpB6qjjtaax1DS0SKuo=; b=yCsjd+
	sSnrt4/sJy/v3L9bQ/hidf6wGRMvEcGFIJoLj9tzBkjAnGID14gA7/QScAzOebGF
	L10Rulr3FRo1f8Qu4xed/kGIhph4N4FrJ3jPW+Inu1Av5w7dC9kWe4aYs8ZXyTQY
	yR+xA4XRzaYAYngRV9ym6TMN47ZAbQY1umnWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mzKPCuNtuw7hbeostfyraVBelxZk16Pa
	VcEvRxnOoY8aEcM3srw3NxrowojHPocZ1SNKi94Pt6+ihsXV380ToDbki1dR6qvu
	pF3ovxAcIjT8hsVVWfK3AATcBDRmZi8yF3gXcn0CJL11gIXsSm4Mjf5Lt6SnwJ9u
	vJBiKZBxdsY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 610BED9C2B;
	Sun, 26 Sep 2010 23:52:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6FC3D9C2A; Sun, 26 Sep
 2010 23:52:17 -0400 (EDT)
In-Reply-To: <20100925143008.14dfbfa6@laptop.localhost> (Alexander Sulfrian's
 message of "Sat\, 25 Sep 2010 14\:30\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A0EB2B62-C9EA-11DF-9217-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157292>

Alexander Sulfrian <alexander@sulfrian.net> writes:

> that's not true. The last version (v4) logs for every listen an error
> if no socket could be created. And dies if not a single socket is there
> after processing all --listen options.

Hmm, the copy in 'pu' has at least these issues.

 - The error behaviour is different between with and without IPV6
   compilation.  A failure from getaddrinfo() on one named address results
   in die, but a failure from corresponding inet_pton() in NO_IPV6
   codepath does not.  I think I've recommended both not to die and let
   the caller do the diagnosing and dying?

 - The style of API, which passes (int **list_p, int cnt) and returns the
   updated cnt, was unwieldy; I thought I recommended to use a struct that
   can be more easily used with ALLOC_GROW() API?

Perhaps there was a v4 that came during the freeze period that I didn't
look at?
