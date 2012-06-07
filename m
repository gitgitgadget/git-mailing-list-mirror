From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Getting pickaxe to perform looser matches, or regex matching
Date: Thu, 07 Jun 2012 10:58:34 -0700
Message-ID: <7vy5nzgg1h.fsf@alter.siamese.dyndns.org>
References: <CACPiFCKyhZPQR+e27Ah5THiPPJy3akajGN5xMwBumP-Wj6JrKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 19:58:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scgyn-0000yR-KX
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 19:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661Ab2FGR6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 13:58:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64205 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932414Ab2FGR6h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 13:58:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9854D8350;
	Thu,  7 Jun 2012 13:58:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QygeQPxmmkLWdiDxjCj2CInX8uo=; b=GypMAL
	/J89EE/CF0vONotesGUmcq/CBrB3dU/5tnjADeNHpbDu4aKxNFJYaHyTLL12TpZa
	Ra3Sh9Oe6yE6oOgXzide1Xr5YSd7ZrxDXMT/XDMNHfr5DfIdpvzDHanpynlaZCMa
	MW5i8RTrp0AsDEnX7+ezMXIkU95aBkQJiaVLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=keqfhz2cmdcadJ9tISBbTo1HbNQJdnmm
	1oXgXuKvCtiu2UtiMkFH1r81jPL7U42Pu7IDK73IKBZH6Z9F2BgBWS7HJWErldOh
	ZAZj7IBD1Wbn1OW4vcPIYU1Fhe0EExBs4h9DMz128tivfuy6+7gptQVv86Q8NrDk
	GCL4DmgaNV8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C077834F;
	Thu,  7 Jun 2012 13:58:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23B4E834E; Thu,  7 Jun 2012
 13:58:36 -0400 (EDT)
In-Reply-To: <CACPiFCKyhZPQR+e27Ah5THiPPJy3akajGN5xMwBumP-Wj6JrKQ@mail.gmail.com> (Martin
 Langhoff's message of "Thu, 7 Jun 2012 12:43:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6758DC50-B0CA-11E1-93F1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199430>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> I am a regular user of gitk's nice pickaxe search field. But it will often
> fail to find what I am looking for because the part of the string I can
> provide is not the part that changes.
>
> For example, I am looking for patches that change any calls to function
> foo(). I want to match on
>
> - foo(1, 0, 1024)
> + foo(0, 1024, 1)
>
> but I don't know the parameters. As the "pickaxe" sections in gitdiffcore
> and git log manpages indicate, it won't match on -S'foo' because foo itself
> was not added or removed.
>
> A regex like "foo(.*" would work, but pickaxe doesn't seem to take
> regexes, and while I could roll my own wrapper around git-log --patch,
> this sounds like an important and useful variant to pickaxe that is
> missing.
>
> Or that has a hidden switch I haven't found ;-)

Like more expensive -G that was recently added?
