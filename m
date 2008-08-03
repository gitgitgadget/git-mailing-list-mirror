From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: [RFC] gitattributes on a bare repo
Date: Sun, 3 Aug 2008 10:34:37 +0200
Message-ID: <cb7bb73a0808030134j5760d627i4180a6ff8f2cde6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 03 10:35:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPZ42-0003K0-Hy
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 10:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbYHCIek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 04:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752798AbYHCIej
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 04:34:39 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:51192 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbYHCIei (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 04:34:38 -0400
Received: by yw-out-2324.google.com with SMTP id 9so946091ywe.1
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=3G1rdG3mHJlwHCx8AKBpiFn9yEx4dqnR/feJDf6pAbM=;
        b=GzTK2m+TyNol7SnxnkNxUCLtJTzCnptQX4dQ3jc9wMXwK6MivZYaz/gwB8V2pqofdd
         RmZijJjXOtrrrAEPYFFVJRbya9w4XHngeC58OJIdJ5Rct4G4yjDFwcNNVqDGPqfNxJ95
         vion+6sye4GuYB/PUkYj41fVq2nu3zGq9affQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=R50bFmd977Jb2mwuP4Ra8jHK3vTT98HYfsGgMZMqre+WvUyGlOszjb8OuRij2qZjqn
         ZbSYkA+Chdu0Te5jBRI/frknqDfZFxIFxZqxkCDqDdcVAdbkEhH5jIyRmbedUazpYIjT
         TEk7RfvHVugJ8n20SAZ30RDjfM2y9uDLOHdFw=
Received: by 10.150.205.13 with SMTP id c13mr6205738ybg.239.1217752477898;
        Sun, 03 Aug 2008 01:34:37 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Sun, 3 Aug 2008 01:34:37 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91216>

Hello all,

I realized recently that gitattributes don't work on a bare repo. It's
easy to see why (no .gitattributes file to look into) and the
'official' solution is to use .git/info/attributes for that, which has
the obvious problem of being local and not carried over to other repos
(so that e.g. you have to recreate it and keep it up to date on remote
repos too).

I was discussing this on IRC with pasky and he suggested that the best
way to approach the matter was to use the .gitattributes from the
relevant head. For example, a diff-tree would use the first
.gitattributes from the first tree-ish parameter. I have actually
looked into implementing this myself, but I'm afraid my git mojo isn't
strong enough yet.

A similar discussion would hold of course for .gitignore and the
corresponding info/excludes file.

I'm not sure how widespread the need for such a possibility (using
.gitignore and .gitattributes on bare repos) is, but at least
.gitattributes it would allow gitweb to use the correct diff
funcnames.

-- 
Giuseppe "Oblomov" Bilotta
