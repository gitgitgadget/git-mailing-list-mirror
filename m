From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash takes excessively long when many untracked files present
Date: Tue, 13 Aug 2013 10:52:55 -0700
Message-ID: <7vmwolwk94.fsf@alter.siamese.dyndns.org>
References: <20130810214453.GA5719@jtriplet-mobl1>
	<loom.20130813T120243-481@post.gmane.org>
	<7v7gfpy0wy.fsf@alter.siamese.dyndns.org>
	<1fc732a7-6b63-4d75-960f-0b1c6cf9c70e@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Darander <anders.darander@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 19:53:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9ImF-0001D6-0z
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 19:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757432Ab3HMRw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 13:52:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64506 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756886Ab3HMRw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 13:52:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 835B53814B;
	Tue, 13 Aug 2013 17:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rFqpQJXpt6U+bobLngFpBGgAMPM=; b=Gw6RGA
	OFa38+ZdMhCXyzZg6SzJx8BOwyh8S3Wltk0wL9QpOJ+MNAx49vSXiK0K3wL64iVH
	S43AC1/wJO+99LeUZlKgsnYBFNDO5fQF2Jf6mad3Oqa270te1Az5jZq5eebxAvkT
	gpzxnH//994F0mz0nlq6EO6K2wQy39ZkW/O0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vURjFCZQKQgiF7oJXQ8jzJR++zonZU1z
	1zPZqg2huxSuKi0R7c0xr08ZLl/nTxWO4gqjnp2mPTneYQJGeFkyRyxIo/c4o/G8
	VjG+k2B1+wBro41PsBQBdpuqZtVZMTkvdjTcx23OuRkcYrjrhIF6npjx66RIqklD
	MlZts82ZXwo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 682E83814A;
	Tue, 13 Aug 2013 17:52:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 784B538149;
	Tue, 13 Aug 2013 17:52:56 +0000 (UTC)
In-Reply-To: <1fc732a7-6b63-4d75-960f-0b1c6cf9c70e@email.android.com> (Anders
	Darander's message of "Tue, 13 Aug 2013 19:36:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F596FEC-0441-11E3-A9DB-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232241>

Anders Darander <anders.darander@gmail.com> writes:

>>> Do anyone have any better idea on how to approach this?
>>
>>Teaching "ls-files" to leave early once it seens even a single
>>output is probably a possibility.
>
> Would that mean that we're able to fail early?

Heh, good point.  "Leave once you find one path" does not help the
most common "sane" case where you do not kill any path, so it does
not help us at all.
