From: Jeff King <peff@peff.net>
Subject: Re: git am fails to add new files
Date: Wed, 3 Feb 2010 10:33:01 -0500
Message-ID: <20100203153301.GA29692@coredump.intra.peff.net>
References: <201002021607.25719.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Wed Feb 03 16:33:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NchE7-0002Vr-Vw
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 16:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071Ab0BCPdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 10:33:07 -0500
Received: from peff.net ([208.65.91.99]:38099 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756746Ab0BCPdF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 10:33:05 -0500
Received: (qmail 29186 invoked by uid 107); 3 Feb 2010 15:33:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Feb 2010 10:33:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Feb 2010 10:33:01 -0500
Content-Disposition: inline
In-Reply-To: <201002021607.25719.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138837>

On Tue, Feb 02, 2010 at 04:07:25PM +0100, Thomas Koch wrote:

> I'm using GIT on Debian unstable (1.6.6.1). When applying patches I created 
> with git format-patch and applying them afterwards with git am, this fails 
> with every patch that adds a new file.
> Is there any option I forgot to give to git am? Or is this a bug.

No, it should just work. However, I can't replicate your problem using
the following script:

mkdir repo && cd repo && git init &&
echo 1 >file-1 && git add . && git commit -m one &&
echo 2 >file-2 && git add . && git commit -m two &&
git format-patch -1 --stdout >patch &&
git reset --hard HEAD^ &&
echo Confirm that file-2 is gone... &&
! grep . file-2 &&
git am patch &&
echo Confirm that file-2 is back... &&
grep . file-2

So perhaps there is something else going on. Can you provide us with
samples of the patches that fail to apply? What does "git am" say when
it tries to apply?

-Peff
