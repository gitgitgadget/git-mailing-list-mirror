From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] index-pack: restructure pack processing into three
 main functions
Date: Mon, 07 May 2012 17:19:49 -0700
Message-ID: <7vy5p31q3e.fsf@alter.siamese.dyndns.org>
References: <7v8vh8c6mx.fsf@alter.siamese.dyndns.org>
 <1336307516-1809-1-git-send-email-pclouds@gmail.com>
 <1336307516-1809-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 02:20:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRY9w-0008EK-2d
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 02:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757952Ab2EHATw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 20:19:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32881 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757803Ab2EHATw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 20:19:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52F48660F;
	Mon,  7 May 2012 20:19:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=v/Ms2xGmbD8TXj5WHujcSlEgp
	bw=; b=rz5+v4K7AZ9+V5nAnW+OkAdLj4hRmMDI92q+GAgp5MB5Kse9fXwpwtByW
	7WNe/1dfrcwyuqpz5GGykfv36SfpZI4bJhQi7sEdrwcdd50P5u+TjPnQaT8mNNpF
	Lt0UAfdxCuaspoEWHdJjK2cvN/Gc3vRKkc0LnO3gaXTjO3T1KM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=msGwj/RLguPmvf6IV2L
	Yx26Zv56kKKzXUmBTmqs4xVgYhxZUSW4twYZGLRSHm8kujiZuY/Mmoj7Ptgs9LN9
	cWSw4dqQdxVvvdfNF83LHeLtreKM7y0Mc1Z/JHNJWuI4fUYF7Yb876hRNIk6alky
	1q+m4UwA1Lqv4FC5oOkgy9Xk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A5C0660E;
	Mon,  7 May 2012 20:19:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6276660D; Mon,  7 May 2012
 20:19:50 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86F124B2-98A3-11E1-9D41-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197332>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The second pass in parse_pack_objects() are split into
> resolve_deltas(). The final phase, fixing thin pack or just seal the
> pack, is now in conclude_pack() function. Main pack processing is now=
 a
> sequence of these functions:
>
>  - parse_pack_objects() reads through the input pack
>  - resolve_deltas()     makes sure all deltas can be resolved
>  - conclude_pack()      seals the output pack
>  - write_idx_file()     writes companion index file
>  - final()              moves the pack/index to proper place

The resulting code looks much more streamlined, instead of just splitti=
ng
out the second phase alone.

Very nice.  Thanks.
