From: Junio C Hamano <gitster@pobox.com>
Subject: Re: finding unmerged branches
Date: Thu, 27 Aug 2009 16:25:12 -0700
Message-ID: <7vd46gn8kn.fsf@alter.siamese.dyndns.org>
References: <20090827220241.GA1413@gnu.kitenet.net>
 <20090827223504.GA18307@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 28 01:25:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgoLT-0005lv-Rz
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 01:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbZH0XZV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 19:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbZH0XZV
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 19:25:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbZH0XZU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 19:25:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0715139419;
	Thu, 27 Aug 2009 19:25:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HDEC+0i9/TiM
	F4mnwSn8m5n32a4=; b=si94cox49wiZeHXRtHtUhSSWhuk6fQ9dEkoj7t5eItno
	/eJdJc5JjZaQPEkpaWUp5Vu89EuSPEhr4Rf/uy2+iPAEiZLXclfYZeIF51sKk5xJ
	iZPpiYmrMqlMUIOdUXGJHp6xV2hpBKkc4rpNKewlXn1blXrH5biqoFciQmRRTLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lU7SUT
	dJtitv8MJ6rGQgOfk72YzIj4qe4quUZS7cRMHaNbVKRmQlVQJcvEQVpZw4loqvjQ
	UVO+zUHwCnzFYW2l6zmkGUeC1aNH8WEr6uxW8AC5YY4jTUXOpiPQPTxL7LT3IIgX
	syNZH7gVDtNMWfoOkcTw0hBX2erIbFcfDl3Zs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CBFA839418;
	Thu, 27 Aug 2009 19:25:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5C90539417; Thu, 27 Aug 2009
 19:25:13 -0400 (EDT)
In-Reply-To: <20090827223504.GA18307@atjola.homenet> (=?utf-8?Q?=22Bj?=
 =?utf-8?Q?=C3=B6rn?= Steinbrink"'s message of "Fri\, 28 Aug 2009 00\:35\:04
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E21DD646-9360-11DE-A908-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127234>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> Hm, not sure if I'd call it "better", but probably at least a bit
> faster. You could create a "fake" merge to combine all the branches.
>
> git branch -r --no-merged $(
>   : | git commit-tree HEAD^{tree} $(
>     git for-each-ref --format=3D'-p %(refname)' \
>       refs/heads/ \
>       refs/remotes/origin
>     )
>   )

Heh, that is certainly a cute hack ;-)
