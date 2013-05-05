From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Make "$remote/$branch" work with unconventional refspecs
Date: Sun, 05 May 2013 15:36:32 -0700
Message-ID: <7vvc6xt5ov.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<7vr4hmuk20.fsf@alter.siamese.dyndns.org>
	<CALKQrgdp9DVDBLNwCAmQHbEfZDvhdsmSW3sh1BRo1XEnyqPPaA@mail.gmail.com>
	<7v8v3tuu6i.fsf@alter.siamese.dyndns.org>
	<CALKQrgf6NcT2tEGMTczxR2WspOi4NjrN_kxmKN-QyE2Py3iSaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 06 00:36:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ7Y0-0004sj-LO
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 00:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab3EEWgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 18:36:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64108 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab3EEWgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 18:36:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B16BE1C45D;
	Sun,  5 May 2013 22:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8YBYx96UWqgKjSDoJZNR3ambv10=; b=sdZPZj
	B5ekqFKj1/y1n7K7nEVSsWK6E73yFZ6sYZZIiDliEW9yJPmZQGzfsxlSPkD0lkp7
	JtPmR9Wbu9/wjvdNTNtAF4eGObVIrOE5Cs4jmyTdsH9tV3EuYLPYS5JRXD7jp3YD
	J2uibXJF7TQ2pSJc6zhPr67hVRuJWJYU5DQyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L+/A2xMbcOcRi34hHG0yJi2RRLV0CaTh
	rv1iYRSdPNUJDqiNROpMJ5azlHe2SVxaeiaAVK+PueY257IOiYlmV9qrcJFYM9Yq
	LWYesacTEOo7FuXpBmn2+uUCyh+YU7hM8T354AkzKsCUC/km5BEBH4xvRvaSncJT
	gIJLiPcDrzM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8BF31C45C;
	Sun,  5 May 2013 22:36:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D0021C45B;
	Sun,  5 May 2013 22:36:34 +0000 (UTC)
In-Reply-To: <CALKQrgf6NcT2tEGMTczxR2WspOi4NjrN_kxmKN-QyE2Py3iSaQ@mail.gmail.com>
	(Johan Herland's message of "Mon, 6 May 2013 00:26:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D5FD920-B5D4-11E2-B347-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223420>

Johan Herland <johan@herland.net> writes:

> This would not allow the user to use the relevant $remote_name for $nick,
> which I argue might be the more natural name for the user to use, since
> it's the same name that is used for otherwise interacting with the remote.

That is where we differ.

The thing is, when you name a local ref (be it "refs/heads/master"
or "refs/remotes/origin/master") with a short-hand, you are still
dealing with a refname, not interacting with the remote at all.

Taking notice of remote.$nick.fetch mappings only to complicate the
refname resolution logic is absolutely unacceptable, at least to
somebody who comes from the "we are interacting with refs, not with
remotes" school, like me.
