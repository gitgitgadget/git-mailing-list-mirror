From: Timur Tabi <timur@freescale.com>
Subject: git config --git-all can return non-zero error code
Date: Mon, 19 Nov 2012 17:02:51 -0600
Organization: Freescale
Message-ID: <50AABA9B.6090007@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 00:03:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaaNL-0000JP-Ru
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 00:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313Ab2KSXDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 18:03:22 -0500
Received: from [213.199.154.204] ([213.199.154.204]:20083 "EHLO
	am1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753307Ab2KSXDV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Nov 2012 18:03:21 -0500
Received: from mail74-am1-R.bigfish.com (10.3.201.231) by
 AM1EHSOBE002.bigfish.com (10.3.204.22) with Microsoft SMTP Server id
 14.1.225.23; Mon, 19 Nov 2012 23:03:04 +0000
Received: from mail74-am1 (localhost [127.0.0.1])	by mail74-am1-R.bigfish.com
 (Postfix) with ESMTP id C805C3E02BC	for <git@vger.kernel.org>; Mon, 19 Nov
 2012 23:03:04 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190;KIP:(null);UIP:(null);IPV:NLI;H:mail.freescale.net;RD:none;EFVD:NLI
X-SpamScore: 0
X-BigFish: VS0(zzzz1de0h1202h1d1ah1d2ahzzz2dh2a8h668h839hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh162dh1631h1155h)
Received: from mail74-am1 (localhost.localdomain [127.0.0.1]) by mail74-am1
 (MessageSwitch) id 1353366183122505_4651; Mon, 19 Nov 2012 23:03:03 +0000
 (UTC)
Received: from AM1EHSMHS002.bigfish.com (unknown [10.3.201.251])	by
 mail74-am1.bigfish.com (Postfix) with ESMTP id 188042E009B	for
 <git@vger.kernel.org>; Mon, 19 Nov 2012 23:03:03 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by AM1EHSMHS002.bigfish.com
 (10.3.207.102) with Microsoft SMTP Server (TLS) id 14.1.225.23; Mon, 19 Nov
 2012 23:02:59 +0000
Received: from tx30smr01.am.freescale.net (10.81.153.31) by
 039-SN1MMR1-003.039d.mgd.msft.net (10.84.1.16) with Microsoft SMTP Server
 (TLS) id 14.2.318.3; Mon, 19 Nov 2012 23:02:59 +0000
Received: from [10.82.123.3] (efes.am.freescale.net [10.82.123.3])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id qAJN2pO7016668	for
 <git@vger.kernel.org>; Mon, 19 Nov 2012 16:02:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Firefox/16.0 SeaMonkey/2.13.1
X-OriginatorOrg: freescale.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210063>

According to the man page for git-config, the --git-all option is not
supposed to return an error code:

--get-all
	Like get, but does not fail if the number of values for the key is
	not exactly one.

IMHO, zero is also "not exactly one", but I still get a 1 exit code if the
key does not exist.

My .git/config says this:

[user "cq.branch"]
	mastr = upstream/master

git-config --get-all does this:

$ git config --get-all user.cq.branch.master
$ echo $?
1
$ git config --get-all user.cq.branch.mastr
upstream/master
$ echo $?
0

I just want git to return nothing if the key doesn't exist.  I don't want
it to return an exit code.  Is there a way to do this?  I think either the
code is broken or the documentation needs to be changed.

I'm running git version 1.7.3.4

-- 
Timur Tabi
Linux kernel developer at Freescale
