X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Timur Tabi <timur@freescale.com>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not
 so large)?
Date: Tue, 21 Nov 2006 17:12:21 -0600
Organization: Freescale
Message-ID: <456387D5.9080407@freescale.com>
References: <455B90AD.3060707@freescale.com> <20061117103611.183640@gmx.net> <45632957.5070205@freescale.com> <20061121163206.GA22006@spearce.org> <45632EC6.5030902@freescale.com> <20061121165656.GC22006@spearce.org> <456330CD.9080503@freescale.com> <20061121183941.GB22283@spearce.org> <45637457.1010505@freescale.com> <Pine.LNX.4.63.0611212306060.26827@wbgn013.biozentrum.uni-wuerzburg.de> <45638212.8030501@freescale.com> <Pine.LNX.4.63.0611212349440.26827@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 23:12:49 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Thomas Kolejka <Thomas.Kolejka@gmx.at>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1) Gecko/20061101 SeaMonkey/1.1b
In-Reply-To: <Pine.LNX.4.63.0611212349440.26827@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32055>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmen1-0002Tr-T2 for gcvg-git@gmane.org; Wed, 22 Nov
 2006 00:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754878AbWKUXM3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 18:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754881AbWKUXM2
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 18:12:28 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:21890 "EHLO
 de01egw01.freescale.net") by vger.kernel.org with ESMTP id S1754878AbWKUXM2
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 18:12:28 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net
 [10.208.0.31]) by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
 kAM0Y8G2015225; Tue, 21 Nov 2006 17:34:08 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
 by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id kALNCLBU021727; Tue,
 21 Nov 2006 17:12:21 -0600 (CST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 21 Nov 2006, Timur Tabi wrote:
> 
>> I think you mean git-clone.sh instead of git-clone.
> 
> No. If "git clone" does not work for you, the compilation failed. Do you 
> run git in-place? Then you _have_ to set
> 
> 	bindir=$(pwd)
> 
> in config.mak.

When I tried that, make spits out this:

GIT_VERSION = 1.4.4.ge1173-dirty
     * new build flags or prefix
(cd perl && /usr/bin/perl Makefile.PL \
         PREFIX='/home/b04825')
Writing Makefile for Git

So I tried this:

make configure
./configure --prefix=$PWD
make

and got this:

     * new build flags or prefix
(cd perl && /usr/bin/perl Makefile.PL \
         PREFIX='/temp/git')
Writing Makefile for Git

which is better, but git-clone still doesn't work:

$ ./git clone --depth 1 git://127.0.0.1/temp/u-boot-83xx
Failed to run command 'clone': Success

$ ./git-clone --depth 1 git://127.0.0.1/temp/u-boot-83xx
usage: git-fetch-pack [--all] [-q] [-v] [-k] [--thin] [--exec=upload-pack] 
[host:]directory <refs>...
fetch-pack from 'git://127.0.0.1/temp/u-boot-83xx' failed.

In both of these cases, the git-daemon process doesn't log anything.

I even tried "export GIT_DIR=$PWD", but that didn't do anything.

-- 
Timur Tabi
