From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] t4211: demonstrate empty -L range crash
Date: Tue, 23 Jul 2013 12:03:05 -0700
Message-ID: <7vvc416qvq.fsf@alter.siamese.dyndns.org>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
	<1374589688-27751-3-git-send-email-sunshine@sunshineco.com>
	<20130723175942.GA21019@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jul 23 21:03:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1hrd-0002cS-OZ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 21:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757424Ab3GWTDJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jul 2013 15:03:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756829Ab3GWTDI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jul 2013 15:03:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4935F330ED;
	Tue, 23 Jul 2013 19:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=arl5CKxP+5gD
	g6s8D699V7yM8Ys=; b=LSJmT91IgkUYyYub4RCfY4eF9N6Uq9bpa7kKZI4dd0/U
	kB76SYnxHQv1M2U9DspRDXz9cio04DiOV+oktQKvUu1abADGGi+5Rrau2a3EtS+F
	N5AYtOPqILka6UUydWQQ4CcSJ1vN0q2ZGW/zou05OmTHBIkExyTehcRvusF1K0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CvrSSX
	H+yltxtgsDe0cIYlYV8UylZPML32PPJ/rE7L2fGse7Md/Imod6A4WkJQIrsGxCuv
	wfX2Z8L0vr4YMLMoJ7E/jwUPCwrDahwjFWNirp7G/fxMQJq2N7jgCxxbJmvct2Y/
	hOEC+DwJnjuL+NzOgh7PKbODq04IB24Li2Jfg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C787330EC;
	Tue, 23 Jul 2013 19:03:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96A5B330EA;
	Tue, 23 Jul 2013 19:03:06 +0000 (UTC)
In-Reply-To: <20130723175942.GA21019@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
	"Tue, 23 Jul 2013 19:59:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 821AE5EE-F3CA-11E2-98CF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231052>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> You could avoid the 'cat' here and patch in 4/5 by doing $(wc -l <b.c=
).

Correct.

> (Side question: the test suite is full with similar constructs, i.e.
> redirecting file contents to stdin, but why not just use wc -l b.c,
> i.e. let wc open the file?)

"wc -l <b.c" is the correct form for the purpose of these tests;
otherwise you will see the filename in the output, and you need to
somehow strip it if you are only interested in the line count.
