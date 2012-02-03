From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 08/13] column: add column.ui for default column output
 settings
Date: Fri, 03 Feb 2012 15:04:42 -0800
Message-ID: <7v62fnmsc5.fsf@alter.siamese.dyndns.org>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328276078-27955-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 00:04:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtSBV-00053P-JX
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 00:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161Ab2BCXEp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 18:04:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40643 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828Ab2BCXEo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 18:04:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BF8D6BB6;
	Fri,  3 Feb 2012 18:04:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WFVaKiCPLsK9
	iEynI4vfcg/NHrI=; b=M7vLTMrYE0XvoHcvFUpe2mAFAktSVd3ttPn5STQWxVKf
	PuQfO3SpYxz+0/xOwebTwRKh8lQy/Uy9Lj7kYHjpGAYoZsZDf8nNkfV05O1ptFAQ
	KzWtCmDz3/6O1OujZ22hwykB3giMG/fjqzAceqZoavOamBqEC8oAcqpiTCb3QsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=otX0oO
	a7UUmA/UOGIWVCzkqFUolIPmDzVNJlQxqni2C961A6tIMyohqiJQb9XjUVQPkegl
	d4sbQcS4f+6Ai66gRK8act9z2tvNVtGWGGPSRQldq5w6If0+8JkRtetgRyaL63fx
	NnWSgJuNTZ6vd+ccbdWEdieENlc3OKS7H8fhY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43CED6BB5;
	Fri,  3 Feb 2012 18:04:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD7E56BB4; Fri,  3 Feb 2012
 18:04:43 -0500 (EST)
In-Reply-To: <1328276078-27955-9-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 3 Feb
 2012 20:34:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75B5C860-4EBB-11E1-8918-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189822>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/column.h b/column.h
> index 1912cb0..afdafc4 100644
> --- a/column.h
> +++ b/column.h
> @@ -17,6 +17,8 @@ struct column_options {
>  	const char *nl;
>  };
> =20
> +extern int git_colopts;

=46or a global state variable, I'd prefer to see it spelled out, e.g.
git_column_opts or even git_column_options.  It's not like you would be
referring to this variable from everywhere---you would use it only from
fallback codepaths after parse_options() returns, or something, no?
