From: Jason Holden <jason.k.holden@gmail.com>
Subject: Re: [PATCH] builtin-mailinfo.c: Trim only first pair of square brackets
 in subject
Date: Tue, 22 Sep 2009 20:26:36 -0400
Message-ID: <4AB96B3C.1040107@gmail.com>
References: <7vfxdkez96.fsf@alter.siamese.dyndns.org> <1246310220-16909-1-git-send-email-rleigh@debian.org> <87hbuv5km2.fsf@janet.wally> <7vocp3t0oz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Neil Roberts <bpeeluk@yahoo.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 02:50:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqG4C-0005Ce-2w
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 02:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbZIWAuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 20:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753605AbZIWAue
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 20:50:34 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:61606 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbZIWAud (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 20:50:33 -0400
Received: by qw-out-2122.google.com with SMTP id 5so103902qwd.37
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 17:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=WQ1rRmTGWTir4McQl4VztyoKrpJ/hxOR9WTmnp1XU/8=;
        b=axlXIidn1MeeMFTf1hzoX7Wc+HhT2B3mSz1mvYuKQnYwYiDqCruYgQfia3djbdSyva
         F3fBpZZE3PicS6BgK1Bo5N75efmAY/zv3DN3BQex2ZTESF3bbDJTlmXdIXZ5ygZIXiZl
         h0xyUrZs+vQE4Uiwe7dwBhpR6/jrXJQ4Tmi0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=wr6+W2qe9KvaHbHwGJPissftGzsZjum12RdnieUpicdyMNOz5WyC4zmhxKFu2f7D6L
         GZ7on87dzEGEtLyh1agC1npAQMNsnRRCirSld5Jxk8xPgoUiFV46Z34YINAKy7/yfVUx
         OrgpvjIEvLPnYKKOZIzEWs0HxDSM4q80ptV5U=
Received: by 10.224.96.88 with SMTP id g24mr1378637qan.361.1253665599682;
        Tue, 22 Sep 2009 17:26:39 -0700 (PDT)
Received: from ?192.168.1.103? (c-75-69-254-77.hsd1.nh.comcast.net [75.69.254.77])
        by mx.google.com with ESMTPS id 7sm8649qwb.14.2009.09.22.17.26.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Sep 2009 17:26:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <7vocp3t0oz.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
OpenPGP: url=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128965>

Junio C Hamano wrote:
> 
> I think we all agree that the behaviour should be improved, but I think
> neither Roger's patch nor Andreas's one was the solution..  People who
> care need to carry discussions and proposed patches forward to help us
> agree on an acceptable solution.


An additional use case for this is that at $dayjob, we use GForge
Advanced Server.  With GForge, commits are tied to the bug-tracker
by including the bug-id in the commit message with the syntax
[#NNN], where NNN is a unique id for each submitted bug.

So the typical first line of a commit message looks something like:
[#100] Fix bug in foo.c

sent using git-send-email, this becomes
[PATCH] [#100] Fix bug in foo.c

But of course, both [PATCH] and [#100] get stripped off when applied
with git-am, forcing a manual edit.

The reg-expression stuff isn't necessary for my particular use-case.
 Stripping off brackets that have any variant of "PATCH" in them, or
just stripping off the first set of brackets would work for me.

-- 
Regards,
Jason Holden
