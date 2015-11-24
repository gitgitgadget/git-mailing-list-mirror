From: Robert Crews <rcrews@hortonworks.com>
Subject: Mac OS X Git Packaging Problem
Date: Tue, 24 Nov 2015 19:08:24 +0000
Message-ID: <7a7427c556404e7ba18ca3f3abea42f5@MBX080-W6-CO-2.EXCH080.SERVERPOD.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 24 20:18:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1J6x-00018s-8E
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 20:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbbKXTSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 14:18:40 -0500
Received: from relayvx12c.securemail.intermedia.net ([64.78.52.187]:26067 "EHLO
	relayvx12c.securemail.intermedia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754059AbbKXTSj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 14:18:39 -0500
X-Greylist: delayed 613 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2015 14:18:39 EST
Received: from securemail.intermedia.net (localhost [127.0.0.1])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by emg-ca-1-2.localdomain (Postfix) with ESMTPS id 1716A53E36
	for <git@vger.kernel.org>; Tue, 24 Nov 2015 11:08:26 -0800 (PST)
x-echoworx-msg-id: 36fa6666-470f-4b12-ba55-445bec20f750
x-echoworx-emg-received: Tue, 24 Nov 2015 11:08:26.031 -0800
x-echoworx-action: delivered
Received: from 10.254.155.17 ([10.254.155.17])
          by emg-ca-1-2 (JAMES SMTP Server 2.3.2) with SMTP ID 976
          for <git@vger.kernel.org>;
          Tue, 24 Nov 2015 11:08:26 -0800 (PST)
Received: from MBX080-W6-CO-1.exch080.serverpod.net (unknown [10.224.117.105])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by emg-ca-1-2.localdomain (Postfix) with ESMTPS id D25DA53E36
	for <git@vger.kernel.org>; Tue, 24 Nov 2015 11:08:25 -0800 (PST)
Received: from MBX080-W6-CO-2.exch080.serverpod.net (10.224.117.106) by
 MBX080-W6-CO-1.exch080.serverpod.net (10.224.117.105) with Microsoft SMTP
 Server (TLS) id 15.0.1130.7; Tue, 24 Nov 2015 11:08:25 -0800
Received: from MBX080-W6-CO-2.exch080.serverpod.net ([10.224.117.106]) by
 MBX080-W6-CO-2.EXCH080.SERVERPOD.NET ([10.224.117.106]) with mapi id
 15.00.1130.005; Tue, 24 Nov 2015 11:08:25 -0800
Thread-Topic: Mac OS X Git Packaging Problem
Thread-Index: AQHRJut+zgZTA+MpKUOcK/wPH/qRXA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.175.27.10]
x-source-routing-agent: Processed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281622>

This is a bug report for the Mac OS X packaging at
http://git-scm.com/download/mac . It is not so much a
software bug as a nonoptimal configuration setting.

Requested Change
Remove the line "excludesfile = ~/.gitignore" under [core] from
/usr/local/git/etc/gitconfig

Reasons:

#1
The documentation at http://git-scm.com/docs/gitignore says the default
global excludes file is at $HOME/.config/git/ignore. The file
$HOME/.config/git/ignore is installed, and does indeed have good default
content, but because of the setting in /usr/local/git/etc/gitconfig, the
file is blocked from being reached.

#2
Seems to me the global excludesFile should never be called .gitignore --
better to be called .gitignore_global -- since the .gitignore name would
prevent a local .gitignore from being included there. I personally don't
have my $HOME directory under git control, but if I did, I might want a
custom .gitignore. And if I did want that, I would be required to set my
global file explicitly in my own ~/.gitconfig:
  git config --global core.excludesFile "~/.gitignore_global"
