From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] gitweb: Create install target for gitweb in Makefile
Date: Sat, 01 May 2010 12:45:42 -0700
Message-ID: <7vbpcz4d95.fsf@alter.siamese.dyndns.org>
References: <20100429235046.29606.35311.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 01 21:46:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Idb-0007AW-Et
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 21:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757527Ab0EATpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 15:45:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59232 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033Ab0EATpu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 15:45:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1A12AF9B8;
	Sat,  1 May 2010 15:45:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PHJkQBRliJ0qIKXmd4GzyXM4XNc=; b=PuFxF7
	u9F0tQyazDiAjf90M9+LHol0tOHIA6yoO4CQyHcdW+1wM9uLVmqV4gZnw3bvt6Fv
	Hukim5mk81mPQRfCfKsk1w+BxDItRO7Xu9wa1vxf/SE4NADHjcq0oe/M85zYIfi+
	cqHbboHSdEggrbcdrEdprlaeFwv1/ws7ptG70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J3N60U8BpmiIBs7DVLYvBGBrT5FJD5Po
	OEHrtygMDOqiufr/3chQW1IpHBZ2wP1033ZHhszPFhnSwxiBKzxE7UdUcor+eBXy
	Q9AywSlaBD2JAOr0V4cCRENhUM73378wqaiLhuCAyiQLfvMYaKPOlyLHL5hMAlz2
	ZO9i2d2ufl4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CB7CBAF9B7;
	Sat,  1 May 2010 15:45:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39EAEAF9B6; Sat,  1 May
 2010 15:45:44 -0400 (EDT)
In-Reply-To: <20100429235046.29606.35311.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Fri\, 30 Apr 2010 01\:58\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 230F96C4-555A-11DF-9691-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146113>

Jakub Narebski <jnareb@gmail.com> writes:

> Installing gitweb is now as easy as
>   # make gitwebdir=/var/www/cgi-bin gitweb-install  ;# as root
> The gitweb/INSTALL file was updated accordingly.

Just a style, but I prefer a blank line on both sides of an example
command line like this.

> There is a question whether to rely on correctly set file permissions
> during build phase, i.e.
>
> 	$(INSTALL) $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
>
> or whether to ensure correct file permissions during installl phase
>
> 	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
> 	$(INSTALL) -m 644 $(GITWEB_FILES)    '$(DESTDIR_SQ)$(gitwebdir_SQ)'
>
> Currently the first option is used.

Hmm, the reason being?  I do not have a strong preference either way, but
the primary Makefile seems to use "-m mode".

> Note that install-* targets, including new install-gitweb, are not
> marked as .PHONY

The reason being?

My preference for the standard targets like "all", "clean", and "install"
is to make them double-colon rules and mark them as phoneys.
