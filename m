From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff too slow for a file
Date: Tue, 04 May 2010 15:56:54 -0700
Message-ID: <7vy6fzl1hl.fsf@alter.siamese.dyndns.org>
References: <4BB00573.6040005@gmail.com> <4BC9D928.50909@lsrfire.ath.cx>
 <7vpr1y2eev.fsf@alter.siamese.dyndns.org> <4BCB48E5.9090303@lsrfire.ath.cx>
 <7vd3xuinbe.fsf@alter.siamese.dyndns.org> <4BDD7869.10701@lsrfire.ath.cx>
 <7v1vduwd8j.fsf@alter.siamese.dyndns.org> <4BE080AF.2030604@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed May 05 00:57:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9R3B-0007y4-52
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 00:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934478Ab0EDW5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 18:57:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934441Ab0EDW5D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 18:57:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D474B0D28;
	Tue,  4 May 2010 18:57:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CLihfKaSGlLj
	pNi6fSffJMGfPOM=; b=G5/h3ISDL+0aRU3akjbWNS4NXRdKq7oROvio5qHpbV/8
	ECsBQR/Mfad+RevzisgMX93TYU6t2inoCGR226YGU1xXM95DZ9UhlEajIdPDIPSi
	xlNfTIG5hd5QdJkxcqKsMyqiUfLeIi2TGlLqLyl0jQ/KKyMoYsl/M/sOP5wDbMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=i42tI9
	BVLJEadNbaQy1iSkZlMeBX1X2RR2YG93r9M6mho51RgV2m6KdZeSTq3Af2MKsVML
	LqjDt+24v7C6g4oxYpssv0hylTww9y0pgGYBfQ9ULZjrc9sXFiAYE4dPWWpPPBSw
	iF2+uv3Q2LBzr4IEqd2y7a3YivJKeORbiv5Xs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ECCBDB0D1C;
	Tue,  4 May 2010 18:56:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45F1BB0D1B; Tue,  4 May
 2010 18:56:55 -0400 (EDT)
In-Reply-To: <4BE080AF.2030604@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue\, 04 May 2010 22\:16\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 58387EB0-57D0-11DF-A291-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146354>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> But when I take a closer look at the surrounding code, I can't help b=
ut
> ask if the flags really have be passed in such a complicated way.
>
> How about the following, which makes xdi_diff*() take a simple flag
> parameter instead, moving the code to handle xpparam_t into
> xdiff-interface.c, which seems to be the proper place for it?

This looks very sensible.  Your patch doesn't touch xdiff/ proper but o=
nly
the thin interface layer, so we don't have to worry about deviating fro=
m
the upstream even further.
