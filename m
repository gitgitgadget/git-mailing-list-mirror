From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep doesn't follow symbolic link
Date: Mon, 16 Jan 2012 14:44:40 -0800
Message-ID: <7vwr8ruv1j.fsf@alter.siamese.dyndns.org>
References: <CAPRVejc7xND_8Y=Pb5rYGEcaKYUaX7_WkSro-_EL8tTGxkfY3Q@mail.gmail.com>
 <CALkWK0=-LZH4MYhX50v-RWpGA2r+6q50YxsKaOxc0mJ__yuK7g@mail.gmail.com>
 <877h0zlvwd.fsf@thomas.inf.ethz.ch> <7vwr8za04q.fsf@alter.siamese.dyndns.org>
 <CACsJy8BfvhWxqBOj=+7AiF8dZBVEASAuxiOsjOvpmfE3uPrO3A@mail.gmail.com>
 <7v1ur1yazf.fsf@alter.siamese.dyndns.org>
 <CACsJy8CaBAEJo_LuvjYhb2kfofH83cbR5DFDffmmCU3uJFqk+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pang Yan Han <pangyanhan@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 16 23:44:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmvIH-0002rw-Ij
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 23:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756479Ab2APWoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 17:44:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239Ab2APWon (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 17:44:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A53C7B06;
	Mon, 16 Jan 2012 17:44:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BnzFBDVie6SHdFn0z3n/bXuvDaY=; b=mJ4VZ9
	hjWHsAU8h85ffGrva5TGU5a9MLc22dct/X6trXPYI0yhGXbHqHj92yJT8jyteAcr
	YBZ9BKE5AZtHZD7EYUtEPT5NzwlXN5oETe0fhmAv5JWuDjSk0wlI4v1vDG8nk5LC
	YEB8w5BGhJ9ZWk2srLYAQwnpvUNtIchAUGd7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ctgFnoURkdD6owKUdc2Okl1BiHs2tGoF
	BsOSNytYsdUUMXe+6roUSOsKHOshkmCUGI19ffv+jQEech6pvK6P6rteoQvcd7Py
	1moOSHKqdpDvJlFqpIqSeh88FRLtEqZ4GB8l46v8zUk8iYlOw20Sg5FR0xwk8GK4
	snfzNNl+yE8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A5087B04;
	Mon, 16 Jan 2012 17:44:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FA7D7B00; Mon, 16 Jan 2012
 17:44:41 -0500 (EST)
In-Reply-To: <CACsJy8CaBAEJo_LuvjYhb2kfofH83cbR5DFDffmmCU3uJFqk+g@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 15 Jan 2012 16:47:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ADB74490-4093-11E1-BB6B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188661>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> It's not wrong per se. It's an implication that users have to take
> when they choose to use it. We may help make it clear that the
> symlinks point to untracked files by putting some indication in the
> diff.
>
> When I do "git log -Sfoo -- '*.cxx'" I don't really care if bar.cxx is
> a symlink. Neither does my compiler. It may be a symlink's target
> change that makes "foo" appear. Git could help me detect that quickly
> instead of sticking with tracked contents only.

As there is nothing in Git that tells that whatever is pointed at by
bar.cxx that happens to be in your filesystem today had "foo" in it when
that historical version of the commit whose bar.cxx symlink was updated to
point to that file. It is *WRONG* to show the commit as something that
changes bar.cxx to contain "foo" (or more precisely, changes the count of
"foo" in it).

Why is it so hard to understand?
