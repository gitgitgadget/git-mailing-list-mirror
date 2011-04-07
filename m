From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] magic pathspec: add tentative
 ":/path/from/top/level" pathspec support
Date: Thu, 07 Apr 2011 09:18:08 -0700
Message-ID: <7vd3kyf327.fsf@alter.siamese.dyndns.org>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-2-git-send-email-gitster@pobox.com>
 <BANLkTint7sGCg7_seu1-SWJC=_sKF-FKYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 18:18:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7rub-0007Mp-T0
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 18:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab1DGQSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 12:18:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab1DGQST (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 12:18:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2CA79492C;
	Thu,  7 Apr 2011 12:20:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eaZdPEOEkff70ajclGM7uqRob6w=; b=j9HxJv
	OAEZdAbooifAqCBh3cOky7tSlPyWzzFx7ILWWSgq8REXSW65eNI/yGtIh5BHn3jy
	5XeN0BHQ/KXUAeiB1AkHQXIK736xMMYzQtkH2ux3MghGHxx7ZzLYmHoq46baNNZw
	Rou9js5Y1lUzrhxKjOTamVZUG2Tst7bBarH5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rgj5CkKSzwjuIpHV9H4ecqOiHXM3qsp7
	jihOquSTnfXGbzyl797LdbuioAjCFQSf3z2FH8fir3W6WUbs1GYwM4Bbhy+YbCvG
	i4LgEJLA+c7HW/ce6kVW24HDjZnL+9IWlbzuZ0llNpEWlSg5AxyLP8i5txy7po39
	zobVhVBT0g8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0A85D492B;
	Thu,  7 Apr 2011 12:20:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 25096492A; Thu,  7 Apr 2011
 12:20:04 -0400 (EDT)
In-Reply-To: <BANLkTint7sGCg7_seu1-SWJC=_sKF-FKYw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 7 Apr 2011 20:23:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E76580C6-6132-11E0-87F4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171064>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Also the patch does not catch this (ie. not die() on unrecognized signature).

Of course it doesn't.

I didn't say "everything that is not alphanumeric is magic". I only said
"all the magic are not alphanumeric".  Notice the difference.


This is so that you can say ":/.gitignore" and do not have to say
":/:.gitignore".

I am also tempted to special case a ':' followed by a zero magic as if it
specifies the top magic, e.g. ":Makefile" is the same as ":(top)Makefile",
aka ":/Makefile".  It is not in the published code, but the short-cut
would help ":.gitignore".

You don't require, nor allowed to have, a colon after ')' when writing a
long hand, by the way.  There is no reason to require one for disambiguation.
