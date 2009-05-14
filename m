From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Wed, 13 May 2009 20:18:32 -0700
Message-ID: <7v8wl01iev.fsf@alter.siamese.dyndns.org>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
	<op.utwdsutn1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: "Matthias Andree" <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 14 05:18:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4RSz-0008I0-QN
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 05:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713AbZENDSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 23:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753272AbZENDSc
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 23:18:32 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:40910 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbZENDSc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 23:18:32 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090514031833.UISE17135.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>;
          Wed, 13 May 2009 23:18:33 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id rFJY1b00D4aMwMQ04FJY5M; Wed, 13 May 2009 23:18:32 -0400
X-Authority-Analysis: v=1.0 c=1 a=lQuyK5o2kcMA:10 a=f4ZrQ2YIIQcA:10
 a=Q4_CS58T3EF7GbRnObEA:9 a=kAqsmjwwuX60cfLJvkkA:7
 a=laBdyNG1Jdtn3IT_R3zZuM1wpG0A:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <op.utwdsutn1e62zd@merlin.emma.line.org> (Matthias Andree's message of "Thu\, 14 May 2009 04\:13\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119126>

"Matthias Andree" <matthias.andree@gmx.de> writes:

> Am 14.05.2009, 02:53 Uhr, schrieb Matthias Andree <matthias.andree@gmx.de>:
>
>> 2. how do I trash the accidentally created 2nd "baz" tag object,
>> i. e.  remove it from the (packed) object database? Of course, I can
>> hack some  script (or use a text editor) to grind this
>> git-fast-export into shape  and re-importing it...
>
> OK, that worked: I traced (with git cat-file) the tree through all
> tagged  tag until the first tagged commit, and hack packed-refs (or
> refs/tags/foo)  to point to the commit object, and afterwards prune
> the dangling tag.
>
> However, the other questions remain. I'd think git tag should
> dereference  its 2nd non-option argument to a commit before laying
> down the tag...

No.  You can tag any object, and a tag is an object.  You can point a
signed tag with your own signed tag to attest your own belief on that
other guy's tag, be it "it's genuine", "the tagged commit suits my need",
etc.

I thought there was a breakage report followed by a fix to the fast-export
that mishandled a tag that points at another tag not too long ago.  Do you
have 1982467 (builtin-fast-export.c: handle nested tags, 2009-03-23)?
