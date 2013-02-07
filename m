From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Makefile: factor common configuration in
 git-default-config.mak
Date: Thu, 07 Feb 2013 11:28:26 -0800
Message-ID: <7vobfv7wkl.fsf@alter.siamese.dyndns.org>
References: <vpqobfxwg2q.fsf@grenoble-inp.fr>
 <1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
 <1360174292-14793-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 07 20:28:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3X9Q-0005Q6-Ib
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 20:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758934Ab3BGT23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 14:28:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755511Ab3BGT23 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 14:28:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81867B20C;
	Thu,  7 Feb 2013 14:28:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=p9m80kxfvQn+2Qcdd2O9v85NxwI=; b=JoqGwnChHm9B0APgYJdF
	LKO+4OyZozOKp8Fr+HVDPBkjLAGlP03OfWSCJFIg2KGZlzeRsfl7cLhBAavlrtmE
	80zVMoPCovUICkLfhjKEXUD2Ew3gGGwfaIynSK/1uXiTM2yqVaWsSNUy0IhtejBz
	7E3c+wa4KZZPisJnML/u4ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=swXd5snege/1VMaue0Ct3g/CvZx47icbEmT1T+5sovIGVW
	irCWBDq5WRgyZXZ4WiBID99igOykp3lNL419OrbytAdiOK0kKr2wuZ680Y7GQTKW
	JNs1mySj9ck4i0FdbPQKkSAz1dgBSPta+0C3djVh9q9epbRrFl2TzAVveb9QU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75528B20B;
	Thu,  7 Feb 2013 14:28:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB992B203; Thu,  7 Feb 2013
 14:28:27 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C53224C-715C-11E2-820E-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215714>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Similarly to the extraction of perl-related code in perl.mak, we extract
> general default configuration from the Makefile to make it available from
> directories other than the toplevel.
>
> This is required to make perl.mak usable because it requires $(pathsep)
> to be set.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

I really think this is going in a wrong direction.  Whatever you
happen to have chosen in this patch will be available to others,
while whatever are left out will not be.  When adding new things,
people need to ask if it needs to be sharable or not, and the right
answer to that question will even change over time.
