From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] CodingGuidelines: describe naming rules for configuration variables
Date: Mon, 02 Feb 2015 10:54:22 -0800
Message-ID: <xmqq386ouotd.fsf@gitster.dls.corp.google.com>
References: <xmqqiofskmfd.fsf@gitster.dls.corp.google.com>
	<1422484393-4414-1-git-send-email-gitster@pobox.com>
	<1422484393-4414-4-git-send-email-gitster@pobox.com>
	<54CDB5C6.3020702@alum.mit.edu>
	<xmqq1tm99yhx.fsf@gitster.dls.corp.google.com>
	<54CF1D7F.6050903@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 02 19:54:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIM8k-0006KW-8o
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 19:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878AbbBBSy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 13:54:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751116AbbBBSyY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 13:54:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56ADD34762;
	Mon,  2 Feb 2015 13:54:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SMYEMAqYliS22CvCEJzBXqzxGvY=; b=SC+OYj
	zh8jEkoKQ+5RTAEvlXqmB/MoXBfVne+BWvEavWw83SDBzZJTN7zUbSOnjJy/UEaK
	PHtpW5ABVrr8YET7Kd7QUpI/M5Nm3UBLy/9uSO9oLMo78apBXtOq8GfKNa7p7BEY
	HZpm2Q+c1eq9IFUGtsYXymZhGRjh71VVOZR1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LAPjDEnWf/FjFnoXUR1mHUHlRnCehV7m
	CDvCGo5Sk/vZKkcUUOnb3tCpEppPoA7Fu/HANfM5Sn0yMF0sLHzzRvjoNf331XDE
	xKeDRmUXvo/Jao4NpgHdxJ8u9D+4tf9r6wyj4y02U2xSshLRnOTtR95dEAtYMSXz
	y/jFFM5cRzI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D60A34761;
	Mon,  2 Feb 2015 13:54:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE32034760;
	Mon,  2 Feb 2015 13:54:23 -0500 (EST)
In-Reply-To: <54CF1D7F.6050903@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 02 Feb 2015 07:47:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E76243B6-AB0C-11E4-8073-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263277>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> You make an interesting point: values that start as a list of
> independent booleans can grow dependencies over time.
>
> In retrospect, ISTM that a better interface for the indentation-related
> "whitespace" settings would have been something like
>
> * "whitespace.indent" -- a single value chosen from "tabs-only |
> spaces-only | tabs-when-possible | anything"
> * "whitespace.tabwidth" -- an integer value
>
> This would have made the mutual-exclusivity of those choices manifest in
> the style of configuration rather than hoping that the user notices that
> his settings contradict each other.
>
> Let's dig into this example some more by imagining some other
> hypothetical future extensions.

Let's not; that line of thought entirely misses the point.  If you
start from one set of variables, you can define a structure
(e.g. "there are indentation-related and you must choose only one
among them") over it after the fact.

Once you have chosen a structure, you have to live with it.  Either
you make sure that a structure itself is extensible, or you make
sure you accept a new variable only if it fits within a structure.
Either way, you lose.  You cannot predict the future, and you do not
want to constrain those who will contribute to the project in the
future.

My aversion to one-variable-per-knob was primarily against the
"because that is how the variables are internally represented; a
collection of enums that can be independently set" argument.  If we
assume that one-variable-per-knob style implies variables that can
be independently set, that _is_ defining the structure the future
work has to live within.

But as I and Peff discussed in the other sub(sub)thread, having two
variables placed flatly in the namespace, e.g. ws.indentWithTab and
ws.noTabInIndent, does not have to mean they are independent.

And the opposite is also true; having these two knobs as possible
elements of the value of a single variable does not imply they
always have meaningful interactions.

So I am fine with "fsck.missingTagger = ignore/warn/error", as long
as the argument that supports the style is not "because
fsck.missingTagger and fsck.malformedIdent are independent".
