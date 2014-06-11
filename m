From: =?UTF-8?Q?Wojciech_Przyby=C5=82?= <przybylwojciech@gmail.com>
Subject: Potential bug in git client
Date: Wed, 11 Jun 2014 11:21:46 +0100
Message-ID: <CAKY5LXywixV3dWcCcVPTvyFrScJjLd8eoVs=RA1VRcrzUgtThQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 12:21:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuffD-0001Rg-Le
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 12:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbaFKKVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 06:21:47 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:49887 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbaFKKVr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 06:21:47 -0400
Received: by mail-qc0-f174.google.com with SMTP id x13so422844qcv.19
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 03:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=c1g3pAiLv5Vtk5Qk2JS95pHYLBDsSLOEwLVK8a42U0k=;
        b=X7HZNqRFoI34PrxFYeE0MjFuIz5nxBZYhzuVvfuJYqjin7RVsNYnwqKnVbcWEK5qfF
         f3pEdqtkVtSGCz6fMsAEQspEW+b0Sj5HJHJ8Cq7sJd+RXXfu0wakydctrnLcHk6Pf46Z
         qzvpphio0u7V5QZFEWzZDoCvCWMiMtQHSmb3xHkh8ejTAVZqoP02rK8+do72X9p5PMT3
         kx40Z4d6hCM/4Wzmi3I+wAz0xrJRLViqVaXYUvVVq+TJydzRhNmdB8ezkQusKonTn/aI
         q2Ovipq/BXECZdQd4eV6mim5PKPr34+Ov2odE3Nxntabu2AwjDktGOVLTaXayLL9y+lJ
         ugfw==
X-Received: by 10.140.104.195 with SMTP id a61mr19890898qgf.102.1402482106361;
 Wed, 11 Jun 2014 03:21:46 -0700 (PDT)
Received: by 10.229.149.196 with HTTP; Wed, 11 Jun 2014 03:21:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251358>

Hi All

When I was tagging, I think I might have discovered a git client bug.

HOW TO REPRODUCE:
- Clone a repo into 2 separate directories. Presume there is a tag
"v0.1" already in there and it is set on say 10 commits ago.

- In first directory change the tag to a different place and push it
to the server:
git tag -d v0.1
git tag v0.1
git push --tags origin master

- In second directory try to update the tag...
git pull --all --tags
git fetch -all --tags
THIS DOES NOT WORK, tag is still at old place, but it says "Already up-to-date".

- I noticed when I use:
git fetch --tags
it works fine and updates the position of the tag, or if I remove tag
from local git manually (rm .git/refs/tags/v0.1) and update again.

Is it a bug or I am doing something wrong? I use git version 1.7.9.5.

Cheers
Wojciech
