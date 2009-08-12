From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Tue, 11 Aug 2009 23:33:06 -0700
Message-ID: <7v3a7xa6e5.fsf@alter.siamese.dyndns.org>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
 <1250005446-12047-2-git-send-email-pclouds@gmail.com>
 <1250005446-12047-3-git-send-email-pclouds@gmail.com>
 <1250005446-12047-4-git-send-email-pclouds@gmail.com>
 <1250005446-12047-5-git-send-email-pclouds@gmail.com>
 <1250005446-12047-6-git-send-email-pclouds@gmail.com>
 <1250005446-12047-7-git-send-email-pclouds@gmail.com>
 <1250005446-12047-8-git-send-email-pclouds@gmail.com>
 <1250005446-12047-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 08:33:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb7Om-00053g-0x
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 08:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbZHLGdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2009 02:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbZHLGdO
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 02:33:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZHLGdN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 02:33:13 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7EDE748C;
	Wed, 12 Aug 2009 02:33:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A26D748A; Wed, 12 Aug
 2009 02:33:08 -0400 (EDT)
In-Reply-To: <1250005446-12047-9-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Tue\, 11 Aug
 2009 22\:44\:06 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 026706D8-870A-11DE-87ED-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125671>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -594,6 +596,8 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
>  		OPT_BOOLEAN('m', "merge", &opts.merge, "merge"),
>  		OPT_STRING(0, "conflict", &conflict_style, "style",
>  			   "conflict style (merge or diff3)"),
> +		OPT_SET_INT(0, "sparse", &opts.apply_sparse,
> +			    "apply sparse checkout filter", 1),

Shouldn't this be BOOLEAN not INT, i.e. "--[no-]sparse"?  That way, you
could enable it by simply the presense of $GIT_DIR/info/sparse.

It could also require core.sparseworktree configuration set to true if =
we
are really paranoid, but without the actual sparse specification file
flipping that configuration to true would not be useful anyway, so in
practice, giving --sparse-work-tree option to these Porcelain commands
would be no-op, but --no-sparse-work-tree option would be useful to
ignore $GIT_DIR/info/sparse and populate the work tree fully.

Or am I missing something?
