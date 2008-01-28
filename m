From: Wayne Davison <wayne@opencoder.net>
Subject: Re: [PATCH] config.c: Expand $HOME and tilde character in
	core.excludesfile
Date: Mon, 28 Jan 2008 15:52:05 -0800
Message-ID: <20080128235205.GE8669@blorf.net>
References: <y7a9aaem.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 00:52:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJdmQ-0001q3-7M
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 00:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828AbYA1XwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 18:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756193AbYA1XwI
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 18:52:08 -0500
Received: from dsl-74-220-69-132.cruzio.com ([74.220.69.132]:50431 "EHLO
	dot.blorf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536AbYA1XwH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 18:52:07 -0500
Received: by dot.blorf.net (Postfix, from userid 1000)
	id EA3C16D84; Mon, 28 Jan 2008 15:52:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <y7a9aaem.fsf@blue.sea.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71908>

On Mon, Jan 28, 2008 at 11:49:05PM +0200, Jari Aalto wrote:
> +                        ret = str_replace(str, "~", home);

This would mangle a name with a tilde in it, e.g. "file.c~", etc.

> +                        ret = str_replace(str, "$HOME", home);

This would affect similarly named vars, e.g. $HOMER, etc.

> +                strcat( ptr, "");   /* Terminate with null string */

Calling strcat() requires a null-terminated string.  Instead, assign a
'\0' char at the right position.

..wayne..
