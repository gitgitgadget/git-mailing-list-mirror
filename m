From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH lt/block-sha1 0/2 v3] block-sha1: avoid pointer conversion
 that violates alignment constraints
Date: Sun, 22 Jul 2012 18:35:47 -0500
Message-ID: <20120722233547.GA1978@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 23 01:36:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St5h2-0007pP-PS
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 01:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595Ab2GVXf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 19:35:59 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60679 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab2GVXf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 19:35:58 -0400
Received: by obbuo13 with SMTP id uo13so8594495obb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 16:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=f+wlQPpPpr5hJqhLDumRiovKU2WZmmSYZUJ7yAvwGmY=;
        b=TmSSj5h7eNNPx6eelBfZGwECcis4GpfBC51GjHxuecpqfJcJ6rYGxLJ/Cnl97xqiNA
         cxq0KIevBurE3Z3gySZNxcAqL1T0+3ASnJ5kyzq7eg7+PHnCOUtoP4V8mymXc2RirRIt
         psM7cPtug7QgbwDbtUQvtSXSYmYk/O2Q+mYfwwK/fTjnEsmDoXHKGGy+1rRijL9ioJiD
         wN57s6mXy3PyVIqJdXZP9b0joKFYwcZXwcDl9VTW460bAS+Jy+5YxIsyIf0mRtXNlwBC
         0zc9vUrAE9kylFAiX+bStJbOkJWq1sJkgXexeljZZfOpvgY6fYwbWmHVdVAm42OxUR62
         fgWg==
Received: by 10.50.173.65 with SMTP id bi1mr9186426igc.10.1343000157459;
        Sun, 22 Jul 2012 16:35:57 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id z7sm4648920igb.3.2012.07.22.16.35.55
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 16:35:56 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201873>

Hi Junio,

This is a series of two patches: the first avoids alignment faults
that were making git either slow on Alpha machines or crashy,
depending on the machine's configuration, and the second patch is a
cosmetic nit noticed while reviewing the first.

Patches are based against

  30ae47b4 remove ARM and Mozilla SHA1 implementations, 2009-08-17

(aka the tip of the lt/block-sha1 branch) for no particular reason.
They should work fine against a more modern codebase if you prefer
that.

No changes since v2[1] except to commit messages.

I think this should be ready for application.  Thanks to Michael and
Linus for shaping the original patch into something sane.

Thoughts?
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/201434/focus=201456

Jonathan Nieder (2):
  block-sha1: avoid pointer conversion that violates alignment
    constraints
  block-sha1: put expanded macro parameters in parentheses

 block-sha1/sha1.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
