From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 7/8] update-ref: support multiple simultaneous updates
Date: Wed, 04 Sep 2013 12:17:06 -0700
Message-ID: <xmqqk3iwmm6l.fsf@gitster.dls.corp.google.com>
References: <cover.1378142795.git.brad.king@kitware.com>
	<cover.1378307529.git.brad.king@kitware.com>
	<ad27a96b70198e837ac61995a1328960e10072bc.1378307529.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 21:17:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHIZo-0007g6-Bh
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 21:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208Ab3IDTRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 15:17:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43234 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752572Ab3IDTRK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 15:17:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CCC73F29C;
	Wed,  4 Sep 2013 19:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5I79vmtu2Auqq0f3e1Aut1lg1hs=; b=l9nl9x
	FiKwIRpNJatILKKpo+o/4NyQYdsqMHSdmw/UrSmo1QcheIWO/bKOz09joDnBOoHC
	Y/eP3NbQYdfK3BIvLsHRQS85ti655h6CAniBgdji25CwIZbwp8zzGs5bJU7+wABd
	Nv0ZOK3Lz1GiHp/tbWk0ItZdi5w9Ur1dlO3KQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DgBtiQ8tHtwIR0Dasw0PfahgDiXZs5Gx
	DnfXWCMo3rC8bcTJzpx8p6WcTHqxi0G+Ix+vAHMQzE7Ua8cttWwUKO8/Ri8HLZGQ
	WwR1eL63W9s/oKILyXx/PGJEiwNIXvxVCei1/mdrWeLfuMnlb1Fo+S/Ex1dyIfmP
	roFuA/GtRzg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FD263F29B;
	Wed,  4 Sep 2013 19:17:10 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFAF73F297;
	Wed,  4 Sep 2013 19:17:08 +0000 (UTC)
In-Reply-To: <ad27a96b70198e837ac61995a1328960e10072bc.1378307529.git.brad.king@kitware.com>
	(Brad King's message of "Wed, 4 Sep 2013 11:22:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 98022168-1596-11E3-9916-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233865>

Brad King <brad.king@kitware.com> writes:

> +static void update_refs_stdin_read_n()
> +{
> +	struct strbuf line = STRBUF_INIT;
> +
> +	while (strbuf_getline(&line, stdin, '\n') != EOF)
> +		update_refs_stdin_parse_line(line.buf);
> +
> +	strbuf_release(&line);
> +}
> +
> +static void update_refs_stdin_read_z()
> +{

These need to be defined with explicit (void) argument list.

	static void foo(void)
        {
        	...
