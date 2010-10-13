From: Matt Stump <mstump@goatyak.com>
Subject: Speeding up the initial git-svn fetch
Date: Wed, 13 Oct 2010 08:44:41 -0700
Message-ID: <AANLkTinOQd4xo6VsDXQxShhrRFM28cJfKHjnVPpRuY-q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 13 17:44:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P63VY-00011L-JA
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 17:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930Ab0JMPom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 11:44:42 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60016 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab0JMPom (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 11:44:42 -0400
Received: by pvc7 with SMTP id 7so376683pvc.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=WTe2RfPy0TSvMJedS9HR6SBeDDIqUmlxC+CUsXeeVxo=;
        b=NCQhm1KhbPN3g56/EMgWQ66g8N4MhpvWip8soANja4KAYLFLRzZ8MPZdp9QWuBCrYX
         L+EuOu4rI52Cs54uoAqiyoa5GHLrUodKok3FhaDeLpzJIiNBt2nULcu6OiHqGaUYa5mm
         WGYZ7vzSEUdAHpIN3QLjAEwYrq/R2kj/e15Ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=iSN+1Sj4FGEzaLax3DqtCmpUW/ofB0+/icmYOq/aTh1c2XcZXQgSMriNuUe8oYKKk0
         cSjushmD0WeNHWb2RuOd3oC0GwrgZQNat/3UrJAfL63/lm9oSDZTAJVPcxbptvmxZaeB
         bjHbUJPFJmGaVRxjCMed2AuIdJrsACVUeHLAk=
Received: by 10.142.156.18 with SMTP id d18mr7716490wfe.81.1286984681825; Wed,
 13 Oct 2010 08:44:41 -0700 (PDT)
Received: by 10.220.201.199 with HTTP; Wed, 13 Oct 2010 08:44:41 -0700 (PDT)
X-Google-Sender-Auth: GiVooIo3hWnYkxHajrccsqarroc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158940>

I have a big repository, 100,000+ revisions with a very high branching
factor. The initial fetch of the full SVN repository using git-svn has
been running for around 2 months and it's only up to revision 60,000.
Is there any way to speed this thing up?

I'm already regularly killing and restarting the fetch due to git-svn
leaking memory like a sieve. The transfer is occurring over the local
LAN, so link speed shouldn't be an issue. The repository is on a
dedicated machine backed by dedicated fiber channel arrays so the
server should have plenty of oomph. The only other thing that I can
think of is do the clone from a local copy of the SVN repository.

What have other people done in similar circumstances?
