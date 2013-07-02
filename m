From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [Q] Getting the latest available Linux-kernel version (v3.x.y-stable
 or v3.x.y-rcX)?
Date: Tue, 2 Jul 2013 10:03:13 +0200
Message-ID: <CA+icZUV50bn4wjohfmKWL-GXpstidPNsNWqHuq+0gvEorWOaxA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 10:03:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtvYb-0003IN-8C
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 10:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159Ab3GBIDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 04:03:17 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:54790 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab3GBIDO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 04:03:14 -0400
Received: by mail-wi0-f171.google.com with SMTP id hj3so3892372wib.16
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=cuiGRU8NJFNejb9CUrelQoztNH+uLvl9gTVFsoZmteY=;
        b=bwt82CNRuXIh8oqmK1fcREWEyUUmT95+1ZDuw6yBQycDPh8Jk/+i0rKgSi05Yc/HAb
         WTAF3wFzr5WogeYVMhUPSHC8cUCyr4Rnz9KAEVjfP+XiusXLkZekg8zKWKXGPQIxCTxd
         jZClG4nqMGWh09zUOGuYYsKXpZ3RsHffUHpm8ppDx3jYftlCEbl/oUdLoZDJcLjo0hlX
         c/jyMCJC9ReZTt9v2hQ/QxEcWwIvkUBgpz7ntLHPhptPdh+qQqF/d2zxNscaiGlo3w8k
         LxqzRZhCx120ZH9fUEyvVE79kINkvZwwF7e1t54oauAPXbuNHPeMcoAh5JZzQqcqo6m3
         K+rA==
X-Received: by 10.180.183.104 with SMTP id el8mr14547929wic.43.1372752193317;
 Tue, 02 Jul 2013 01:03:13 -0700 (PDT)
Received: by 10.216.192.8 with HTTP; Tue, 2 Jul 2013 01:03:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229372>

Hi,

for my Linux-kernel build-script I am searching for a reliable check
of getting the ***latest*** version.
This could be 'v3.x.y-stable' or 'v3.x.y-rcX'.

'git tag' seems to be fast, but not reliable.
'git log --oneline' is slow, but does the job.

For getting v3.x.y-stable this seems to work...

$ git tag | grep ^'v3.[0-9]*' | grep -v '\-rc' | sort --version-sort
v3.0
v3.1
v3.2
v3.3
v3.4
v3.5
v3.6
v3.7
v3.8
v3.9
v3.10

...but not when listing v3.x.y-rcX, too:

$ git tag | grep ^'v3.[0-9]*' | sort --version-sort | grep ^'v3.10'
v3.10
v3.10-rc1
v3.10-rc2
v3.10-rc3
v3.10-rc4
v3.10-rc5
v3.10-rc6
v3.10-rc7

I know that v3.10 > v3.10-rcX, but not 'git tag' or 'sort --version-sort' :-).

This seems from my poor sed/awk/grep skills to be the most reliable method...

$ time git log --oneline v3.0-rc1.. | grep 'Linux 3.' | awk '{ print
$3 }' | grep ^'3.[0-9]*' | head -1
3.10

real    0m10.024s
user    0m5.611s
sys     0m4.857s

...but is slow (even I take v3.0-rc1 as the 1st version-tag of
Linux-v3.x series).

Any improvements?

Thanks in advance.

Regards,
- Sedat -
