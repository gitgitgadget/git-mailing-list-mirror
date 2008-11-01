From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] connect.c: add a way for git-daemon to pass an error
	back to client
Date: Sat, 1 Nov 2008 11:10:35 -0700
Message-ID: <20081101181035.GB14706@spearce.org>
References: <b97024a40810311859t2e5a6102u31ad4480e7c75c03@mail.gmail.com> <7vy7043sy9.fsf@gitster.siamese.dyndns.org> <b97024a40810312329o53e37fd5td82aa69634ff1e6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tom Preston-Werner <tom@github.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 19:12:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwKwv-0000RJ-NM
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 19:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbYKASKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 14:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbYKASKg
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 14:10:36 -0400
Received: from george.spearce.org ([209.20.77.23]:46812 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbYKASKg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 14:10:36 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6B4903835F; Sat,  1 Nov 2008 18:10:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <b97024a40810312329o53e37fd5td82aa69634ff1e6b@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99756>

Tom Preston-Werner <tom@github.com> wrote:
> 
> I saw several methods of testing for a specific prefix in connect.c.
> Looking more closely at the source, the closest similar call is
> actually the test for ACK:
> 
> 	if (!prefixcmp(line, "ACK ")) {
> 		if (!get_sha1_hex(line+4, result_sha1)) {
> 			if (strstr(line+45, "continue"))
> 				return 2;
> 			return 1;
> 		}
> 	}
> 
> Explicitly testing for "ERR " (including the space) does seem like the
> more correct thing to do. Would you like me to resubmit a modified
> patch that uses prefixcmp()?

Yes, I think that is what Junio was hinting at.  The pattern above
is much more typical in Git sources, so keeping the new "ERR "
check consistent would be appreciated.

-- 
Shawn.
