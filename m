From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: DWIM .git repository discovery
Date: Wed, 26 Sep 2012 08:49:42 +0700
Message-ID: <CACsJy8DOtPWgkq=KSHCb=J3qg4o1aPaLo4aj7U5f_qa+kCCipQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 03:50:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGgle-0007xu-NZ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 03:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167Ab2IZBuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 21:50:14 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33169 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab2IZBuN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 21:50:13 -0400
Received: by ieak13 with SMTP id k13so215292iea.19
        for <git@vger.kernel.org>; Tue, 25 Sep 2012 18:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=N4RfesDBVpgAl6JX0cLtZLw2nnAaX2t98ezS1oJSrFw=;
        b=GnYjl8BYFYK5HvYoOmqm72gE5+OoiqDAjEOXr4Vkf4fS0VOMN/LdnFw/70G8Kz7ggT
         ZlRQ2MFCWB2L7Zop5SgiuJPrP3kNrfjkdXTGj5zRMvQ5a71yxaeSIRha+Qr6D1U+whF/
         a74lmbq5T/b+o09p/k1OBoR9RWumMZelAP1zryv9JjqD3FcXp/jIz+qFkpzgydjCBH/g
         stm+sSoSBRNu0QIfYRocXWVimnmvXLydW7Qp1kylW24HGJG1+C99ALdu22/IOrmncinQ
         PJU24LX00/S1IYyVGuJxvrWH+S9yzrP90Y3mgvb0kNR6cpis0G6A+yDrjHrzpO2zpzwJ
         mkLw==
Received: by 10.50.170.98 with SMTP id al2mr9922060igc.47.1348624213139; Tue,
 25 Sep 2012 18:50:13 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Tue, 25 Sep 2012 18:49:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206391>

Hi,

I often find myself attempting to examine another repository,
especially in projects that are closely related but put in different
git repos. It's usually just a diff or log command

git log --patch ../path/to/another/repo/path/to/file.c

cd'ing out is nuisance for one-shot commands, even setting --git-dir
is because i'd need to repeat the path. I think when we detect paths
outside repository, we could try to discover new repository that
contain those paths, the adjust $GIT_DIR internally to the new
repository.

We can't do that now because .git repository and "path outside
repository" check occur in two separate stages, the latter after .git
is discovered and .git can't be moved once discovered. We might be
able to move "path outside repo" check up to discovery phase. But that
could be big change.

Does anybody want such a feature, or it's just my itch? It's probably
not worth doing because few people need it.
-- 
Duy
