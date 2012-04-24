From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a way to fetch commits that are detached
Date: Tue, 24 Apr 2012 15:15:48 -0700
Message-ID: <xmqq62cog4iz.fsf@junio.mtv.corp.google.com>
References: <CA+jCPNcmcxQcSN_BNvigQa2uRiaw-c2PK5T-y1yacYNs6Ws4WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:16:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMo1b-0004zl-PB
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757995Ab2DXWPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:15:50 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:62838 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757146Ab2DXWPt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:15:49 -0400
Received: by qcsp5 with SMTP id p5so142258qcs.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 15:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=Fd376JqdYL25z1rPElnWR6J3HrJrhr9JpKcZsU2B31Q=;
        b=QR1VQ64pDGKnter9rmFjVMftxpJpHa547/6SkchTSJRJBsrhg3kUPjLO50aOvjw+zD
         KFL6OVD8GJDByVrK5BbEOe4XVN+PYQiOslsjRH0i2EhFByD3I5kZzAWPTSooKAku7Dt1
         NDB/9UdH23peeuK3Us9EeGBC0wHfQpEyBzxcLu5tYQWxVqilrJYvN5+tSbNb17PKWXNA
         dCmbqXPSoxEY0OCRX5fNzbAIenGH5lBUPa3p1jcSwBRUh0nv+s7bz7HM8yVNCbr01W6K
         l7MGgAL7FC7TqXpwwSneYUBAt3wDZpL92mKIt0ucryjB6UN1iuwOj9kNeYPhDTUPqmg8
         mVTw==
Received: by 10.101.176.19 with SMTP id d19mr102406anp.20.1335305749050;
        Tue, 24 Apr 2012 15:15:49 -0700 (PDT)
Received: by 10.101.176.19 with SMTP id d19mr102393anp.20.1335305748929;
        Tue, 24 Apr 2012 15:15:48 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i36si2928453anp.0.2012.04.24.15.15.48
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 24 Apr 2012 15:15:48 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id CD4811E004D;
	Tue, 24 Apr 2012 15:15:48 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 75588E125C; Tue, 24 Apr 2012 15:15:48 -0700 (PDT)
In-Reply-To: <CA+jCPNcmcxQcSN_BNvigQa2uRiaw-c2PK5T-y1yacYNs6Ws4WA@mail.gmail.com>
	(Allan Caffee's message of "Tue, 24 Apr 2012 14:49:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmYHAxvlokz6674Aw9+Dt2XxhaQbhUHt1F83nbK35XWaGNVF6i0GTdntratX3tiJVs14xnIjJdCAhJCONs8sGdGKiHazPJlFY/9LfoZ5hBW7d8WmKvEyNVXm4TFWz4hcU0csU1t+AkhT0v93WYFIttUPy4907xpdec1Xm0E4QeJTJGeVMs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196256>

Allan Caffee <allan.caffee@gmail.com> writes:

> Is there a way to explicitly fetch whatever objects are necessary to checkout
> the commit?

One security principle built into git is that any object that is
unreachable from refs/* is not to be exposed to outside world.  If the
commit is not on any ref, you shouldn't be able to obtain it remotely.

So you need to know which branch (or it could be a tag) the commit you
want is on, fetch that branch or tag and then check the commit out.
