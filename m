From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH] Replace hard-coded path with one configurable at make
 time
Date: Tue, 6 Apr 2010 17:35:25 +0100
Message-ID: <20100406163525.GF15306@arachsys.com>
References: <186fa4afcc08ad6ba10906a231c437536fbdb8e9.1270412075.git.chris@arachsys.com>
 <7vk4sm7vao.fsf@alter.siamese.dyndns.org>
 <20100404222801.GB31315@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 18:35:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzBkT-0003lm-Vg
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 18:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756657Ab0DFQf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 12:35:29 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:60891 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0DFQf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 12:35:27 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NzBkM-0003Gn-GW; Tue, 06 Apr 2010 17:35:26 +0100
Content-Disposition: inline
In-Reply-To: <20100404222801.GB31315@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144156>

Chris Webb <chris@arachsys.com> writes:

> Were it just exec_cmd.c, I would just have changed it to use _PATH_DEFPATH
> from <paths.h> in preference to a make variable, as that should always give
> an appropriate value for a correctly put-together system and is a sensible
> place to treat as the central definition of 'default path'. However, in this
> case it's needed in the shell script too and I don't think I can easily get
> at _PATH_DEFPATH from there.

Having looked at this again, I think it's probably better to tackle the two
pieces separately. It would be cleaner to fix exec_cmd.c to use the correct
system-wide _PATH_DEFPATH from <paths.h> if possible, as in the following
patch, rather than introduce yet another make variable.

Similarly, looking more closely at what the path gets used for, I think
git-instaweb.sh is wrong to hard-code a default path anyway: it should
surely pass through the path inherited from the invoking user rather than
silently overriding it. I'll do a separate patch for that.

Cheers,

Chris.
