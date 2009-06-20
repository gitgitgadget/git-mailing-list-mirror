From: Jon Seymour <jon.seymour@gmail.com>
Subject: Specifying multiple refspecs in remote.{remote}.fetch
Date: Sat, 20 Jun 2009 16:37:51 +1000
Message-ID: <2cfc40320906192337g66db81f0w92e06adfc6a189c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 20 08:38:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHuDC-0004IX-4a
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 08:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbZFTGhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 02:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbZFTGhu
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 02:37:50 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:34658 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbZFTGht (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 02:37:49 -0400
Received: by gxk10 with SMTP id 10so3623689gxk.13
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 23:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=O2Dr+rBNdrAE4aG92zyhnHXL/ljggN7GfXf7x63MDl8=;
        b=mf7P1O2YqbUx9IySAV2CGfuCmPwQl1g4LMukwGEYoXoxmDYViLw59Cy28WSTJkR2a3
         chNlheGW/h+iL5JaUNKGC0Upx0m7CcQ6g5wIqLr+vKGjChFKCK9nTVXa6ptnwf6X7wJH
         +yGUr/PoVLAIR1NrJkRodENpVulEv4fQ0cogM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=LE21dWQfHXj667LsFLUa+hjHwTQGt38V18AIbSdRgAwRHxfu1lPxVus4HqC20IYMQB
         QenDr2ao9X8oW+pcflTqjugq1OulXAYjy38/Ki3czvU6y110DyOYE5AlKlhbsjDlS3W/
         GLu0ipuFnzzFfVk88zEGq1ZyaCbqmdB08bn6U=
Received: by 10.151.141.15 with SMTP id t15mr7183781ybn.309.1245479871764; 
	Fri, 19 Jun 2009 23:37:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121933>

It doesn't seem to be possible to specify multiple refspecs in a git config.

I want to do this:

remote.hub/pub/release.fetch=+refs/heads/*:refs/remotes/hub/pub/release/*
+refs/tags/*:refs/tags/hub/pub/release/*
remote.hub/pub/release.tagopt=--no-tags

but git fetch complains:

fatal: Invalid refspec '+refs/heads/*:refs/remotes/hub/pub/release/*
+refs/tags/*:refs/tags/hub/pub/release/*'

Now, in theory, I could use a file in remotes/ to specify multiple
Pull: lines. This works if my remote doesn't have slashes in its name,
but it doesn't work if my remote does have slashes in its name since
git doesn't recognize remote files located in sub-directories of
${GIT_DIR}/remotes.

Is it a reasonable expectation that:

* git should support multiple refspecs specified via git config?
* git should support subdirectories in ${GIT_DIR}/remotes?

BTW: the reason I want to do this is that I need to namespace the tags
and heads because I am using a "hub" repo to simplify a transport
topology for distributing a number of different spoke repos via a
smaller number of hub repos. Since I can't guarantee the branches and
tags of each spoke repo will be globally unique, I need to namespace
both the heads and the tags and a path-like naming convention for each
spoke repo seems like the most natural way to do that.

jon seymour.
