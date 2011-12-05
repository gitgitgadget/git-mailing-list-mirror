From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Debugging git-commit slowness on a large repo
Date: Mon, 05 Dec 2011 09:38:22 -0800
Message-ID: <7vr50inckx.fsf@alter.siamese.dyndns.org>
References: <CAFE9C7B.2BFEC%joshua.redstone@fb.com>
 <20111203002347.GB2950@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Redstone <joshua.redstone@fb.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Dec 05 18:38:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXcUv-0000Lz-1j
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 18:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790Ab1LERi0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Dec 2011 12:38:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932546Ab1LERiZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2011 12:38:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37CC86641;
	Mon,  5 Dec 2011 12:38:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2xNRBpS0zgL8
	RMg5WvOySVbpLbI=; b=VfsB0LcfqvMAjgvIWDX4L1qQMFQwkTf+GMuqw68F2Bru
	vtINL3V4ZtziWZnvu1HHLBLM1J0xDQmas4EyooVuiEgP0Bawzj0ltFMXesgM5gxm
	NOoeVlXJwloXspUS+j7SdWVp2URAYzcpitNXH0Akq0xIJiRIHZNd/oiB9oY9MDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MSZ+Sf
	B8UdrDfJZ7af8tfYfiNClrzBUzDKwXi6Pwxc6VtXfTuTHgK339FxFYOTsJjOfKcf
	iC6U6R7ZkLFP2YksjKCJJF5Cx2lJYYn/c1YCTz8sOgYTPS2c6irfqnkqW+AQ70la
	Mdd7NTvFLWxwF7wN2k7iaIK7X2P/DLpZ+gipw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EC966640;
	Mon,  5 Dec 2011 12:38:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B331E663F; Mon,  5 Dec 2011
 12:38:23 -0500 (EST)
In-Reply-To: <20111203002347.GB2950@centaur.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Sat, 3 Dec 2011 01:23:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE4595A4-1F67-11E1-8396-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186282>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> ... At one
> point, commit forgot how to write the tree cache to the index (a
> performance optimisation). Do the times improve if you run 'git
> read-tree HEAD' between one commit and another? Note that this will
> reset the index to the last commit, though for the tests I image you
> use some variation of 'git commit -a'.
>
> Thomas Rast wrote a patch to re-teach commit to store the tree cache,
> but there were some issues and never got applied.

Ahh, I forgot all about that exchange.

  http://thread.gmane.org/gmane.comp.version-control.git/178480/focus=3D=
178515

The cache-tree mechanism has traditionally been one of the more importa=
nt
optimizations and it would be very nice if we can resurrect the behavio=
ur
for "git commit" too.
