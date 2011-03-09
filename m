From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git cat-file does not terminate
Date: Wed, 09 Mar 2011 11:32:12 -0800
Message-ID: <7vzkp49jk3.fsf@alter.siamese.dyndns.org>
References: <4D70E340.3050309@tweerlei.de>
 <20110304154014.GE24660@m62s10.vlinux.de>
 <20110304160047.GA9662@sigill.intra.peff.net>
 <7vzkpa7qmp.fsf@alter.siamese.dyndns.org>
 <20110308211423.GB4594@sigill.intra.peff.net>
 <7vwrk9cjib.fsf@alter.siamese.dyndns.org> <4D779385.3070602@tweerlei.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Peter Baumann <waste.manager@gmx.de>,
	git@vger.kernel.org
To: Robert Wruck <wruck@tweerlei.de>
X-From: git-owner@vger.kernel.org Wed Mar 09 20:32:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxP7W-0006Fo-PJ
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 20:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280Ab1CITcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 14:32:25 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab1CITcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 14:32:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 53F7D35F7;
	Wed,  9 Mar 2011 14:33:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=xW+lJPnn3fcQXb0MVJt7z8A8R/k=; b=qgD05vvmC6KL/X1LOvTd
	ZNBYUZ28ZsGETPdZyxHSgsph+qJ2/8ESTVQeM7RZSF+naxB5++66GqOIHuCphQDd
	HQ+efFvWSk68wuixIfiBmEgUkdQGaJM/WfeNZZVvuSRbRmdiZjNc0UaBRJJmpsDu
	zCze1GlLf74fcQ5yxq+BuRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=bQBLc40PytnGtHYPSJuZ5X28Oh6A7HmX6gLqGFLzsln3k4
	KhsP3fbOOVyFIPdX5SqnitdHX0U3dMmZACQ9USOkPSTz8FOHWalqRo7pYnwK0DlG
	7kIyIBTwdHlVXh7RBPLVdVgsLGzxKtBhlUiIYLKKiv+8YT5lsu4SMYjsbEmF4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0ED4B35F1;
	Wed,  9 Mar 2011 14:33:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9574035ED; Wed,  9 Mar 2011
 14:33:42 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 277D7E2C-4A84-11E0-8725-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168747>

Robert Wruck <wruck@tweerlei.de> writes:

>> I asked (1) if we can find out at runtime if we are on which version of
>> cygwin1.dll, and (2) if we can have a small list of "bad" versions of
>> cygwin1.dll.  If both are true, the runtime test should be trivial, no?
>
> Currently I don't know of a programmatic way to get the cygwin version
> except `cygcheck -c cygwin` or `uname -r` but these utilities seem to
> know where to find it. I'll take a look at the source.

Thanks; it is not very critical so don't spend too much effort trying to
find a way to do so at runtime.  We can always use the approach Jeff's
Makefile patch took to make it safe (and potentially slow) by default on
all Cygwin while still allowing people on an unaffected version to turn
the workaround off while building.
