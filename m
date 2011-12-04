From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv2 0/4] git-p4: small fixes to branches and labels; tests
Date: Sun, 4 Dec 2011 11:07:39 -0500
Message-ID: <20111204160739.GA13549@arf.padd.com>
References: <1322643817-13051-1-git-send-email-luke@diamand.org>
 <loom.20111130T155409-599@post.gmane.org>
 <4ED6809A.9020703@diamand.org>
 <20111130225813.GA11544@arf.padd.com>
 <20111130230007.GA11598@arf.padd.com>
 <CAOpHH-U6NxRSioRZg9_+f146vVR+S1hWsVbRmHz+vsqtz+vXiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 04 17:07:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXEbU-0007Y6-Ei
	for gcvg-git-2@lo.gmane.org; Sun, 04 Dec 2011 17:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab1LDQHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Dec 2011 11:07:44 -0500
Received: from honk.padd.com ([74.3.171.149]:37457 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754037Ab1LDQHn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2011 11:07:43 -0500
Received: from arf.padd.com (unknown [50.52.169.245])
	by honk.padd.com (Postfix) with ESMTPSA id 386472FE9;
	Sun,  4 Dec 2011 08:07:42 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 87D423154D; Sun,  4 Dec 2011 11:07:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAOpHH-U6NxRSioRZg9_+f146vVR+S1hWsVbRmHz+vsqtz+vXiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186270>

vitor.hda@gmail.com wrote on Thu, 01 Dec 2011 00:37 +0000:
> On Wed, Nov 30, 2011 at 11:00 PM, Pete Wyckoff <pw@padd.com> wrote:
> > And avoids collision with some Vitor code that will get
> > added eventually.
> 
> I'm starting to doubt I will ever be able to overcome the fast-import
> limitation on not allowing branch delesetion. Sure, the code I wrote was
> garbage! But they seem to be very relunctant on the concept of deleting
> branches on the fly.
> Did you ever take a look at the patch I sent? Maybe you could help me
> shape it up a bit.

I don't think we necessarily need branch deletion inside the
fast-import.  Can you go back and look at my mail from August and
see if that approach is doable?  Just make a single commit on a
throwaway branch with no parent, checkpoint, then do diff-tree
for each potential parent until you find a match.  Do the commit
for real where it goes.  As git-p4 exits, we'll delete the branch
ref of the test commit.

If this works, we can see if fast-import can be taught to
generate a tree object without a commit to save the need for a
temporary branch.

		-- Pete
