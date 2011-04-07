From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] magic pathspec: add tentative
 ":/path/from/top/level" pathspec support
Date: Thu, 07 Apr 2011 11:28:10 -0700
Message-ID: <7v8vvlgblx.fsf@alter.siamese.dyndns.org>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-2-git-send-email-gitster@pobox.com>
 <7v62qqhm9h.fsf@alter.siamese.dyndns.org>
 <BANLkTinkXVSFYqqZ+pHK0w8ij5YtPMfKEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 20:28:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7twT-000543-9h
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 20:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227Ab1DGS2X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Apr 2011 14:28:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301Ab1DGS2W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 14:28:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F5DB5921;
	Thu,  7 Apr 2011 14:30:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ug+l+TMKMeE3
	6GvBG4O9UxsCeX0=; b=svlllgIJrcWA9amJkd/1bZo2v6lYIBI6zspiIZ3wYOTY
	tNiz2dMCPbfaU1nm24gMAFm+P9wr+hN65ROscxSl8NpzMoy9gw0GWTsBU/hJu51/
	v49pS8v1AIhGsTk+3pNcRK9G9G0eX3Nyv8p4r7xfBUNbMfjbmPsToaUBkmUoTS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aO2RXN
	wgb7p5kQU06/EOrMXPjUkFY2f6ZFGRxQY7KAF1y4j3L2cos1XqT51416INzIgHj8
	0jVhRa+X4zR3lSMGinQtk0eWpvN6alyol2iy/uP0PyZ+y1u8MPJvI/o+wWSMyb5j
	TDrn4iSu6B2DryjVo/sD5ekvDLQsAjMxMPlAg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 06F0C591F;
	Thu,  7 Apr 2011 14:30:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0B14B591D; Thu,  7 Apr 2011
 14:30:06 -0400 (EDT)
In-Reply-To: <BANLkTinkXVSFYqqZ+pHK0w8ij5YtPMfKEA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 7 Apr 2011 20:09:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11BE3586-6145-11E0-903B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171069>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2011/4/7 Junio C Hamano <gitster@pobox.com>:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (('a' <=3D ch && ch <=3D 'z') ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ('A' <=3D ch && ch <=3D 'Z')) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addf(&sb, "[%c%c]",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 tolower(ch), toupper(ch));
>
> Nice try. You know you are going to pay a high performance price for
> that, don't you ;) Maybe also worth mentioning in document that this
> applies to ASCII charset only (as opposed to Unicode).

You know this is a throw-away patch, just to illustrate that some thing=
s
are doable with a hack to add more code to get_pathspec(), while others
would need a bigger restructuring, don't you?

Besides, _if_ the user wants to do something costly, as long as the
implementation does not harm common cases, it _still_ is better to make
the code do the work, no?
