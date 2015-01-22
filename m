From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper: do not request symbolic refs to remote helpers
Date: Wed, 21 Jan 2015 23:41:51 -0800
Message-ID: <xmqqbnlruurk.fsf@gitster.dls.corp.google.com>
References: <1421631307-20669-1-git-send-email-mh@glandium.org>
	<xmqqwq4fuxbb.fsf@gitster.dls.corp.google.com>
	<20150122070301.GA18195@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, srabbelier@gmail.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 08:41:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YECOs-0007Ml-3H
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 08:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbbAVHly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 02:41:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751221AbbAVHlx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 02:41:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF871292B4;
	Thu, 22 Jan 2015 02:41:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Qn881JilTdrb/nuYWYHMuN7adg=; b=gTx4es
	Tn1UAycaSBCNnyzuPRoTzUF5czga9XaJhP/bQOacwtjcDA1uB9CkoOaVQ+8fehJh
	yBacPoubVQ0+2ZwhA6cMpqNbuOWrJVQQ2Ip0dQjg4xvcGNvCcybfHz6zTx5VOrIn
	LGffE1KQvkzU5+GfZHzyzaZazkyq3+fGCRBCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TU3FF8cz7lE1XUBh6VVbVlIQVuJXXuGp
	tzBcmni4+zRr+GD0D2W6ODDnw2dnWSmFvalHgU7e1d9/fS0HnmUlkoHfCGTFlUSQ
	ym2IrhgQaFPBFLVTR8ykS84s6USuBtTfRoiM8yEU92YP8pNaiiNKXoeVeca3nnTb
	+hSAWO15yuc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5B0B292B2;
	Thu, 22 Jan 2015 02:41:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F39F292B1;
	Thu, 22 Jan 2015 02:41:52 -0500 (EST)
In-Reply-To: <20150122070301.GA18195@glandium.org> (Mike Hommey's message of
	"Thu, 22 Jan 2015 16:03:01 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 21759406-A20A-11E4-AF95-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262804>

Mike Hommey <mh@glandium.org> writes:

> Note the most important part is actually between the parens: that only
> happens when the remote helper returns '?' to the `list` command, which
> non-git remotes helpers (like git-remote-hg or git-remote-bzr) do.
> git-remote-testgit also does, so if you only apply the test parts of the
> patch, you'll see that the test fails.
>
> remote-curl probably doesn't hit the problem because it's not returning
> '?' to `list`.

Hmm, that suggests that the new codepath should be taken only when
the remote helper says '?' (does it mean "I dunno"? where are these
documented, by the way?), yes?  It wasn't immediately obvious from
the patch text that it was the case.

Thanks.
