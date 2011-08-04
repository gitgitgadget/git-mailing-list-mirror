From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why isn't there a hook for all operations that update the
 working tree?
Date: Wed, 03 Aug 2011 19:06:26 -0700
Message-ID: <7v1ux26icd.fsf@alter.siamese.dyndns.org>
References: <CACBZZX7dJhGT0H8JZRbQ_t9mNnJocaktYAXgMSihfLBuFmL3nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 04:06:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QonKU-0005GP-Cf
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 04:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594Ab1HDCGa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 22:06:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63754 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756582Ab1HDCG3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 22:06:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAA3D4D31;
	Wed,  3 Aug 2011 22:06:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ksbgtbmw9rCr
	XTN74O+TY9JCKKM=; b=fmSdNoLPGijvVt1E2USKy3FHZmQPFP/OyZEgRPM5b7yt
	QsHZx+D2IAcrdlR1MwPF3wnca4y0/UWxh2CeX0ZpF5m8GW/hTYTwedzXeY4NDbc4
	zt1rjs2RKuNPYCtPaNJjUhH7kvQ4+yKLonlWAUWUxFfxe0900mXcUePBfeTQyKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FQg2GQ
	vXaJ2ERq0r5UCqvLrDlrcohG3ZVGTTWoKpJA33fIfWRWcV2iSKX0XD4cfH5ygUt+
	oNtdAOo4vTsKb4DxfP5N9MF7xwyXfFkFqpKvrKM5nSi9OE5UltWbaqlPVyt2Lh0H
	eQ9FEV0f5gp+LkCeRlfso8VVcte0iHRak1cyw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0D7D4D30;
	Wed,  3 Aug 2011 22:06:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F1BE4D2E; Wed,  3 Aug 2011
 22:06:28 -0400 (EDT)
In-Reply-To: <CACBZZX7dJhGT0H8JZRbQ_t9mNnJocaktYAXgMSihfLBuFmL3nw@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 28 Jul
 2011 13:59:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D3DA02C-BE3E-11E0-BE24-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178654>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> ... Is there any
> reason beside omission that there isn't a post-reset hook?
> Or hooks for any other thing ...

In principle, we historically tended to avoid hooks unless absolutely
necessary. Even having to check to find out no hook needs to be run is
considered wasted cycles.

  http://thread.gmane.org/gmane.comp.version-control.git/79314/focus=3D=
79321

I'd especially rather not to see a hook on something as low level as
"reset". It would be too tempting to use "reset" itself inside a hook t=
hat
is run from the post-reset hook, and I do not want to complicate the co=
de
even further to give callers to ask disabling the hook.
