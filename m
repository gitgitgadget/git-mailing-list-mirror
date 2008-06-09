From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] cat-file --batch / --batch-check: do not exit if
 hashes are missing
Date: Mon, 09 Jun 2008 13:42:57 -0700
Message-ID: <7vwskyfige.fsf@gitster.siamese.dyndns.org>
References: <1212967717-5165-1-git-send-email-LeWiemann@gmail.com>
 <1212969741-24899-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 22:44:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5oDs-0002RJ-Hd
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 22:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbYFIUnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 16:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754237AbYFIUnL
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 16:43:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbYFIUnK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 16:43:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 10C51283D;
	Mon,  9 Jun 2008 16:43:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7E7E22839; Mon,  9 Jun 2008 16:43:03 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A99259C8-3664-11DD-830A-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84423>

Lea Wiemann <lewiemann@gmail.com> writes:

> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 973aef7..542b4ae 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -174,9 +174,27 @@ do
> ...
> +foobar84 missing" = \
> +    "$(( echo foobar42; echo_without_newline foobar84; ) | git cat-file --batch-check)"


I have a slight suspicion that some of the Bourne shell implementations we
support may misinterpret $(( as beginning of arithmetic expansion, so
perhaps we would want an extra SP between the open parens.

Other than that, looked ok.
