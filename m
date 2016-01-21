From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] submodule-config: keep groups around
Date: Wed, 20 Jan 2016 18:37:00 -0800
Message-ID: <xmqqio2n1wvn.fsf@gitster.mtv.corp.google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<1453260880-628-3-git-send-email-sbeller@google.com>
	<xmqqwpr43pyz.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZXSUkMx=+P0+L4yastYzqeCAUf83L2t8H9=QAC1FwuiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 03:37:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM57W-0002s8-0B
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 03:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbcAUChH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 21:37:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751499AbcAUChE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 21:37:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1088B3E3E3;
	Wed, 20 Jan 2016 21:37:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tu40dzX4rf0KpSUquQkg+9b9pvU=; b=aGyoZ9
	evgLXyabRQgts7Tlw6+LaoLmvqF3s1Du3kedZS4WDUnS0n5Y5cCj5O2XxtNLdgfe
	aTHOSTnhhQ/YgMuj+3CSPPJLpG7c4Pi5evc18FAKv+UUzbNWwM0la909MXmZrcTJ
	DmTAMYjMgxqR0ehSP7qoGJD7d+0SkBAypT6VI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TvXUk8yrpQD5n/kP3ZaGCy9prw3937TN
	T+kP0pQryUoSplXfFLJL0HYZ5YghUctbuUoIg0gP1YA+Wjyc6Ngkcay7c53ulcuz
	OulvfLgNMzEMN6zNySPhe7Zt1WXg8wE94HTjUV6T+a2Z+t21jNy2Gqv2sSNIRCpM
	cDwVJTQEGoo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0702F3E3E2;
	Wed, 20 Jan 2016 21:37:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 59FFA3E3E1;
	Wed, 20 Jan 2016 21:37:02 -0500 (EST)
In-Reply-To: <CAGZ79kZXSUkMx=+P0+L4yastYzqeCAUf83L2t8H9=QAC1FwuiA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 20 Jan 2016 16:20:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DA33750C-BFE7-11E5-A6AF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284496>

Stefan Beller <sbeller@google.com> writes:

> In this patch series we only need to check the items of that list one by one,
> no need for a sorted version, so I'll change it to be unsorted and
> document that.

I actually was going to suggest keeping the sorted one.  The order
may be changed from the order specified in the file, but the sorted
variant has one very desirable property, namely de-duping, that the
code that uses this data structure may find useful.
