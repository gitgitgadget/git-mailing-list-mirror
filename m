From: "Thomas Leonard" <talex5@gmail.com>
Subject: Fwd: [Bug 163341] Re: git-svn gets wrong parent revision for tags
Date: Tue, 8 Apr 2008 16:48:03 +0100
Message-ID: <cd53a0140804080848r54bb1e6dq54b5cce62339d6d1@mail.gmail.com>
References: <20071117143713.8355.50653.malonedeb@potassium.ubuntu.com>
	 <20080407195610.13681.39351.malone@potassium.ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 17:48:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjG47-0001gp-8t
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 17:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbYDHPsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 11:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbYDHPsJ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 11:48:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:13524 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbYDHPsH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 11:48:07 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2063534wxd.4
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 08:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XVtiPg52DC49BQYyFf1Eq1R5V6cfBrqJbQ3LfFQEvSA=;
        b=PsblFXl870phlA79emJJaRH6/vPFFBsr+foOiWe+/QArkNpp30VHv35gxHD69kN5oLimRnT7/T9RBGdTr1qaD3DUeeLdqzXpTlQ6deYhBAdHT2Q33l3sENI4aVnwPKjmNJJpRrRIUFrAZnwNxEApx7OZc/vnsE4t8Oe1877nFAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HACymsZ7q1qw4OoVy624Mgz29iQgd65Ri/DeE0Kzd7otRb5ODUUksGtk6PCE8PvA1C/nSbpI8chuyrdluL8pgtrwSo9ABiMyrvMQ1cjNTyO+XaCq1Rsvmc8mHYCyWl11UQgxIZqjQuG/fDdlzH26HwqVZz9Pjhh4+KJqWtrrqq4=
Received: by 10.100.178.7 with SMTP id a7mr13211853anf.73.1207669683336;
        Tue, 08 Apr 2008 08:48:03 -0700 (PDT)
Received: by 10.100.105.20 with HTTP; Tue, 8 Apr 2008 08:48:03 -0700 (PDT)
In-Reply-To: <20080407195610.13681.39351.malone@potassium.ubuntu.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79004>

Hi.

The git-svn Ubuntu packager asked me to forward this here.

Summary:

When converting a subversion repository to GIT using git-svn, the tags
do not have the right parent. Each tag should be identical to a trunk
revision (which it was copied from), but because git-svn uses an
earlier revision as the parent it appears that the same work was
duplicated on two branches.

Example:

git-svn clone https://zero-install.svn.sourceforge.net/svnroot/zero-install
-T trunk/0publish -r1890:2072 -b releases/0publish

The git branch comes from r1894, yet the svn log shows that in
includes files from r2070:

$ svn log https://zero-install.svn.sourceforge.net/svnroot/zero-install
-r2071 -v
r2071 | tal197 | 2007-11-10 19:40:45 +0000 (Sat, 10 Nov 2007) | 1 line
Changed paths:
   A /releases/0publish/0publish-0.12 (from /trunk/0publish:1968)
   R /releases/0publish/0publish-0.12/0publish (from
/trunk/0publish/0publish:2070)
   R /releases/0publish/0publish-0.12/0publish.xml (from
/trunk/0publish/0publish.xml:2070)
   R /releases/0publish/0publish-0.12/release.py (from
/trunk/0publish/release.py:2069)

Released 0.12

https://bugs.launchpad.net/ubuntu/+source/git-core/+bug/163341

Thanks,


---------- Forwarded message ----------
From: Emil Sit <sit@amsterdam.lcs.mit.edu>
Date: 7 Apr 2008 20:56
Subject: [Bug 163341] Re: git-svn gets wrong parent revision for tags


I know that git-svn may rely on various conventions for the use of git
 and use of svn but since I'm not really familiar with either, it sounds
 like this should best be handled by the upstream developers.  Git does
 not use a dedicated bug tracker but handles issues on the mailing list
 git@vger.kernel.org.  If you submit your patch there, you should get a
 pretty fast response and you can follow up with this bug.  In any event,
 if the bug is fixed upstream, the next version of Ubuntu will probably
 include the fix automatically.

 Can you handle the follow-up with the official git developers?  Thanks!


 --
 git-svn gets wrong parent revision for tags
 https://bugs.launchpad.net/bugs/163341
 You received this bug notification because you are a direct subscriber
 of the bug.


-- 
Dr Thomas Leonard		http://rox.sourceforge.net
GPG: 9242 9807 C985 3C07 44A6  8B9A AE07 8280 59A5 3CC1
