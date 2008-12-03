From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFCv2 1/2] gitweb: add patch view
Date: Wed, 3 Dec 2008 14:00:50 +0100
Message-ID: <200812031400.50980.jnareb@gmail.com>
References: <1228298862-28191-1-git-send-email-giuseppe.bilotta@gmail.com> <7vbpvtecb6.fsf@gitster.siamese.dyndns.org> <cb7bb73a0812030333n2cfdc745m3a910d2e8677e7fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 14:02:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7rMr-00087f-Rw
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 14:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbYLCNA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 08:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbYLCNA5
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 08:00:57 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:41212 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbYLCNA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 08:00:56 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1495477eyi.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 05:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=afiBsCCOkXVxPbv30zyZu87nh96TeoLe7GlaTd+pHbg=;
        b=QVaFf/oBTJXa0YFOnS/O21JCF0XaGliFOm/n4B9NjpYs9sRuxb8eQGJ89I13PIIsu2
         nCxLDG7DVxAALhzFCMkDlF3A6qp5hx29J+KmcGsXK6lDGNLiPR1nqHonDONVCfUY7GIT
         zNGrSYGMUjPA3H51RWqlcGNte1IZBKIAjlYsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=i2LXjR/ZwtWc1/FdzZHc+wc/Ip1CEj8zvnf8MOmSnGi5jOfpaODE0wqIT8p84sUJZQ
         W6Ym/R2jtzv0aYe7euJZpVRhCK2FkJVt11+e4KbIPE1HbVLiWL35hxMs0xA3Mb7KKWaY
         ZEp18On/10jMPMr3F+cIQ46d1+UUfMy8QEndU=
Received: by 10.210.23.3 with SMTP id 3mr5726962ebw.124.1228309254759;
        Wed, 03 Dec 2008 05:00:54 -0800 (PST)
Received: from ?192.168.1.11? (abvo179.neoplus.adsl.tpnet.pl [83.8.212.179])
        by mx.google.com with ESMTPS id b36sm8676183ika.15.2008.12.03.05.00.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 05:00:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0812030333n2cfdc745m3a910d2e8677e7fe@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102249>

On Wed, 3 Dec 2008, Giuseppe Bilotta wrote:
> On Wed, Dec 3, 2008 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>
>>> We thus create a new view that can be fed to git-am directly by exposing
>>> the output of git format-patch directly. This allows patch exchange and
>>> submission via gitweb. A hard limit (configurable, defaults to 100) is
>>> imposed on the number of commits which will be included in a patchset,
>>> to prevent DoS attacks on the server.
>>
>> Hmm, I would imagine that "snapshot" would be a much more effective way to
>> do such an attack, and notice the way we prevent it is to selectively
>> enable the feature per repository.
>>
>> Perhaps this configuration should also be a feature defined in %feature,
>> overridable by each repository?  If you default it to "disabled" (as any
>> new feature typically does), you do not have to yank a random number such
>> as 100 out of thin air.
> 
> I thought about it, but then I thought it was way too useful for
> single patches to disable the feature a priori. I'd rather make the
> default limit much smaller (like the original 16 commits I had in
> mind, or even less).

Perhaps %feature can be used to configure _maximum_ number of patches
in 'patch' / 'format_patch' view (gitweb_get_feature... well, sort of
as gitweb_check_feature would work too), rather than checking if it
is enabled or disabled?

-- 
Jakub Narebski
Poland
