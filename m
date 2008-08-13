From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Adding a challenge-response authentication method to
	git://
Date: Wed, 13 Aug 2008 11:08:57 -0700
Message-ID: <20080813180857.GH3782@spearce.org>
References: <20080813162644.GC12200@cuci.nl> <20080813164038.GE3782@spearce.org> <20080813173757.GE12200@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Aug 13 20:10:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTKnL-0002q6-Ds
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 20:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbYHMSI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 14:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbYHMSI7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 14:08:59 -0400
Received: from george.spearce.org ([209.20.77.23]:37654 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbYHMSI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 14:08:58 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A95C038375; Wed, 13 Aug 2008 18:08:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080813173757.GE12200@cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92253>

"Stephen R. van den Berg" <srb@cuci.nl> wrote:
> Shawn O. Pearce wrote:
> >"Stephen R. van den Berg" <srb@cuci.nl> wrote:
> >> What are the opinions on adding a basic challenge-response type
> >> authentication mechanism to the native git protocol?
> 
> In order to aid them in setting up a simple accesslist, git would do
> just fine by simply offering a flat-file like list.  Forcing those
> setups to use anything more complicated makes adoption of git for those
> kind of projects unreasonably more complicated (IMO).

Well, anytime you get into a flat-file access list you get into
management of that list.  How do users change their own password?
How does an admin add/remove a user, or reset a password?  What
defines an admin?  Can you do these things remotely? Can you keep
the password encrypted on the remote side so an admin cannot see
a user's (common) password and maybe gain access to unrelated sites?

If you are going to keep it "really simple" you may be tempted to
say that all user additions/deletions/password changes should be
done by the admin directly editing the password list.  At which
point it may actually be easier (and safer) for the admin to just
handle a GnuPG or SSH public key.

This is why we tend to rely on SSH.  It neatly solves all of this
for us, and does it in a way that UNIX administrators are familiar
with managing.

This is also why the last discussion on this topic went down the road
of using GnuPG to handle the authentication portion of the protocol.
Unfortunately dealing with the server side keychain is a little
bit more complex then I'd like it to be out of the box, and the
client side I think is lacking something as common as ssh-agent
for caching the decrypted key.

I can see how it would be pretty simple to add authentication to
git-daemon based upon a shared secret, but such schemes always
cause management problems on both sides.
 
-- 
Shawn.
