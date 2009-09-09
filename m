From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Wed, 09 Sep 2009 12:08:08 -0700
Message-ID: <7vljkoszqf.fsf@alter.siamese.dyndns.org>
References: <be6fef0d0909080610j89c0a4bkf1cb0119b9b11db@mail.gmail.com>
 <7viqfzvwf1.fsf@alter.siamese.dyndns.org>
 <0016e6470f36315b8a0472bc75a8@google.com>
 <20090904212956.f02b0c60.rctay89@gmail.com>
 <7v8wgrbb9e.fsf@alter.siamese.dyndns.org>
 <be6fef0d0909062253p1b86628et8a9f979952eebb00@mail.gmail.com>
 <7vocpn44dg.fsf@alter.siamese.dyndns.org>
 <20090907172751.6cf38640.rctay89@gmail.com>
 <7v7hwatw0v.fsf@alter.siamese.dyndns.org>
 <20090909203350.e3d7e5dc.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, Tom Preston-Werner <tom@mojombo.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 21:08:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlSWr-00070S-Jp
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 21:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbZIITIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 15:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753349AbZIITIV
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 15:08:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbZIITIU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 15:08:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 112AD2CFBA;
	Wed,  9 Sep 2009 15:08:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KgSBJtbtBaNuN+oxzEgXwF9vV8o=; b=sZxL5M
	RlrKqj3taI4wjhtmXYqDUjGVKwIhz8ikjLW5ZtFvVjrEqQtEOZL/uErUcd13ysp6
	ZQUdPIe1kwL/Arf+RSZz2u7LdPOwPUfKYNJC0UGkwrptWH528SdMYk6iyda0HWFc
	9UCNsDkR9PJPE/7wv7Sbeau8s6eIm3RtmXL8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mBARs0SULhAmeRODG59CspBj9tZ08aMp
	AS/R45ODXKb8veXdIWC1NkOakMNbyhmr3x6EY+P3iwg3DL4RREjq7+yjgVJvxS1H
	xudlCtIZxohCZrJLaljE+EEtpcGR3cdBV47uv6bgbdBgQjMHcmf9wZ4he0HVQFsE
	bn22Qqmhr44=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C33E72CFB9;
	Wed,  9 Sep 2009 15:08:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B999F2CFB7; Wed,  9 Sep
 2009 15:08:09 -0400 (EDT)
In-Reply-To: <20090909203350.e3d7e5dc.rctay89@gmail.com> (Tay Ray Chuan's
 message of "Wed\, 9 Sep 2009 20\:33\:50 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2146B2EE-9D74-11DE-8754-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128077>

Tay Ray Chuan <rctay89@gmail.com> writes:

> I still think github.com should look into this issue (of differing
> responses for HEAD and GET requests).
>
>  -- >8 --
>
> Subject: [PATCH] http.c: remove verification of remote packs
>
> Make http.c::fetch_pack_index() no longer check for the remote pack
> with a HEAD request before fetching the corresponding pack index file.
>
> Not only does sending a HEAD request before we do a GET incur a
> performance penalty, it does not offer any significant error-
> prevention advantages (pack fetching in the *_http_pack_request()
> methods is capable of handling any errors on its own).
>
> This addresses an issue raised elsewhere:
>
>   http://code.google.com/p/msysgit/issues/detail?id=323
>   http://support.github.com/discussions/repos/957-cant-clone-over-http-or-git
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>
> Junio, I'm not sure if the credits and references ("This addresses...")
> should be included, since the patch doesn't look like it's fixing any
> thing, even though it is a response to an acknowledged issue.
>
> Please remove those lines if you so wish.

I think the backstory deserves to be recorded in this case, which is what
you did.

Thanks.
