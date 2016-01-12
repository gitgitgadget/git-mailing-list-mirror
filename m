From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Can't diff against the 00000000 revision
Date: Tue, 12 Jan 2016 10:17:24 -0500
Message-ID: <jwv4meiygrc.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 16:17:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ0he-0006IV-JI
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 16:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbcALPRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 10:17:43 -0500
Received: from plane.gmane.org ([80.91.229.3]:36524 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964962AbcALPRm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 10:17:42 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aJ0hX-0006Dr-82
	for git@vger.kernel.org; Tue, 12 Jan 2016 16:17:39 +0100
Received: from 184-175-3-20.dsl.teksavvy.com ([184.175.3.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 16:17:39 +0100
Received: from monnier by 184-175-3-20.dsl.teksavvy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 16:17:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 184-175-3-20.dsl.teksavvy.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
Cancel-Lock: sha1:7D/XqaSWRmLdiNqCMWhVu85zx4M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283817>

If I look at the initial commit on a branch, I see something like:

    % git show d59cfff346c3e210adc26501f8cebf8da5ab2e7d
    commit d59cfff346c3e210adc26501f8cebf8da5ab2e7d
    Author: Stefan Monnier <monnier@iro.umontreal.ca>
    Date:   Wed Dec 2 20:46:51 2015 -0500
    
        Initial release
    
    diff --git a/bugit b/bugit
    new file mode 100755
    index 0000000..681bd38
    --- /dev/null
    +++ b/bugit
    @@ -0,0 +1,512 @@
    ...

which is great.  But I can't get the same result with

    git diff 0000000..681bd38

because it complains:

    % git diff 0000000..681bd38
    fatal: ambiguous argument '0000000..681bd38': unknown revision or path not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'
    %

I bumped into this problem in a post-receive hook where I need to pay
attention to all newly added files, and where this problem means that
I can't use the same code for a newly added branch as for a push on
a pre-existing branch.

I currently work around the problem by adding a dummy empty branch, but
being able to use the revision 00000000 as a known reference to an empty
tree would come in really handy, and since it's already used at various
places in Git (post-receive hook and "git show" output, at least), it
would seem like a natural extension.


        Stefan
