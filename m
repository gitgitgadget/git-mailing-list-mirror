From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/19] tree-diff.c: reserve space in "base" for pathname
 concatenation
Date: Mon, 13 Dec 2010 10:10:02 -0800
Message-ID: <7vlj3t35ol.fsf@alter.siamese.dyndns.org>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 19:10:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSCqp-0000Mn-DO
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 19:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758555Ab0LMSKN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 13:10:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758018Ab0LMSKK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 13:10:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 69CE02F23;
	Mon, 13 Dec 2010 13:10:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=atJvgskrcjVXGioZA3/V9xGRd
	xQ=; b=c2UAPGPz1uWwWGih5uKcqXX5KsEViUiqFOt2vCLoU600bquePrSWF5e6w
	ksyV3HF2BxosJzKki5P52yp4aE4t2mGj+seHXR6SSGbvauUxfZFAHzEuslrjizui
	/NBSGioJReZFuC0G0QtpdVIA+LrsswOq1f2BoBXuoax/DdEUpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=UQWOcrXNs2kmbYf2aAv
	w/Y0mXYXKjamQ5sEFSqdb4i0l47qi1ATwta8rlkgIe90ZRBqMMNlFugbsC2fYgOU
	P29cyCEIetRLDc3IvzpbBjIEyNq/P/Xo3Q1HHkjf0YDqjbmQMhHrxlQieju3Cf/J
	q7mLweHQQVzpLonYCh98VnrI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 34AF62F21;
	Mon, 13 Dec 2010 13:10:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 28A642F1F; Mon, 13 Dec 2010
 13:10:29 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 46D49668-06E4-11E0-8C3D-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163572>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This patch make sure that "base" parameter is writable. The callees
> are free to modify it as long as base remains the same before
> entering and after leaving the callee.
>
> This avoids quite a bit of malloc and memcpy().
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

I like what I see in this patch in general, but there is nothing that
guarantees that you are "reserving" enough space.  Doesn't the buffer
overflow with deep enough trees?
