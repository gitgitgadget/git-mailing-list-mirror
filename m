From: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
Subject: git {pull,push} fails without stdin
Date: Wed, 28 Jan 2009 10:27:14 +0100
Message-ID: <a1e915350901280127g55d6a978i241c2b9793cc8690@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 10:28:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS6ix-0003YW-DW
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 10:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbZA1J1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 04:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753009AbZA1J1S
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 04:27:18 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:56412 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbZA1J1R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 04:27:17 -0500
Received: by fg-out-1718.google.com with SMTP id 13so479155fge.17
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 01:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=RgIT57A7Jyu1o8Mh5xLpTn+fYvisp78eJ02zLLU9Elg=;
        b=C0Jom0Ttuxd3PG5IDepi8xF9iBhLD6Ox96hqaPSa8sCb1F3+xGFTynJpLyTgo0dupv
         redW1oUt/GqAiWWcVy00YAcaeSplmgAFzt0L8FnblF63NCCxI1eFW6XSlKgX2KYiThGo
         CGgOQIHuiaPog0CBW0tIr5cLrJ9USvGdYkKTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=fjM4KUimLZC3JE+7yNPaN6eiHwKpXFmhc/T95GTh8yf+RIxZy/SmPzSOy3tbrQVkNh
         tJfSGPL9mFss7TEXGnwZ4ZNqg8O8FZg/ihFZj/FwWqu5mTzskpBP//YZ4M7D0z6bpZ1S
         eN+SsZ8SR1PPj2DnndTVKw3G60dBeKeAXtT1s=
Received: by 10.181.137.17 with SMTP id p17mr2256824bkn.193.1233134834239; 
	Wed, 28 Jan 2009 01:27:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107514>

This was seen in git 1.6.0.2...

I want to run "git push" in an automated system and, as there's no
sensible stdin to use, I close fd 0 before exec'ing.
However, it does not work:

  sh$ git push <&-
  fatal: read error (Bad file descriptor)

compared to:

  sh$ git push
  Everything up-to-date

The same thing happens with "git pull", but not the other git commands
I tried (in a far-from-exhaustive search).

It's trivial to work around (e.g., use /dev/null as stdin), but it
would be more convenient if it just worked :-)

- Gustav
