From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3200: clean up checks for file existence
Date: Tue, 13 Sep 2011 10:13:56 -0700
Message-ID: <7v62kwxt4b.fsf@alter.siamese.dyndns.org>
References: <20110909193033.GA31184@sigill.intra.peff.net>
 <49578782dd114220aa2562b5bd29755fc2bdd0fa.1315597137.git.git@drmicha.warpmail.net> <20110909194357.GA31446@sigill.intra.peff.net> <4E6B6647.7090802@drmicha.warpmail.net> <20110913035724.GA4828@sigill.intra.peff.net> <4E6F48C4.3030407@drmicha.warpmail.net> <20110913161358.GB28634@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 19:14:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3WYg-000736-KP
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 19:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386Ab1IMROB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 13:14:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997Ab1IMROA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 13:14:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B84585F14;
	Tue, 13 Sep 2011 13:13:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qt5a7LImY135iDEQfOHpIInoC2s=; b=o1Fun4
	ul46QcoG3JiaZ22OCjmb9QtBCBGsf281EPOrGniG5IoZTIPdaC4t7hyD+s5IK7to
	7UW71DENEDzwAGQKZ7b6NWUw/i8gD8K0S8kCyNhHP1iUTFGSMHnnHAbe7+A0MmU1
	DJPFagK9m4uSYRy05YM+TtjAIZSkFYm9+uOcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wfUR/FeWtec1FiaLAcgOnAdsSM0DMAN+
	45LfGsnh1N++AyXqPFWWUU4r1tjwB5epvTo9EGBfjnMv/hcqzMvLYhOeju8py/+G
	c1mh7LZUHEra01dZ/vUzEShNmctEcPX0WfFmdMAQVw4csF+s+K7oDKZGUFKyHOUH
	5EnDtxgMbHU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B05275F13;
	Tue, 13 Sep 2011 13:13:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46BB75F12; Tue, 13 Sep 2011
 13:13:58 -0400 (EDT)
In-Reply-To: <20110913161358.GB28634@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Sep 2011 12:13:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C48337EE-DE2B-11E0-BB74-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181292>

Jeff King <peff@peff.net> writes:

> Here it is, on top of mg/branch-list. The "test without -f" bits could
> actually be squashed in to your commits if we really want clean history,
> but I don't think it's a big deal.

Thanks.

In the longer term, we might want to update these tests further so that
they do not fail when implementation is updated not to write loose refs,
e.g.

>  test_expect_success \
>      'git branch abc should create a branch' \
> -    'git branch abc && test -f .git/refs/heads/abc'
> +    'git branch abc && test_path_is_file .git/refs/heads/abc'

    git branch abc && git show-ref -q --verify refs/heads/abc

But this patch is about correctness first, so I'll queue it as-is.
 
