From: Brian Foster <brian.foster@innova-card.com>
Subject: [Q] merging from one (kernel) stable to another?
Date: Mon, 30 Mar 2009 10:24:08 +0200
Message-ID: <200903301024.08848.brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 30 10:26:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoCot-0005RL-FP
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 10:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbZC3IYk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 04:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbZC3IYj
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 04:24:39 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:36127 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbZC3IYh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 04:24:37 -0400
Received: by ewy9 with SMTP id 9so1936903ewy.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 01:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=++wnPENe16l8J4Pf0oyRzuToBPb4/zxjaBpOuIn9iG4=;
        b=vT1Qmf1MZeNwoLtsB46jBJVB2YmcJaChMEJsYdhfnovE7k5c3J8kSCC50N+R5vPev0
         AN5Tp3HJ+Jj4cc29nX2QNJYbs/mbb6v22mYZ/BZ78gdI05v1/ECATy2ZBORBnTF8a/Qv
         N3pRmcq/U8jOAI5xVv/jEmORN6y/T+Hp9qVR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=o07PslaukQa3CQ16MKSTBMgqZGEbuZ8GIlLPyhPgno1WizsP6E3d6VISUd8szZyFgu
         8d6iRpnouXo+kruFnZVnBm2svItvkwnXYJLBSa7sW306IjGU9eMDDH4+dDY6lacS3gfw
         fWMRIhXaP9Au4jRi7L3qfvj2UHcsZRPI0hBEg=
Received: by 10.210.139.15 with SMTP id m15mr3926834ebd.32.1238401474460;
        Mon, 30 Mar 2009 01:24:34 -0700 (PDT)
Received: from innova-card.com (LRouen-152-82-23-47.w80-13.abo.wanadoo.fr [80.13.118.47])
        by mx.google.com with ESMTPS id 20sm5455909ewy.113.2009.03.30.01.24.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 01:24:33 -0700 (PDT)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; x86_64; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115105>

  Whilst this question involves linux(-mips) kernel tree,
 it's a git(-related?) question, not a kernel question ....

  We are currently in the process of upgrading our embedded
 system from kernel 2.6.21(-ish) to at least 2.6.26.8;  and
 later, at some time in the future on to 2.6.3x or something.
 Going from 2.6.21 to .22 to .23 and so on to .26, then to
 .26.1 and so on to .26.8 is =E2=80=9Ceasy=E2=80=9D in the sense there =
are
 very few conflicts with our existing baseline (e.g., just
 2 or 3 in 2 or 3 files).

  .21 --> me --> .22 --> .23 ... --> .26 --> .27 --> master
     \              \       \           \      \
     .21-stable  .22-stable .23-stable   \     .27-stable
                                        .26.8
                                           \
                                           .26-stable

  But (using 2.6.21-stable and 2.6.22-stable as proxies),
 tests indicate that going from .26.8 to .27 or anything
 later will have numerous conflicts (100s? in more than
 30 files).  Thinking about it, this isn't too surprising
 since the -stable branches cherry-pick important/benign
 fixes from later revisions.

  What's frustrating is that in essentially all =E2=80=9Cconflict=E2=80=
=9D
 cases, the resolution is simple:  Use the later version.
 Very few conflicts are caused by our local changes.  But
 the merge tool I used (=E2=80=98tkdiff=E2=80=99 via =E2=80=98git merge=
tool=E2=80=99) for
 my tests doesn't seem to make that resolution an easy
 thing to do =E2=80=94 I (seem to) have to manually check each
 and every conflict, which very quickly becomes tedious
 (read: error-prone).

  Is there a (relatively) easy way to manage this situation?
 Trying some internet searches didn't find much of anything,
 albeit just what to search for isn't too clear.

 Thanks for any suggestions (including =E2=80=9CRFT<a named>M=E2=80=9D)=
=2E
cheers!
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
