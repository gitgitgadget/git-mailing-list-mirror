From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] renaming strcmp/strncmp-icase
Date: Mon, 08 Sep 2014 12:56:01 -0700
Message-ID: <xmqqegvlnay6.fsf@gitster.dls.corp.google.com>
References: <xmqqmwaalzb4.fsf@gitster.dls.corp.google.com>
	<540E03F6.3010100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 08 22:00:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR52r-00009J-Tn
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 21:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797AbaIHT4G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2014 15:56:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52529 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbaIHT4F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Sep 2014 15:56:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D2AF936AC9;
	Mon,  8 Sep 2014 15:56:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=azLZO5cOQMYa
	lNlYRfF0puJ0u1g=; b=IhgQHSCUoJ6siWD1HMUOXMjCEqtobNVxkcY2PfvH/ABr
	B7sfDa/NdTTtrfB2BJ13Ii+Aj+eYOi8+w3yQD8EqaPmwfmt69MqVmKu0SD60VqvZ
	R9WW5IYcVbAQ06f+oSmSU9VZUkithUn/T+vKjpyYN8/r2f0+VJwyLMx3L2H/JxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UrRTd3
	zFdL18hUVHeH6BA101Mnd2EndhTSV/r/gSH6dcOreGyifY/QssNy5pb8bj8kowvB
	ok5jF2xoZoYojAQ2SHug6d1hd4yRbJFeofBQnTzt27JHllAeJxkxTgLRiCe4TIZI
	aZ+bbFPmaQTzYQ/PTkcxLu3H6zpfui2TcWdAs=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C9CC936AC8;
	Mon,  8 Sep 2014 15:56:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 261CE36AC2;
	Mon,  8 Sep 2014 15:56:03 -0400 (EDT)
In-Reply-To: <540E03F6.3010100@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Mon, 08 Sep 2014 21:31:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 29A8F862-3792-11E4-AD15-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256673>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> And then we have this in name-hash.c:
> (Which may explain the "icase" suffix ?)
>
> static int same_name(const struct cache_entry *ce, const char *name, =
int namelen, int icase)

As this file-scope static function takes the "icase" as an explicit
argument, I do not see anything confusing about it.  My complaint
was it is confusing that str[n]cmp_icase is not always icase, even
though the name of the function implies that it would be to those
who haven't looked at its implementation for a while.
