From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 2/3] git-svn: Add --add-author-from option.
Date: Thu, 17 Apr 2008 10:24:03 +1200
Message-ID: <48067C83.4020209@vilain.net>
References: <1208307858-31039-1-git-send-email-apenwarr@gmail.com> <1208307858-31039-2-git-send-email-apenwarr@gmail.com> <7vej96v2pk.fsf@gitster.siamese.dyndns.org> <32541b130804160946s343d53d2l271b9391d89a7953@mail.gmail.com> <7v3aplsl3p.fsf@gitster.siamese.dyndns.org> <20080416192312.GF3133@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@versabanq.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 00:26:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmG3o-0008Si-1M
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 00:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbYDPWYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 18:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701AbYDPWYO
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 18:24:14 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:60065 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbYDPWYO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 18:24:14 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 56CA221CEFA; Thu, 17 Apr 2008 10:24:11 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from [192.168.69.179] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 7381021CEEE;
	Thu, 17 Apr 2008 10:24:04 +1200 (NZST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <20080416192312.GF3133@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79759>

Dmitry Potapov wrote:
> On Wed, Apr 16, 2008 at 11:36:26AM -0700, Junio C Hamano wrote:
>   
>> It makes me wonder if there is a better way.
>>
>> For example, CVS honors LOGNAME to allow you to "lie" who the author of a
>> change was, which is the behaviour inherited from RCS.  I have to wonder
>> if SVN has a similar mechanism to tell it "Excuse me, but I am just a
>> secretary recording changes for my boss."
>>     
>
> Yes, there is such a mechanism:
> ====
> Revision Property (revprop)
>
> Just as files can have properties, so can each revision in the
> repository. Some special revprops are added automatically when the
> revision is created, namely: svn:date svn:author svn:log which represent
> the commit date/time, the committer and the log message respectively.
> These properties can be edited, but they are not versioned, so any
> change is permanent and cannot be undone. 
> ====
>
> So, it is possible not only set the real author but also date/time.
> Unfortunately, there is one problem with this approach -- by default,
> these properties are disabled from modification for security reasons.
> To enable modification of these properties, the administrator is
> required to change some hooks. Personally, I have never observed any
> SVN repository where anyone was granted the right to change them. So,
> while it is possible, it is impractical.

Yes, and in fact with most shared SVN hosting services the users are 
left with no option to do this.

While there doesn't seem to be a command-line way to do this, it's 
possible that a commit "editor" making a new commit can create revision 
properties without being necessarily subject to those restrictions. 
Possible, but I guess unlikely as it would then be inconsistent.

The usual thing is to dump the extra information in the commit message. 
Some projects, like Perl, were quite systematic about this and a lot of 
useful author information is available. In fact, it was saved in the 
proposed form.

While not the main thrust of this thread, the usual convention for 
mapping svn committers to names is a project AUTHORS file. This made me 
wonder whether allowing git-svn to take its author map from the 
repository, such as from a revision property or a directory property of 
the root or project would be a good idea.

Sam
