From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: re-allow HEAD:Documentation on a remote
 invocation
Date: Wed, 11 Jan 2012 18:46:56 -0800
Message-ID: <7vipkh4oyn.fsf@alter.siamese.dyndns.org>
References: <20120110232132.GA29245@sigill.intra.peff.net>
 <1326283958-30271-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Albert Astals Cid <aacid@kde.org>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Jan 12 03:47:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlAgy-0002hv-NA
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 03:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab2ALCrA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 21:47:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab2ALCq7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 21:46:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF24C68B1;
	Wed, 11 Jan 2012 21:46:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+n8HZ6Po6Udy
	GkeQy4Gzri6MYB0=; b=ulhiDz0LI4UE9m0YImRFsWov+ODlUjeYkmZFO6u2ghY7
	eY4sD8IAasYNxtCBE5XG78m1zO2G/a71FVR/MaEQDQ00v6wlNQD5BMuBty0rL51c
	u2KJCKRxw5ywdizu/KKYbzGNreoCSJSrbyVSCAnrNhcT/JssjnoiRad4fLo0rXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=r5bTFS
	SKiOZVjaDQVHG4xBFsJJhMRW51vtKpXg7LfpjoDH/GqUUgwk0Dv/JyQhj5i3K9yG
	4sv074bwIYwcxiUkp7iNP0CeI0I0Fiqy3JMgFsEI3E6puP/nSRYXli7gHdsWHEYr
	FwaoxAE/yZSCzOfJ/fZsjTDBeHsSEfWDRoyeY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA5A668B0;
	Wed, 11 Jan 2012 21:46:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B95868AF; Wed, 11 Jan 2012
 21:46:58 -0500 (EST)
In-Reply-To: <1326283958-30271-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Wed, 11 Jan 2012 13:12:38
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B221FDBA-3CC7-11E1-A831-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188416>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> The tightening done in (ee27ca4a: archive: don't let remote clients
> get unreachable commits, 2011-11-17) went too far and disallowed
> HEAD:Documentation as it would try to find "HEAD:Documentation" as a
> ref.

I do not think it went too far. Actually we discussed this exact issue
when the topic was cooking, and saw no objections. The commit in questi=
on
itself advertises this restriction.

Why are we loosening it now? I do not see a compelling reason to do so.

> Only DWIM the "HEAD" part to see if it exists as a ref. Once we're
> sure that we've been given a valid ref, we follow the normal code
> path. This still disallows attempts to access commits which are not
> branch tips.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---
> AFAICT this should still be safe. Using HEAD^:Documentation or
> <sha1>:Documentation still complains that HEAD^ and <sha1> aren't
> refs.

Having said that, I think I agree this is a safe thing to do, _if_ we w=
ant
to loosen it.
