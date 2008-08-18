From: "Tor Arvid Lund" <torarvid@gmail.com>
Subject: [RFC] Using git-p4 on project with branches
Date: Mon, 18 Aug 2008 11:26:27 +0200
Message-ID: <1a6be5fa0808180226h79eebf46yad9174b1518d4eed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Simon Hausmann" <simon@lst.de>
X-From: git-owner@vger.kernel.org Mon Aug 18 11:27:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV11S-0008Er-18
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 11:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbYHRJ0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 05:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbYHRJ0a
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 05:26:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:11753 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbYHRJ03 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 05:26:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1598695fgg.17
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 02:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=UZvrf6LHmh3ZpToksUxIv8r+IfE+rJ4tf7WOgiWGW68=;
        b=hLFLPrzEqTeSQ5M1dDAqDrPohzlQ+I9+ASfx/9gJbAsCv0Lr3L8J3N5CjIzoMWvPc0
         manp5HaCv6CFxnmFoLE1Sfny9bZb5VLVdyg1leodpWfrEZf8PUQH5w0TgrqCFIaKPnkv
         lZKocEU5nkhlmSh0h6VBtsEN+/WCZzxAzu84A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Dm1aBsk1gzDOuoyzCpPLJeKabBXRBNTwhV91cey+XSb1D6sQSBgZgdFXS5pjmCosln
         jECLIXHqvHg/TQDuLH+6V+rLK+AVXduo+wi88taaQ/teG+lPfHGfI4vO/8ithwBU+qxN
         j1mONA/ezucRBEcqu0RGXQRv6P3e006yOdjyI=
Received: by 10.86.77.5 with SMTP id z5mr4430103fga.10.1219051587665;
        Mon, 18 Aug 2008 02:26:27 -0700 (PDT)
Received: by 10.86.79.9 with HTTP; Mon, 18 Aug 2008 02:26:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92692>

Hi!

I really appreciate the work that is done with allowing us poor souls
stuck with perforce at work to use git via git-p4. But I'm wondering
how to make it work when there are several branches on the perforce
server.

Say, for instance, that I have this setup:

//depot/old/path/to/projectX
//depot/new/path/to/projectX_Devel_Branch
//depot/new/path/to/projectX_Release_1.2_Branch
//depot/new/path/to/projectOther

It would be really nice, if I were able to make a projectX.git
repository with the 'old', 'devel' and '1.2' branches. It seems that
the --detect-branches argument to P4Sync wants me to enter
//depot/new/path/to as the root path, and detect p4 branchspecs from
there. That works poorly for me, since it would also include
projectOther, which I don't want. It would also not include the 'old'
branch.

I have looked briefly at the git-p4 code, but don't know it very well
yet. Anyway, I suspect this functionality is not implemented... I
might try to do this myself, and if anybody has ideas on how to get
started, it would be much appreciated.

To support submitting changelists back to perforce, it would probably
need some configuration (to determine which path to submit to in
perforce)... Like:

[git-p4 "branches"]
        old = //depot/old/path/to/projectX
        devel = //depot/new/path/to/projectX_Devel_Branch
        1.2 = //depot/new/path/to/projectX_Release_1.2_Branch

Well, I guess I'm just wondering if this is something anybody but me
would like to have? Or if there is another/better way to go about
doing it...

-Tor Arvid-
