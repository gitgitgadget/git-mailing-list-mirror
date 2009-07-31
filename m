From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] gitignore: read from index if .gitignore is not in
 worktree
Date: Fri, 31 Jul 2009 09:55:26 -0700
Message-ID: <7vhbwsssg1.fsf@alter.siamese.dyndns.org>
References: <1248850154-5469-1-git-send-email-pclouds@gmail.com>
 <1248850154-5469-2-git-send-email-pclouds@gmail.com>
 <1248850154-5469-3-git-send-email-pclouds@gmail.com>
 <1248850154-5469-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 18:55:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWvON-0005ay-Ph
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 18:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbZGaQzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 12:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752478AbZGaQzb
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 12:55:31 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbZGaQzb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 12:55:31 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C4A321BC08;
	Fri, 31 Jul 2009 12:55:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3C4871BC04; Fri,
 31 Jul 2009 12:55:28 -0400 (EDT)
In-Reply-To: <1248850154-5469-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\, 29 Jul
 2009 16\:49\:12 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F4A88C1C-7DF2-11DE-8A6E-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124582>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> this allows to use .gitignore in sparse mode, where .gitignore may or
> may not be checked out (CE_VALID)

Hmm, do we have a guarantee that we have read the index when .gitignore=
 is
used in all the codepath in the current codebase?

"git add" used to do the fill_directory() traversal before reading the
index in some cases back in v1.6.0 days for a reason.  "git add" does n=
ot
do so anymore, but I am wondering if there are others.
