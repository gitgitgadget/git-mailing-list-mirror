From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t: Replace 'perl' by $PERL_PATH
Date: Sun, 17 Jun 2012 15:23:43 -0700
Message-ID: <7vk3z560i8.fsf@alter.siamese.dyndns.org>
References: <1339441313-5296-1-git-send-email-vfr@lyx.org>
 <4FDD7AE6.6000000@web.de> <7vipeq76ke.fsf@alter.siamese.dyndns.org>
 <4FDD9A4F.2060605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vfr@lyx.org, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 18 00:24:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgNtT-0002dn-5u
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 00:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab2FQWXq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jun 2012 18:23:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544Ab2FQWXp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jun 2012 18:23:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 586769920;
	Sun, 17 Jun 2012 18:23:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iOd32uAxcuVa
	v8KBwJuZKwIn3eE=; b=blUHyVT30CVRYg18od+kG8UJZYe3G6PeQ/zLs0PKgkiY
	B4FEASZPzO8F1BgUZPwlklnXwCyJ92cSOerSDGtL2HpV6oKiv3MNAsBCuvGKt9WC
	w1wJtblI+emy3+AD8HOLpqBb6AmMu+7EEI4SR/VWWmIFbQQ/TFz3e6DF1WaMuwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FDeLh3
	i88l/dpBNJY+bZd46HkQWlTQbHRuZ2lj3x0T9oPljjpSJjjtoTKrp380iCVKbbur
	I0i0J3etm9yf2dwhmjICx9qITyGQPgAxV6vz0nhWWxSqI0ySwHD4ws3FrN2ulL64
	27zYYdoIlK3V/lIRrd0l0+b0fDwJwOKIPvATs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F1C1991F;
	Sun, 17 Jun 2012 18:23:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6BE5991E; Sun, 17 Jun 2012
 18:23:44 -0400 (EDT)
In-Reply-To: <4FDD9A4F.2060605@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Sun, 17 Jun 2012 10:50:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19D24CD8-B8CB-11E1-BEF6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200134>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> PERL_PATH should be exported from test-lib.sh; we dot-source
>> GIT-BUILD-OPTIONS to get its value, but it is not propagated to the
>
> Thanks, that works for me.
> Do you squeeze some like that onto pu?
>
> @@ -493,6 +493,7 @@ GIT_ATTR_NOSYSTEM=3D1
>  export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_A=
TTR_NOSYSTEM
> =20
>  . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> +export PERL_PATH

Not on 'pu'; any fix should go on top of vr/use-our-perl-in-tests
topic that ends at b493e6b (t/README: add a bit more Don'ts,
2012-06-12).

I see other uses of bare "perl" that the patch forgot to convert,
and the worst part is that one of these uses of bare "perl" appears
in test-lib.sh _before_ it dot-sources GIT-BUILD-OPTIONS to pick up
the correct version of Perl, so the above single liner cannot be the
whole fix.
