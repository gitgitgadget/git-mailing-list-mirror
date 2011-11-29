From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] checkout,merge: loosen overwriting untracked file
 check based on info/exclude
Date: Tue, 29 Nov 2011 10:17:30 -0800
Message-ID: <7v7h2iu72d.fsf@alter.siamese.dyndns.org>
References: <CACsJy8AXLBNSPmeEJjD1QX2zF1ic+S9kb_+4=EBO9xd07xhAYQ@mail.gmail.com>
 <1322388933-6284-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 19:17:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVSFO-0004Eu-BH
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 19:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098Ab1K2SRd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 13:17:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36036 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756092Ab1K2SRc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 13:17:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2E49681F;
	Tue, 29 Nov 2011 13:17:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=uL4ITrKYOtofErbflxaxaxz1v
	9U=; b=BJMRt7rM1aa3KOm4wyaR0w5jQZt6yd/GX1p3xeLK15GgqOfHcAttKL5T1
	qudE/PDYdCXNy2vNkx/giNKcm9nr0ORx9gVxh/xYDVRI8ZgHHcpnB4DUYEk69rs6
	fSEBH6tXId2CsqQC5WLs0Pyk+bP4YYzA0TkeNbNWfxw0q9okBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=OLmrt5R6LOgxZOyCXzO
	VN86qU12oBXBFNkDAStAHcbx7L6dS/huMMuK5U05NoXRWsR+VUun9jNQ5pOMb45N
	POM/O8P+2GLMbkrBX766NC9hbTg6hYSFY5QHaOp/5IQlhb1v+DytESbNHRVFfCVu
	svMGiFdOIKXToEkHIYOvkOOA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8984681C;
	Tue, 29 Nov 2011 13:17:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F0EA6818; Tue, 29 Nov 2011
 13:17:31 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6724EB70-1AB6-11E1-806C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186068>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Back in 1127148 (Loosen "working file will be lost" check in
> Porcelain-ish - 2006-12-04), git-checkout.sh learned to quietly
> overwrite ignored files. Howver the code only took .gitignore files
> into account.

v1.5.3.5-721-g039bc64 also tried to make it harder to make this kind of
mistake, and forgot to spot it in git-checkout.sh which was a bit
unfortunate.

Thanks. I think both patches make sense, and especially 2/2 opens the d=
oor
to possibly make ignored ones automatically precious.
