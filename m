From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] grep: stop looking at random places for
 .gitattributes
Date: Fri, 12 Oct 2012 09:47:07 -0700
Message-ID: <7vfw5j4oz8.fsf@alter.siamese.dyndns.org>
References: <1349877544-17648-3-git-send-email-pclouds@gmail.com>
 <1350038978-26153-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 18:47:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMiOS-0008Cz-8n
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 18:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759873Ab2JLQrN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Oct 2012 12:47:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759857Ab2JLQrL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Oct 2012 12:47:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B1A68E52;
	Fri, 12 Oct 2012 12:47:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=eE9p4FGzrjsA3+yZ8fxGZaDVx
	sc=; b=Da0V2fQjFOaAyJUsmqdN8wj/FyB+YnYRXFWh+o0jh34B3BDOOqHwf03Ld
	ObkTmnUrSqRR23M9H4bV8HASJ+WEdza/GvJnhi7F4wb/CBCHQqb/+/dHFr+hCflL
	5rpjKGhbPSVSN+PW5mW/VrhevMS7CEc5BYuhWnbDiM2xnZ1o1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=XFGzFpufw6XlFHSUInM
	nsEatNVYwkzQeAl1JUwzZk05FaRpGUcHbN6L1Mwtn8LA2Mml9GFQBpW0uET4qHKp
	NJjJxoF93WL6PmhDyKX5MGDMcWScVIi5CT+V6XJyhunMFnYnk5U+aI9qTOU+Yp75
	WeSBLFYxskHLVSgVavwb2vgA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC0878E51;
	Fri, 12 Oct 2012 12:47:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED0298E50; Fri, 12 Oct 2012
 12:47:09 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 770BEF0E-148C-11E2-BDEE-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207556>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> grep searches for .gitattributes using "name" field in struct
> grep_source but that field is not real on-disk path name. For example=
,
> "grep pattern rev" fills the field with "rev:path", and Git looks for
> .gitattributes in the (non-existent but exploitable) path "rev:path"
> instead of "path".
>
> This patch passes real paths down to grep_source_load_driver() when:
>
>  - grep on work tree
>  - grep on the index
>  - grep a commit (or a tag if it points to a commit)
>
> so that these cases look up .gitattributes at proper paths.
> .gitattributes lookup is disabled in all other cases.
>
> Initial-work-by: Jeff King <peff@peff.net>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Looks sensible and straightforward.  Thanks.
