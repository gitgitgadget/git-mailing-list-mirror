From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] new git check-ignore sub-command
Date: Sun, 02 Sep 2012 13:35:14 -0700
Message-ID: <7v7gscgnnr.fsf@alter.siamese.dyndns.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 22:45:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8H2b-0000NT-3H
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 22:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab2IBUop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 16:44:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35556 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754754Ab2IBUom (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2012 16:44:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 615D8832A;
	Sun,  2 Sep 2012 16:44:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=8rMFe7bSm1MsZqBMNs2AGUXwVQQ=; b=A/ow60tN743eeNUTue7r
	G1tOlomoy1u7PlHE9zvWfmZjAq0CwmzW+R+lZuUYlkvuPSRcLZ79182Le0ZZINm6
	GV5nMgYrR02V9PR/ZGGL9+UyaDO6R40f7ItXrceQJxVY+phF7K/4AotRJZlmS9si
	RNEhvn117D4QZSd8+yNMp9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=fO832fbFp06mJ5ovK1AgcTxEmmoCntBl5HOXNwvDAiviQ9
	xOjJIaIBsG7/AUmmAvpEzCysFbQ4SpEK5cq7YTnRhSRKavX6/HjhmkW/D9PDTp8k
	imkogGMTsvZbii/TlJ6Hl5us/dhidOiaTMU90RTs0DB6bFD4fPE9iPjNGQe/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E0CE8329;
	Sun,  2 Sep 2012 16:44:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAE338325; Sun,  2 Sep 2012
 16:44:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05371DC0-F53F-11E1-9B7E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204676>

Adam Spiers <git@adamspiers.org> writes:

> I was browsing stackoverflow the other day and came across this question:
>
>     http://stackoverflow.com/questions/12144633/which-gitignore-rule-is-ignoring-my-file/
>
> A quick google revealed this thread from 2009:
>
>     http://thread.gmane.org/gmane.comp.version-control.git/108671/focus=108815
>
> where Junio and Jeff discussed the possibility of adding a new `git
> check-ignore' subcommand somewhat analogous to the existing `git
> check-attr', and suggested the beginnings of an implementation.  It
> struck me that it might not be too hard to follow these ideas to their
> natural conclusion, so I decided it would make a fun project :-)

Thanks.  I wish there are more people like you ;-)

As to styles, I spotted only three kinds of "Huh?":

 * do not initialise statics to 0 or NULL, e.g.

    -static int exclude_args = 0;
    +static int exclude_args;

 * avoid unnnecessary braces {} around single statement blocks, e.g.

    -if (exclude) {
    +if (exclude)
        return exclude;
    -}

 * else should follow close brace '}' of if clause, e.g.

     if (...) {
         ...
    -}
    -else {
    +} else {
         ...

For reviews on substance, please see other messages from me.
