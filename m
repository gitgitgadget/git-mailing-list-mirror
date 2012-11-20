From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git config --git-all can return non-zero error code
Date: Mon, 19 Nov 2012 16:10:04 -0800
Message-ID: <7vd2z9uobn.fsf@alter.siamese.dyndns.org>
References: <50AABA9B.6090007@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 01:10:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TabQ2-0005Rn-T4
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 01:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607Ab2KTAKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 19:10:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236Ab2KTAKH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 19:10:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FB3D7343;
	Mon, 19 Nov 2012 19:10:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UU8PsVUv6SpGDYslrv+kesADcEM=; b=Y33NOJ
	t0Brf2u5tQrXe+08OYBl3eY0vl/GrXrhry9By1DhwDpqfnJH+NHA3L+YvcaiBIhm
	IbN3eeUlaM8oaKomhwd5SjK494Hjpw2Nr2yMRIXBZ961oh7ZYTl8t+xIqGWgXD7H
	i4bXSVD4MFwV9JBFP2Ua+xjMEA86BmCfKyWmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C+fYMvQIGyVtilGfgcWEvhrJUFDBu6Hk
	V/aZWn3dQtZ6j5AOjgIktKgMMo1Y5GPZORMFTBBk/n2FfufdrVeq8UM/To8rlrAs
	QLpzjiuVuvoYOsA8JFATFr40P0b/rYE4jrXW3pmeN5Bq3JCxmdiKnawTximVezGD
	nYISUQicVBI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81A6A7341;
	Mon, 19 Nov 2012 19:10:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EACD7733E; Mon, 19 Nov 2012
 19:10:05 -0500 (EST)
In-Reply-To: <50AABA9B.6090007@freescale.com> (Timur Tabi's message of "Mon,
 19 Nov 2012 17:02:51 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A345074E-32A6-11E2-821A-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210068>

Timur Tabi <timur@freescale.com> writes:

> According to the man page for git-config, the --git-all option is not
> supposed to return an error code:
>
> --get-all
> 	Like get, but does not fail if the number of values for the key is
> 	not exactly one.
>
> IMHO, zero is also "not exactly one",...

It should have stated "like get, but unlike get, it does not fail
when there are multiple values for the key", but the documentation
was written with that specific knowledge that "--get" has a logic to
make it fail when there are ambiguities, and wanted to stress that
difference.  It forgot to mention their similarity explicitly and
relied on "Like get" part to mean (1) shows the value(s) given to
the key, and (2) it is an error if there is no such key defined.
