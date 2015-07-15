From: Juston Li <juston.h.li@gmail.com>
Subject: git send-email Connection Closed
Date: Tue, 14 Jul 2015 22:11:13 -0700
Message-ID: <CAFow2F9ZFNcBdoc7YTCeGT_PA-UvMyfcKWE4K4ufGMyFXJd5Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 15 07:11:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFEyU-00044y-Oq
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 07:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbbGOFLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 01:11:14 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:36117 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbbGOFLN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 01:11:13 -0400
Received: by ieik3 with SMTP id k3so26162656iei.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 22:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=k4o/PLW8NOrL/5nTRAX8Rm8FeHShYz+XDknp7w7RLb0=;
        b=KwjOk9pFUTOemraw88gK2U0BEWCX8YHBQeULChNGBYMRGQTLMH82clFHeBAI/eiXGZ
         m5IfdweXJNdOUuUniDK1J4Nbkfs801TMKim0sWFTa+V2DtJojVgsK8d9iDPaHEBg/6VV
         zcUgFBK0INqBvJAfqx6POQC+82KQOJABZznxbMBqb9N78sAztwr/IcHJko4FGFie4mHK
         xFew3RA9BX1TjHby6KD+1CcLVSGE6xUu5NdlE1WCgzBNELrTgw6+Z2u7CMx70ZqMC8s8
         9Zd9R8mo3rP1vrzAziw5wF7KzINYSq2Cfp8gkaSTt+gQf07vfWXwCo3U7ozvwpFaKwXN
         9XDw==
X-Received: by 10.50.61.241 with SMTP id t17mr8016766igr.34.1436937073345;
 Tue, 14 Jul 2015 22:11:13 -0700 (PDT)
Received: by 10.79.19.7 with HTTP; Tue, 14 Jul 2015 22:11:13 -0700 (PDT)
X-Google-Sender-Auth: 9rZgyBBQhfWWfgmx4dFX4Mu5woE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273979>

Hello

Recently, I have had trouble using git send-email to send a patchset.
After the confirmation to send the email I get the following:
Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
[Net::SMTP::SSL] Connection closed at /usr/lib/git-core/git-send-email
line 1320.
fatal: 'send-email' appears to be a git command, but we were not
able to execute it. Maybe git-send-email is broken?

This message first appeared when I tried to send a 19 commit patchset
via 'git send-email HEAD~19'. It also fails when I try to format-patch
and send the patchset separately via 'git send-email 0001...'
Oddly enough, it works when I send anything other than 19 commits
for example 'git send-email HEAD~1' or 'git send-email HEAD~20'

I thought it was something with the gmail servers but I was able to send
the patchset by downgrading a couple perl packages
warning: downgrading package perl (5.22.0-1 => 5.20.2-1)
warning: downgrading package perl-net-ssleay (1.68-2 => 1.67-1)

Note perl-net-ssleay depends on perl 5.22 so I can't isolate which
package but I can consistently get the failure with the newest packges
and it works fine with the downgraded packages.

Running Arch Linux
git 2.4.5
perl 5.22.0
perl-authen-sasl 2.16
perl-mime-tools 5.505
perl-net-smtp-ssl 1.03

.gitconfig
[sendemail]
    smtpEncryption = tls
    smtpServer = smtp.gmail.com
    smtpUser = juston.h.li@gmail.com
    smtpServerPort = 587

Regards
Juston
