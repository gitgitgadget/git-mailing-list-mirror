From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: adjust prefixlen after striping trailing slash
Date: Sun, 19 Apr 2015 22:37:24 -0700
Message-ID: <xmqqy4lnmkbv.fsf@gitster.dls.corp.google.com>
References: <55300D2C.9030903@web.de>
	<1429319946-19890-1-git-send-email-pclouds@gmail.com>
	<5533A567.7070301@web.de>
	<CACsJy8A7+rQhn5ry6Z86SbeYHoDw=w7tB73Ls2V05E8F-JMnhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 07:37:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk4Oi-0001Bh-Dm
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 07:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbbDTFh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 01:37:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752175AbbDTFh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 01:37:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B2BE3BFFE;
	Mon, 20 Apr 2015 01:37:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IJBCAy+x2ASa5PKT3oDmV8dWW3Y=; b=nbu3+v
	wRqidG2fRQ6E7C7p4DAEYhZnvzMz2tXgjVaE7rk1nE+g0LgLW8He+K4ulqQ2o2Zx
	bGJ7hTlN0wxm5fTG1h529s7U+kVz2hB7ZVLBzFN5kkYVxV6RR2D/gkwP2b9NFczp
	0BYpRL6EY4/52ZAGx6Imw3XY6BZvoKFr93U2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YlumPRVvBfvbrZFiS3U4ecQcDSb9IDbU
	6eO+AbqxtaCwPhvah9jjj+q9l2vst44U+mRM1ux+FD2MNQstY2MM+cjrZCf33ECH
	oh/ckBRXQNDecG3kNyFapOcuJr65RQFHAQ7x6vPm2eMYPuIVsVAn+Lc76DTGVd3V
	kx1onr5zRRU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 34B803BFFD;
	Mon, 20 Apr 2015 01:37:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AECF53BFFC;
	Mon, 20 Apr 2015 01:37:25 -0400 (EDT)
In-Reply-To: <CACsJy8A7+rQhn5ry6Z86SbeYHoDw=w7tB73Ls2V05E8F-JMnhA@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 20 Apr 2015 08:34:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 53689210-E71F-11E4-A4AA-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267451>

Duy Nguyen <pclouds@gmail.com> writes:

> But if you look at it another way, "cd subrepo; git add ." should be
> the same as "git add subrepo" ...

Once you cd into "subrepo", you are in a different world, a world
different from the toplevel project.  "git add ." over there should
mean "add everything in subproject's working tree to subproject's
index", shouldn't it?  On the other hand, "git add subrepo" without
leavingin the working tree of the superproject is about binding the
submodule to the superproject's index.

I do not think these two should be the same.  Where am I mistaken?
