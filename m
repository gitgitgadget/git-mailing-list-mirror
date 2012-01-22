From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: What does "modified" in git status mean?
Date: Sun, 22 Jan 2012 12:56:32 -0500
Message-ID: <201201221756.q0MHuWmL003864@no.baka.org>
References: <loom.20120122T174204-274@post.gmane.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Mikolas <mikolas.janota@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 18:56:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rp1f0-0003P5-Th
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 18:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075Ab2AVR4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 12:56:37 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:54460 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976Ab2AVR4g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 12:56:36 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q0MHuXw7029820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 22 Jan 2012 12:56:33 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q0MHuWmL003864;
	Sun, 22 Jan 2012 12:56:32 -0500
In-reply-to: <loom.20120122T174204-274@post.gmane.org>
Comments: In reply to a message from "Mikolas <mikolas.janota@gmail.com>" dated "Sun, 22 Jan 2012 16:57:52 +0000."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188969>


In message <loom.20120122T174204-274@post.gmane.org>, Mikolas writes:

    1) Is there some way how to tell status to tell me *why* the files
    are marked as modified?

Not as such.  However, I do have a script which, when run from the
root of the working directory, manually compares the on-disk files to
what is checked into git.  This would detect any whitespace or smudge
related changes, or of course any normal user changes.

git ls-tree --name-only -r HEAD | while read path; do if [ ! -f "$path" ]; then continue; fi; sha1=`git show "HEAD:$path" | sha1sum | awk '{print $1;}'`; sha2=`sha1sum "$path" | awk '{print $1;}'`; if [ $sha1 != $sha2 ]; then echo "<$sha1> <$sha2> $path"; fi; done


    2) Is it normal that git status behaves differently in different directories?

I would say not, but perhaps you have a .gitattributes in that
directory? (Which would be a bug) Could you try with a more recent
version of git?

					-Seth Robertson
