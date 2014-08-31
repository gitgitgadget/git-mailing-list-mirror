From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH] rev-parse: include HEAD in --all output
Date: Mon, 1 Sep 2014 00:36:06 +0300
Message-ID: <20140831213606.GB6385@wheezy.local>
References: <CAF7_NFRz6Zc-wTDSFdkW4N2wRATZ8-g05j6sFu1t7DB0X72dkg@mail.gmail.com>
 <1409437488-25233-1-git-send-email-max@max630.net>
 <20140831153054.GD17449@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 31 23:36:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOCno-0001lA-N9
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 23:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbaHaVgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 17:36:40 -0400
Received: from p3plsmtpa12-01.prod.phx3.secureserver.net ([68.178.252.230]:49099
	"EHLO p3plsmtpa12-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751449AbaHaVgk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Aug 2014 17:36:40 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa12-01.prod.phx3.secureserver.net with 
	id lZca1o0053gsSd601ZccQC; Sun, 31 Aug 2014 14:36:39 -0700
Content-Disposition: inline
In-Reply-To: <20140831153054.GD17449@peff.net>
From2: "Maksim Kirillov" <max630@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256300>

On Sun, Aug 31, 2014 at 11:30:54AM -0400, Jeff King wrote:
> On Sun, Aug 31, 2014 at 01:24:48AM +0300, Max Kirillov wrote:
> 
>> for_each_ref() does not include it itself, and without
>> the hash the detached HEAD may be missed by some
>> frontends (like gitk).
>> 
>> Add test which verifies the head is returned
>> 
>> Update test t6018-rev-list-glob.sh which relied on exact
>> list of returned hashes.
> 
> I think the missing bit of the justification here is that
> "--all" _does_ include HEAD in other contexts (like in
> git-log), and rev-parse should probably match it.
> 
> This is probably the right thing to do. It's possible that
> some caller of rev-parse really depends on "--all" meaning
> "just the refs", but I kind of doubt it. Being in sync
> with the revision.c parser seems saner.

Actually, yes, this is a bit incompatible change, and while
I'm pretty sure that rev-parse returning hashes should
include detached HEAD, returning HEAD when it's called with
something like "--symbolic" might be questioned. It could
depend on the output mode (add HEAD only if printing hashes)
but this kind of logic does not look good. So maybe some
more opinions should be asked for.

btw, manpage for git-rev-parse says "Show all refs found in
refs/.", should it also be changed?

-- 
Max
