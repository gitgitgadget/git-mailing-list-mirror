From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diff: introduce --stat-lines to limit the stat lines
Date: Fri, 29 Apr 2011 09:15:15 -0700
Message-ID: <7voc3pyqy4.fsf@alter.siamese.dyndns.org>
References: <5f16db0f3730be70ff522e63fbd491dc910c34d0.1304089050.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:15:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFqLp-0005Hu-Tb
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 18:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759818Ab1D2QPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 12:15:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759773Ab1D2QPX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 12:15:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 64010507A;
	Fri, 29 Apr 2011 12:17:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5xJnIn3TBy+IWTVqo8a+g0fA1Xk=; b=Hquxot
	bbIccS+hWYzGUsrqqZYFPiVZajXC6IjEJ0JVYg1FpKNyk/uz/jwEV74LzHagyWY4
	s5iu9qCuhb/4Hbrzcx11bEQ0TKxla8j/ztebj/mm1m060JpCXG8NRK6FieMnW8O5
	/7qacaunrS1IOw0di9DhBoqglecLyWXaVaJHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i4kZQiUrZmlwq6faIgVwasQqTQtxF+wk
	cPTS/Ox0nxaIAFZs52xHmS/3mztu6fFONJFEQfR3wMPB8Rg5Le7WZZ+RgbVpiY1/
	AGvBsvzvVr4nYGS/M6BqzH8NzXsQGObAUiIwh9wVT+W3y0temlp5movjQTozCkJ/
	ukNBieQE+J4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3ED865079;
	Fri, 29 Apr 2011 12:17:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 31A215075; Fri, 29 Apr 2011
 12:17:19 -0400 (EDT)
In-Reply-To: <5f16db0f3730be70ff522e63fbd491dc910c34d0.1304089050.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 29 Apr 2011 16:57:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A39DAFA-727C-11E0-8EBB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172460>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I would even consider a default of 10 (i.e. show a 20 line stat in full,
> abbreviate larger ones) to be sensible but have refrained from such a
> behaviour change.
>
> We have hardcoded defaults for width (80) and name-width (50), so having
> one for lines should be okay also. Can I has tis wiz default? ;)

The terminal has fixed width to be apportioned but has an infinite height
with scrolling, so that comparison is somewhat bogus.

This should be called "count", not "lines".  Anticipate a future where we
introduce a variant of --stat (in a way similar to how --numstat is a
variant of --stat) that displays its result with two lines per entry.

Also getting (N+1) "lines" output for specifying N feels very unnatural.
