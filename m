From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] checkout: reorder option handling
Date: Wed, 29 Aug 2012 11:37:21 -0700
Message-ID: <7v7gshwnmm.fsf@alter.siamese.dyndns.org>
References: <CACsJy8Cjbg2tb_E+D7hMwPZNFWhvEF1eNpf5HUBzJnBoQQaMAg@mail.gmail.com>
 <1346248524-11616-1-git-send-email-pclouds@gmail.com>
 <1346248524-11616-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 20:37:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6n8t-0005rh-30
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 20:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374Ab2H2ShY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Aug 2012 14:37:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754220Ab2H2ShY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Aug 2012 14:37:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A3D99EC6;
	Wed, 29 Aug 2012 14:37:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zx1kpzKTm8ZN
	qCr8Lk7aEulEmQA=; b=X4ieU8ihGea68qmZhsnUOrKfEjGPdMLf1d/nX0gugUJY
	taM0yXaA/8lnjhZLiAkTGY1nT/Qj/aoigMh/3DH05dcJ5iTfN+opJVZYv6RKJCSt
	Gr0037fPqlEmY2Ev34PWuSIemiaomMHd/gIRc0+++P3/LKh2G6nwYVf0m+amrGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nGf3Yf
	u2/sLhs/EIFuLKwfmsVgADcIR5vSp0quJDRE9L6BSAzhNH8FctULf3Ytm8oCy73r
	GKBPa53yEyuhENzc89lAKVt222MGqfeAotSvisBttjKF+/wgwDcxekz2s2zH4d8G
	P0YSRzxngJowqNz7RZ4jC0wfEQjErIVUrzjtY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37E2E9EC5;
	Wed, 29 Aug 2012 14:37:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9FF99EC4; Wed, 29 Aug 2012
 14:37:22 -0400 (EDT)
In-Reply-To: <1346248524-11616-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 29 Aug
 2012 20:55:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 925CB9E2-F208-11E1-9611-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204492>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  I'm not entirely sure about this chunk
>
>  +	if (opts->track !=3D BRANCH_TRACK_UNSPECIFIED) {
>  +		if (opts->new_orphan_branch)
>  +			die(_("%s cannot be used with %s"), "--orphan", "-t");
>  +		if (opts->force_detach)
>  +			die(_("%s cannot be used with %s"), "--detach", "-t");
>  +	} else
>  +		opts->track =3D git_branch_track;
>
>  If we don't want -t and --orphan/--detach together, then we probably=
 should ignore
>  branch.autosetupmerge when --orphan/--detach is specified.

Yeah, I agree.

>  I did not unify new_branch, new_branch_force and new_orphan_branch.
>  They touch other parts of the code and should probably be done
>  separately.

That sounds like a very sensible decision.
