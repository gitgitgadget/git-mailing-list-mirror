From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] notes: only append a blob to a blob
Date: Thu, 10 May 2012 20:57:59 -0700
Message-ID: <7v3977mks8.fsf@alter.siamese.dyndns.org>
References: <1336658701-9004-5-git-send-email-pclouds@gmail.com>
 <1336661015-14149-1-git-send-email-pclouds@gmail.com>
 <20120510151904.GB20639@sigill.intra.peff.net>
 <CACsJy8ADE1PBYsQcJnO6U4OFoWQjaEW7=6=3V_UO=t5KNinDCA@mail.gmail.com>
 <20120510154519.GB23941@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 11 05:58:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSgzz-0003Pr-SU
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 05:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240Ab2EKD6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 23:58:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58122 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab2EKD6C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 23:58:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 258898271;
	Thu, 10 May 2012 23:58:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JTIjHszvsvcFjyAjciJ2UI5KZQA=; b=KJg/7A
	rpnUyM1Y+dnypjURsFI7yt4V0Myr36mv823LwbWgIm0+vhBpIuH7Fi+sgF9OOJ2v
	xy3amogC/jKHPb1XNR4EIVJM+2FIRtVOEx8RcYCwxcVKVP+FxgyXqrx69uufJqZd
	hex7WX7NBSXvP5DPpLUvyd8Gpu8h9SnAfVCGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GTcCvGZYoUBjsiNJaI/I+QOvOEbFXvnP
	m5VnGILpdnP+aJwOjKBPJFfQFs6T3rD21m9jCTy0cZNMyON9Kqo2bnYjw61PXKut
	Ddw7+Ey+l4x7hE2wtlqWKNHPhcDkz5v98WBg2LtdJlse2SP1rBJyhivo1Obma7w2
	c6xd3L37EO4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C8E38270;
	Thu, 10 May 2012 23:58:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A47B826F; Thu, 10 May 2012
 23:58:00 -0400 (EDT)
In-Reply-To: <20120510154519.GB23941@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 10 May 2012 11:45:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 803ECAD0-9B1D-11E1-8A8D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197654>

Jeff King <peff@peff.net> writes:

> I think the behavior is correct, but the message confused me. If I see
> "cannot append a foo to a bar", it implies to me that it is the
> combination of the elements that is the limiting factor. But it is not.
> It is that one (or more) of the elements is not a blob, regardless of
> what the other element is. So I think this would be more accurate:
>
>   if (type != OBJ_BLOB)
>           die(_("cannot append to a non-blob note"));
>   if (msg->type != OBJ_BLOB)
>           die(_("cannot append a non-blob object to a note"));

It certainly looks easier to grok.
