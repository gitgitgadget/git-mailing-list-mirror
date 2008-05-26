From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now incompatible
 with Cygwin (and probably Windows)
Date: Mon, 26 May 2008 10:01:50 -0400
Message-ID: <483AC2CE.7090801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 26 16:03:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0dHm-0006w5-7r
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 16:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbYEZOB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 10:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYEZOB6
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 10:01:58 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:22095 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbYEZOB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 10:01:57 -0400
Received: by yx-out-2324.google.com with SMTP id 31so18793yxl.1
        for <git@vger.kernel.org>; Mon, 26 May 2008 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=y6NeFkhjXdBaTbGMy+jkYPIsBN3XW1ZlwyEfky3Itys=;
        b=u1ZRsXxr0MLMeyHxke/NgV3Et5Kj5OHH8KJPaIELRMC96yEHOFGDjHsTXPse2GSvpPmdnkzbUFTHa3EfY+WTFSF5HjRi8EOAkiINp/PUkfHjJDzFrcocqNgpPUUVZrnVPjOyDxEy5RUGybcYHc/MUYAMp+wl1VvDGkQgn7WP9HU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=FtYmUhsWTxzfG2iTnfgXN9S578bgW6ns5AQkH+Q96slYnF1CYv1jrUaO9L2I1OkBvnfF1cIrpvT7OSyZ5ZcxUY9+DNzs5FhbUrWzftFLAx/CCTdI5ALuDLTn0cZboJn9lqRIP8MzZVyOyvqyrml5gtN6uP6uePLkpVQXP3lQ3GU=
Received: by 10.150.78.41 with SMTP id a41mr2835598ybb.177.1211810514633;
        Mon, 26 May 2008 07:01:54 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.126.133.203])
        by mx.google.com with ESMTPS id 6sm16781093ywp.3.2008.05.26.07.01.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 May 2008 07:01:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82934>

Beginning with the referenced commit, the git project cannot be checked 
out on Cygwin (and I assume cannot be checked out on Windows using 
msysgit, though I have not verified this) as this commit introduces the 
file "t/5100/nul." On Windows, the file name "nul" is reserved, 
regardless of path, and cannot be created or deleted. It serves 
essentially the same function as /dev/null.

As a for instance of the troubles:

git>git checkout -f origin/master
Previous HEAD position was a2f5be5... Merge branch 
'jk/maint-send-email-compose' into maint
error: git-checkout-index: unable to create file t/t5100/nul (File exists)

As this commit is part of the published master branch, I am not sure the 
correct resolution: leaving this commit in place means that any commit 
between it and a commit fixing this will always cause an error on Cygwin 
/ Windows. Of course, it *is* on the published master branch.

Mark
