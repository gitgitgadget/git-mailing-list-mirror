From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dangerous "git am --abort" behavior
Date: Thu, 23 Dec 2010 14:32:23 -0800
Message-ID: <7vtyi415oo.fsf@alter.siamese.dyndns.org>
References: <AANLkTinP4SArMkjvTXOEG=tf=8EcEdP9fPAB7F=iitSc@mail.gmail.com>
 <loom.20101220T203122-271@post.gmane.org>
 <1292881979.23145.5.camel@drew-northup.unet.maine.edu>
 <AANLkTikUn+Mco3YeJ7Rj=xZrr1H5xr1Z0=cknf1MdCqC@mail.gmail.com>
 <m2tyi45ell.fsf@Spindle.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Steven E. Harris" <seh@panix.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 23:32:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVti9-0003u0-TD
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 23:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944Ab0LWWcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Dec 2010 17:32:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60233 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab0LWWcc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Dec 2010 17:32:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B638236CE;
	Thu, 23 Dec 2010 17:32:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RQSC6QrObMPensF+d1LvEo/9GQ4=; b=F88Gz/
	TZM2a7T/FWOxH0BbE9MVrw+vylw23ZO9u6LTYVsb1F7rsTJwNFP6pVmLwLv0hx/W
	TAIbrzI/46xFamJF2Kehj4A/LmFYSodG6Ip996RELyYzv3uZkU1Bwnw/KPic9m3V
	7yfA+p+xD3JYUEA/e5L2pMYrCdSW5YtFlX/zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PVuHQUPbCho0et+T3ZmSC4FLsZCNU2CO
	IhEULIP9N2DuaC07UDGTPXKEdHDByNINQDeMKcumNjBEi/6mSIIGxJU3sJJBOrWK
	hDi6ac3hg+OwS5R5cOIkPbjjzsHKMHkAGvHyXuGDAlWrqSt9Ty7wbWHyrS2HwdD4
	pFOGLuo6GO4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 93E3036CD;
	Thu, 23 Dec 2010 17:32:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B85D936CC; Thu, 23 Dec 2010
 17:32:54 -0500 (EST)
In-Reply-To: <m2tyi45ell.fsf@Spindle.sehlabs.com> (Steven E. Harris's message
 of "Thu\, 23 Dec 2010 17\:06\:14 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 975934CE-0EE4-11E0-A85E-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164139>

"Steven E. Harris" <seh@panix.com> writes:

> Adam Monsen <haircut@gmail.com> writes:
>
>> That's a good way to keep tabs on whether you're in the middle of a
>> rebase or am (as well as many other statuses).
>
> How so? How are you using it for this purpose?

There is this gem in the completion script:

#    3) Consider changing your PS1 to also show the current branch:
#        PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

With this, you will see something like:

    [junio@alter git.git (master|AM)]$ 

as your prompt while you are working to fix corrupt patch you tried but
failed to apply.
