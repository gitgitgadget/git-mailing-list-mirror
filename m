From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] instaweb: make it compatible with Mac OS X 10.5's
 apache installation.
Date: Mon, 12 May 2008 11:42:03 -0700
Message-ID: <7v7idzz7no.fsf@gitster.siamese.dyndns.org>
References: <1210534569-48466-1-git-send-email-nathans@gmail.com>
 <B3990C52-0AF9-490C-86E1-B311144C6661@gmail.com>
 <200805121952.55492.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nathan spindel <nathans@gmail.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon May 12 20:43:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvczR-000646-4c
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 20:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900AbYELSmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 14:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756031AbYELSmY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 14:42:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbYELSmX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 14:42:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8855C4D36;
	Mon, 12 May 2008 14:42:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DFD2D4D35; Mon, 12 May 2008 14:42:17 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 28898378-2053-11DD-8617-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81899>

Christian Couder <chriscool@tuxfamily.org> writes:

> Maybe you can use a function like this not tested one:
>
> check_cmd() {
> 	cmd="$1"
>
> 	if type "$cmd" > /dev/null 2>&1; then
> 		if "$cmd" -v | grep Apache > /dev/null 2>&1; then
> 			httpd=$(echo "$cmd" | sed "s/apache2/httpd/")
> 		fi
> 	fi
> }

One worry I have with that approach is if any and all random
implementations of "httpd" that live somewhere in path do not do any harm
when started with "-v" option.  Namely, they should exit without becoming
a daemon and/or start the service.

I am not convinced that would be the case.
