From: "Rick Liu" <rickliu@broadcom.com>
Subject: standarize mtime when git checkout
Date: Mon, 8 Jul 2013 21:39:09 +0000
Message-ID: <7D0754FFADBD2D4785C1D233C497C47B209AF2BC@SJEXCHMB06.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 08 23:39:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwJ9Z-00054h-VB
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 23:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab3GHVjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 17:39:22 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:1682 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087Ab3GHVjV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jul 2013 17:39:21 -0400
Received: from [10.9.208.53] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 08 Jul 2013 14:35:24 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from SJEXCHCAS05.corp.ad.broadcom.com (10.16.203.12) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 8 Jul 2013 14:39:09 -0700
Received: from SJEXCHMB06.corp.ad.broadcom.com (
 [fe80::65ea:1de7:41c4:e948]) by SJEXCHCAS05.corp.ad.broadcom.com (
 [::1]) with mapi id 14.01.0438.000; Mon, 8 Jul 2013 14:39:09 -0700
Thread-Topic: standarize mtime when git checkout
Thread-Index: Ac58IbYJXUCbF7y1RXWD8zNuu6I1/QAAZkzw
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.16.203.100]
X-WSS-ID: 7DC5EF1631W49697105-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229896>

Hi,

Currently when doing "git checkout" (either for a branch or a tag),
if the file doesn't exist before,
the file will be created using current datetime.

This causes problem while trying to tar the git repository source files (excluding .git folder).
The tar binary can be different 
even all of file contents are the same (eg. from the same GIT commit)
because the mtime for the files might be different due to different "git checkout" time.

eg:
User A checkout the commit at time A and then tarball the folder.
User B checkout the same commit as time B and then tarball the folder.
The result tarball are binary different 
even though all of tarball contents are the same 
except the mtime for each file.


Can we use GIT's commit time as the mtime for all of files/folders when we do "git checkout"?


Rick
