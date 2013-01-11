From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: missing objects -- prevention
Date: Fri, 11 Jan 2013 16:40:38 +0530
Message-ID: <CAMK1S_jpofLRO02XTYryOP98g7rnrJXs7Mh2zvi=SoVUAs0dUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 12:11:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtcVt-0005m7-SS
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab3AKLKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 06:10:42 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:61572 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009Ab3AKLKj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:10:39 -0500
Received: by mail-ie0-f173.google.com with SMTP id e13so2135403iej.32
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=P9jQ2cEXSFneBiBUNaDpYg8Ag0NoSfUzMruk3qzlrho=;
        b=UCXW31nZBKGMYmp1J2j0EgoQql8yzBoufa42xcS0RueDSDTOqM20V+wDgD80NMjqZO
         MZ0k2rUaPA/6FHHXNDwK/qcxcn/JYML4QTT6XDtrhBUFBhRHYIdarWMf6QB8Nh6mo6it
         KFmS0vO5fAKhpZcPFBJbrEHSw4e7q26RwFCp+UJmveCfLgOGb3FLYkE5Tpu8gZUHepjy
         6wf+oCsvWMNrtcxWAU5dX8c8gf8JZqLNlcqQLO1Vf3Txzg0JScB4yGjR4PzATCrv6YGU
         YgP0zyL+riV6w07+z3n3O9APRjXYDKAswAKeRbVCuyBTIdTziy8s83h9wBbuCpbu/3d1
         0/wQ==
X-Received: by 10.50.77.133 with SMTP id s5mr8843164igw.110.1357902638727;
 Fri, 11 Jan 2013 03:10:38 -0800 (PST)
Received: by 10.50.30.164 with HTTP; Fri, 11 Jan 2013 03:10:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213190>

Hi all,

I find a lot of info on how to recover from and/or repair a repo that
has missing (or corrupted) objects.

What I need is info on common reasons (other than disk errors -- we've
checked for those) for such errors to occur, any preventive measures
we can take, and so on.  For example, can *any* type of network error
or race condition cause this?  (Say, can one push writes an object,
then fails an update check, and a later push succeeds and races
against a gc that removes the unreachable object?)  Or... the repo is
pretty large -- about 6-7 GB, so could size cause a race that would
not show up on a smaller repo?

Anything else I can watch out for or caution the team about?

The symptom is usually a disk space crunch caused by tmp_pack_* files
left around by auto-gc.  Presumably the missing objects failed the gc
and so it left the files around, and they eventually accumulate enough
to cause disk full errors.  (If a gc ever succeeded, I suspect these
files would go away, but that requires manual intervention).

I would appreciate any thoughts...  Thanks!

-- 
Sitaram
