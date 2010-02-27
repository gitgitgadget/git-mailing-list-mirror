From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] grep: Colorize filename, line number, and separator
Date: Sat, 27 Feb 2010 09:08:33 -0800
Message-ID: <7vy6ie1u9a.fsf@alter.siamese.dyndns.org>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com>
 <1267246670-19118-5-git-send-email-lodatom@gmail.com>
 <4B89079C.8030206@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Feb 27 18:09:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlQA0-00040C-3p
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 18:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968632Ab0B0RIp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2010 12:08:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968612Ab0B0RIn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Feb 2010 12:08:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D07C69DE38;
	Sat, 27 Feb 2010 12:08:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=o8j1rqM6J3WU
	08/eFqDE3s+C2Os=; b=gD+8e3rkxORMcrkbYcw8ohYh5Y1kH8qwdM6LoKonIime
	+83t5g3zmpZ6ZG9NXegTe+Fh5cl2hDn/HRrleP0T/PMY116E3e52HDDFFiU3+jSU
	bc+gIcEsJeQe7+fhj+3zv+WDZDImLLy0/dj/ZtWpRo542fJrasH1/wKq0+1tqNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hLWA56
	ICF5iy2B99gcSdHX/E4fdZqXCUsf7KyyOMNuFS2bn5rGKXL+pbSzncZQO4BpkS3x
	OKXL9hjvrEbpB4uZGIhgDl8X5soHbnHw0VE219RKCYqfn5qd5jMrnopWSAyVXwuV
	JqIUEmr87gIONZ41b50MBEgl/xSiBsRn5/Dnw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DB4D9DE37;
	Sat, 27 Feb 2010 12:08:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3F9B9DE2C; Sat, 27 Feb
 2010 12:08:35 -0500 (EST)
In-Reply-To: <4B89079C.8030206@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat\, 27 Feb 2010 12\:53\:00 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BFFDF8B4-23C2-11DF-90EB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141219>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>> -			opt->output(opt, bol + match.rm_so,
>> -				    (int)(match.rm_eo - match.rm_so));
>
> The third parameter of output_color() (and of ->output(), so you didn=
't
> introduce this, of course) is a size_t, so why cast to int?  Is a cas=
t
> needed at all?

I don't think so.

Earlier in 747a322 (grep: cast printf %.*s "precision" argument explici=
tly
to int, 2009-03-08), I casted the difference between two regoff_t you w=
ere
feeding to printf's "%.*s" as a length, introduced by 7e8f59d (grep: co=
lor
patterns in output, 2009-03-07), and 5b594f4 (Threaded grep, 2010-01-25=
)
carried that cast over without thinking.
