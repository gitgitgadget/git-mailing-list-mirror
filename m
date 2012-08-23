From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: in_merge_bases() is too expensive for recent "pu" update
Date: Thu, 23 Aug 2012 19:32:33 +0700
Message-ID: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 14:33:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Wb5-0003DK-7G
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 14:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab2HWMdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 08:33:07 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33887 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390Ab2HWMdE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 08:33:04 -0400
Received: by ialo24 with SMTP id o24so1233962ial.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 05:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=rtPafKaqCk1Vtpg0wuLxiccu3I0UgRiVIdRrypPPqHs=;
        b=PmzGV4MTZESWFnJNCfCVHWG48IE2A0UQ2h9qH0xJhmV26tvZyPpx5XY6sWEKJtAi2t
         wEPT3n33ZVX0Qgs+DXRYV+Jfitb0EoCLTOYo+r2+Ey3wZQqlGcgpgyLCp4yW+dWkZINE
         2h6tJjWSjmZWGqyE4+F0qWFXmdBtYPxth3/kpFc+OxQ83WJT3lU9wE+fI28GytDOSJTa
         GY5/tkfQOyINlvmEyywEoWvTUp7BLX9UrXcovrS5BM3Me6k99sgQ/yt6UOUANyh9MDUV
         bfipYXCHbJZI1I0pAy5Ek1NA8+e8RVSlR1QmvZWP9WeG1BQG05CnyfE8qr6nhDZSEFRa
         fHKQ==
Received: by 10.50.220.194 with SMTP id py2mr1372354igc.15.1345725183492; Thu,
 23 Aug 2012 05:33:03 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Thu, 23 Aug 2012 05:32:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204148>

I just did a "git fetch". It took 19 seconds (measured with
gettimeofday) to finish in_merge_bases() in update_local_ref() in
fetch.c, just to print this line

 + a4f2db3...b95a282 pu         -> origin/pu  (forced update)

It's partly my fault because I'm on gcc -O0. But should it not take
that much time for one line? As a grumpy user, I'd be perfectly ok
with git saying "probably forced update, check it yourself" if the
spent time exceeds half a second. On the same token, if diffstat takes
too long for git-pull, then perhaps just stop and print "do it
yourself".
-- 
Duy
