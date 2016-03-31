From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Signed-off-by vs Reviewed-by
Date: Thu, 31 Mar 2016 09:28:44 -0700
Message-ID: <xmqqtwjmpq6b.fsf@gitster.mtv.corp.google.com>
References: <20160331123507.GC19857@collabora.co.uk>
	<CAFZEwPMzcqrd8NEP6MH5saXL2KdUKAyN51uuoS5=aeU0aPWjJQ@mail.gmail.com>
	<20160331143501.GE19857@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@collabora.co.uk>
X-From: git-owner@vger.kernel.org Thu Mar 31 18:28:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alfSl-0001Ir-TY
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 18:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647AbcCaQ2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 12:28:48 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753533AbcCaQ2r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 12:28:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 763B450BFD;
	Thu, 31 Mar 2016 12:28:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8+YYWa7rU7Gs2i/Fe1NnffvchLA=; b=raCx1W
	FFLHA/uIEc0sGbetbM7tsdcUcS9SEp0GH+3s+eLkL0/4TgPBz6jhc81q/o9be4Tn
	y8XkXgr+tjDSPCTFxNJL0C01VmJYE956t1Zm/qun2PzjWSk5n0axWFCSpjcCkDM9
	n+f7vAGRJeVpebOx3XWPNKOvHHBWTylILv53c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dV25KTkHAZUt+0xtIjt7WTniM5MuRG7L
	2QRRAOhB0xqhyrHw70rbT/kwnaups8T/e9T+bT/V4h9ybY0jmX9L9xstcSjDWdmX
	AJ6z5lZxj5ajr4r2XR3e8K4ExS2uCQKIemTzIXadW4DJIHv5lCDItulGzFZ7znBs
	acr9a/xWxt0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E3C750BF6;
	Thu, 31 Mar 2016 12:28:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D3BDE50BF4;
	Thu, 31 Mar 2016 12:28:45 -0400 (EDT)
In-Reply-To: <20160331143501.GE19857@collabora.co.uk> (Miklos Vajna's message
	of "Thu, 31 Mar 2016 16:35:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A3EBCAF0-F75D-11E5-9F2F-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290411>

Miklos Vajna <vmiklos@collabora.co.uk> writes:

> Typing that line (including copy&pasting your name + email all the time)
> is a bit boring.

I think the last message from Christian in the thread points at the
right direction in the future.

The internal "parse the existing trailer block and manipulate it by
adding, conditionally adding, replacing and deleting it" logic was
done as an experimental "interpret-trailers" program, but polishing
it (both its design and implementation) and integrating it to the
front-line programs (e.g. "git commit") hasn't been done.

As to the last step of "integration", we cannot use short-and-sweet
single letter options like '-s' (for sign-off) for each and every
custom trailer different projects use for their own purpose (as
there are only 26 of the lowercase ASCII alphabet letters), so the
most general syntax for the option has to become "--trailer <arg>"
or some variation of it, and at that point "-s" would look like a
short-hand for "--trailer signed-off-by".
