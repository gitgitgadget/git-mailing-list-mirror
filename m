From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule.sh: avoid "test <cond> -a/-o <cond>"
Date: Tue, 10 Jun 2014 07:55:58 -0700
Message-ID: <xmqq7g4obypt.fsf@gitster.dls.corp.google.com>
References: <1402403313-22468-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 16:56:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuNT9-0004r8-DN
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 16:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbaFJO4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 10:56:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59942 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbaFJO4E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 10:56:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4419B1C58D;
	Tue, 10 Jun 2014 10:56:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ByQQDAF3CuHKI1sEuv1sc64cGw4=; b=wrqcLP
	NrPZJrX8ZgetMA7tx04kn1Igwe+VkkanWtHN45cdj9TcRPeP0NZYird5yzvCD1FL
	qoh8OE7PqWrtcmtBwMAN2ZJtDI+1AukWhImxM8h702w2XUtquxbJbcu6twclGa6e
	13SnhTiFF3rhjcV5EbGbcYMvkof2hRtlVKy1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=grvSygYRInHCATU5gYFDzwHxInecEQWx
	ox2FoTuOdgWFjG+9TOo1wYB/ZCuKS5s4AiaUw2rLnfk8JCCyPX7SKexWCvPhkZM7
	QVKEDKNth0WPrqjij/9NHbeV/OZgqmujxNxCcmENSOGvYMn5Vd0r64FwojQ+b2FM
	eI7ahmystzI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 390E81C58C;
	Tue, 10 Jun 2014 10:56:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 45BD51C585;
	Tue, 10 Jun 2014 10:56:00 -0400 (EDT)
In-Reply-To: <1402403313-22468-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 10 Jun 2014 05:28:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 55F04648-F0AF-11E3-8D81-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251194>

Elia Pinto <gitter.spiros@gmail.com> writes:

> @@ -832,7 +832,7 @@ Maybe you want to use 'update --init'?")"
>  			continue
>  		fi
>  
> -		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
> +		if ! test -d "$sm_path"/.git || test -f "$sm_path"/.git

Which part of test conditions does that "!" apply in the original,
and in the updated? 

I think the new test after || also needs negation, no?
