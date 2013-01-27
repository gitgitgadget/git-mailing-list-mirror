From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/4] mergetool--lib: Simplify command expressions
Date: Sun, 27 Jan 2013 23:08:46 +0100
Message-ID: <5105A56E.4010002@kdbg.org>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com> <1359321886-80523-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 23:09:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzaPZ-000297-7Q
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 23:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643Ab3A0WIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 17:08:51 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:38812 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756595Ab3A0WIu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 17:08:50 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C5621A7EB0;
	Sun, 27 Jan 2013 23:08:46 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4A24819F46B;
	Sun, 27 Jan 2013 23:08:46 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130105 Thunderbird/17.0.2
In-Reply-To: <1359321886-80523-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214738>

Am 27.01.2013 22:24, schrieb David Aguilar:
> Use $(command "$arg") instead of "$(command "$arg")" as the latter is
> harder to read.

If at all, you should restrict yourself to simplify only variable
assignments. Because this case:

> -	if test -z "$(get_merge_tool_cmd "$merge_tool")" &&
> +	if test -z $(get_merge_tool_cmd "$merge_tool") &&

cannot work as intended: If the output of $() is empty, then without the
outer quotes this becomes

  test -z

without an operand for -z, which is a syntax error (of the test command).

-- Hannes
