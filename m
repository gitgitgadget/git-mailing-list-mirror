From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] commit: allow partial commits with relative paths
Date: Wed, 27 Jul 2011 08:41:07 -0700
Message-ID: <7vbowfpw8c.fsf@alter.siamese.dyndns.org>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
 <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net> <7v8vrmrxok.fsf@alter.siamese.dyndns.org> <4E2FCAC4.7020408@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Reuben Thomas <rrt@sc3d.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 27 17:41:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm6EV-0006ha-4n
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 17:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab1G0PlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 11:41:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58961 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025Ab1G0PlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 11:41:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7A7B3EA5;
	Wed, 27 Jul 2011 11:41:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xcfB2DQebAyzsPL9dVoeby3EWZ4=; b=b2GIq/
	iSmmw0PnvLL9ojGuy1ZxtAo4mLYvm3axl+Fysc+6gGZDg1NNHOH7ves8l3qpYaJa
	uuqzcA2GvmTRqbNWW70bDZdAKxWh2RijBYuuG3LHeUN/h7w7bI10dzu4Oqd+GezE
	0WYOFqpGUbai7SU7SxN4+TzuuI/rhQl3TCbJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hrOtiIK/Qchjz5PSacipnaIKutkS4Scb
	BQmd0LnrjHzzxPRmQxxVN4L4Bx1g8NSIo5qdH7mW+f5yYmMA0cGZarm/cSN9wrUj
	X03kp/vVd++uSNxv82Vl8WNbZCvsTupsOCBrNR7Esr2/MRjPDkcq3yi9jauu0KMe
	Z+A8GUvQIoQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFC723EA3;
	Wed, 27 Jul 2011 11:41:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F55C3EA2; Wed, 27 Jul 2011
 11:41:08 -0400 (EDT)
In-Reply-To: <4E2FCAC4.7020408@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 27 Jul 2011 10:22:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8C4094E-B866-11E0-80F0-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177973>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The one reported by the OP for commit:
>
> git rm ../a
> git commit -m "blurb" ../a
> error: pathspec '../a' did not match any file(s) known to git.

That does look like a bug given that (starting from a state where that
"../a" is a tracked file that appear in the HEAD commit):

	git rm ../a
        (cd .. && git commit -m "removed a" a)

does work. For "git add ../a" after removing the path from both index and
the working tree, see my other message.
