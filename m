From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG (maybe)] git rev-parse --verify --quiet isn't quiet
Date: Thu, 04 Sep 2014 11:12:39 -0700
Message-ID: <xmqqppfbtfu0.fsf@gitster.dls.corp.google.com>
References: <loom.20140904T131954-274@post.gmane.org>
	<xmqq1trruv3b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 20:12:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPbWY-0004ag-HR
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 20:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbaIDSMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 14:12:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58406 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbaIDSMl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 14:12:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 567F3383D3;
	Thu,  4 Sep 2014 14:12:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8swBGVsD4SLyXzTVjWf1S/uApsg=; b=O2GvNS
	uaNhWV9KZUFlqorKjKJF59ErWlPExmUyjlIsw9IZbtHuUKW/84wntahnGUPdTef3
	eWkluHz+zBc9zz2h8JuG4vT/AwJKFKdO7oBY48vFjo09XHGgUqk5v/MzFbVaxwRf
	QMD7CGiYpsl8bQVl3s38wh9YYLmxfHietk6go=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UEcHiOj5Tv9atD63889vlN0LhL6u/eQ4
	mzCzghUaw74/4gQnQqHFX0wAmFktEna5bg3xgSpq3c/gf7NAVi+Es2kJOPwJrB7h
	80eq5OWTIfUEXHNvxICgUXaOXrH9TuUCzMb058iDLiFOB8qOIOnz57Aejni0FDd+
	QZb6Xz8qvoo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E873383D2;
	Thu,  4 Sep 2014 14:12:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D0184383D1;
	Thu,  4 Sep 2014 14:12:40 -0400 (EDT)
In-Reply-To: <xmqq1trruv3b.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 04 Sep 2014 10:57:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0F25A728-345F-11E4-8F68-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256457>

Junio C Hamano <gitster@pobox.com> writes:

> I would suspect that this may be fine.
>
> "rev-parse --verify" makes sure the named object exists, but in this
> case @{u} does not even name any object, does it?

Hmph, but "rev-parse --verify no-such-branch" does *not* name any
object, we would want to see it barf, and we probably would want to
be able to squelch the message.  So it is unclear if @{u} barfing is
a good idea.

What is the reason why it is inpractical to pass 'quiet' down the
callchain?
