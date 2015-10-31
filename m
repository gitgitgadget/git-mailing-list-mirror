From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Limit the size of the data block passed to SHA1_Update()
Date: Sat, 31 Oct 2015 10:35:29 -0700
Message-ID: <xmqqoaffhrfi.fsf@gitster.mtv.corp.google.com>
References: <CA+izobsBmYHHepYka795K2VnVLYBmN2tFqEyzSweMoS9gvuRVw@mail.gmail.com>
	<1446243500-21580-1-git-send-email-apahlevan@ieee.org>
	<015b01d11362$0b8c1e70$22a45b50$@com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "'Atousa Pahlevan Duprat'" <atousa.p@gmail.com>,
	<git@vger.kernel.org>,
	"'Atousa Pahlevan Duprat'" <apahlevan@ieee.org>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 18:35:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsa40-0002KR-Bd
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 18:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbbJaRfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 13:35:32 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751999AbbJaRfb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 13:35:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D2A1825787;
	Sat, 31 Oct 2015 13:35:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mcFEpNb3PdPTGbu6VyziJ/53wTk=; b=ZpypNi
	MLoRXwI+ZEeNQ8Xunevmn1DzrXhSyh2hpE595PpMegTtgxw8RwiXiLF/qtfTIwnG
	hXXxaRZwpc03patjBEfpiShNpxvNCujs+h2D3HPXCOs1Bq9iDh0S/FBSprsEq8kk
	2BsRmHb9d3FnU2QnsGn+PrfwKDPTSCe+bDAc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DfEYxGyHQ96wuuXZazNKlrWfcAvYZBCU
	+pFiTOMNWhRkQU7vSwd5+dxnuvGT/hHLysoN1oIYGlg412Lh1vDlLu9Z8RDDR09w
	wMjjnuGaSYSq6Z3tr6YBXSwbLS8TFfbVfpuXZC6uMJE77KSrOSay9HS2zmoiHJAi
	yekIoVnglLg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CB09225786;
	Sat, 31 Oct 2015 13:35:30 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4599325785;
	Sat, 31 Oct 2015 13:35:30 -0400 (EDT)
In-Reply-To: <015b01d11362$0b8c1e70$22a45b50$@com> (Randall S. Becker's
	message of "Fri, 30 Oct 2015 18:26:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C7FCE814-7FF5-11E5-9767-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280586>

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> Didn't we have this same issue with NonStop port about a year ago and
> decided to provision this through the configure script?

I do not recall, but a support in configure.ac would be a nice
addition.

It does not have to be a requirement for the first cut solution,
though.  The customization based on Makefile variables like in
Atousa's change would serve as a foundation to add configure support
as a follow-up change, so let's not make the scope of this topic too
big before we have a solid foundation to build on.
