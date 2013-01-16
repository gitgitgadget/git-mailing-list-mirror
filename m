From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote: distinguish between default and configured
 URLs
Date: Wed, 16 Jan 2013 11:19:46 -0800
Message-ID: <7vvcaxvstp.fsf@alter.siamese.dyndns.org>
References: <7v4nii5tp2.fsf@alter.siamese.dyndns.org>
 <a5bf3511b3ecf4e9243d550d11ab977f95ecea30.1358331096.git.git@drmicha.warpmail.net> <20130116104222.GA15125@farnsworth.metanate.com> <50F6A0F0.70800@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 20:20:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvYWw-0003Wg-Fc
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 20:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856Ab3APTTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 14:19:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027Ab3APTTt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 14:19:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B226AB83;
	Wed, 16 Jan 2013 14:19:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QTGSGB4ENOrmnu5rhB8wnNIepNs=; b=hXuzlQ
	TS8UL7j74DpwX6VazxZoeJWIM67BGpoBeRm2hqA+5o/Ixbp+S90zghAs5bGlnzcv
	79tTZDlP/k3z/RN+4kL4hV84Rx3dQiq+eaEt8Pu/FromQyrsc6/KOTZ7icopfFwP
	1/BdBQw4BYFJuofvt0y4ajaSxIcc1FaQUI7+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IkdqdfG0uUxYSDjL/vup/ZIgFVxpquw+
	70lse+NNNUZPn5l52b/nK5erFUfkwHDs2esyvMcBWqfR3xqmlC6bwHA76m1O6SC8
	84WXHxhK9tghrJoZAYtWZa3/uNIdkD+TfbxNp8G2UudVzgYAeD5nd0hzqCgPj4Bx
	GNC9ZVN77gI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D92FAB82;
	Wed, 16 Jan 2013 14:19:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01053AB71; Wed, 16 Jan 2013
 14:19:47 -0500 (EST)
In-Reply-To: <50F6A0F0.70800@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 16 Jan 2013 13:45:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B152F9C0-6011-11E2-A2E6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213803>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> In short, the separate listing is correct, but in this case there's no
> improvement in readability.

Yes, I think the "insteadOf" rewrite is a related but a separate
issue.

Is "remote -v" meant for diagnosing remote.origin.{url,pushurl} that
are misconfigured?

If not, the output just should just say the final outcome, i.e. what
destinations we will fetch from and push to, without cluttering the
output.

If on the other hand it is to help users debug their configuration,
the output also needs to explain exactly what made us decide those
destinations to use (e.g. to discover there was a leftover insteadof
in $HOME/.gitconfig the user forgot about).
