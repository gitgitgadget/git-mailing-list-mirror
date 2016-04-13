From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: detect and offer to skip backup files
Date: Tue, 12 Apr 2016 18:38:13 -0700
Message-ID: <xmqqvb3ml24a.fsf@gitster.mtv.corp.google.com>
References: <xmqqlh4io2v1.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZ+_JW-5BWdXse++_KaATO+qDhNtTz_k5gX507sObZyzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 03:38:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq9l6-0008MN-US
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 03:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757217AbcDMBiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 21:38:17 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757149AbcDMBiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 21:38:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F6195581C;
	Tue, 12 Apr 2016 21:38:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e5hE4uC4p2OEdRl7fqEVopHT9GY=; b=HIGaE1
	WmuPoMwy75tirMpZ+ATsGcqxy0g3emviVBBpF5+gzAjrIztB8BIAaYO9b6k5Owar
	OHE0/ysR6ZAOZYF01jPSKTS654NfsqxXcbO8vJp81HNVyHitNrMZr0MD/OEX7Y65
	GI166CmPiEZqjA6IHMnN6CtdZoXoe04LKNayY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iyb0YzzWnz7Y8siK3dBUAVGf/JJSHLPe
	JmXL2hxt9WeR3TPy0D6Vb9UZewuCWt3G5umtzyLGoBX5lgE0EOLj8qrYieddhbKt
	HkuXS87bdVCIXdcRHdEn0QjcS75X9z9zvu43qK3OGQv4sRMZ7Si9Q5vRnNPa+oDN
	FM1sDJEpZbQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2774A5581B;
	Tue, 12 Apr 2016 21:38:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 99D5F5581A;
	Tue, 12 Apr 2016 21:38:14 -0400 (EDT)
In-Reply-To: <CAGZ79kZ+_JW-5BWdXse++_KaATO+qDhNtTz_k5gX507sObZyzA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 12 Apr 2016 16:05:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 63CA989C-0118-11E6-983D-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291361>

Stefan Beller <sbeller@google.com> writes:

> Once I made the mistake to not remove a previous patch series I had,
> such that there was:
>
>   0000-coverletter.patch (newly worded)
>   0001-bla-from-new-series
>   0001-foo-from-old-series
>   0002-...
>   ...
>
> `git send-email 0*` then sent out a totally bogus series for me.
>
> As another user friendly helper we could warn/abort if the first <n> characters
> are the same as the previous patch as well?

I think that would be one of the many things that can be built on
top.  For example, you could notice that all messages begin with
4-digit and a dash, and send such a set to a special case (where
patches having duplicated numbers are signalled as a potential
error).
