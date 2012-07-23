From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH lt/block-sha1 0/2 v3] block-sha1: avoid pointer
 conversion that violates alignment constraints
Date: Mon, 23 Jul 2012 00:28:02 -0500
Message-ID: <20120723052605.GA13728@burratino>
References: <20120722233547.GA1978@burratino>
 <7v8vebp0cl.fsf@alter.siamese.dyndns.org>
 <20120723045148.GA13623@burratino>
 <7vobn7njtz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 07:28:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StBBp-0001Sn-Vo
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 07:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485Ab2GWF2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 01:28:13 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:63715 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734Ab2GWF2M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 01:28:12 -0400
Received: by gglu4 with SMTP id u4so5089453ggl.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 22:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=i/3cAclhLWBOcAQJ233N/BSYcvqs4rK4FTE1TI4PxRc=;
        b=Sw4+M+yhzVyWVEQNBllVUXh5bFUiIzg6TyUd8GmW8H7WQwyFOZQImNJTHf0JcSLdGQ
         qSwrXWqx/duuD8ojCrhVWij7OqLyQES7qsN8Z7mS6wqYtwHQQGJzZwCwP7As6IHenzP3
         fscUClu0Eb0rMY5upPbcep3RsKp6NJ4hlj8WD1uQJbqDzU9nOMyqIxf1sg0uVnIzP8vu
         RfcgoogTGDSo0Wi7DEtdXh36nulqdTbKZOMc6B3dwi/ExaK1qPGwVDqWb+kSHtYcdqsZ
         TDYLJJ4ZNpFBO1TGt8W1dAOZDU1TDRqz3Y7Uxz7Ypp8d6RBtU6CHJSw0liVJFStaO+xU
         BuKg==
Received: by 10.50.158.130 with SMTP id wu2mr13524742igb.32.1343021291689;
        Sun, 22 Jul 2012 22:28:11 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id ai6sm11758453igc.0.2012.07.22.22.28.10
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 22:28:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vobn7njtz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201902>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> The big-endian part was just my idiocy, sorry.
>
> Hrm, do we want an update log message for 1/2 then?

Hm, I thought all the crazy had been eliminated already.

*looks again*

I guess "using a single 32-bit load" makes it sound like it's using a
big-endian load instead of a load followed by twiddling in registers.

Simplest fix would be to drop the phrase "by using a single 32-bit
load", leaving "... and gcc takes full advantage, resulting in a whole
bunch of unaligned access traps."  Would that work for you, or should
I resend?

Thanks,
Jonathan
