From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-tag -s can't find GPG private key
Date: Wed, 27 Jan 2010 13:16:33 -0800
Message-ID: <7v3a1rp7ta.fsf@alter.siamese.dyndns.org>
References: <4B60A9F0.5000904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Mike.lifeguard" <mike.lifeguard@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 22:16:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaFFq-00043H-KO
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 22:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004Ab0A0VQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 16:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460Ab0A0VQn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 16:16:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35350 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162Ab0A0VQm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 16:16:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 60C6294804;
	Wed, 27 Jan 2010 16:16:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+HnMyFxt5qNSpuBKt2BACtLlewI=; b=w6r7C+
	MYJcZkvxEMHVei6UddBp1seZ2nAhBAjqgYQ4YgP50oLnZGtMh9c9ZLPAf76lGTD8
	/eHPH/JJPrulVYR6fCWNJ+fZVnYvJiqh1lbcLfMU/eIIVfzDfyjRHNrPSWm+rDZN
	GmyxV/q6V5qRXX4KyvZKf3CFe+tT/se5LBqO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OAMpewQPPjDWeXweWQyyHauv6NJXZDlx
	u/C9aDG/u0/xvy+OMoom/ecWhDhN1IAJR5mPmmodicaPpXkU23fv3yNXuYhVze3k
	GibdwNS6a5Eiz2tS81CbakXT/4ZaB1if2d9coYXoygD3a/u5Qey5/8P2hNdhKXAq
	ZA8VUAejcnM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 374CE947FF;
	Wed, 27 Jan 2010 16:16:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F5B6947FE; Wed, 27 Jan
 2010 16:16:34 -0500 (EST)
In-Reply-To: <4B60A9F0.5000904@gmail.com> (Mike lifeguard's message of "Wed\,
 27 Jan 2010 17\:02\:40 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 40EADC5A-0B89-11DF-BF8E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138197>

"Mike.lifeguard" <mike.lifeguard@gmail.com> writes:

> It seems that when the GPG key name and user.name in git's config are
> different, git can't find the appropriate private key to sign the tag.
> Git should attempt to use user.email to find the key. Setting
> user.signingkey is of course a workaround.

user.signingkey was devised for this exact case, and I don't think it is a
work-around.

I do not think "should attempt" is a correct attitude, even though I can
100% agree with "it would have been nicer if it attempted to do this from
day one".  You are unfortunately not interacting with git codebase in
early 2005 anymore and there are thousands if not millions of existing
users you should worry about.

Using user.email changes the behaviour for people who do not want a key
that has the same e-mail address, and because the choice of key is all
about security, the logic to choose which one shouldn't be changed
lightly.
