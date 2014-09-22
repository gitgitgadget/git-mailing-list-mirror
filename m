From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailinfo: resolve -Wstring-plus-int warning
Date: Mon, 22 Sep 2014 13:50:37 -0700
Message-ID: <xmqqoau7js6a.fsf@gitster.dls.corp.google.com>
References: <1411290838-45622-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 22:50:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWAZK-0004Iw-5x
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 22:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052AbaIVUum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 16:50:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53822 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754770AbaIVUul (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 16:50:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 13D953DE44;
	Mon, 22 Sep 2014 16:50:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ovpp/9DSyBDOZlQFici9iJ6U9vE=; b=W0XnC2
	XUq3AIdcFIfiLt4wJ57JPjbSdPNzJTjiXZsCvMZQH83x8XOiDls2z66Nm9Q0btYe
	ohefUqJKps36abLJYortnWQiD/uh57O2iNkW4eVOmCjLQgn9r4fimdJNJZDMd+A+
	ZkNekVsIyKZYlCyFkC/li3fbHsj0StqMFebLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CjxMiRxbpmL1LqYSLusGj9euQ/fjU5/m
	xlcNAzoSHWF0tFmOQYbzJyagYf7Z9o4RqERUcb5wmUsuTTkFYDRckdC6RgQuL4yj
	YSy+DpPdNWSP61QwPTD+I9nR+qjF3EaeaLzm37uZ38OSg7UhdPfIScWLclj5GWcx
	iHkhe3r4cSI=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 08AD63DE43;
	Mon, 22 Sep 2014 16:50:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 78B733DE42;
	Mon, 22 Sep 2014 16:50:40 -0400 (EDT)
In-Reply-To: <1411290838-45622-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Sun, 21 Sep 2014 05:13:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1CE3BE1A-429A-11E4-A7EC-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257380>

Eric Sunshine <sunshine@sunshineco.com> writes:

> however, the solution in this patch allows us drop a couple strlen()s in
> favor of sizeof()s.

It is actually not a very good justification when you know you care
about the length of the string.  A decent compiler ought to know the
length of a constant string can be computed at the compilation time.

Let's at least not do that part of the change.
