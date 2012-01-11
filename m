From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/10] clone: allow --branch to take a tag
Date: Wed, 11 Jan 2012 15:57:28 -0800
Message-ID: <7vboq96bdj.fsf@alter.siamese.dyndns.org>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
 <1326189427-20800-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 00:57:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl82y-0000gY-Fu
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 00:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556Ab2AKX5e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 18:57:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549Ab2AKX5b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 18:57:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A004062CC;
	Wed, 11 Jan 2012 18:57:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=ogNA/qVMtapvVpMrFtISlu9H2
	1Y=; b=G7yASXbsI3nXmPpeGdWhrkE5pdwuI0P+UEGUKn9sgbhiVD98sOyde2+QY
	sA77g6sjpvybzUCbbDXkxgnKVqd74DwaZ5npC2WKZnCm40XPD1BMzugQdyXbTKAX
	x7vaM0w7t9jmMhCnYoQLOjUAvoc5ywIG3RlerKwJJsCochbQIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=nqMJgsdOun0KZaTDJAT
	aiZshesM/tzrsa7TfjOO6DeeKXySdFcLTnRr5io5QdPd3Mxb/poVuaLSBX/mhV8o
	lHiDp7VFZogqsLs0z9ARLk9lERewNiZ2uFJlu66LdkjFiH8qmtgIStyEdyEYI5I4
	ooKRUKvNvQo/y3Pyhj8GrmGY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9835162CB;
	Wed, 11 Jan 2012 18:57:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31EA762C8; Wed, 11 Jan 2012
 18:57:30 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 058223EE-3CB0-11E1-8128-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188407>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> @@ -766,6 +771,14 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
>  				find_ref_by_name(mapped_refs, head.buf);
>  			strbuf_release(&head);
> =20
> +			if (!our_head_points_at) {
> +				strbuf_addstr(&head, "refs/tags/");
> +				strbuf_addstr(&head, option_branch);
> +				our_head_points_at =3D
> +					find_ref_by_name(mapped_refs, head.buf);
> +				strbuf_release(&head);
> +			}
> +

Ok. I think this makes sense.
