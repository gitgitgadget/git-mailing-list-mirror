From: Duy Nguyen <pclouds@gmail.com>
Subject: Turning a complete repository to a shallow one
Date: Fri, 11 Jan 2013 11:40:03 +0700
Message-ID: <CACsJy8Bv+AfDbttFdJ5a0PaoMrMtv1seda7VqLpfdevR4BMj4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 05:40:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtWQJ-0005To-4w
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 05:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733Ab3AKEkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 23:40:35 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:61291 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab3AKEke (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 23:40:34 -0500
Received: by mail-ob0-f177.google.com with SMTP id uo13so1344396obb.8
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 20:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=TOGKPQw85cytClFLwQi5TicM5C6Q/fGR12xoREnPvIA=;
        b=tHtGN0VAfjVtYHVUu/uNS4NUxq/wWIAS9ShiVrPQwEuSP61bIlkgGwfF41Ez6Wnlaf
         79PIsW+DqKfrinQr5lRqmRFawIBZiHRfKfKX6MEXDDTPm8EN87Xs/i+CWaodqPe/Rzmq
         hFFb467T5t9xlyARhr5saVK/BSTT6HZ7WOkHiOYFg1WfRY6+zdFQES9LDU/oCu02HFkm
         5kF/1wer64E5T7ILHXKirEGDdimtEnvTFmM0C4uTZUkdtay3n/DvbAeieum2iozaInhg
         +1d3IPTZUrAzCP59nTrkyKm82KILLxWD0JGHJavn+RbLzMhJ0LbwWOxV0pWy5WRey7O8
         a+lA==
Received: by 10.60.8.134 with SMTP id r6mr42664782oea.53.1357879233878; Thu,
 10 Jan 2013 20:40:33 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Thu, 10 Jan 2013 20:40:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213179>

Apparently we could do it:

git clone --single-branch git.git
cd git
git tag -l|xargs git tag -d
git fetch --depth=1 origin master
git repack -ad

Now the repository becomes shallow and all of history is _lost_. It is
a feature for those who wants to reduce disk usage, but it's also a
gun to shoot at your feet. I'm tempted to ban this case. If I want to
reduce disk usage, I should be forced to shallow clone it first, then
remove the original repository. I still have a complete repository if
I change my mind. And "rm -rf git" is alarming enough for me to think
it twice before executing.

Comments?
-- 
Duy
