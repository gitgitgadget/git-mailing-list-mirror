From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not send "want" lines for complete objects
Date: Fri, 21 Oct 2005 01:16:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510210114370.10503@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510200004290.7689@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmp5xfwu.fsf@assigned-by-dhcp.cox.net> <7vwtk9vvhg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510200351260.26594@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0510200559540.3394@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0510201630000.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 01:17:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESjes-00050v-Ff
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 01:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVJTXRE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 19:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbVJTXRE
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 19:17:04 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51344 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964799AbVJTXRC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 19:17:02 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A23F4DFA14; Fri, 21 Oct 2005 01:16:59 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 85FF69EF58; Fri, 21 Oct 2005 01:16:59 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7176A9EDBD; Fri, 21 Oct 2005 01:16:59 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0C6B3DFA14; Fri, 21 Oct 2005 01:16:59 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0510201630000.25300@iabervon.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10383>

Hi,

On Thu, 20 Oct 2005, Daniel Barkalow wrote:

> On Thu, 20 Oct 2005, Johannes Schindelin wrote:
> 
> > Hi,
> > 
> > > > +		    ((o = parse_object(remote)) != NULL) &&
> > > > +		    (o->flags & COMPLETE) &&
> > 
> > I just realized that parse_object() always reads the file, then does a 
> > lookup (which makes the above code work), and then parses the file. It 
> > always does all of these steps, even if the object was already parsed. Any 
> > reason for this?
> 
> I'm lazy and haven't sent in a patch to clean that up. There's no reason 
> it couldn't check whether the value it gets is already parsed.

Actually, you don't have to... Junio already replaced parse_object() by 
lookup_object() in this case. I did not use it originally, because lines 
24-25 of commit.h say

	/** Internal only **/
	struct object *lookup_object(const unsigned char *sha1);

Is this obsolete?

Ciao,
Dscho
