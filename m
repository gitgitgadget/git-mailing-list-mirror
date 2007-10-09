From: Mark Levedahl <mlevedahl@gmail.com>
Subject: bug? - git-checkout treeish paths  ignores deleted files
Date: Mon, 08 Oct 2007 20:58:06 -0400
Message-ID: <470AD21E.6070906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 02:58:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If3QT-0002pa-0d
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 02:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbXJIA6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 20:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbXJIA6L
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 20:58:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:34239 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbXJIA6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 20:58:10 -0400
Received: by wr-out-0506.google.com with SMTP id 36so739899wra
        for <git@vger.kernel.org>; Mon, 08 Oct 2007 17:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=Yy6M7AJBxx0wxUvuvQ6BU0GvYxQqQGRlk+vxy6/g7k0=;
        b=a0vHMsTcGRsH9SuRql7q3EaCn8EksFlmaYvBIaNBo5pO3YRSEIRU3CUQd1tGeM+QQEFVlv47+IdGBEN+gBYp4dSWfSwHrShpmJZrBnPiTU1BgyaA5TvTWZ5Mz5yF2nnjVtjn59lhwma8IDQLMS4ERNDaxwRGJ6C1t12p7r3ZZaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=l0Vl0UWqjbyyIkhqIK3/Pm7i85SSZ7GgMKSq8/OvUthhC/tjgiz2PAcSIjFgAD4XYSviFtUNtUJxZd7oBPz8dn+paVeGA3Iv2Omr1RA8xJq8OK+IWUIhWmHa1i/rf7Os8FvGejwMu04NmUeHcNnRs/9XA3vGquvyQxTQCnS0xkY=
Received: by 10.90.83.14 with SMTP id g14mr4597732agb.1191891489356;
        Mon, 08 Oct 2007 17:58:09 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.246.225.127])
        by mx.google.com with ESMTPS id 33sm8341296wra.2007.10.08.17.58.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Oct 2007 17:58:08 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60348>

Shouldn't   "git checkout topic path"  make the directory tree rooted at 
path identical to what is on branch topic? It doesn't.

Try this:

mkdir test
cd test
git init
touch a b
git add a b
git commit -m 'base'
git checkout -b topic
git rm a
git commit -m 'removed a'
git checkout master
git checkout topic .

...and the result is...
ls
a   b

instead of
b

Mark
