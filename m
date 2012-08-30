From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/4] wincred: port to generic credential helper
 (UNTESTED)
Date: Thu, 30 Aug 2012 13:11:10 -0700
Message-ID: <7vpq68qgwx.fsf@alter.siamese.dyndns.org>
References: <503A680C.3090406@qo.cx>
 <1346018649-3002-1-git-send-email-pah@qo.cx>
 <CABPQNSZsXnf2kjcN+Qma8pApjGRF6SD5iJjB2Ow6GuGts0Z=Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Philipp A. Hartmann" <pah@qo.cx>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 30 22:11:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7B5E-0001Ha-St
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 22:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026Ab2H3ULO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 16:11:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49589 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121Ab2H3ULN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 16:11:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C43094A7;
	Thu, 30 Aug 2012 16:11:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TvQi46/lbj4Ntg5fgK+Xp0miGFU=; b=GYCYDp
	uJ5XJy1cBY1ALcj1/I3y0A3IM47Mr0BV+eo+O+QE7hepPg8oZSBrpg8lbnWiYKU3
	tm96zRUM34oAFsBQUjhlTpyCNBGkIWAUX2bAiRKrf8e1ejJNdzo82t9l9o3tGKus
	62igV9uJSUME14j+Qpx11uu/VrCYpWFnq4M0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I2egO/Q1un7DyT7DF5memiKmzmCZgZMs
	ua+1RMk+y2sAgYtF9dihhKnsMSbB4Ce/oicCuOegb8N6jvKNxayBIgJAqqIeumgG
	M6IlY3uLvMMGXLcQFCuXvRkO1q/XAaaBvFxN9r3PJoqIOIOlf1n3ponYV2uptXoq
	e3XWTW6byNU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19FA694A6;
	Thu, 30 Aug 2012 16:11:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F29694A5; Thu, 30 Aug 2012
 16:11:11 -0400 (EDT)
In-Reply-To: <CABPQNSZsXnf2kjcN+Qma8pApjGRF6SD5iJjB2Ow6GuGts0Z=Kg@mail.gmail.com> (Erik
 Faye-Lund's message of "Thu, 30 Aug 2012 20:27:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7C70510-F2DE-11E1-8D71-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204563>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Mon, Aug 27, 2012 at 12:04 AM, Philipp A. Hartmann <pah@qo.cx> wrote:
>> From: "Philipp A. Hartmann" <pah@qo.cx>
>>
>> This patch is an experiment to port the wincred helper
>> to the generic implementation.  As of know, it is
>> completely untested.
>>
>> In addition to porting the helper to the generic API,
>> this patch clears up all passwords from memory, which
>> reduces the total amount to saved lines.
>>
>> Signed-off-by: Philipp A. Hartmann <pah@qo.cx>
>> ---
>>
>> The porting was fairly easy, but due to the lack of a testing
>> platform, it is completely untested.
>>
>> Erik: Can you try to have look?
>
> Sorry for the late reply, I'm currently in bed with pneumonia.
>
> But I gave it a quick go, but as-is it's a NACK; a wall of warnings and errors.

Thanks, and get well soon.

For now, let's not worry about merging the "let's share code across
helpers" bit that comes later in Philipp's series.
