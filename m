From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv1 0/6] Fix bug in large transactions
Date: Thu, 22 Jan 2015 00:00:16 -0800
Message-ID: <xmqqsif3tfcf.fsf@gitster.dls.corp.google.com>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
	<20150121234659.GE11115@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu, loic@dachary.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 22 09:00:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YECgn-0002YC-JV
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 09:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbbAVIA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 03:00:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751185AbbAVIAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 03:00:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 80351296BF;
	Thu, 22 Jan 2015 03:00:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=08pvq1l627Jj3Yc/dVwsn63/X6E=; b=nJyWG8J2Om0siFaqomSF
	r2Knln35+1IvNi5IRtzwAzh3sNDGiMVbRpSmngnHPRyE3xAXZlqGP3NKhJH0f7WP
	UjzDU69OslTP986jkbABcPpbpo9zaxqmliumSqC2LoGbf5TLYRv2JGiPyc+eTfHA
	n7mXjSMevIeBo3VjOHdc5ig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=l+u4fU8uIDcIs+cMAYvIB+Kopc7RP1jDgophp95cUxD4ix
	1AMl2sWgbRK6VqIF5zNFmiHUpB0baF7Jy0feCoCvOiTrYdHBUpq6aOkzo6tW4jQh
	m2iXJXohN++rVmy8XEVAtawscXUvX9RpF0JVUbCygEDVakMze+uMyUfPdQbnA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 77529296BC;
	Thu, 22 Jan 2015 03:00:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D89B296AC;
	Thu, 22 Jan 2015 03:00:17 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B4529BAA-A20C-11E4-BB8D-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262807>

Jeff King <peff@peff.net> writes:

> On Wed, Jan 21, 2015 at 03:23:39PM -0800, Stefan Beller wrote:
>
>> (reported as: git update-ref --stdin : too many open files, 2014-12-20)
>> 
>> First a test case is introduced to demonstrate the failure,
>> the patches 2-6 are little refactoring and the last patch 
>> fixes the bug and also marks the bugs as resolved in the
>> test suite.
>> 
>> Unfortunately this applies on top of origin/next.
>
> Saying "applies on next" is not very useful to Junio. He is not going to
> branch a topic straight from "next", as merging it to master would pull
> in all of the topics cooking in "next" (not to mention a bunch of merge
> commits which are generally never part of "master").
>
> Instead, figure out which topic in next you actually _need_ to build on,
> and then it can be branched from there. And if there is no such topic,
> then you should not be building on next, of course. :) But I think you
> know that part already.

All very true.

I consider anything new that appears late in the cycle, especially
during deep in the pre-release freeze, less for me to apply but more
for others to eyeball the preview of a series the submitter plans to
work on once the next cycle starts, so basing on 'next' does not
hurt too much.  For interested others,

	git checkout origin/next^0

would be shorter to type than

	git checkout "origin/next^{/^Merge branch 'sb/atomic-push'}^2"

so... ;-)

But what is more troublesome is that neither this or updated v2
applies to 'next'.

Let me try to wiggle it in first.

Thanks.
