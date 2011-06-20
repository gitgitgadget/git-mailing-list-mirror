From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with
 NO_NORETURN
Date: Mon, 20 Jun 2011 14:53:58 -0700
Message-ID: <7vk4cgb24p.fsf@alter.siamese.dyndns.org>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
 <1308445625-30667-2-git-send-email-andi@firstfloor.org>
 <7vsjr4b3tf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 23:54:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYmQ4-00011u-Ja
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 23:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245Ab1FTVyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 17:54:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab1FTVyB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 17:54:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 13220658D;
	Mon, 20 Jun 2011 17:56:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fqhWwCwaQKkCW6CP0vMHYBuc1NI=; b=btybZN
	n+e3Rvd0MzhH/ANIqvSf1Z87xuhUzrjhl3ToEd/ssACiCnVk6EEWjujOHDKcnC2c
	bJbthYsh0cwfJ+vZWmGviKf8ln+F05uYDRmYemULUTgu48p3XEDjpt/k1ZhaWY7F
	fJ7WDno5h1YXRRFvPmJTr02JG1YNizJI8VZTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c3gIDQ40P+NxBQwSUqrOPjzkoWuvrsnk
	CGTw9r9edee7hnTZP41rOZOC1TnYHtd28TtVbqKPdrW2IOI64K2VzyY6LggIrN2D
	3TXd2nbskwmOnGVb74P8/ddxRpjHX9a3V8HsXkxDgQAwaGsw3bfWQ9OnuLvCHILP
	4CCZCam2NVo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B16F658C;
	Mon, 20 Jun 2011 17:56:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6E4A5658B; Mon, 20 Jun 2011
 17:56:12 -0400 (EDT)
In-Reply-To: <7vsjr4b3tf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 20 Jun 2011 14:17:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CF25BF8-9B88-11E0-85EC-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176097>

Junio C Hamano <gitster@pobox.com> writes:

> I think this is probably a bad move, given that the previous patch is a
> temporary workaround until gcc 4.6 is fixed. With -Wunreachable-code on,
> these will introduce noise for build without NO_NORETURN (either when
> profile feedback is not used, or when profile feedback build is in use and
> it no longer requires the NO_NORETURN workaround).

I would need to clarify with s/introduce noise/introduce more noise/; the
existing codebase is not noise-free.

But I do not see much point in making things worse, only to squelch
"reaches end of non void function" warnings that will be given under the
NO_NORETURN workaround configuration.
