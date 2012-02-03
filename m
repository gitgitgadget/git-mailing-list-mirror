From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 11/13] status: add --column
Date: Fri, 03 Feb 2012 15:19:54 -0800
Message-ID: <7vobtfld2d.fsf@alter.siamese.dyndns.org>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328276078-27955-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 00:20:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtSQD-0004Cp-89
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 00:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459Ab2BCXT5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 18:19:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46278 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755142Ab2BCXT4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 18:19:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B9E46DC6;
	Fri,  3 Feb 2012 18:19:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VDjiQKiSqEas
	qHH6CZGxeowlQTQ=; b=lMKlslwdxkYqKP3HG3ogKzCNQrRsB4i7VIDlMYkwdUnX
	yoYFcHVxQOsmG7eYSx0JaMewAMN8LOruPCdgE5A+JOpNnINgHYiJ0NJuaiIN/hhC
	4sSRGkzRfvYPkqJ1IvfMTRgK7hiJOIgIB2WT+xGIAvmzCvoJBNA59m1iJPu/Y8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Zy5Txr
	ty/KdeVsY/i9wouk1wJ8dbYTyAohC1KA307RreXvhAWuk6dUpl1g1ruq6zDRpU6U
	ceROx5aDwV1S0C0PdVHUmnXbZTgRkgnhgcQaSjzPU8bi4VniZBdyCwxcFShu31Ft
	fgk4fh4X687TjykA2xgEqjbF7WMb4q6zqpsks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 042806DC5;
	Fri,  3 Feb 2012 18:19:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72DFD6DC3; Fri,  3 Feb 2012
 18:19:55 -0500 (EST)
In-Reply-To: <1328276078-27955-12-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 3 Feb
 2012 20:34:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95154936-4EBD-11E1-B677-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189828>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -1251,7 +1260,7 @@ int cmd_status(int argc, const char **argv, con=
st char *prefix)
>  	case STATUS_FORMAT_LONG:
>  		s.verbose =3D verbose;
>  		s.ignore_submodule_arg =3D ignore_submodule_arg;
> -		wt_status_print(&s);
> +		wt_status_print(&s, colopts);
>  		break;
>  	}

Do you really need to pass colopts around as a separate parameter all t=
he
way through the callchain?

Why isn't it a new member of wt_status that sits next to existing
use_color, verbose, etc. that define _how_ the status is shown?
