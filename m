From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] deprecating and eventually removing "git relink"?
Date: Mon, 14 Nov 2011 12:18:25 -0800
Message-ID: <7vfwhqjw4u.fsf@alter.siamese.dyndns.org>
References: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org>
 <buomxbzutjm.fsf@dhlpc061.dev.necel.com>
 <CAD=rjTXgH+AivmK+zLurQVC+=p1UYqFy_p=wBF-1-TOQ=Cqjtw@mail.gmail.com>
 <20111114103451.GA10847@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Brenner <olsner@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 14 21:18:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ2zD-0001x1-RQ
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 21:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165Ab1KNUSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 15:18:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47868 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756157Ab1KNUSa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 15:18:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BA245E43;
	Mon, 14 Nov 2011 15:18:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/NeJ94SMZo/Nv9HtdoiXmU9jSqI=; b=gHTU+v
	GLztk7Oj4rFZiWbKNjJ/tZBNkw+00KSJo+k8Gi6lMRv8PzgQW0Z9nt2mPDn2TGYH
	zSYtBttQT6PvOfbrMi4gHyRck2XzDtzpYdcBqf9zwzRNWNgzNxDvYJkYCwO+u5UC
	lCcX0Nn+zq2T+9HoYKTHmhtKa9lSls61Vv7HE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L8twnYU0Fe/3FTQY8I/m5aTGW99tV4uP
	DXdBuiHKlrjo92qQ6OyJHFuNyPz028Pi0lJFRByIBZQp3iSuGdPFYoYbbImogZ4A
	GG3FtPRxGD3ksQ6SPEvF6At3oR7hWyySwr9LW/GWzVl2NNufvpULJdoocgVF3Pru
	N6iF9YKww8k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 537355E41;
	Mon, 14 Nov 2011 15:18:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0E705E40; Mon, 14 Nov 2011
 15:18:26 -0500 (EST)
In-Reply-To: <20111114103451.GA10847@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 14 Nov 2011 05:34:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF76D11C-0EFD-11E1-94D9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185394>

Jeff King <peff@peff.net> writes:

> On Mon, Nov 14, 2011 at 09:48:07AM +0100, Simon Brenner wrote:
>
>> On Mon, Nov 14, 2011 at 7:06 AM, Miles Bader <miles@gnu.org> wrote:
>> > It might be nice to have a mechanism where new objects would update
>> > the _alternate_ rather than the object-store in the tree where the
>> > command was run... then you could easily have a bunch of trees using a
>> > central object store without needing to update the central store
>> > occasionally by hand (and do gc in its "clients")...
>> 
>> This sounds like a nice way forward: replace/extend the current
>> alternates system ...
>
> Yes, I think that is sensible. I'm not sure there is even any core git
> code to be written. I think a wrapper that does the following would
> probably work:

I agree with your outline, which I find is in line with what I had in mind
in the message Miles responded.

The approach is different from what Miles alluded to, which is to have
"clients" create objects in the "central" place in the first place,
though.
