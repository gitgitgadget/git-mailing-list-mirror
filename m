From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Configuring a third-party git hook
Date: Fri, 21 Mar 2014 11:54:58 -0700
Message-ID: <xmqqeh1vtm9p.fsf@gitster.dls.corp.google.com>
References: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
	<CAO54GHC1B6hj-OvibHn2=-B25Xd5EmfWsphJ1S7vE4bgUUX3Bw@mail.gmail.com>
	<CAPTjJmpAcmVGgJK8iUvFuXJq_ZukisRZ6OD9TM=feuxDYm5iPQ@mail.gmail.com>
	<20140320233816.GC7774@sigill.intra.peff.net>
	<CAPTjJmpYREHy1cufZMuyOoXrO1Oy7QwXR+wBvm9cbgkT7SqC4Q@mail.gmail.com>
	<20140321034334.GA29683@sigill.intra.peff.net>
	<CAPTjJmqRFbKxe8MODtBDDC0SUYGoaFmQj2724YmKnMmdbrgOUA@mail.gmail.com>
	<xmqqha6rv4og.fsf@gitster.dls.corp.google.com>
	<20140321181532.GC15508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Angelico <rosuav@gmail.com>, Kevin <ikke@ikke.info>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:55:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR4az-0006gw-18
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 19:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbaCUSzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 14:55:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59702 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbaCUSzB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 14:55:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60F3C77E20;
	Fri, 21 Mar 2014 14:55:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pvdk3t4xY28lN1uDwqkF23Aaymw=; b=qG28TV
	kuO/7PejB92Wn06mYGls0Y3EfdFSpLx5xGLASmM/IlcQXE9QiDWlnt9viAy3tgT7
	/ZoNrxwVKABcMnVyYk4ZNJoCCegWc7vowZs2Or47Zek1XidLe14QAXUxE7JYM7Uu
	5+x+mLwrwbCtr1pOeudbCrf52qqwwlW9awnP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NQwaORNOmUyDmojIGl9Cnr19dyL2tTUA
	Su6RouJDw/K3lBgXG4dfuQ6OgfUVfClJ4lQziPQGBPhK4dbKyVNw2/6sAzdGhsjp
	CockClrBCcWgVV/diYkAAnSq9EGeqBzodg7SMIwIlWRFgAT+/V0nKHnQCFitAe1V
	YtRlsxK63fE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E1C277E1E;
	Fri, 21 Mar 2014 14:55:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 991D377E1D;
	Fri, 21 Mar 2014 14:54:59 -0400 (EDT)
In-Reply-To: <20140321181532.GC15508@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 21 Mar 2014 14:15:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4D63F476-B12A-11E3-B290-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244723>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 21, 2014 at 10:31:59AM -0700, Junio C Hamano wrote:
>
>> -- >8 --
>> From: Chris Angelico <rosuav@gmail.com>
>> Date: Fri, 21 Mar 2014 15:07:08 +1100
>> Subject: [PATCH] config.txt: third-party tools may and do use their own variables
>> [...]
>> +Other git-related tools may and do use their own variables.  When
>> +inventing new variables for use in your own tool, make sure their
>> +names do not conflict with what are used by Git itself and other
>> +popular tools, and describe them in your documentation.
>
> I think this third line should be "with what _is_ used" to match the
> verb and noun pluralness[1]. Or to keep better parallel structure with
> the first clause, something like "...their names do not conflict with
> those that are used by Git...".

Thanks. I'll amend to do the "those that are".
