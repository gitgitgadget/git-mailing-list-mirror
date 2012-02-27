From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Subject: [BUG] git branch --merged $unknown_checksum segfaults
Date: Mon, 27 Feb 2012 13:26:09 +0100
Message-ID: <20120227122609.GA26981@mx.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 13:26:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1zel-0005Kw-2V
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 13:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab2B0M0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 07:26:14 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39437 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab2B0M0N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 07:26:13 -0500
Received: by eekc41 with SMTP id c41so716463eek.19
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 04:26:12 -0800 (PST)
Received-SPF: pass (google.com: domain of rep.dot.nop@gmail.com designates 10.213.19.133 as permitted sender) client-ip=10.213.19.133;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of rep.dot.nop@gmail.com designates 10.213.19.133 as permitted sender) smtp.mail=rep.dot.nop@gmail.com; dkim=pass header.i=rep.dot.nop@gmail.com
Received: from mr.google.com ([10.213.19.133])
        by 10.213.19.133 with SMTP id a5mr3901902ebb.72.1330345572281 (num_hops = 1);
        Mon, 27 Feb 2012 04:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=s78kxOJpDaaXgV/5xC9lTk01Gj2XSt/oSN+VyPN8PD4=;
        b=eYrZI2jVgU9PNWDIDXIK7fyAe+HD4oU/KLxcHwUPd1jmTbgiI1hZDa0p4UZdaqkrUR
         XD1+9geQcpnstvBOzGfmdmfFBTA5fr7W5d0kQKlJCfvNblXyuwfxJDtBuBOfnQiB7OZI
         d8y3B+DcG/ufnjesr5FUw8oea1F1J4AlauEaE=
Received: by 10.213.19.133 with SMTP id a5mr2946476ebb.72.1330345572195;
        Mon, 27 Feb 2012 04:26:12 -0800 (PST)
Received: from s42.loc (85-127-89-51.dynamic.xdsl-line.inode.at. [85.127.89.51])
        by mx.google.com with ESMTPS id v51sm57521438eef.2.2012.02.27.04.26.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Feb 2012 04:26:11 -0800 (PST)
Received: from cow by s42.loc with local (Exim 4.77)
	(envelope-from <rep.dot.nop@gmail.com>)
	id 1S1zeb-0007WN-OH; Mon, 27 Feb 2012 13:26:09 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191622>

Hi,

I hope this minor buglet is not known already..
I did not look further.

Seen with
$ dpkg-query -W git
git	1:1.7.2.5-3
and
git	1:1.7.9-1
cheers,

git init
git branch --merged 0000000000000000000000000000000000000000
Segmentation fault
touch f
git commit -m one f
[master (root-commit) f11ad60] one
 0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 f
git branch --merged $((echo "obase=16;ibase=16;$(git log -n1 --format='%H'| tr '[[:lower:]]' '[[:upper:]]')+1") | bc)
Segmentation fault
