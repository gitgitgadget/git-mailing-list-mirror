From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 1.7.9, libcharset missing from EXTLIBS
Date: Thu, 09 Feb 2012 18:13:49 -0800
Message-ID: <7v1uq3toyq.fsf@alter.siamese.dyndns.org>
References: <4F3472F4.4060605@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCJyUnWiddJ3EnXxsoQiAbJEInMSdRJ10nUSdlJ1knYCdTGyhC?= 
	<dilyan.palauzov@aegee.org>
X-From: git-owner@vger.kernel.org Fri Feb 10 03:14:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvfzp-00026P-1I
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 03:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758016Ab2BJCNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 21:13:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754005Ab2BJCNw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 21:13:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EE9177E5;
	Thu,  9 Feb 2012 21:13:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mK3CLvizpwZUaq1DNiDT4mlymME=; b=jXC7b3
	SANtaRZfv2UU6/t7kfxyNSG/hwa8h3PxY6NCs5brVX9ilbjqXV4p7j0nPTGjGOjf
	h93iYv9sFqgZVYPhSDrrfFYfuTUf+62sAKu9o/zIoUAB7OV0j9398fdcvFXuQJgp
	WqpPGYxCokgA5mbfuZ20ydxLacbBRlDJvOp6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uk0sev3QsAIx9OTLRLXG/YCykbpXJ4mq
	jGxyjS9w2nZph+0VAJuaBa/Cnd2I4zZGZwL/1ABcFkz9VoKSvOKpuGNCvOeFUDlF
	x+/GgdqRsMyVk74nlJoP85ApHGnvAERR3Cf3cAEH83Lk1zI10tsAI2KFTkBK8cE2
	LsOZyXBDRPk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5748577E4;
	Thu,  9 Feb 2012 21:13:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5FE677E3; Thu,  9 Feb 2012
 21:13:50 -0500 (EST)
In-Reply-To: <4F3472F4.4060605@aegee.org> (=?iso-2022-jp?B?IhskQiclGyhC?=
 =?iso-2022-jp?B?GyRCJ1onXSdxJ18bKEIgGyRCJzEnUSddJ1EnZSdZJ2AnUxsoQiIncw==?=
 message of "Fri, 10 Feb 2012 02:29:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF786426-538C-11E1-9FEB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190367>

Дилян Палаузов  <dilyan.palauzov@aegee.org> writes:

> Hello,
>
> git 1.7.9 makes use of libcharset and /Makefile contains:
>
> ifdef HAVE_LIBCHARSET_H
>         BASIC_CFLAGS += -DHAVE_LIBCHARSET_H
> endif
> ...
> and the problem is, that libcharset is not used when linking.  To
> solve this, please replace the above extract from /Makefile with
>
> ifdef HAVE_LIBCHARSET_H
>         BASIC_CFLAGS += -DHAVE_LIBCHARSET_H
> 	EXTLIBS += -lcharset
> endif

Thanks.

What platform is this?  Is there a guarantee that any and all system that
use "#include <libcharset.h>" has to link with "-lcharset"?

What I am wondering is there are systems that need to include the header,
but locale_charset() does not live in /lib/libcharset.a, in which case we
cannot make HAVE_LIBCHARSET_H imply use of -lcharset.
