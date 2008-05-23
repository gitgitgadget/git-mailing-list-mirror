From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: git diff-files weirdness (bug?)
Date: Fri, 23 May 2008 15:20:47 +0100
Message-ID: <b0943d9e0805230720h61cbabbbw180908e1b28a34cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 23 16:22:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzY9f-0008LX-SC
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 16:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbYEWOUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 10:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754490AbYEWOUw
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 10:20:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:55046 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbYEWOUv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 10:20:51 -0400
Received: by ug-out-1314.google.com with SMTP id h2so779754ugf.16
        for <git@vger.kernel.org>; Fri, 23 May 2008 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=DylCcNN209aMe2wpEm31dffoqHKNNXbbNr7PpfufUYM=;
        b=HQUdio8pY9IvNUk26MBtnej/imdo4ePjL4Fra/okenbX+cwbmyQBLZnxixW6rblxf2bi7qtUCH8emfgsVGRhqefCv1e69ZneoJGfFvewzJlmzE/XeGSDwj9MRs9Hb3Gli/ium/o/UdueoJFme9pwaekjdsEd1mJ+xRpWsNA6YJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nn1P1AMvKhBJjoylWzGnSveGgotArs4F4X71KXflyxtNu7KRzQQqPYdd+jywkx+sHXZEj5m+WucW/BG6kFPYF8zNg9pTD1IRv4dFRDsl0Lr/qgE3v935M3fUmPj3EOUbD78raOu9Is/uC59vxp1+RqPeHKB+9uD8o/Ow9tPUYus=
Received: by 10.66.251.6 with SMTP id y6mr880473ugh.30.1211552447440;
        Fri, 23 May 2008 07:20:47 -0700 (PDT)
Received: by 10.66.242.4 with HTTP; Fri, 23 May 2008 07:20:47 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82712>

Hi,

I was investigating a bug in "stg refresh" failing with moved files
and noticed that it was caused by Git (HEAD pulled yesterday):

  git init
  touch a
  git add a
  git commit -m "test"
  git mv a b

These are OK:

  git diff-files -- a
  git diff-files -- b

These fail:

  git diff-files -- a b
  git diff-files -- a c

These are OK:

  git diff-files -- a b c
  git diff-files -- a b c d e
  git diff-files -- c d e
  ...

It looks like the two arguments command is a special case. Passing
"-q" doesn't make any difference.

Thanks.

-- 
Catalin
