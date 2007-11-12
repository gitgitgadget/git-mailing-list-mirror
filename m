From: "Adrian Wilkins" <adrian.wilkins@gmail.com>
Subject: BUG: git-svn does not escape literal backslashes in author names.
Date: Mon, 12 Nov 2007 14:28:24 +0000
Message-ID: <1213a9470711120628l4ccab632n17635295ec897a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 15:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IraHq-00005q-5n
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 15:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757539AbXKLO21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 09:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757527AbXKLO21
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 09:28:27 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:34678 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757514AbXKLO20 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 09:28:26 -0500
Received: by py-out-1112.google.com with SMTP id u77so1249861pyb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 06:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=Jw5wi4Z1c5a7Wi3Al5wB7PLEt+f5YiopRthNnh/mi34=;
        b=FYErztt8ndki1X+gI+oaLPOJdue/aFMmiZ8MV40sT2xl+gpDdYcL3SEM+SFPZUa+8a6eYBqDXIXhN15U1O6JGwraQqY8Wu8e8MvI06Hp+GYFQM6px9unSQDjGyls6vIZ9CUzPP1agCZOHLvu5zHvjSOb+E9I6CF1++vha4FfQCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hzVSjMwcERU4DzaFnSdAi6oGuyLxDRNyGKHzT0zvikmc/78mYsEie6zJOArHFObZEoAQHNHvBETrD66Updd5lzyMhDoIdvWy8dSV534L5DpygC8EVfzElxd25apANi2YuYunOsX6xbBZ4e2FqBqaSptP+LUU4pdXO7oIpj5ONJw=
Received: by 10.65.159.19 with SMTP id l19mr13912416qbo.1194877704970;
        Mon, 12 Nov 2007 06:28:24 -0800 (PST)
Received: by 10.64.243.15 with HTTP; Mon, 12 Nov 2007 06:28:24 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64628>

Recently converted a large (11,000+ revisions) repository.

We authenticate against the NT domain controller, so all our revision
authors are of the form "domain\user". (You can switch off mod_sspi
reporting the domain part, but I didn't know about this at the time,
so it continues for historical reasons.)

git-svn treats the literal backslashes in the author names as escapes.
This leads to authors like

domainkevin
domain\
ichard

I know, I should have read the manual and used my "authors" file. Bah.

I'm sure that part of the revision hash in git includes the author
name... so I guess I'm looking at another multi-day conversion. :-(

Can I suggest that you make the authors file compulsory by default as well?
