From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: git clone does not respect command line options
Date: Fri, 26 Feb 2016 08:59:06 -0800
Message-ID: <xmqqegbzl86d.fsf@gitster.mtv.corp.google.com>
References: <CAMDzUtzoiJWzckTX818HJV=su0eEP35gsNDJ=+k_me08EDvxRg@mail.gmail.com>
	<CAMDzUtxQPMty0Nncr7Yj3up6Zb6F-E0QudOMOZO_jG-Goq0YBg@mail.gmail.com>
	<20160226073444.GA26340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Guilherme <guibufolo@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 17:59:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZLjX-0004KD-2s
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 17:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933502AbcBZQ7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 11:59:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932659AbcBZQ7K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 11:59:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7E5CB43E63;
	Fri, 26 Feb 2016 11:59:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C/kOezByYsfGUDRbWy1J0LHpIaw=; b=Ni4K5l
	w0X1oYsFCRpC1JE7kXEuSOmvloh7ONqPyVxuMhhpGvOkFdEICLLJYAm5+1KRD2Fm
	/lmFumNqgn1a+ez5ldKBEEdUHvsysy1Wlk+MXZsys/HB+K0xPcFl9jYoillqPgIi
	o0Vy6iVDE/ycgmgrqqt/KhKby2yEmjITYClK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MxgDmdl2sAaRt/0UjZAC/Mi1oPnVBf2D
	fv2JLvjlpx88eh7QQZ/LOp6Rxd9Sl8XEhZ8leEQ46ixLMbbJht3ROGdneW0jaTNd
	EKBP+2P9B1qCzhWIHTinyS36YUsGWoeCmjkBZ7To4sfXdrAF2m8altjzcamp7bsi
	N0xm0ZlHqMk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7349343E61;
	Fri, 26 Feb 2016 11:59:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DE09B43E5C;
	Fri, 26 Feb 2016 11:59:07 -0500 (EST)
In-Reply-To: <20160226073444.GA26340@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 26 Feb 2016 02:34:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3FE5DD5C-DCAA-11E5-9819-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287591>

Jeff King <peff@peff.net> writes:

> That's behaving as expected. Unfortunately, you cannot currently do what
> you want easily; there is no way to "unset" a multi-valued config
> variable (like credential.helper) with a later one. Git will ask both
> configured helpers for the password, and will store a successful result
> in both.
>
> The simplest way I can think of to work around it is to point your $HOME
> elsewhere[1] during the integration test, so that it does not read your
> regular ~/gitconfig.

Yup, that was the reaction I initially had.  I saw your "setting
helper to an empty string does not mean anything sensible, so let's
use it as a signal to clear the list" patch and I think that is a
reasonable workaround.

Thanks.
