From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] prompt: respect GIT_TERMINAL_PROMPT to disable terminal prompts
Date: Thu, 04 Dec 2014 13:33:53 -0800
Message-ID: <xmqqbnnjrtfi.fsf@gitster.dls.corp.google.com>
References: <20141204034206.GA1493@peff.net> <20141204035228.GB21492@peff.net>
	<xmqqy4qntgs6.fsf@gitster.dls.corp.google.com>
	<20141204210149.GB19953@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 22:34:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwe2B-0004nT-Nk
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 22:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933274AbaLDVd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 16:33:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932094AbaLDVdz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 16:33:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DAF6824E5F;
	Thu,  4 Dec 2014 16:33:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jgcrS4TUo6GFejY2ZFfZ5LyGRSk=; b=H24bCV
	njpolPfsYpu41kLHE3sffiAhLS/7D0oatodda5iYOb62DSigsoOuUHdAIEa03gbi
	unyoQjdlJF0GpD635KJrBAZZOpAb5CVSaoYcIdahOxv3aTy8eDQssQweD7b3/oY0
	K+ifjynoO0/WcYBBETUfYd1EYk+LQY3+m+RWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=olCGkxIWZYGigfOgZvWVcNBs6PHrcOoV
	i+YyOARczA2j5V25eKCBChuKvlCMOy7/757K+jvIcZoqDpezDyxXgEijoCoEmHjj
	REBpmTsBVus630CqHgaMmiUvoTtCMkAbvhKhbgfZmhkTxVgQHxW+LYLrKWZRQhjq
	qygRFd+YPO0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1E2224E5E;
	Thu,  4 Dec 2014 16:33:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 56C9524E5D;
	Thu,  4 Dec 2014 16:33:54 -0500 (EST)
In-Reply-To: <20141204210149.GB19953@peff.net> (Jeff King's message of "Thu, 4
	Dec 2014 16:01:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3F1B8926-7BFD-11E4-BA5B-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260805>

Jeff King <peff@peff.net> writes:

> On Thu, Dec 04, 2014 at 10:24:09AM -0800, Junio C Hamano wrote:
>
>> I wish this covered a lot more than just this part from an
>> end-user's point of view, but this is definitely one of the most
>> important code paths the mechanism should cover.
>
> Which parts do you mean? Stuff like "git add -i"?

No, more like "tag -s" that eventually leads to somebody prompting
for the passphrase to unlock your GPG key---and from an end user's
point of view, that somebody is Git.

Of course, from _our_ point of view, that somebody is not us.  We do
not have direct control, certainly from this codepath.
