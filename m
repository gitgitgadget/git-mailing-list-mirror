From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Clarifying "invalid tag signature file" error message from git
 filter-branch (and others)
Date: Thu, 11 Dec 2008 15:06:06 -0600
Message-ID: <P7E-5meNX4tXFurN9mnRguFHdJG1jaZYTn6WxFFpECSJ68KyYT3wqQ@cipher.nrlssc.navy.mil>
References: <c5df85930812110214k2e12d926m60856fb630d45e80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: James Youngman <jay@gnu.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 22:07:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAsl1-0005XF-5T
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 22:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765AbYLKVGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 16:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756747AbYLKVGU
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 16:06:20 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47074 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756550AbYLKVGU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 16:06:20 -0500
Received: by mail.nrlssc.navy.mil id mBBL66aD009130; Thu, 11 Dec 2008 15:06:08 -0600
In-Reply-To: <c5df85930812110214k2e12d926m60856fb630d45e80@mail.gmail.com>
X-OriginalArrivalTime: 11 Dec 2008 21:06:06.0351 (UTC) FILETIME=[4873C1F0:01C95BD4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102826>

James Youngman wrote:
> What do the errors "error: char88: malformed tagger field" and "fatal:
> invalid tag signature file" and "Could not create new tag object for
> FINDUTILS-4_1-10" signify in the session below?

It means the tagger field in the tag does not follow the correct form.
Specifically the testing in git-mktag (called by filter-branch) does:

         * Check for correct form for name and email
         * i.e. " <" followed by "> " on _this_ line
         * No angle brackets within the name or email address fields.
         * No spaces within the email address field.

What does 'git cat-file tag FINDUTILS-4_1-10' show you?

> Are any of those errors correctable (I can re-run the tree rewrite
> script as many times as needed, I'm just using it on a test repository
> for now).

If there are only a few, then you can manually retag with a corrected
tagger field, and then run your script.

Of course, depending on the output of the cat-file call above, the
testing in git-mktag may need to be relaxed.

-brandon
