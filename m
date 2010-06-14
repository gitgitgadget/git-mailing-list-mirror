From: Jay Soffian <jaysoffian@gmail.com>
Subject: Amending a merge commit doesn't update the rerere cache
Date: Mon, 14 Jun 2010 19:04:34 -0400
Message-ID: <AANLkTik50ayTQUnft4oD0Paqf-AuFWxGNdx_zZlHKFPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 15 01:04:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOIht-0007ac-Li
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 01:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab0FNXEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 19:04:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47013 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab0FNXEf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 19:04:35 -0400
Received: by iwn9 with SMTP id 9so3835408iwn.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 16:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=1VFoanrSgzJ1b247CP6PCdIJlXSqat6hbluLj5SFM1I=;
        b=UCa+kPtR/M+2RrRo4ZjePtkYS5Ucn03LNOb3O9MGCMkyOMFHaZfT7v3+SxIP84DqcA
         2hJv1UjKd1sj/vPH9FXX9AuLTqaWHwSLkXz4KikC3GFf5oO9ai+f8vGj1Dll5UdI6yvO
         QrIVkO2xNemmV5mE2Kz5K9Dd0Ak/B5HuTrG4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=QPQbXkdWrc7TS0+XOpQJqtizSqR9JmomJeDRtuPFIOwcxm6h1YyUp2N75f1U+tBxIf
         Zj9h1WYybdddR0b5Dpti5LgMCMjwEqgRyqCy5WeNoaapEJD/bjrB8ZO3ZzVUCq/lQrOw
         o6+PoIqe9G74jbPD12rrvpvlk6Oy89v0x99/s=
Received: by 10.231.60.5 with SMTP id n5mr5138943ibh.162.1276556674782; Mon, 
	14 Jun 2010 16:04:34 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Mon, 14 Jun 2010 16:04:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149145>

Subject says it all, but I'll elaborate.

During the course of testing a merge, I'll sometimes realize there was
a mistake and I'll amend the merge commit. Sadly this doesn't update
the rerere cache. For now I've been doing this:

   mv .git/rr-cache .git/rr-cache.saved &&
   git rerere-train HEAD -1 &&
   rsync -av .git/rr-cache/ .git/rr-cache.saved &&
   rm -rf .git/rr-cache &&
   mv .git/rr-cache.saved .git/rr-cache

Which is quite hackish. I think amending a merge commit should
probably update the rr-cache, but I'm not sure how best to fix this.

Thoughts?

j.
