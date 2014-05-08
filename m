From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is misleading
Date: Thu, 08 May 2014 14:58:58 -0700
Message-ID: <xmqqvbtg0w65.fsf@gitster.dls.corp.google.com>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
	<20140508213806.GA19464@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu May 08 23:59:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiWLN-0000Lb-Hx
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 23:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747AbaEHV7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 17:59:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65264 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755378AbaEHV7D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 17:59:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 86B8015119;
	Thu,  8 May 2014 17:59:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mdSYxNZkcLjBzoXM7oW4kgBpDN8=; b=avLr9M
	JKLwGl2nuXjUBL8zpXP0P99qkKtbb5mXALD7/N2sX9UmBd2J7+qhIbNOKjz1WUuF
	GHyjsAfwRg0oQlSQ7O4x3v7zWooSmFPjcbF4FcGJ1bfvFF1rHjM1BWStq10yqeqs
	8saE7Yvht1pkxF9uJ+8yNl9kNOujfTKxdrtg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dG+2aQ8xxz5BxGT+X61S7IwPZVUKRmM5
	G27dYMXi9IveizMRxeYOZIiKTY2N/WVonpAdiQXQdVfdqRtUiinqfRcbR6S1lHoY
	zd78Qk0YdBDU4BqoE/61u+O1dzmbV/i8PSMYUonk0D+eH4Ak2ouRwGcd1vXn/MwQ
	6cFo8c7Fg+g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7E43515118;
	Thu,  8 May 2014 17:59:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C611C15111;
	Thu,  8 May 2014 17:58:59 -0400 (EDT)
In-Reply-To: <20140508213806.GA19464@serenity.lan> (John Keeping's message of
	"Thu, 8 May 2014 22:38:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F5AE55E4-D6FB-11E3-89E8-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248454>

John Keeping <john@keeping.me.uk> writes:

> On a slight tangent, I tried this in a fairly young repository and got
> this (with master at v2.0.0-rc2-4-g1dc51c6):
>
> $ git blame Makefile | head -5
> 7a3fc144 (John Keeping      2013-12-26 17:37:53 +0000   1) REL_VERSION = v0.2
> 5c9829f9 (John Keeping      2013-07-29 17:03:26 +0100   2) 
> 5c9829f9 (John Keeping      2013-07-29 17:03:26 +0100   3) # The default target is...
> ^f7fae99 (John Keeping      2013-03-24 17:14:40 +0000   4) all::
> ^f7fae99 (John Keeping      2013-03-24 17:14:40 +0000   5) 
>
> f7fae99 is the initial commit in the repository, so shouldn't the last
> two lines blame to that, not a non-existent ancestor?

It is not saying f7fae99^, is it?  It is debatable if it is correct
to mark the root commit as a boundary, but that is what it is
showing, I think.  In other words, "this line hasn't changed since
the inception of the project".
