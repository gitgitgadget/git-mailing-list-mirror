From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] Refactor excluded and path_excluded
Date: Wed, 05 Sep 2012 20:21:35 -0700
Message-ID: <7v627r7s5c.fsf@alter.siamese.dyndns.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-6-git-send-email-git@adamspiers.org>
 <CACsJy8A-P0RziZt1_PajFrzqmq9ZbkyaxwUCeDAO3XteQ0gAag@mail.gmail.com>
 <7vr4qhbt3d.fsf@alter.siamese.dyndns.org>
 <CACsJy8D23tDa3SJO6yegHFs2hT+bTr6mLTn16ZU3kiT1dtj4vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 05:22:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9SfU-0006Hi-U1
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 05:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab2IFDVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 23:21:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64663 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979Ab2IFDVi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 23:21:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E21918E40;
	Wed,  5 Sep 2012 23:21:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K5dARnOe36jRH30atu1OtPWRtP8=; b=Q30ocd
	FCya+TEb4Uo2xDYcr9u1THJOnkxdsjOi4qc5KKGLIOi0AhHTYYjD7xUreuWyhSM6
	LIhTO2KgPFlxxdgKtuRK5XlRkv4BlBrV9+bHuS8znKYJyG2sezxh796e0JfdefH9
	6GDIal8g3CQwWD0cYJzlabYOET0WP9N1OSTHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xH6KXnPWxbcZD/XPdCJQu89+U9dubLiz
	2bGLX/HEJMn9DtiBcSNcfddoPXuoAHZfSYdGEF9gp4L8FlgzGL25q3u7MkOgNVS/
	fpZHU/4mDBvHfKwyVDDMpF0Q8F62h6dLlBEJr5lgqmgA7dEaiGf+f33i01n3CDUd
	w6k2KspwfZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF93C8E3F;
	Wed,  5 Sep 2012 23:21:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51F678E3E; Wed,  5 Sep 2012
 23:21:37 -0400 (EDT)
In-Reply-To: <CACsJy8D23tDa3SJO6yegHFs2hT+bTr6mLTn16ZU3kiT1dtj4vw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 5 Sep 2012 17:28:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7AE3306-F7D1-11E1-B9F1-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204854>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> We could introduce exclude_path() and kill path_excluded() then. There
> are just about 5-6 call sites to replace.

The name path_excluded(... path ...) sounds like it is asking a
yes/no question "is this path excluded?", which actually is what is
going on.

The name exclude_path(... path ...) sounds as if you are requesting
somebody to exclude the path.  Does that meaning match the semantics
of the function?
