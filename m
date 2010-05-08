From: Robert Buck <buck.robert.j@gmail.com>
Subject: anything behaviourally like perforce branch-spec mappings in git?
Date: Sat, 8 May 2010 09:39:20 -0400
Message-ID: <AANLkTikAPyfkAXLstPdEWyq2mKM0uBP1khSUV5t4-I23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 08 15:40:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAkGL-000134-Hi
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 15:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196Ab0EHNjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 09:39:24 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36611 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0EHNjX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 09:39:23 -0400
Received: by wyg36 with SMTP id 36so1424835wyg.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=LDuN8D44r9Uky3OoHF2aPfBtWaknc/WZkEe0iXmG+9Q=;
        b=HKUv6OefzqC4iMoHCyuDzmVBFW4NwEfmXrB9nI1pUWbQHUNWr3yFATS7gdMpHVZ32K
         i1N9ypzrcpyvxF4crpMs1YAfq4ybpBkMfgVxPOMFvdVIUVO0SfKaFnAglu1oKRQe//b2
         6nOScaIrAFXH6NnS1gSchgz5Km65pLFfpEMu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=K8mZD7B0E8OF68GQ9Rz5i/FvZ1ob8mP6e5qyNRfCMniZBMMQGGpd3JtOYAshNITl5n
         GScJfhhP6GHemLEVBWnSwrvYYL46yvCJB0m6ZOMD6j5cxbwzbyc+JJ6hG9vSyrXK0MBZ
         LM/bYHUNTjkLSwrTFQ+Tabl/mYgJRbvqL3u1Y=
Received: by 10.216.90.13 with SMTP id d13mr880822wef.18.1273325960731; Sat, 
	08 May 2010 06:39:20 -0700 (PDT)
Received: by 10.216.25.18 with HTTP; Sat, 8 May 2010 06:39:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146659>

Back at VeriSign we used branch-specs in Perforce to normalize
checked-in tooling to standard names (without version numbers). For
example:

Checked into the Perforce "releng" depot was the following:

//releng/
  head/
    vendor/
      junit-4.1/
        junit-4.1.jar
      junit-4.3
        junit-4.3.jar
  branches/
     same as above...

And a product specific depot may be:

//general
  head/
    ...
  branches/
    ...

The branch spec for a product would be:

//releng/branches/branch-name/vendor/junit-4.1   //workspace/releng/vendor/junit
...

You should be able to get the point. We supported workspace
composition, and the neat thing was that the build system itself was
versioned and could be separately versioned and changed as though it
were itself a product. But, as the build system was Ant based, rather
than constantly changing the build system to adapt to new versions of
junit, oro, and ivy jars, we simply used branch and view specs to
neutralize the workspace so the build system only referred to names
that lack version numbers. Further, a product could upgrade to a newer
version of the build system, almost always without consequence just by
changing these mappings.

So, is there some way to similarly accomplish this in Git? It was a
huge time-saver for release engineering at VeriSign, a pattern I'd
like to replicate using Git.

- Bob
