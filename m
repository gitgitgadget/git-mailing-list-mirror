From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] copy.c: make copy_fd preserve meaningful errno
Date: Fri, 21 Nov 2014 09:48:19 -0800
Message-ID: <xmqqa93k1m3g.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<546F0284.7050904@alum.mit.edu> <546F033F.7030201@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Nov 21 18:48:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrsK5-0001Ek-BD
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 18:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbaKURs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 12:48:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751204AbaKURsX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 12:48:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 159461F470;
	Fri, 21 Nov 2014 12:48:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TH9VlRbHvxRqUGlIBUIxKll/vDo=; b=x2La4a
	m1/TcEl4nqau621F0JDSl9hcVAyfjnumGOKdgxHxvU5ny3v9Q3IVK7BxlrIRAdtp
	1lMACqQn0g/fTEo1gLyvQUqTmyS/SFCtTS1LzVtzCyKXOBe6mg40Xw+jBS7Q9cHX
	J4J4e7SfBnPQ4olsrcm0K4GvXcVj+LwZqQQnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xEBNaHkAJqy7w5mzPwCiSwUNPLV8d1Fo
	S3U6sJE3vDkqxMQL1V+0Rj0W1bfXr0jse528kjJJq19o1RBKBR3uKYwtHlDmAhBG
	//soU4sDYqZPvRt5DZ2b0/rmQahwGPbHfwu3wnqXM8pcDNHLbpJd9/xZmVHZAakQ
	v/SH13Y6SRM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07E441F46F;
	Fri, 21 Nov 2014 12:48:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E8C71F46C;
	Fri, 21 Nov 2014 12:48:21 -0500 (EST)
In-Reply-To: <546F033F.7030201@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 21 Nov 2014 10:17:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9589F786-71A6-11E4-97AA-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 11/21/2014 10:14 AM, Michael Haggerty wrote:
>> Couldn't we save ourselves a lot of this "save_errno" boilerplate by
>> making error() and warning() preserve errno? [...]
>
> Never mind; I see that Peff already submitted a patch to this effect.

My understanding of the conclusion of those four patches was that
only a single updated one is needed, and "moving save/restore inside
error()" did not have to survive.

  http://article.gmane.org/gmane.comp.version-control.git/259911
