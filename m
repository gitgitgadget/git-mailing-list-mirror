From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Wed, 18 Jun 2008 00:28:03 +0200
Message-ID: <48583A73.7020508@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com> <7vy75580p1.fsf@gitster.siamese.dyndns.org> <4857C469.1000401@gmail.com> <200806171633.26864.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 00:29:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8jfn-0004W3-9Q
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 00:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758365AbYFQW2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 18:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758036AbYFQW2L
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 18:28:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:31309 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758010AbYFQW2K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 18:28:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3685476fgg.17
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=o5xeij0EVaEagzSPqDSVjbK5UxaLhtKQG15tNHL9Uc0=;
        b=eQRkHDRhHFKMpTn/qZvWJXL9hrP1aqC4EBNoU6eMwKd2jvi9ZN1+Dk6pmoYR45gU7l
         z1T0qkySyvO4oh/nMlC7BJVKCSdi2QMtOahNkkY077U/SUjNHlCF7XfoAAEm9JmtOG3L
         86UuVizld+ung0h+Y+h6z/BPoaAxPXbSSoTw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=gosIlhRznn6OfyLcZtiWryzUu6mHamJYTtoJ3XaWJv5luGxKcQKvHvcwa36hjZGJ7F
         xqhjOmtYppPWh9+q6Z0W3RumfiLPwdIUMY1xTDVWAnJEhZWdnSu3jxjYpETTupFO9BRz
         C+ND2EIuP8eYzCcXoCfWOTflO+J2XyLvT7amA=
Received: by 10.78.159.5 with SMTP id h5mr3349933hue.35.1213741686043;
        Tue, 17 Jun 2008 15:28:06 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.241.48])
        by mx.google.com with ESMTPS id 33sm11535654hue.28.2008.06.17.15.28.03
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 15:28:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200806171633.26864.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85335>

Jakub Narebski wrote:
> But that means checking arguments in the "fast path", which means
> additional calls to git commands in the _common_ case, not only in
> the case of errors.

No, it doesn't, it just pipes stuff into cat-file --batch-check, which 
has to be opened on virtually any call to gitweb.  Before telling me 
about the performance of my code, can you please (a) read it and (b) 
benchmark it?  We lose a lot of time on pointless discussion otherwise.

> I'll try to come with example implementation using Error.pm and Git.pm

I don't think it's worth the time; I think I understand your point 
without an example implementation. :)

Unrelatedly, I thought we had agreement not to use Error.pm as of 
<http://thread.gmane.org/gmane.comp.version-control.git/83267/focus=83348> 
(though Git.pm still does use Error.pm, so it can still be used as long 
as there's no patch that removes all instances of it).  I got *really* 
weird unreproduceable errors when throwing exceptions with Error.pm in 
gitweb, and I suspect that Error.pm (perhaps in interaction with some 
other module) was to blame.  Just a warning. ;-)

-- Lea
