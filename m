From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: replace 'vi' for 'editor' to reflect
 build-time option
Date: Thu, 29 Mar 2012 19:55:23 -0500
Message-ID: <20120330005523.GA28519@burratino>
References: <20120330002543.2138.91961.reportbug@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: "Rodrigo Silva (MestreLion)" <linux@rodrigosilva.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 02:55:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDQ7v-00032M-B6
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 02:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758391Ab2C3Azf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 20:55:35 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50653 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab2C3Azd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 20:55:33 -0400
Received: by iagz16 with SMTP id z16so199314iag.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 17:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Es6Yd1eBz3zXCIpmjcgQ4fbAec7qVoc3LNQPEtCTi8c=;
        b=xIC2OL7zJ6DD39Frb43QvtBJZmUgtTvO7DgxaI7qUeVciZOPGluRsvnEzYBvw9E8l3
         8A7FbovrwkDeTf10G/odcxuZQeIbsH32TwpkRZpVFAzXRW4hsFBcrOjh9+t38Ejhq2cR
         LhpMmiaZ5eLDHcJ+cTdVjM8tLJAZx43esTWKLjv8vD+3thpOZUgeN9qBrvSo/dExEHT6
         W2SYrks+R1Ak6HMw/DCpPV57uH2DhkqdAXSjuMgv1HZlp7FUCDy7LFmGfCCMDjrKCwP4
         TgPYE6dAAFyMDUd+ShkG61LW1UPQGQn5jukQn0sFcsFT285Da7/AA8dFbFZFMm96UaMR
         wyeQ==
Received: by 10.50.217.137 with SMTP id oy9mr57089igc.31.1333068933172;
        Thu, 29 Mar 2012 17:55:33 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c2sm608170igj.1.2012.03.29.17.55.32
        (version=SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 17:55:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120330002543.2138.91961.reportbug@localhost6.localdomain6>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194307>

Hi Rodrigo,

Rodrigo Silva (MestreLion) wrote:

> git-var(1) did not say that hardcoded fallback 'vi' may have been changed
> at build time. A user could be puzzled if 'nano' pops up even when none of the
> mentioned environment vars or config.editor are set.
>
> Ideally, the build system should be changed to reflect the chosen fallback
> editor when creating the man pages. Not sure if that is even possible though.

Good catch.

Filling in the blank at compile time would be possible, but I'm not
convinced it's a good idea.  Wouldn't the same user be just as puzzled
when

  http://git.kernel.org/?p=git/git-htmldocs.git;a=blob_plain;f=git-var.html

(or whatever page with a nicer URL arises to replace the old
www.kernel.org/...  pages) says the fallback is 'vi' and git behaves
differently?

How about something like this?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Context: http://bugs.debian.org/666250

 Documentation/git-var.txt |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git i/Documentation/git-var.txt w/Documentation/git-var.txt
index 5317cc24..beef9e28 100644
--- i/Documentation/git-var.txt
+++ w/Documentation/git-var.txt
@@ -43,13 +43,15 @@ GIT_EDITOR::
     `$SOME_ENVIRONMENT_VARIABLE`, `"C:\Program Files\Vim\gvim.exe"
     --nofork`.  The order of preference is the `$GIT_EDITOR`
     environment variable, then `core.editor` configuration, then
-    `$VISUAL`, then `$EDITOR`, and then finally 'vi'.
+    `$VISUAL`, then `$EDITOR`, and then the default chosen at compile
+    time, which is usually 'vi'.
 
 GIT_PAGER::
     Text viewer for use by git commands (e.g., 'less').  The value
     is meant to be interpreted by the shell.  The order of preference
     is the `$GIT_PAGER` environment variable, then `core.pager`
-    configuration, then `$PAGER`, and then finally 'less'.
+    configuration, then `$PAGER`, and then the default chosen at
+    compile time (usually 'less').
 
 Diagnostics
 -----------
-- 
