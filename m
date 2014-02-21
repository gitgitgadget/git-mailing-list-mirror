From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Fri, 21 Feb 2014 09:47:36 -0800
Message-ID: <xmqqzjlk4atj.fsf@gitster.dls.corp.google.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
	<87r470ssuc.fsf@fencepost.gnu.org>
	<CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
	<87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
	<xmqqzjlocf28.fsf@gitster.dls.corp.google.com>
	<CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
	<xmqq4n3warni.fsf@gitster.dls.corp.google.com>
	<CACsJy8C+wGd9WxnsML6-_G_S5GtN2pCPf09kcFtBVu-SDfP8YA@mail.gmail.com>
	<CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com>
	<xmqqd2ij9be1.fsf@gitster.dls.corp.google.com>
	<CACsJy8AeZWPz=39ySQr9MrSUiLyJDQbs02sumS9VjbbGWzP9pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Kastrup <dak@gnu.org>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 21 18:47:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGuCT-0000md-S0
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 18:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933249AbaBURrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 12:47:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42588 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933220AbaBURrm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 12:47:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AB3D6DB56;
	Fri, 21 Feb 2014 12:47:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+EzW+HjdOY5Pc2e/EUL5uSb1Hx4=; b=M7n9KX
	e3hFSGZ2nBDwGSQpuBCZrOMCOZKlsQJAcpG+VykaiNFGLjqIzrXSR4lRuknnhVb0
	ZXGKqoMchA/r3Kc783S7XD6Pg9ArJse7/uc+ylUusvlfmvX6BR+wCwS6uiH/cDJ9
	oQDbyX8FEJWIAUOp94rcbEeRc/Adxb8GVZEpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CUQUtnK7mJipy72/NANUsDSb+3Y+sNjz
	BzVSrqafEnaB69UD4fkNsYK/roZDmfHL7gcu4SoIrZv6/HMEScY9Fvt34Q3HXMAJ
	cpYfvx4SVY9EjSUCcQZpTWYM6zpNN5Y2ocwdAqckh8dnl4Wlq6vF+6PKXCHvpOY8
	eSjP/945UxM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79F6D6DB55;
	Fri, 21 Feb 2014 12:47:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 305106DB4F;
	Fri, 21 Feb 2014 12:47:40 -0500 (EST)
In-Reply-To: <CACsJy8AeZWPz=39ySQr9MrSUiLyJDQbs02sumS9VjbbGWzP9pw@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 21 Feb 2014 06:35:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4222F212-9B20-11E3-980D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242481>

Duy Nguyen <pclouds@gmail.com> writes:

> For old projects, commits older than 1-2 years is probably less often
> accessed and could use some aggressive packing.

I used to repack older part of history manually with a deeper depth,
mark the result with the .keep bit, and then repack the whole thing
again to have the remainder in a shallower depth.  Something like:

	git rev-list --objects v1.5.3 |
        git pack-objects --depth=128 --delta-base-offset pack

would give me the first pack (in real life, I would use a larger
window size like 4096), and then after placing the resulting .pack
and .idx files along with a .keep file in .git/objects/pack/,
running "git repack -a -d" to pack the rest.

> This still hits git-blame badly. We could even make sure all
> objects "on the blame surface" have short delta chain. But that
> may be pushing pack-objects too much.

Yes, you can do a similar trick by blaming all the paths that ever
existed in the project, parse its --porcelain output to learn all
the commits and paths involved, to find the objects that need
quicker access.  Pack such objects in a pack with a shallow depth,
tentatively mark that pack with .keep, repack the remainder with a
deep depth, remove .keep from the first pack and mark the new pack
with .keep to prevent it from getting repacked, or something like
that.
