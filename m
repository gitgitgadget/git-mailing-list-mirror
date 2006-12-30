From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Possible regression in git-rev-list --header
Date: Sat, 30 Dec 2006 18:56:19 +0100
Message-ID: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 30 18:56:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0iRX-0007EL-Op
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 18:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbWL3R4V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 12:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755182AbWL3R4V
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 12:56:21 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:44991 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181AbWL3R4U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 12:56:20 -0500
Received: by py-out-1112.google.com with SMTP id a29so2815813pyi
        for <git@vger.kernel.org>; Sat, 30 Dec 2006 09:56:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H2ZMqMrOUhiA/SsSqjMRzOQnUcyMXNqZ3eCl5J9orBd7Ah8KLBLft0nGBYGUnzyrBm/LmuDGemegjrGne3JFCxAvCrMHIPT356smw3n7OUg/wrCcAok3FCfBaWo/UWC8cwYDQMFtA7hdRq7AKx69DbGYqtjJ2nU1BlGr+Ol2CIs=
Received: by 10.35.27.1 with SMTP id e1mr16326172pyj.1167501379568;
        Sat, 30 Dec 2006 09:56:19 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Sat, 30 Dec 2006 09:56:19 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35621>

When 'commitencoding' variable is set in config file then git-rev-list
called with --header option sends also the encoding information.

$ git rev-list --header -n1 HEAD
6d751699cb04150abd79a730187d4e2ed6330c05
tree 70209eebdc59d108948feb15c3c5497f299ef290
parent 49a8186d7352d0454df79b289fecb18c8e535c32
author Marco Costalba <mcostalba@gmail.com> 1167500660 +0100
committer Marco Costalba <mcostalba@gmail.com> 1167500660 +0100
encoding UTF-8

    Test commit

    Let's see what git-rev-list --header spits out.

    Signed-off-by: Marco Costalba <mcostalba@gmail.com>

$ git --version
git version 1.5.0.rc0.g1ed48


This is very unfortunate because qgit parsing routine it's totally
broken after this change. Please revert the patch, or at least make
git-rev-list --header quiet as default, IOW add an option
--show-encoding that defaults to disabled.

Sorry to ask you this but _all_ the qgit users out there will see a
broken main view revision's list for all the commits created after the
patch went in.

Thanks
Marco
