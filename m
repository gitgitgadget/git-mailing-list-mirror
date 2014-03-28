From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Fri, 28 Mar 2014 12:30:02 -0700
Message-ID: <xmqq8uru9l51.fsf@gitster.dls.corp.google.com>
References: <xmqqr45oixa6.fsf@gitster.dls.corp.google.com>
	<20140326192536.GA13989@sigill.intra.peff.net>
	<20140326193359.GA14105@sigill.intra.peff.net>
	<20140326212227.GC6991@hashpling.org>
	<20140326215741.GA17716@sigill.intra.peff.net>
	<20140326224616.GA9454@hashpling.org>
	<20140327224837.GB32434@sigill.intra.peff.net>
	<xmqqd2h6cm26.fsf@gitster.dls.corp.google.com>
	<20140328184710.GA29987@sigill.intra.peff.net>
	<xmqqppl69meh.fsf@gitster.dls.corp.google.com>
	<20140328190548.GB30739@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 20:30:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTcTq-0004kr-4Z
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 20:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbaC1TaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 15:30:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46702 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751902AbaC1TaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 15:30:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A613775B7;
	Fri, 28 Mar 2014 15:30:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cYdkPyUnYHhWFEswEupGlaY/7aQ=; b=KCZfX9
	L8dQ/e/M685hGRZMsnzekgnL7XDX2FJAEq7tnW5mOcbTlbJ70EVTlQBSboQM4x5J
	pXXWVMtJPfIMt1HnGgFwJ2jTfDt0XIHg+N73HFDuUaCqgNDwE+14ssnbx7ybY/+6
	mlZCmMy+ANc7FFE42gg2qmcEorL9GepoJ2jFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=voKIYEfRpd4dvVldoLU6HbIC8C5pDarz
	2d9tdt9Keg/7wvjTAmmOE00LVO1amnWrEPfqICiyQ8pMfDt/5aBEvVsd2roGwaPm
	aav3Hnvg95AQl2uizcxNX3TZM+2UaI/DbUrmZP3HWJZFhKsC+Qei1wahf+Oe/1OS
	TNmr96uecSs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA766775B3;
	Fri, 28 Mar 2014 15:30:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D8357759C;
	Fri, 28 Mar 2014 15:30:07 -0400 (EDT)
In-Reply-To: <20140328190548.GB30739@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 28 Mar 2014 15:05:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5E86279E-B6AF-11E3-BBCF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245422>

Jeff King <peff@peff.net> writes:

> This (non-)issue has consumed a lot more brain power than it is probably
> worth. I'd like to figure out which patch to go with and be done. :)

Let's just deal with a simple known cases (like FreeBSD) in the real
code that everybody exercises at runtime, and have the new test only
check we do not segfault on a value we used to segfault upon seeing.
