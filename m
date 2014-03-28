From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit vs. ignore-submodules
Date: Fri, 28 Mar 2014 10:59:19 -0700
Message-ID: <xmqqbnwqb3wo.fsf@gitster.dls.corp.google.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>
	<5335A78C.60401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronald Weiss <weiss.ronald@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 28 18:59:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTb41-0006QI-NY
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 18:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbaC1R70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 13:59:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbaC1R7W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 13:59:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FF657635F;
	Fri, 28 Mar 2014 13:59:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cjLfiOKqUAnIfXjweMbL+Uk5URE=; b=nyse/Y
	Qao13g1axEDLY1Y2k95otvMn11QhaXQhdUCi/qLBsOPmldDUlZheH9vjbKEzong0
	fSAV8KlOcSkSS8NGaFD2wphR0BuiKadMVaeO9i6Ie55N0UQv1mmhAcsqD3wTfdjb
	weKPQUCqfJGciylqz8fYBE/KMyjgL8t6T6lX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UQGOxpBrC/DbsGFh1fm19uBFoSrgqCdw
	JD2WAeCIofPWM4TrhLrmBNwqdDIWHBVcdR3MZ972wnmFx3rTySMxj56jL3M+brhu
	/kt6aLpd+NpFJ0rUzBkJvS0tAX72NAGhO1VwG20yUZFHSKS6FfXRyR9ivm93MAsr
	qorGEC+2C7s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C8947635E;
	Fri, 28 Mar 2014 13:59:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 771447635A;
	Fri, 28 Mar 2014 13:59:21 -0400 (EDT)
In-Reply-To: <5335A78C.60401@web.de> (Jens Lehmann's message of "Fri, 28 Mar
	2014 17:47:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B0985BA4-B6A2-11E3-85B0-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245406>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> .. but it's less clear if one explicitely stages an updated
>> submodule using git add. Git commit will ignore it anyway, if
>> ignore=all is configured in .gitmodules. Maybe that's correct too

That definitely smells like a bug to me.  Excluding modified
submodules when "git add -u" is run with ignore=all would be fine
and most likely the right thing to do, but once the user actually
adds the change to the index, it should not be ignored.

> ...
>> And also, I'd like to know git folks' opinion on whether it's OK that
>> git commit with ignore=all in .gitmodules ignores submodules even when
>> they are explicitely staged with git add.
>
> No, they should be visible in status and commit when the user chose
> to add them. I see if I can hack something up (as I've been bitten
> myself by that recently ;-).

Thanks.
