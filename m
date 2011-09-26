From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: auth plain/login fix
Date: Mon, 26 Sep 2011 09:38:21 -0700
Message-ID: <7v8vpb5kea.fsf@alter.siamese.dyndns.org>
References: <7vzkjn16n6.fsf@alter.siamese.dyndns.org>
 <1316879367-1182-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: joe@perches.com, git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Mon Sep 26 18:38:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8ECM-0002Da-8i
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 18:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927Ab1IZQiZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 12:38:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857Ab1IZQiY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 12:38:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95D7E54C4;
	Mon, 26 Sep 2011 12:38:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BIjZXDQhLQK3
	CkYu3RX/gkq1f/c=; b=SKano0zJZ8e1643YRm7UQwk8ht3uBxkWzAp6wxo57/Vb
	TSNuInDtATEVyTPwHtLGro+A9HpA/TvYYjLXA07mc4WGBKv1JD7HXMDY+z6igJ4Q
	AMxZP8zijq6EWeA0s0elHAJK569kjPwsmNJEIfJf9x5rxTKms3O+y/BhyHjBUhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FV76/c
	rRVaUKNqKTQt9+juBrO4r23uDrD0NFhOqZy5NIbY/OcD5gEOAhMcepiGOXFWs4lO
	Oj4FtSRxcHSJVRajR72PYy46MjAVwZfl+KEORLFcpLzLBK6zyjm8W1Wqb8f4/CBK
	M7uwBoNdTBdv8wIsov4ndvoE5DPNHbif6naio=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D19954C3;
	Mon, 26 Sep 2011 12:38:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D80254C2; Mon, 26 Sep 2011
 12:38:22 -0400 (EDT)
In-Reply-To: <1316879367-1182-1-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Sat, 24 Sep 2011
 17:49:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F32F0956-E85D-11E0-A8BE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182128>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> git send-email was not authenticating properly when communicating ove=
r
> TLS with a server supporting only AUTH PLAIN and AUTH LOGIN. This is
> e.g. the standard server setup under debian with exim4 and probably
> everywhere where system accounts are used.

Now that's a solution that makes me feel less dirty than

  http://thread.gmane.org/gmane.comp.version-control.git/178818/focus=3D=
178824

even though, by forcing Authen::SASL::Perl to be used bypassing XS and
Cyrus variants, this _might_ be introducing regression for others. We'l=
l
find out soon enough if anybody screams ;-)

I see you already researched previous discussion and have Joe Perches i=
n
the loop; Thanks.
