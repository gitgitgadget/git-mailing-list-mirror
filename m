From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Wed, 25 Feb 2015 10:33:53 -0800
Message-ID: <xmqqk2z5on72.fsf@gitster.dls.corp.google.com>
References: <54EDBEC2.8090107@peralex.com>
	<CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
	<20150225143116.GA13567@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Noel Grandin <noel@peralex.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 19:34:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQgmc-0007qJ-8b
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 19:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbbBYSeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 13:34:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51720 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753231AbbBYSd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 13:33:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 314813B2C8;
	Wed, 25 Feb 2015 13:33:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zTo5VlhEIdRKhiD3/rtXxZDfDLY=; b=hzMzmM
	6Pr84x4hFvRifM7dByYQF0PPmGZoUNXg73NXeJzubTwu0YgkQYr5PDKBZ2x/CGut
	rlOCYLpimdZBAHP35Z2mq9vCQaJBtlJZu1Pdo1TNrIvUMQQq79SSzb2Cx5FdPa/f
	cWNUYodlGLuC9GLXb1SWljGegSmIqj5pt/ijc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IiO+rgqNri6EQJh5j3vPXKgGgqKd1aO9
	UqkBra/gnu0jeY6PFFNoX3y/igpUmer9LH8fkPfLQ7/ocNKL1SxG3KL+mo8GLwbt
	FBgrkkHU2wf2F+X2ljg1Ih8QStONf/ANn37wHfJQfZfkgjr4UrsiS/PDV+zQtUnc
	xZpl+SR92AM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 279233B2C7;
	Wed, 25 Feb 2015 13:33:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8AFCF3B2A6;
	Wed, 25 Feb 2015 13:33:54 -0500 (EST)
In-Reply-To: <20150225143116.GA13567@peff.net> (Jeff King's message of "Wed,
	25 Feb 2015 09:31:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DA37FB46-BD1C-11E4-BBA4-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264400>

Jeff King <peff@peff.net> writes:

> If it's an attribute of the file, and not the request, maybe
> gitattributes would be a better fit. You can already do this with:
>
>   *.foo -diff
>
> in your .gitattributes file, though that _also_ marks the files as "not
> for diffing", which may not be desired. There's not a separate "grep"
> attribute, but I do not think it would be unreasonable to add one.

I have a vague recollection of having a discussion that started with
something like this:

    "diff" is named as if it is only for "diff" for historical
    reasons, but it is about "do we want to treat its raw contents
    as text?"

I do not recall its conclusion, but it it were "Yes, that is what it
means", then it might be reasonable to:

 - have "git grep" ignore paths marked with -diff by default
   (perhaps "-a" option to disable, just like GNU)

 - have "git grep" pay attention to diff.textconv and search in the
   result of textconv filter.


 
