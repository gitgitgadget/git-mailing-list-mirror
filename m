From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On "interpret-trailers" standalone tool
Date: Wed, 16 Apr 2014 11:40:34 -0700
Message-ID: <xmqqlhv5glst.fsf@gitster.dls.corp.google.com>
References: <xmqq61mi1djt.fsf@gitster.dls.corp.google.com>
	<20140412.213003.73509455950485398.chriscool@tuxfamily.org>
	<xmqqy4z7lhc4.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0w9xUwuk9UZ_mu=qvjtYN1r5skidweruM8t1KbfQpQyA@mail.gmail.com>
	<xmqq38hdi2zr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 20:40:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaUlJ-0002pr-O2
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 20:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755666AbaDPSkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 14:40:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64545 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbaDPSki (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 14:40:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E625E7BD61;
	Wed, 16 Apr 2014 14:40:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NguDgXlJH9A3uDaSLfB2EFzZ13Q=; b=ZJcJBL
	LNopp/9JyG2VgbpvKsiJwUdZpm4vtj6ujWU2pbntP6p4mVGwJr+q6JzR4bEcUMgy
	UFCladDW5UutKa/xbReLK+GgLqTNyxpc7DhqZUoQzGigydSNMQ3tgGGhGWsAEB9d
	dEezjJmvz+U5OUPK88NWBKN/fOEtELEQZe5GI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BHwYYV9YVF/dkLgg4KvjA9cYA8sJ15fF
	gd/TOgBU+k5G5iIp8ROlwejy6RURKU2qSU/J4rd8xqwBdiwOBlyWEYW2FTVNifqu
	UetQQ7tvF+BkOV2BTaWObQLtkyuGTePc7mRgNbxqxGwDjgujaQDtnJycwxTIr7Ln
	38eZyxTE7tI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D12E07BD60;
	Wed, 16 Apr 2014 14:40:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD2B57BD5F;
	Wed, 16 Apr 2014 14:40:35 -0400 (EDT)
In-Reply-To: <xmqq38hdi2zr.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 16 Apr 2014 10:43:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 99568BB6-C596-11E3-88FC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246371>

Junio C Hamano <gitster@pobox.com> writes:

> ...  I am looking at this
> more from the angle of obtaining a useful building block, while you
> seem to be thinking of this as a specialized tool for a narrow set
> of specifkc tasks.

By the way, I am speaking with a bitter experience of designing the
original "format-patch" command line parameters, thinking that "This
is a specialized tool to let me send what Linus hasn't picked up
yet, so the command should take where Linus is and where I am".

Not using the A..B syntax turned out to be a poor choice but that
realization came long after the ship sailed---back then, A..B syntax
was relatively new and it was unclear that it would become the
universal syntax we use throughout the system to denote a range of
commits in the DAG.

The design mistake for starting at a specialized tool for a narrow
set of specific tasks took considerable effort to retrofit the
general syntax while not breaking the traditional usage.  I am being
cautious here because I do not see us making the same mistake.
