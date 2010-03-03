From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Latest master failing t7401 submodule tests
Date: Wed, 03 Mar 2010 12:32:11 -0800
Message-ID: <7vhboxno38.fsf@alter.siamese.dyndns.org>
References: <4B8E5450.3040702@gmail.com>
 <7vhboxqje8.fsf@alter.siamese.dyndns.org>
 <20100303200239.GA28904@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 03 21:32:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmvF9-0000we-3X
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 21:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab0CCUcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 15:32:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626Ab0CCUcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 15:32:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 183FD9EA8F;
	Wed,  3 Mar 2010 15:32:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bBrmDqd4eNb/Cp2zbksZMtN3p/s=; b=IjgFqC
	grR6EWaXSNMAxY0iZL1CMwsqAYuYoCk2PCsDf5xHMFNdb77pAwMwR/C+/y0TXa0l
	RQOduqpgyA24nvGtZAdfGBz34cL5U1SDkNzfy2f/gyqggTeXCA8N5an2fikOUYU+
	Twa5neIVkpGON+yf7l1DVETwkbDiRGuyjc3U8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=canQLvZEKCQx6KFrycev594zKxOVHvoM
	vTv2kLqtgWjdZMRHKTXHVN3z3ymNzcM/vsSwWCktkiNOjoKGbKitckVwS8Z4WGT8
	nE9W80tykFQcUcsiMItF55GpuWJ128mJKz2VONEA85S68JubN7ubrPkMG+mFSm8R
	eX8PfUovi4c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D9DC9EA89;
	Wed,  3 Mar 2010 15:32:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C25939EA82; Wed,  3 Mar
 2010 15:32:13 -0500 (EST)
In-Reply-To: <20100303200239.GA28904@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 3 Mar 2010 15\:02\:39 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DC19EEA6-2703-11DF-81B1-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141473>

Jeff King <peff@peff.net> writes:

> I did see it on my debian unstable box with with dash as /bin/sh (though

3deea89 (submodule summary: Don't barf when invoked in an empty repo,
2010-02-16) looks broken.  It shifts $1 unconditionally when:

 - "git submodule summary", no arguments given and defaults to HEAD which
   is _not_ unborn (we shouldn't shift in this case);

 - "git submodule summary HEAD path...", which is not unborn (we should shift);

 - "git submodule summary path...", defaults to HEAD which is _not_ unborn
   (we shouldn't shift).
