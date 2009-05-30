From: Erik Sandberg <mandolaerik@gmail.com>
Subject: BUG: mergetool fails on gitignore:d files
Date: Sat, 30 May 2009 17:30:52 +0200
Message-ID: <e87cdfda0905300830t6b332533g9a4298f6b8005b9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485f8955eda91f1046b22e0e9
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 17:31:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAQWT-0004C1-KG
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 17:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbZE3Pax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 11:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759595AbZE3Paw
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 11:30:52 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:40966 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759176AbZE3Paw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 11:30:52 -0400
Received: by bwz22 with SMTP id 22so6668521bwz.37
        for <git@vger.kernel.org>; Sat, 30 May 2009 08:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=gfLawmFqSa+Bp67rn/xYUjHChC0GTspymtJBqVKtO18=;
        b=cARFRgFT/r9dDYfjuEwpSoj7jk3US2T7IDQ0DaVOfVUmLqzGYrqpJI5Y9D94uSPrmZ
         oBAe8tENLy1nKfbr6BmFJRn4ufrqGPRxiFuxl8b4NanQ6oOMiXfEyyc10m33gRahfriL
         zusmC4rplqX7enKl8Ygnj7fd+QjlJlEiqqUQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=s3uzIDb6sHK86/uHMWpqy/JxCnfulfi0ElNco4Y7haf4vAWMloegnPLNN1qhAX02ZR
         pX/xpBS24Nfd8D1XzedRJScWYdW4dCQlDFTABg90ah2/l9tbSk7S6ZJZS+YEqea93aZ3
         BsjqvJBOXOO/6Du4xvrxxMzQ0I6wTqi98kesg=
Received: by 10.239.147.19 with SMTP id y19mr255049hba.90.1243697452322; Sat, 
	30 May 2009 08:30:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120355>

--001485f8955eda91f1046b22e0e9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

If a version-controlled file is ignored by git, and a conflict arises
on the file, and I use mergetool to resolve the conflict, then
mergetool fails with a message like:

The following paths are ignored by one of your .gitignore files:
a
Use -f if you really want to add them.

The problem disappears if I edit the git-mergetool script to always
pass -f to "git add", but I'm not sure if that's the right fix; I have
a vague feeling that "git-update-index --add" could be more correct.

I have attached a script that reproduces the problem.

--001485f8955eda91f1046b22e0e9
Content-Type: application/x-sh; name="bug.sh"
Content-Disposition: attachment; filename="bug.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvch9mjc0

IyEvYmluL2Jhc2gKCmdpdCBpbml0CmVjaG8gYSA+LmdpdC9pbmZvL2V4Y2x1ZGUKdG91Y2ggYQpn
aXQgYWRkIC1mIGEKZ2l0IGNvbW1pdCAtbSBpbml0CmdpdCBjaGVja291dCAtYiBhCmVjaG8gYT5h
CmdpdCBjb21taXQgLWEgLW0gYQpnaXQgY2hlY2tvdXQgYX4xIC1iIGIKCmVjaG8gYj5hCmdpdCBj
b21taXQgLWEgLW0gYgoKIyBnZW5lcmF0ZXMgYSBjb25mbGljdCBvbiBmaWxlIGEKZ2l0IG1lcmdl
IGEKCiMgY3JlYXRlIGEgZHVtbXkgbWVyZ2V0b29sIGNvbW1hbmQKZ2l0IGNvbmZpZyBtZXJnZXRv
b2wuZHVtbXkuY21kICdlY2hvID4kTUVSR0VEJwpnaXQgY29uZmlnIG1lcmdldG9vbC5kdW1teS50
cnVzdEV4aXRDb2RlIHRydWUKCmdpdCBtZXJnZXRvb2wgLXkgLS10b29sIGR1bW15Cg==
--001485f8955eda91f1046b22e0e9--
