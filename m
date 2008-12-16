From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Git Notes idea.
Date: Tue, 16 Dec 2008 02:15:47 -0600
Message-ID: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 16 09:17:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCV75-0000hQ-Kr
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 09:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbYLPIPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 03:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbYLPIPt
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 03:15:49 -0500
Received: from mail-gx0-f12.google.com ([209.85.217.12]:34573 "EHLO
	mail-gx0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbYLPIPs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 03:15:48 -0500
Received: by gxk5 with SMTP id 5so2292277gxk.13
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 00:15:47 -0800 (PST)
Received: by 10.151.100.17 with SMTP id c17mr14189065ybm.204.1229415347440;
        Tue, 16 Dec 2008 00:15:47 -0800 (PST)
Received: by 10.151.74.12 with HTTP; Tue, 16 Dec 2008 00:15:47 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103257>

Hi All,

I was thinking about possible ideas for my little pet project and I
had and idea for way to tack on notes to a commit, or any object
really.  I know that the idea has been flying around for a long time
but there has never been any implementation or a concept that people
liked enough to use (unless I have missed something).

Here is my idea.

.git/refs/notes  contains a tree-id (assuming that using a tree-id
will not cause any problems, otherwise a commit object can be used.
it does not *need* a history, but it *could* have one).

That tree has a structure similar to the layout of .git/objects, where
it is 2 letter subdirectories for the notes objects.

Given a git object (commit, tree, blob, tag), use its sha as the
path/filename in this tree.
    If I have a commit 1234567890123456789012345678901234567890 then
the notes tree will have a file
12/34567890123456789012345678901234567890

That file has a list of sha1s (one per line).  These shas are object
IDs for blobs that have the notes or whatever that you want attached
to the item.

I think you get the idea.  When looking up an item, it should be
fairly easy to have the notes tree and subtrees available for doing
lookups.  And as far as I know stuff under .git/refs can be
pushed/pulled even if its not under heads or remotes or tags using
already existing machinery.  I am not sure, but I think that would
satisfy gc operations as well.  Also, these trees and blobs never have
to be put in the working directory.

Does this sound like something that is workable?  I thought it might
appeal since it uses only features that are already present.

This could be extended so that you have different sets of notes under
.git/refs/notes/<my note set> or whatever.  So that you can have some
notes you keep private and some that you publish or whatever.

OK, hopefully this isn't a off the wall,
thats-what-you-get-for-being-up-at-2-AM idea.

Thanks,
Govind.
