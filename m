From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make words boundary for --color-words configurable
Date: Thu, 01 May 2008 20:54:57 -0700
Message-ID: <7vprs5xsvi.fsf@gitster.siamese.dyndns.org>
References: <1209699564-2800-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 05:56:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrmNV-0008Go-6K
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 05:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765554AbYEBDzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 23:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757982AbYEBDzI
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 23:55:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761329AbYEBDzH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 23:55:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9CE511FDE;
	Thu,  1 May 2008 23:55:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E9C511FDD; Thu,  1 May 2008 23:54:59 -0400 (EDT)
In-Reply-To: <1209699564-2800-1-git-send-email-pkufranky@gmail.com> (Ping
 Yin's message of "Fri, 2 May 2008 11:39:24 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C22C576-17FB-11DD-A1D2-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80955>

Ping Yin <pkufranky@gmail.com> writes:

> Previously --color-words only allow spaces as words boundary. However,
> just space is not enough. For example, when i rename a function from
> foo to bar, following example doesn't show as expected when using
> --color-words.
>
> ------------------
> - if (foo(arg))
> + if (bar(arg))
> ------------------
>
> It shows as "if <r>(foo(arg))</r><g>(foo(arg))</g>". Actually, it's the
> best to show as "if (<r>foo</r><g>bar</g>(arg))". Here "r" and "g"
> represent "red" and "green" separately.
>
> This patch introduces a configuration diff.wordsboundary to make
> --color-words treat both spaces and characters in diff.wordsboundary as
> boundary characters.

Just an idle thought.

I suspect a more natural definition of word boundary is between a run of
word characters and a run of non-word characters.  IOW, instead of saying
" " and "(these other)" characters are boundary, you would say

	if (foo(arg))

between f and space, open paren and f, second o and open paren, that open
paren and a, ... are boundaries.

If you go that route, you would make the definition of "what is the set of
word characters" configurable.
