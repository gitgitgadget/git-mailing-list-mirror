From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/6] Enable threaded async procedures whenever pthreads
 is available
Date: Wed, 10 Mar 2010 14:28:07 -0800
Message-ID: <7v7hpjq0aw.fsf@alter.siamese.dyndns.org>
References: <cover.1267889072.git.j6t@kdbg.org>
 <7vk4tpdx9x.fsf@alter.siamese.dyndns.org> <20100306215051.GE2529@spearce.org>
 <201003092100.36616.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 10 23:28:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpUOE-0006Aj-6F
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 23:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366Ab0CJW2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Mar 2010 17:28:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352Ab0CJW2T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Mar 2010 17:28:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3915FA0AFF;
	Wed, 10 Mar 2010 17:28:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jxPdNY7vPhad
	FZTLO4IVSuI5MkY=; b=Pz4KtNwMpjJic9eP1RKzcSth74dpadGYevxAlOzJXxy9
	sRLV8F7GX2Hu6btkTN6FgcwQQNQtRJtgdbSSJlXPLTDN7m0qlGGiZAX0P0u1cchO
	fOh+jGlGPrXdV+FZKl8C+g05E2nkSh25llJvDV+DcCaHqsmF68Rsxqq8ERRR24k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iBb4JF
	LppFL9eHuT0nG/bFaWWCWD51wYog1oIsKwzSEBPosEbdy5bsRuZ5UDEfqDuFN7Db
	rPtc50TSh68N4J5OLZPYjtKGA7QHq1qtx+umlAGQN3Ql/AwT41Zg1nZhzNVyVS6d
	7WsaMj7CRBc3ZWO3rIu6DuxBFTawNRVWA+Aog=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03744A0AFC;
	Wed, 10 Mar 2010 17:28:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 569CBA0AFB; Wed, 10 Mar
 2010 17:28:09 -0500 (EST)
In-Reply-To: <201003092100.36616.j6t@kdbg.org> (Johannes Sixt's message of
 "Tue\, 9 Mar 2010 21\:00\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 36C163EE-2C94-11DF-B8C9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141927>

Johannes Sixt <j6t@kdbg.org> writes:

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> On Samstag, 6. M=C3=A4rz 2010, Shawn O. Pearce wrote:
>> I'm in favor of that.  If we have threaded delta search enabled,
>> we probably can also run these async procedures in a POSIX thread
>> rather than forking off a child.
>
> OK. The patch could look like this.

Will queue in 'pu', but as Shawn said, we should probably give another
closer look at the callees that are started with this interface before
moving forward.
