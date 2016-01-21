From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] sh-setup: make require_clean_work_tree() work on orphan branches
Date: Wed, 20 Jan 2016 16:06:01 -0800
Message-ID: <xmqq7fj33ifq.fsf@gitster.mtv.corp.google.com>
References: <1448376345-27339-1-git-send-email-szeder@ira.uka.de>
	<1448376345-27339-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jan 21 01:06:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM2lN-0005US-Mw
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 01:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbcAUAGF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 19:06:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752516AbcAUAGD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2016 19:06:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 20B683EE28;
	Wed, 20 Jan 2016 19:06:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VB519UF6GQug
	1UvlmNRcBDuQKVI=; b=iejhHlfFosVo23oF8afrVA/SWspO4QAHkH+fyi6DjXZQ
	XwVQgETb8VGjEU19lfGspD5HWbVjJ0MBjHKihn/C2f8giIZR/SD9wgbpKKSlY63r
	ju+7U7Ou3mDtQWzCgBdIOxPSyVjXyZ3Fx7ZPiNFIRQ8lPSdJ1Dyt/vesFu2m0QE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KuVW6S
	ykn1aJDbwi835UgN3X+RBGXZDlZtuvMDpAkFieRkFUwdUZaxZFEgWnHDT3898zVw
	VApoV/ZOWbrkVt3afLcJIPaThgNy+MRO924965NCmftMVNQHDvVvobroYHdR3LnT
	NeO+dXpu8KiTo1qhxOA++FQk6BVNUF3PqaeLI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 162C83EE27;
	Wed, 20 Jan 2016 19:06:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8869F3EE26;
	Wed, 20 Jan 2016 19:06:02 -0500 (EST)
In-Reply-To: <1448376345-27339-2-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Tue, 24 Nov 2015 15:45:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C2228C10-BFD2-11E5-A8CB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284488>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> git-sh-setup's require_clean_work_tree() always exits with error on a=
n
> orphan branch, even when the index and worktree are both clean.

Ah, I just sent a review on 1/2 as I found it was not commented on
by anybody, but re-reading this sentence (and subsequent review of
this 2/2) makes it clear this is not a good idea.  By definition,
the index immediately after creating and getting on an orphan branch
is not clean [*1*].

I'll move the topic from "Needs review" to "Will discard" pile in my
tree.

Sorry for the noise.


[Footnote]

*1* Roughly speaking, if "git commit" (no arguments) to record the
state of the index succeeds without "--allow-empty", your index is
dirty with respect to HEAD.
