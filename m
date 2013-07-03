From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: Skip pack-*.keep files when cloning locally
Date: Wed, 03 Jul 2013 10:26:35 -0700
Message-ID: <7vzju3ftbo.fsf@alter.siamese.dyndns.org>
References: <1372430538-19216-1-git-send-email-jl@opera.com>
	<7vvc4ynkrx.fsf@alter.siamese.dyndns.org>
	<CAEef6WzAg8-QMH1c4v=1tm7TPgfeE3W3K+ue-eYgRL3pyYo6Vg@mail.gmail.com>
	<7vip0ui757.fsf@alter.siamese.dyndns.org>
	<CAEef6WxnRbPVFgZP4asQrvYGVTTbGzeQCwPJrwj4a-6k9vFcbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, johan@herland.net
To: Jens =?utf-8?Q?Lindstr=C3=B6m?= <jl@opera.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 19:26:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuQpG-0002Du-VN
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 19:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792Ab3GCR0j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jul 2013 13:26:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193Ab3GCR0i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jul 2013 13:26:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB3812D740;
	Wed,  3 Jul 2013 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eMpmQjJ4lkzd
	bHOREMb36GmBOp8=; b=KExuvOhjbBchHgtlE9m65FcUBLOHEHd59hck/2qoxgp/
	+8u90ih9I2NASTka8hxMspOaeUE4dEDwgdBnGwohd18c7CU3iRSRHg6y2Einzhdj
	61rD4cVY9RYkcDDuIeEv88R/vW1xhMIfEJzlo9FUppjQ6m8hLkoYd611ksV7+r4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aRv89j
	g4IYqpFMLFgQa3cRBQuPMsrAg7TQ4PrJjXXBHjQ+p/POcXHUihafNLxxGtPaL4Qu
	MP/iTJ4YUu5yMl3/gnvmnpARRBQGZoDrtNBpkFK6KmyeQA980945qSNCj8bqYap9
	X7cpCWnYhm/28NL5YN9I/X8W0eWQsf3U9mFUU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EB5E2D73F;
	Wed,  3 Jul 2013 17:26:37 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07C1D2D73A;
	Wed,  3 Jul 2013 17:26:36 +0000 (UTC)
In-Reply-To: <CAEef6WxnRbPVFgZP4asQrvYGVTTbGzeQCwPJrwj4a-6k9vFcbQ@mail.gmail.com>
	("Jens =?utf-8?Q?Lindstr=C3=B6m=22's?= message of "Wed, 3 Jul 2013 12:02:49
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6FB0E08-E405-11E2-8A92-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229499>

Jens Lindstr=C3=B6m <jl@opera.com> writes:

> On Mon, Jul 1, 2013 at 6:20 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> I am not sure if we should care that deeply about them in the first
>> place.
>
> Fine by me; I don't really have a strong opinion on the matter.
>
>> Besides, I think you can make a hardlink to a file that you cannot
>> read.
>
> Not always.  The Linux kernel can at least be configured not to allow
> it.  It seems this is enabled by default in at least Debian.

You learn a new thing every day, I guess.  I am on Debian, I do not
think I did any customization in that area, and I can hardlink just
fine.

> This restriction had me a bit confused when I was testing variations
> here; I expected all "access denied" failures to be because of .keep
> files, but in fact creating hardlinks to other files (.idx and .pack)
> failed too, even though they were readable. =20

Is it possible that you are tripping cross-device link?  The reason
why we have "attempt to hardlink but fall back to copy" is exactly
because it is fairly common that people try local-cheap clone without
realizing the source and the destination may be on separate filesystems=
=2E
