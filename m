From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/3] interactive git clean
Date: Fri, 03 May 2013 09:07:08 -0700
Message-ID: <7v4nekyrmb.fsf@alter.siamese.dyndns.org>
References: <cover.1367551846.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 18:07:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYIW0-0002dA-In
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 18:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933295Ab3ECQHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 12:07:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47309 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933289Ab3ECQHL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 12:07:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D2A31B0D0;
	Fri,  3 May 2013 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nIYMwJbB2dD/NP1GQ9AUIfqz2YM=; b=NbkO1/
	eaVJCBPSkxBtUrPyscmZy5VYjE420VT4uuwRJgGfhTXR/xQQiYHpiz9s0GRzLi/a
	cxWCrsCYCQ8391XSC+vZhg9Sw8+pUSAaq8oudmXICanSBTiSqB4gIUwQWYl35j3T
	mYmb8OI593ibdB+k+9wNTv1dzzn/3BuvzUiPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ld7TQ0+S8GiU6XF8853y6nPFvrHvj6bw
	oqUiZGgL/3QnyWd8La96/vZ+jlcTPeRRAhg2db9D88HsTDuCsToq6c/as+ObNrfp
	6sGeMaNSYLEfTqaGSIj2lEI43lk/IFrFdBWAHKvka+gdVFr20GBpL1yQr0zWFjqh
	RfCf7cHhyEs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 834911B0CE;
	Fri,  3 May 2013 16:07:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 040CE1B0CD;
	Fri,  3 May 2013 16:07:09 +0000 (UTC)
In-Reply-To: <cover.1367551846.git.worldhello.net@gmail.com> (Jiang Xin's
	message of "Fri, 3 May 2013 11:49:52 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 826BED8A-B40B-11E2-A33A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223313>

Jiang Xin <worldhello.net@gmail.com> writes:

> The interactive git clean combines `git clean -n` and `git clean -f`
> together to do safe cleaning, and has more features.
>
> First it displays what would be removed in columns (so that you can
> see them all in one screen). The user must confirm before actually
> cleaning.
>
>     WARNING: The following items will be removed permanently. Press "y"
>     WARNING: to start cleaning, and press "n" to abort the cleaning.
>     WARNING: You can also enter the "edit" mode, and select items
>     WARNING: to be excluded from the cleaning.
>
>       What would be removed...    What would be removed...
>       What would be removed...    What would be removed...

To a user who explicitly _asked_ to run the interactive mode, I find
these four warning lines that shout at the user in all caps way
overkill.  I would have expected the output to begin with a line to
explain what it is listing (e.g. "Cleaning the following files:"),
the list and then

    Remove (Yes/no/edit/?) ?

The existing "add -p" prompt uses this trick to hint the user that a
further help is available by typing "?", and it is a good example to
follow.
