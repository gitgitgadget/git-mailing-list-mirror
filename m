From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] p4merge: swap LOCAL and REMOTE for mergetool
Date: Thu, 07 Mar 2013 12:31:47 -0800
Message-ID: <7v4ngnlznw.fsf@alter.siamese.dyndns.org>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
 <1362601978-16911-2-git-send-email-kevin@bracey.fi>
 <7vlia0nj0i.fsf@alter.siamese.dyndns.org> <513830AD.10302@bracey.fi>
 <7vd2vboepi.fsf@alter.siamese.dyndns.org> <5138CAFE.2010602@bracey.fi>
 <7vboavm3fh.fsf@alter.siamese.dyndns.org>
 <CAJDDKr5-ttcU48r0-qTfov7q736Rj63rS33fTScSsvx53VG4pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Bracey <kevin@bracey.fi>, git@vger.kernel.org,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 21:32:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDhU8-0008ON-M4
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 21:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759765Ab3CGUbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 15:31:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759693Ab3CGUbt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 15:31:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1154EBDBE;
	Thu,  7 Mar 2013 15:31:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pIID3MSWhoW/TV8GoXB3g0EPiYw=; b=Kuc9dB
	9IFsClKr/4XgOow4OxfbgIN+c+OvgBOv2m9gT6xa86cTy9dEFHV25KQjGtAwJEoX
	mTiAUxHoxqj+hmFNkntf1ACVz2sAaEMsf/xORos6+875eVUbtA/CjF+wClQWBhAx
	J0xa60xCFPL0ZyhiJ7EBdW1dkHMYbyMplqdBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XUbx7hSdaNMg921atLDbq3RzM7JlgZaG
	tPY/3DzJL8MfPeWE0mJSngI69HNgR8cpxe238hPKdxDfWFlbCYRZoqEYGtSYqxDe
	YrkjENNIzJRSXGSXHTPvMsGIvEeSaSbOThQwqE8gxoOd6D3m5sSypaZHJkcKTNM3
	nd8fswWej5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04E86BDBD;
	Thu,  7 Mar 2013 15:31:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AA4EBDB9; Thu,  7 Mar 2013
 15:31:48 -0500 (EST)
In-Reply-To: <CAJDDKr5-ttcU48r0-qTfov7q736Rj63rS33fTScSsvx53VG4pA@mail.gmail.com> (David
 Aguilar's message of "Thu, 7 Mar 2013 11:50:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0930518A-8766-11E2-817D-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217615>

David Aguilar <davvid@gmail.com> writes:

> I would prefer to treat this as a bugfix rather than introducing
> a new set of configuration knobs if possible.  It really does
> seem like a correction.
> 
> Users that want the traditional behavior can get that by
> configuring a custom mergetool.p4merge.cmd, so we're not
> completely losing the ability to get at the old behavior.
>
> Users that want to see a reverse diff with difftool can
> already say "--reverse", so there's even less reason to
> have it there (though I know we're talking about mergetool only).
> ...
> I would much rather prefer to have the default/mainstream
> behavior be the best out-of-the-box sans configuration.
>
> The reasoning behind swapping them for p4merge makes sense
> for p4merge only.  I don't think we're quite ready to declare
> that all the merge tools need to be swapped or that we need a
> mechanism for swapping the order.

Thanks for an injection of sanity.
