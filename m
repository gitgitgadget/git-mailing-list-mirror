From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 3/3] git-submodule: add "sync" command
Date: Sun, 24 Aug 2008 17:29:48 -0400
Message-ID: <48B1D2CC.7000200@gmail.com>
References: <1219598500-8334-1-git-send-email-davvid@gmail.com> <e21617f50ffaae98ab73fa364e40440397bcbe33.1219598198.git.davvid@gmail.com> <341166c1e31ba26c4e8e48cd7cf9ce12a9f745b9.1219598198.git.davvid@gmail.com> <23327a679798d19dc52a27c55a58c5b8c9ebe945.1219598198.git.davvid@gmail.com> <7vwsi6meas.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 23:30:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXNAm-0000sE-Qq
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 23:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbYHXV3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 17:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbYHXV3w
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 17:29:52 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:32822 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbYHXV3w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 17:29:52 -0400
Received: by an-out-0708.google.com with SMTP id d40so188582and.103
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=y8MLr58B41yhJeJ02uNvENjTPjOKMNy8h+1PFpoZCFY=;
        b=hSNlfBbE/y3WVVQPgRO5KyXYQrQIhIs4Mg22x++bjFThxddOw0wIghmH494091RhHO
         INdA4wTQ9P9R3hLsHOJBUo+1aeJ8ObJsQQWtK22ft0T4vp+PXVxPiZG0/cYfNZytk5Lp
         99DlcBDWmA7NuFDAqwddsIp0Nl7oOZkhIk0OM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=SP53OvHkML0momJP3sYWUFl7xSyea0KNd70zo39dbkqHkGCzBMEdtsACINi7sKWO1q
         xEXq6J/eSp/J8TBrM8u0OETi+YTfBBDQG03fEGh4WmtfpWJsu77hCOll0G0V3rK1iY7r
         jSASCloyVeI0Ez5nrAe1jdKdrVVqYF4AJmroo=
Received: by 10.100.144.11 with SMTP id r11mr3253473and.52.1219613391058;
        Sun, 24 Aug 2008 14:29:51 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.163.41.46])
        by mx.google.com with ESMTPS id c23sm5794178ana.18.2008.08.24.14.29.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 14:29:50 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <7vwsi6meas.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93567>

Junio C Hamano wrote:
> I am not sure about the way you determine $remote.  When the HEAD in the
> submodule repository is detached by prior "git submodule update", this
> will fall back to the default "origin" --- is it a good behaviour?
>
> This is not an objection; I am merely wondering if that fallback is
> sensible, or if people who are interested in submodules can suggest better
> alternatives.
>
>   
I think it makes sense to split submodules into two categories, name 
them what you will, but the discernible difference is whether they are 
defined using relative or absolute urls.

1) relative url - this should *always* fetch / pull from a url relative 
to the superproject's url. Overriding not possible (except by recording 
an absolute url). The idea is these submodules are closely related to 
the superproject, and the use of a relative url is a positive 
declaration that "I will maintain this 'forest' of git trees as a unit".
2) absolute url - use .gitmodules entry as the initial hint, allow 
overrides in .git/config, such a submodule is maintained separately.

If we could reach some such agreement as above, we might begin to make 
some progress on what role the porcelain has in maintaining a 'forest' 
of git projects as a superproject and submodules.

Mark
