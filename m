From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: Ignore whitespace before patches
Date: Thu, 10 Jun 2010 09:51:40 -0700
Message-ID: <7vd3vyn84j.fsf@alter.siamese.dyndns.org>
References: <1273944188-9472-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 18:51:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMkyx-0003w5-Tu
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 18:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759560Ab0FJQvv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 12:51:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab0FJQvt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 12:51:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DA27BAD6E;
	Thu, 10 Jun 2010 12:51:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FnxlYS2Z4te6
	n9WOWMVgWgiYAGQ=; b=iIqW/w5FqNLWnjHg3GJsYw9YcRIYtPNFiufu3OwR7gkY
	p9ULvyTa0UOpoUbNqIPxeN0QNKlvvDGATffSrnLN7lr8sWSFXN3nHEtDg6hNXlTa
	mjB5UhioLrZhKvRot94rpupwap00/owMJQM9a0mQ5RfXQ2yPzKMWEhMQ211fb5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PilQtz
	29QTY0NkgHjKKy+KKYjQm04kL7qsDhdCj01od7nMqFMDg/yTQUCU+DQNzZakqCdc
	GUV9nBjzat86s7NagzD/iP0CHxdv/XYODt2uEpokz4W9MXx4IDk4r1m1uO0FwsYn
	pHYLyoOT2qc22HeG/mA3clxWZbAOAi/nHlEj0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3720BBAD6C;
	Thu, 10 Jun 2010 12:51:46 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B4D1BAD6B; Thu, 10 Jun
 2010 12:51:42 -0400 (EDT)
In-Reply-To: <1273944188-9472-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat\, 15 May
 2010 17\:23\:08 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 747E92C4-74B0-11DF-8172-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148891>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change git-am to ignore whitespace (as defined by sh's read) at the
> beginning of patches.
>
> Empty lines are wont to creep in at the beginning of patches, here's
> an example from a raw Gmail attachment:
>
>     20 20 20 20 20 20 20 20  20 20 20 20 20 20 20 20  |              =
  |
>     20 20 20 20 20 20 20 20  20 20 20 20 20 20 20 0a  |              =
 .|
>     52 65 74 75 72 6e 2d 50  61 74 68 3a 20 3c 61 76  |Return-Path: <=
av|
>
> Whitespace is also likely to appear if the user copy/pastes the patch
> around, e.g. via a pastebin, or any any number of other cases. This
> harms nothing and makes git-am's detection more fault tolerant.

Actually cut-and-paste is often a major source of whitespace breakage
(including tabs silently being expanded), and I personally think a patc=
h
like this to encourage the practice is going in a wrong direction.
