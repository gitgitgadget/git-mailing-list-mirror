From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix problem with authentification on http repository.
Date: Sat, 29 Sep 2007 16:38:27 -0700
Message-ID: <7v8x6pjb4c.fsf@gitster.siamese.dyndns.org>
References: <11911047823308-git-send-email-jean.guyader@linkea.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jean Guyader <jean.guyader@gmail.com>
To: jean.guyader@linkea.org
X-From: git-owner@vger.kernel.org Sun Sep 30 01:38:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbltU-0001DK-4o
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 01:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbXI2Xih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 19:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754507AbXI2Xih
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 19:38:37 -0400
Received: from rune.pobox.com ([208.210.124.79]:34742 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbXI2Xig (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 19:38:36 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 338E913DF8C;
	Sat, 29 Sep 2007 19:38:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 97C9213DE32;
	Sat, 29 Sep 2007 19:38:51 -0400 (EDT)
In-Reply-To: <11911047823308-git-send-email-jean.guyader@linkea.org> (jean
	guyader's message of "Sun, 30 Sep 2007 00:26:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59511>

jean.guyader@linkea.org writes:

> From: Jean Guyader <jean.guyader@gmail.com>
>
> Curl uses the option -u user:passwd and not the user:password
> given in the url.
> The solution was to extract user:password from the url and set
> the option.
>
> Here the regex used :
>         sed -re 's-.*http://([^:]*):([^@]+)@.*-\1:\2-g'

This is more like "allowing embedded authentication credentials
in URL for http transport".

We never supported URLs with embedded credentials (see
Documentation/urls.txt), partly because nobody asked for it, but
more importantly because giving -n to curl to have it read from
user's .netrc is generally much more preferred approach.
