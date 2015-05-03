From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout-index.c: Unconditionally free memory
Date: Sat, 02 May 2015 20:03:07 -0700
Message-ID: <xmqqbni2wefo.fsf@gitster.dls.corp.google.com>
References: <1430508507-14016-1-git-send-email-sbeller@google.com>
	<1430519737-6224-1-git-send-email-sbeller@google.com>
	<20150501224334.GB1179@peff.net>
	<xmqqpp6iwgnn.fsf@gitster.dls.corp.google.com>
	<20150503023024.GA4269@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 03 05:03:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YokBa-0003gd-30
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 05:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbbECDDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 23:03:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60733 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750866AbbECDDK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 23:03:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 473E54E43F;
	Sat,  2 May 2015 23:03:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y6IXpIx2Ys5IgKDEayJgYziIajA=; b=Pg8EfM
	oYp5EA7xSyjQfskkFGyk07jusQaXyZ1WAgD1YvN2WqG1jov7RChwXyBLiq45XqM8
	4DapNd5Dnvonci/92p4A0tlHMi6tiZwSRBLkLbtuFUqn2fv22VmyqRdhHa9iyLBj
	X+B3XUAvoVg8t5on8RtZXFM31Pqqb8k9uDjKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=APIfZ+tvzAKP1g1/gWyhaNkLbRaqE3F4
	Ri6hWWnbnMQLUC1FnwlqUkqN9vDIAms0o5+lyHmXn1fbbzwRoAmPxrN75HG4lt8S
	jWwwTeqXpx97Ed8thC0U7w4ZisIU9PdibriWJkSI5eKllv5MWnrqN5rqIi9rsedh
	ijGVf8ZIL2I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 406334E43E;
	Sat,  2 May 2015 23:03:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ABFCC4E43D;
	Sat,  2 May 2015 23:03:08 -0400 (EDT)
In-Reply-To: <20150503023024.GA4269@peff.net> (Jeff King's message of "Sat, 2
	May 2015 22:30:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ED2B8FC6-F140-11E4-A411-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268256>

Jeff King <peff@peff.net> writes:

>> Sure, the prefix could even be "prefix_path(): $message", I would
>> think.
>
> I almost suggested that, but it not a change to prefix_path at all, but
> rather to its callers. That may be getting nit-picky, though. :)

Using "prefix_path(): free returned memory in the callers" as the
title, with the body that explains that an earlier fix to make that
a requirement but forgot to do so for a few that are fixed in this
commit, would be sensible, no?  It is not about how prefix_path() is
implemented but its returned value, which is still about that
function.
