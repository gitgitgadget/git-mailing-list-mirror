From: ulrik <ulrik.sverdrup@gmail.com>
Subject: [BUG] Invalid rebase command leaves unclean status
Date: Wed, 19 Dec 2007 01:47:12 +0100
Message-ID: <a1b6cb1b0712181647v34822692t4a3d88f90cd7346@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 01:47:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4n62-0007xq-4e
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 01:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847AbXLSArO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 19:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753360AbXLSArO
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 19:47:14 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:31503 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755599AbXLSArN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 19:47:13 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2330288fkz.5
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 16:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=SaDVtmYSsJ/ioGmz8zerr7l0mnO6CDgejna0rVMYifU=;
        b=BSZHgCc6Vsi4kEnRnATpPtFWotga9086xeeCkTwSw+6ab26G9vdWXviM00c/HS4eah16jCNWeOldatURok6Ec6tqtLyAmupc00C2R3wqkEHzFOitt24hZtAtWYk3d3Dx5Od5qMSw6EPgMrKuhfe/oPw2DUBPHCMn4ZNlKPVv+BA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mWJB8w0M3LmEXHLwubUhtE6csVjKG42Hejlb9mTmHicMFQPMn957Xq5FN2qYW82sld6MVFgf29coSEhaeLCOIBCMY4f7BbR7Qc941ntt63qnqBhKK2zKVJi2Gljr13hankh7l476/VjVpeQbalCddI+ilWYDhd3qBCZ+XcVTTmw=
Received: by 10.82.112.3 with SMTP id k3mr6052796buc.15.1198025232109;
        Tue, 18 Dec 2007 16:47:12 -0800 (PST)
Received: by 10.82.112.8 with HTTP; Tue, 18 Dec 2007 16:47:12 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68851>

Hello git list

A bug in rebase -i: A typo in the command (for example in the branch
name) still makes later invocations of rebase think a rebase is
already in process.

I found this bug in master, and it was already reported to the mailing
list under version 1.5.3.5, but there were no follow-ups to that mail.
I'm using 1.5.3.7 and it is still present, and looking at the maint
branch it does not seem to be mentioned in post-x.3.7 changes there.
So I am now reporting this bug again. I'm sorry for not checking this
in master, I'll have to ask someone on the list to do that.

Original email:
http://marc.info/?l=git&m=119410951019002&w=2
Date:       2007-11-03 17:04:51
Message-ID: 200711031804.52259.elendil () planet ! nl

# A sample session:
# Invoking rebase with a typo, there is no "muster" branch
$ git rebase -i muster
fatal: Needed a single revision
Invalid base
$ git rebase -i master
Interactive rebase already started
$ git rebase --abort
fatal: Needed a single revision
# Even though rebase --abort reports an error, rebase's internal state
is now cleared

Regards,
Ulrik Sverdrup
