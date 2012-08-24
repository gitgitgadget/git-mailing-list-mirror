From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Support non-WIN32 system lacking poll() while keeping
 the WIN32 part intact
Date: Fri, 24 Aug 2012 12:46:36 -0700
Message-ID: <7vboi0yswz.fsf@alter.siamese.dyndns.org>
References: <004001cd81f9$21e68e10$65b3aa30$@schmitz-digital.de>
 <7vsjbc1dg1.fsf@alter.siamese.dyndns.org>
 <005401cd822a$67687a30$36396e90$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, "'Erik Faye-Lund'" <kusmabite@gmail.com>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Aug 24 21:46:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4zqA-0001AV-O5
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 21:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760118Ab2HXTql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 15:46:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37311 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757692Ab2HXTqj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 15:46:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67FD09FCF;
	Fri, 24 Aug 2012 15:46:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q7LGoAzaB5l8nvfqlxgw3b31FyY=; b=IhUOD1
	/b60+eaI0vwW+rTixzNuMbOJS4fUxJ+Y8w9bwqMA7iv0Z12sMxek9K6CE6x4XR54
	zTmcU28j5CyPLzn720OhLBV/cFAkaj/dwU8vHUTE14XoCNRo+gpSX92SoAamB040
	BRCzIYWLEotRAU7WK9aU1muFrvuur3AVnxBvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JMMsPg5TKbrANDddD5TiaNSq0oQeiKPg
	SYEX/h7wO/qgXvlOBvIHDECZR0OuwmEWig3/3ME9woQMO4+eWLhnxNpelk7/PhV8
	pTx8vSuEI/S7j+Fneg7Wv0XvK/HO672Tie6rLg5Zl9Gh0K8675x8hC4D8iQilC/5
	vni40JrD7pA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53B8A9FCE;
	Fri, 24 Aug 2012 15:46:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C65ED9FCD; Fri, 24 Aug 2012
 15:46:37 -0400 (EDT)
In-Reply-To: <005401cd822a$67687a30$36396e90$@schmitz-digital.de> (Joachim
 Schmitz's message of "Fri, 24 Aug 2012 20:58:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AF098D4-EE24-11E1-8528-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204229>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Different, but related question: would poll.[ch] be allowed to #include "git-compat-util.h"?

Seeing other existing generic wrappers directly under compat/,
e.g. fopen.c, mkdtemp.c, doing so, I would say why not.

Windows folks (I see Erik is already CC'ed, which is good ;-),
please work with Joachim to make sure such a move won't break your
builds.  I believe that it should just be the matter of updating a
couple of paths in the top-level Makefile.

Thanks.
