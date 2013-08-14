From: Junio C Hamano <gitster@pobox.com>
Subject: Re: New special handing of '@' character broke my use case
Date: Wed, 14 Aug 2013 11:05:07 -0700
Message-ID: <7vd2pgtagc.fsf@alter.siamese.dyndns.org>
References: <520BC017.7050907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 20:05:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9fRf-00044s-2o
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 20:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760135Ab3HNSFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 14:05:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56123 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758444Ab3HNSFL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 14:05:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44E7F36994;
	Wed, 14 Aug 2013 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M1hyYbA0g0jDi8KvKR8Tob420ok=; b=ZlMRdu
	6BhCMVQjlPcEEUUoSEGLiBLTHsTs2ST+2RVU25+SUT5PYpuyRYEE4k9rbRVcv4sP
	JUHYqfU9VIoOZRWWuZnIdCQ/OhgE2cmzZaoPz91A8Emon8lL/zZOegjEyKFWzqIh
	ITZ8AcwUwmmm4P+ZEF1EzNaIqZ+a9e2S123BA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JtPwrfMMfyNu9oF0rZ2GpsULpOCrOf6+
	fO0ivz666AeRVKFd5CGynf52HacD1iNmIItPF2/t6neo/q0xY9HXM8fM88U50N4T
	ZQ+xvPbDD4RS+6BduS1zBoewl6a+4zktMcgY0LYiyXzooZSKKeyAgiyBdI0F6ehI
	4gddrLUebZM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B24336993;
	Wed, 14 Aug 2013 18:05:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 961B936992;
	Wed, 14 Aug 2013 18:05:09 +0000 (UTC)
In-Reply-To: <520BC017.7050907@gmail.com> (Stefano Lattarini's message of
	"Wed, 14 Aug 2013 18:36:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0EBCBD4A-050C-11E3-A481-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232304>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> My problems is that some new automagical interpretation of the bare
> @' character (introduced after 1.8.3) has destroyed my use case:
> ...
> I don't want to ask you to revert this new behaviour, but I'd like to
> at least have an option to disable it.

I do not think it is simply not worth the complexity to selectively
disable it.  If it is a regression, it is much better to simply
revert, if we can (it appears that cdfd9483 (Add new @ shortcut for
HEAD, 2013-05-07) can be reverted without any textual context, but
there may already be new stuff that depends on the "@").

For the upcoming release, I am very much tempted to revert it and
let the topic retried, by people who really want the "let's save
four keystrokes and replace it with @ aka Shift-<something>",
without hurting your use case (and others), after the upcoming
release.

What do others think?
