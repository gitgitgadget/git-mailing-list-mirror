From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: "git diff --stat" doesn't show added empty file
Date: Mon, 12 Jan 2009 16:41:46 +0100
Message-ID: <496B64BA.7000408@drmicha.warpmail.net>
References: <46dff0320901111936h6343e51fo94750d83e95743dc@mail.gmail.com> <alpine.DEB.1.00.0901121319210.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 12 16:44:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMOwa-0001TA-9z
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 16:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbZALPlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 10:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbZALPlt
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 10:41:49 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34284 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752423AbZALPlt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 10:41:49 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 74A0620F855;
	Mon, 12 Jan 2009 10:41:47 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 12 Jan 2009 10:41:47 -0500
X-Sasl-enc: ITR+MqH6zICfIZnWGo564ZUTJuQgwhwO7Z/aektLBTN0 1231774907
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B49B4EA24;
	Mon, 12 Jan 2009 10:41:46 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <alpine.DEB.1.00.0901121319210.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105352>

Johannes Schindelin venit, vidit, dixit 01/12/09 13:19:
> Hi,
> 
> On Mon, 12 Jan 2009, Ping Yin wrote:
> 
>> $ git --version
>> git version 1.6.1.9.g97c34
>> $ mkdir test && cd test && git init && git commit --allow-empty -m
>> "Initial commit"
>> $ touch .gitignore && git add .gitignore && git commit -m "Add empty .gitignore"
>> $ git diff --stat HEAD^..
>>  0 files changed, 0 insertions(+), 0 deletions(-)
>>
>> May be the following is better?
>>
>>  .gitignore |    0 +
>>  1 files changed, 0 insertions(+), 0 deletions(-)
> 
> Have fun coding that.

Removing 5 lines from diff.c does the job, except for the " +" after 0,
but I don't know if that output is really better. Is the
addition/removal of an empty file a file change? It's certainly a change
of the containing dir, which git does not track. I don't see how to
distinguish addition from removal of an empty file at that point in the
code yet. This might be the "fun" part...

Michael
