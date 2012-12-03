From: Junio C Hamano <gitster@pobox.com>
Subject: Re: does a successful 'git gc' imply 'git fsck'
Date: Mon, 03 Dec 2012 06:06:21 -0800
Message-ID: <7vpq2rtele.fsf@alter.siamese.dyndns.org>
References: <CAMK1S_iBq1ReGkjuy2UBENSQXOWyKj2ZzSCcg7Z89FVtVL2wMw@mail.gmail.com>
 <7vlidgls09.fsf@alter.siamese.dyndns.org> <vpq4nk3uu39.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Dec 03 15:06:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfWfR-00006d-2X
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 15:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642Ab2LCOGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 09:06:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60241 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218Ab2LCOGY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 09:06:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AAED96FC;
	Mon,  3 Dec 2012 09:06:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7oR4+6HzXY4nBZpUL+wjR9vJS18=; b=dfo3DV
	g5fVr3H7Q6tfEGHCRddAdNlEynr+tQeR48BU/nT93sa7Qsg1uh89UqRaj6kASjHQ
	yrMk8MTq63Mb4Bu6b8ExvFVnPUHGJ4UE/k68oBDwu95yV/mztRFNQlavNoEVuLpC
	HvENuLE54WFn5MjVxfNcOjvkoZ4jfeaf7yrE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iis+OhZVd9JayNmO3uWSdcFZZmIXaGWj
	rXgUDOlX35msEWsXZZQQFsBlZoDEfb4ITW23zxAYwa7r8Dlod4cgDic57NzQo5My
	1JYEAwbPz5C3iet32OkNZl3A+3F3KVBg6yWwU38ZWaA7mBLqTmSgOOltcd67tNvB
	XkQZi36ZXQM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6799396FB;
	Mon,  3 Dec 2012 09:06:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF16196FA; Mon,  3 Dec 2012
 09:06:22 -0500 (EST)
In-Reply-To: <vpq4nk3uu39.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 03 Dec 2012 14:46:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E6EED32-3D52-11E2-A0ED-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211038>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> But a "gc" does not necessarily run "repack -a" when it does not see
>> too many pack files, so it can end up scanning only the surface of
>> the history to collect the recently created loose objects into a
>> pack, and stop its traversal without going into existing packfiles.
>
> Isn't that the behavior of "git gc --auto", not plain "git gc" ?

True; I missed that Sitaram was running "gc" manually.
