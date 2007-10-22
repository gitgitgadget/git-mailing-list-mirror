From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: .gittattributes handling has deficiencies
Date: Mon, 22 Oct 2007 15:04:41 +0200
Message-ID: <A524F676-BFFD-4AA7-8683-9623F12D2F2D@zib.de>
References: <1192956535617-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0710210204580.4818@asgard> <20071022050111.GL14735@spearce.org> <565E1D52-59C4-4EB8-AA81-FF94F346FE61@zib.de> <Pine.LNX.4.64.0710221125350.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, david@lang.hm,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 15:06:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijwxx-00078f-3k
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 15:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbXJVNE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 09:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbXJVNE4
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 09:04:56 -0400
Received: from mailer.zib.de ([130.73.108.11]:52752 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126AbXJVNE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 09:04:56 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9MD3DND025552;
	Mon, 22 Oct 2007 15:04:44 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9MD3C6W021044
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 22 Oct 2007 15:03:12 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710221125350.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61999>


On Oct 22, 2007, at 12:29 PM, Johannes Schindelin wrote:

>
> On Mon, 22 Oct 2007, Steffen Prohaska wrote:
>
>> .gitattributes is first looked for in the working directory, and  
>> if not
>> there, .gitattributes is read from the index.
>
> Of course we could change that to do it the other way round.  But this
> would contradict expectations when you edit .gitattributes and then
> checkout single files without having git-add'ed .gitattributes first.
>
> The biggest problem in your setup, however, is not  
> if .gitattributes is
> read from the index or the working directory.  The biggest problem  
> is that
> files are not touched when their contents have not changed.
>
> IOW if you have .gitattributes in the to-be-checked-out branch  
> which say
> that README is crlf, and in the current branch it is not, and README's
> _contents_ are identical in both branches, a "git checkout
> <that-other-branch>" will not rewrite README, and consequently not  
> change
> the working copy to crlf.

Exactly. The order of reading .gitattributes from the working
directory or the index doesn't matter. The current mechanism
has a more fundamental deficiency.

Changes of.gitattributes can influence how the same content
is checked out to the work tree. If .gitattributes change the
checkout may need to be updated, even if the real content did
not change.

	Steffen
