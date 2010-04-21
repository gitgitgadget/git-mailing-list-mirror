From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: I need a `git format-patch --attach-complete' for RT
Date: Wed, 21 Apr 2010 12:22:24 +0000
Message-ID: <q2j51dd1af81004210522ze6062110j2033788601e17ce8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 21 14:22:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Ywu-0000aa-6i
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 14:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab0DUMW1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 08:22:27 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:51560 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623Ab0DUMW1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 08:22:27 -0400
Received: by bwz2 with SMTP id 2so2782534bwz.10
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 05:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=YlYJEsUSelFEzl/PUJINWZd3G7o+7Ta4OWb5Bsi2DtE=;
        b=EH06XrRYYCkjgIc5j3iVypI33f0ypneOH1s/6hE+dq5qM3CCjfZV9usTsyGDkrvLnF
         OxNCorZlx+jgsaha8Et1oLy2PEpMXWuKBzwfiiSRbgENANqQ+WV8s3P1K3KsayXTMkoL
         JHYm4883Aw2HRxp5E5psZltUOJQtASLd1pKM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=TXsIz//KAQzaojMCo+N/SC4g6edtPAKvaP2l0uYNa90+VoPx6bgDda5OLNRcLX51qx
         YI7svrZiOUiFgZ2GZwYi0TWEtW0HqpHni8uvE1XienrDqoKbgKOlNqFbCQtW/Cca4WQm
         mATIjJXq0tQ/SPiaGXoaf8TB0WQ0oaMyZTrdw=
Received: by 10.204.121.195 with HTTP; Wed, 21 Apr 2010 05:22:24 -0700 (PDT)
Received: by 10.204.132.214 with SMTP id c22mr1176667bkt.60.1271852544859; 
	Wed, 21 Apr 2010 05:22:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145426>

I'm working with a system that doesn't play nice with git-format-patch
/ git-send-email. When you send mail to RT (e.g. http://rt.perl.org/)
it'll always munge the original E-Mail, so inline patches won't
work. Here's an example of this gone wrong:

    commit f9bcfeacc119e37fd70816a2cb4678fded53e8d1
    Author: =C3=83var Arnfj=C3=83=C2=B6r=C3=83=C2=B0 Bjarmason) (via RT=
 <perlbug-followup@perl.org>
    Date:   Tue Apr 20 10:58:37 2010 -0700

        GitHub's mirror is now at mirrors/perl, not github/perl

        # New Ticket Created by  (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n)
        # Please include the string:  [perl #74532]
        # in the subject line of all future correspondence about this i=
ssue.
        # <URL: http://rt.perl.org/rt3/Ticket/Display.html?id=3D74532 >
        From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar@cpan.org>

The workaround is to:

    git format-patch --stdout origin.. > my-patches.patch
    *open your mail client*
    *attach patch as attachment*
    *send to RT*

It would be nicer if I could instead:

    git format-patch --attach-complete origin..
    git send-email *.patch

The --attach option doesn't work with RT because `git am' will take
the commit message from the Subject/body of the message. RT messes
with that.

Is there some existing workaround for this that I've missed?
