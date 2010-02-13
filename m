From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH 0/5] Speed up string search routines
Date: Sat, 13 Feb 2010 15:20:14 +0100
Message-ID: <20100213142014.GA9543@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 15:20:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgIrG-0005kY-Vg
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 15:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009Ab0BMOU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 09:20:26 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:53809 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921Ab0BMOUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 09:20:25 -0500
Received: by ewy28 with SMTP id 28so2560766ewy.28
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 06:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=8wTPx3T3b1MNxSrJQkDgsbRjdO9racW1EMZbd5qR4RM=;
        b=T5atUkG7oLjkQFyIu+jx0Qtnm3P5Vxc6kfysvg3MKfa4/jK8TocSRCs+aAB6txH0QW
         v7AxmksZzXGB9VXdIcJ/F5x61kEFEBlHTZDXuQ0AOGk3A6N+YED2iIhsXElYx91Dp2e9
         wvRp/kVptAtyV8LngoUKg7IAvfZordNo8sqCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=PCBSVKGZOd+LpbWOk0ovkzdNjYgHW7PxMlxvDanjM6WjS/etAZ1VLs9VGhgEgtD4Wk
         fzA38t9e4196YgKkgT2icT1psajw/vEaF7TsjeIvqrIwrv/SemSu2q6i2iA2Mz28pQ8t
         5pUhfvkSKb339VOJw/b+OcPu58ZucVmGT2iMs=
Received: by 10.213.109.199 with SMTP id k7mr1031386ebp.66.1266070816871;
        Sat, 13 Feb 2010 06:20:16 -0800 (PST)
Received: from fredrik-laptop (c83-250-157-96.bredband.comhem.se [83.250.157.96])
        by mx.google.com with ESMTPS id 23sm10599473eya.3.2010.02.13.06.20.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 06:20:16 -0800 (PST)
Content-Disposition: inline
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139797>

This series speeds up git grep and pickaxe by using the string search
routines from GNU grep.

---

Fredrik Kuivinen (5):
      Use kwset in grep
      Use kwset in pickaxe
      Adapt the kwset code to Git
      Add string search routines from GNU grep
      Add obstack.[ch] from EGLIBC 2.10


 Makefile           |    2 
 diffcore-pickaxe.c |   34 ++
 grep.c             |   61 +++-
 grep.h             |    2 
 kwset.c            |  775 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 kwset.h            |   62 ++++
 obstack.c          |  441 ++++++++++++++++++++++++++++++
 obstack.h          |  509 ++++++++++++++++++++++++++++++++++
 8 files changed, 1855 insertions(+), 31 deletions(-)
 create mode 100644 kwset.c
 create mode 100644 kwset.h
 create mode 100644 obstack.c
 create mode 100644 obstack.h
