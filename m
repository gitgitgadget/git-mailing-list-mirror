From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/4] cache-tree: Write updated cache-tree after commit
Date: Wed, 16 Jul 2014 10:33:20 -0700
Message-ID: <xmqq38e1tdi7.fsf@gitster.dls.corp.google.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
	<1405140276-32162-4-git-send-email-dturner@twitter.com>
	<CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com>
	<xmqqr41oylyo.fsf@gitster.dls.corp.google.com>
	<53C41456.2000006@ramsay1.demon.co.uk>
	<xmqqvbqzygkm.fsf@gitster.dls.corp.google.com>
	<53C42453.1090109@ramsay1.demon.co.uk>
	<xmqq8unvy4bf.fsf@gitster.dls.corp.google.com>
	<CACsJy8BvQYyXWB7YfoonfEeqi9gStEZHqKC_JNAhxZbLJas54w@mail.gmail.com>
	<CAPc5daVH=i72Y4dA8TefPLfFB79Cvw7STPnQf_f10cBeYbg2ug@mail.gmail.com>
	<20140715102314.GA8273@lanh>
	<xmqqbnsqwoxz.fsf@gitster.dls.corp.google.com>
	<CACsJy8BsoYP40K7vFoZhgXvy32vkHjhwCMYLFM6ishXcVXdzAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 19:33:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7T5B-0002eH-Bn
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 19:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759981AbaGPRda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 13:33:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59496 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759391AbaGPRd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 13:33:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D558627789;
	Wed, 16 Jul 2014 13:33:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A8YhrFS+TA/W7yj0sRRuRDu6GF4=; b=YK/ce8
	prwfD0flNXBqC8tYvBgRbZdy4DxO1Oxb2kupxZ8OHAgQYKfxMAm7mV4H3zfg5brV
	QGdQPZHGw0mXmc2V6XhnmScXYvVsB7LxPyffJBb8axQ68SLCz0szrp0dyBxMJhJI
	bob+lM+/fvEdPNy3JPfHwuEM34tY3qhWcr8vc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q9QsuLjOIhB4erEp8guUihBSD9RHK0+Y
	zUT/eEX/9688fPJEqj8DtGaYPR37qVSkwpLi/GYJyXJg9WjCxDq4gT8jHpMG+DUo
	Y+njwx/FD3GIqLLb3IErXphOnR1q3Hkyxa29447y1kEKc2LYn0bC0O5KaINzJTr3
	BQ92nCq+Bp0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CAA9527788;
	Wed, 16 Jul 2014 13:33:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 234852777F;
	Wed, 16 Jul 2014 13:33:22 -0400 (EDT)
In-Reply-To: <CACsJy8BsoYP40K7vFoZhgXvy32vkHjhwCMYLFM6ishXcVXdzAA@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 16 Jul 2014 17:18:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4899248E-0D0F-11E4-B6D7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253679>

Duy Nguyen <pclouds@gmail.com> writes:

>> ....  If you do not
>> use the extra temporary file, you start from "index.lock" left by
>> "add -i", write the updated index into "index.lock" and if you fail
>> to write, you have to roll back the entire "index"---you lose the
>> option to use the index left by "add -i" without repopulated
>> cache-tree.  But in the index update context, I do not think such a
>> complexity is not necessary.  If something fails, we should fail and
>> roll back the entire "index".
>
> I probably look at the problem from a wrong angle. To me the result of
> "commit -p" is precious. I'm not a big user of "commit -p" myself as I
> prefer "add -p" but it's the same...

Oh, we agree that the result of "commit -p" is precious.

But the point of David's series is to change the definition of the
"precious result" to not just "commit is made as asked", but now
also to include that "the index the user will use for continued work
will have populated cache-tree".  The series thinks both are precious.

As you can probably read from my review responses, I am not sold to
the idea that spending extra cycles to pre-populate cache-tree is
100% good idea, but if we _were_ to accept that it is a good idea,
it logically follows that failing to populate cache-tree is just as
a failure as failing to commit.

In any case, it is unlikely for writing out the updated index with
refreshed cache-tree to fail and blow away the partially built index
(we do not even attempt to reopen/update if we cannot prepare
in-core cache-tree), so I do not think it is such a big deal either
way.
