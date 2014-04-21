From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What is missing from Git v2.0
Date: Mon, 21 Apr 2014 12:39:04 -0700
Message-ID: <xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
	<53557071.5040500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 21:39:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcK3g-0000Ej-MR
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 21:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbaDUTjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 15:39:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64491 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbaDUTjM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 15:39:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 449787F9CB;
	Mon, 21 Apr 2014 15:39:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qGTdOrx7TzaJ/hSmugEbeVoHPew=; b=gxK2Om
	NGscDnBRAYb8CVVC9MZSXykfE1KACYVhiGnM5bK+k6CwJdrEy8yvY9EfCavuHAeu
	bo5oteGtTDC4lFAg3snjDcrbn+hpAMrQuWwInr9ax6/N2ogqwJBS59EK5Zoz2QOx
	oj036255yGPz+b2QqPCr++c4ttTC8jQFM6gBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YlT9nof2UE4cYjL/2fxJYFJYMuchmgWz
	mRUhXJ4sH7t+z4HoO+AaXkJXH+rQ56iiUh+bzSjwLOUz/BlO2xcfKkCHa/p6CQUd
	esM1+4MQaCRM5S7Zu6jadJn5BvXB123WD0SM56hw/+cLXE6TvjQbYNLyKTizQR7a
	5tZwKIYqcj4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F3997F9CA;
	Mon, 21 Apr 2014 15:39:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4EC737F9BD;
	Mon, 21 Apr 2014 15:39:06 -0400 (EDT)
In-Reply-To: <53557071.5040500@gmail.com> (Sebastian Schuberth's message of
	"Mon, 21 Apr 2014 21:24:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 99C17DBE-C98C-11E3-B0A4-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246626>

Sebastian Schuberth <sschuberth@gmail.com> writes:

>> Every argument against default aliases was basically refuted, yet my
>> patches went nowhere. And the users still expect these aliases.
>
> +1 about having default aliases in general, and I'd also add these:

I think it might be OK to implement them as the lowest priority
fallback alias, so that '[alias] co = "user's definition"' anywhere
in the various configuration locations will override it.  I am a bit
hesitant about adding start-up overhead, though.  Also I am not sure
if people can agree with (1) a broadly wide selection of aliases and
(2) the actual definitions for them (I am OK with "co === checkout"
myself, but I'd rather not to even think about my Git wasting cycles
parsing extra configuration items to support "br === branch" at all,
for example).

If we squat on "co" and other short-and-sweet friends by adding them
as built-in aliases (i.e by adding them to git.c:commands[]), the
only effect would be to annoy people who have them defined somewhat
slightly differently, so that won't fly well.

> If we don't standardize this now people will come up with their own
> definitions [1] [2] (and many others if you just search GitHub) which
> are again likely to differ (slightly), hindering interoperability.

I am afraid that that ship has sailed long time ago, though.
