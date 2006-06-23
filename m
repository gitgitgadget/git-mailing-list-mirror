From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Rework diff options
Date: Sat, 24 Jun 2006 01:18:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606240111590.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060624011538.9bb179e7.tihirvon@gmail.com>
 <Pine.LNX.4.63.0606240024460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060624014420.2c3df276.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 01:18:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftuuh-0003v7-No
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 01:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbWFWXSI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 19:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbWFWXSI
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 19:18:08 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:31956 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1752170AbWFWXSH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 19:18:07 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 7C8552AAB;
	Sat, 24 Jun 2006 01:18:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 700E02AF0;
	Sat, 24 Jun 2006 01:18:06 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 4A34B23DB;
	Sat, 24 Jun 2006 01:18:06 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060624014420.2c3df276.tihirvon@gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22454>

Hi,

On Sat, 24 Jun 2006, Timo Hirvonen wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > Although I understand that to convert all users to the new convention, it 
> > is sensible to rename the constants, I think it is not good to change 
> > something as DIFF_FORMAT_RAW to OUTPUT_FMT_RAW in the resulting patch.

Note that I understand this for the purpose of not forgetting to change 
things over to "|=" and "&": the compiler will warn you about that now.

But after it compiles, you can change the names back to reduce patch size 
and to avoid confusing of dumb people like me.

> > IMHO it is an unnecessary change, and accounts for a lot of the diffstat.
> 
> I did it because you can't have many DIFF_FORMAT_* options at the same
> time but OUTPUT_FMT_* can be combined.

But you just renamed them! The name alone does not say "you cannot combine 
them".

-- snip --
@@ -150,15 +162,6 @@ #define COMMON_DIFF_OPTIONS_HELP \
 "                show all files diff when -S is used and hit is found.\n"
 
 extern int diff_queue_is_empty(void);
-
-#define DIFF_FORMAT_RAW                1
-#define DIFF_FORMAT_PATCH      2
-#define DIFF_FORMAT_NO_OUTPUT  3
-#define DIFF_FORMAT_NAME       4
-#define DIFF_FORMAT_NAME_STATUS        5
-#define DIFF_FORMAT_DIFFSTAT   6
-#define DIFF_FORMAT_CHECKDIFF  7
-
-- snap --

You also sneak in some other things, such as renaming output_format to 
output_fmt in struct diff_options, making a function static, and expanding 
a "(a ? b : c)", without accounting for it in the commit message.

Ciao,
Dscho
