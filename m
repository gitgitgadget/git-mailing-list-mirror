From: Bill Lear <rael@zopyra.com>
Subject: Re: removing content from git history
Date: Tue, 9 Oct 2007 15:58:57 -0500
Message-ID: <18187.60305.613904.547916@lisa.zopyra.com>
References: <20070221164527.GA8513@ginosko.local>
	<20070221165636.GH25559@spearce.org>
	<20070221171738.GA9112@fieldses.org>
	<Pine.LNX.4.64.0702210934470.4043@woody.linux-foundation.org>
	<20070221210045.GB26525@spearce.org>
	<Pine.LNX.4.64.0702211306520.4043@woody.linux-foundation.org>
	<20070221212129.GD26525@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 22:59:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfMAc-0002Aq-2H
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 22:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbXJIU7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754603AbXJIU7G
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 16:59:06 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61579 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754179AbXJIU7F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 16:59:05 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l99KwwZ17229;
	Tue, 9 Oct 2007 14:58:58 -0600
In-Reply-To: <20070221212129.GD26525@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60436>

I'm resurrecting this old thread, as we have come across a similar need and
I could not tell if this has been settled.  More below...

On Wednesday, February 21, 2007 at 16:21:30 (-0500) Shawn O. Pearce writes:
>Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> The probnlem there is that most conversion scripts that use 
>> "write_sha1_file()" will want to *read* that file later. If 
>> git-fast-import hasn't generated the pack yet (because it's still waiting 
>> for more data), that will not work at all.
>
>Yes, indeed...
> 
>> So then you basically force the conversion script to keep remembering all 
>> the old object data (using something like pretend_sha1_file), or you limit 
>> it to things that just always re-write the whole object and never need any 
>> old object references that they might have written.
>> 
>> A lot of conversions tend to be incremental, ie they will depend on the 
>> data they converted previously.
>
>Which is why I was actually thinking of flipping this on its head.
>Libify git-apply and embed that into fast-import, then one of the
>native input formats might just be an mbox, or something close enough
>that a simple C/perl/sed prefilter could make an mbox into the input.
>
>fast-import can (and does if necessary) go back to access the
>packfile it is writing.  It has the index data held in memory and
>uses only OBJ_OFS_REF so that sha1_file.c can unpack deltas just
>fine, even though we lack an index file and have not completely
>checksummed the pack itself.
>
>So although no other Git process can use the packfile, it is usuable
>from within fast-import...

As I understand this thread, it does not appear that a resolution
was reached.  Our company has content in our central git repository
that we need to remove per a contractual obligation.  I believe the
content in question is limited to one sub-directory, that has existed
since (or near to) the beginning of the repo, if that matters.  We
obviously would just like to issue a "git nuke" operation and be done
with it, if that is available.  Barring that, we could probably follow
reasonably simple steps to purge the content and rebuild the repo.

So, what options do we have at present?


Bill
