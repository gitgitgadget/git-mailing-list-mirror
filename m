From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] GPG-Signed pushes & commits: differentiating between no signature and an unknown key
Date: Mon, 01 Feb 2016 19:17:16 -0800
Message-ID: <xmqq1t8vu7gj.fsf@gitster.mtv.corp.google.com>
References: <robbat2-20160201T220940-187080200Z@orbis-terrarum.net>
	<xmqqmvrkt5ay.fsf@gitster.mtv.corp.google.com>
	<robbat2-20160202T002257-169038640Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 04:17:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQRT0-0005ly-Om
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 04:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbcBBDRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 22:17:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751925AbcBBDRS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 22:17:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BC1894212F;
	Mon,  1 Feb 2016 22:17:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CCVhfN7lWUyUfEe83tKGpKBlE5k=; b=bK7QLn
	T7ZX+RXoYzPX+fK4ziTgWN0++OA97x7UMw8TzdtkMaAGSvTjec+uHltdxcf+BAE0
	EhaRa4z2cPn20x3oDPuxWyKbX+ReMv1hPbgiF2xCw7mcem6nByCUKKWG7kz5RaAM
	eyWexbQjCKSlsXjvJGf7EgsE4naAw9kio3Izg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ug0jyOJImaQZzRWX7HvNktftcXPzkQFU
	dXh/EpzJHCE7Qo9LGaYSRY6kSJPhOINdz0ax4dCUFBpQp0dd4PnazwD695iYsAiG
	KBponwT9VBbP5m634GONt/4LHiLyapeOno5im45kzSzlnDxHT9XLrHK9iGIFcf8k
	VXeWcE1QrQc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B3C804212E;
	Mon,  1 Feb 2016 22:17:17 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3612D4212D;
	Mon,  1 Feb 2016 22:17:17 -0500 (EST)
In-Reply-To: <robbat2-20160202T002257-169038640Z@orbis-terrarum.net> (Robin
	H. Johnson's message of "Tue, 2 Feb 2016 00:43:30 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 768593DC-C95B-11E5-8D16-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285235>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> On Mon, Feb 01, 2016 at 02:49:09PM -0800,  Junio C Hamano wrote:
>> Are you talking about something other than prepare_push_cert_sha1()?
> I went and verified it, and what was reported to me was slightly wrong. Only
> some of the field are empty, notably CERT_KEY and SIGNER.
>
> Signed push with an unknown key:
> ===
> remote: No signature found
> remote: Your push was not signed with a known key.
> remote: You MUST use git push --signed with a known key.
> remote: If you just updated your key, please wait 15 minutes for sync.
> remote: git-receive-pack variables:
> remote: GIT_PUSH_CERT='1c471177906014e65e2825ee71572bf749970c16'
> remote: GIT_PUSH_CERT_KEY=''
> remote: GIT_PUSH_CERT_NONCE='1454372558-35db7be4533958f14731'
> remote: GIT_PUSH_CERT_NONCE_SLOP=''
> remote: GIT_PUSH_CERT_NONCE_STATUS='OK'
> remote: GIT_PUSH_CERT_SIGNER=''
> remote: GIT_PUSH_CERT_STATUS='N'

OK, this matches my expectation, and my earlier response to you is
consistent with the above output, so there isn't much to add to the
discussion from me.  I was primarily worried about GIT_PUSH_CERT not
being passed, but that does not seem to be the case, which is good.
We still give GIT_PUSH_CERT, which makes it possible to write a
validation hook that lazily fetches unknown keys as needed to
implement its own more advanced checks, while allowing validation
hooks that rely on a set of a-priori known keys to be written in a
less error-prone way by saying "N" for "unknown" case.

Thanks.
