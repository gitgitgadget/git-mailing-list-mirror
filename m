From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why aren't tag refs namespaced?
Date: Thu, 26 Apr 2012 12:24:22 -0700
Message-ID: <xmqqty068ffd.fsf@junio.mtv.corp.google.com>
References: <CA+7g9Jxc6eaCUR8aVhqKH--sOrvQVrZn+se7wtFJsOiKNjz9Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Thu Apr 26 21:24:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNUIo-0005DA-Uh
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 21:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493Ab2DZTY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 15:24:26 -0400
Received: from mail-ey0-f202.google.com ([209.85.215.202]:63588 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab2DZTYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 15:24:25 -0400
Received: by eaaq10 with SMTP id q10so74971eaa.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 12:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=0MY6dqeYZ1GnQHNw4go0OiOJ38de5TBrs288iXDAQK4=;
        b=TrLtMZlbI4q5ilUHb6ReGEigcWREkYQfq3V+Hb7t9N8NGbcCnXKSmWQ6Y32dSxupnM
         y6FnvSQyrfyyzwLVAdRLnp/Y+b4578BkGP9COG+86QHhvTnq+ZC8WJ0Kj/siiy3+jCap
         FpdRqYL52VvwgWJUEKIA86lpAe3g1g+zwpKKdWEdHtG6I9vlPhAS8Yp8Uw40s8bpJVoQ
         0D2q1oA0/tRLspFRrT8PdGJyMWJQysHeK8iNe+P8aNE6D4G29TP1Q/uHltR+5DS6zagv
         f0U7Qobn+lFXf8DGbsRhGmC75yQSo41+44IhadJEE2HFQAOY9BkJQkHuQ04OqZKOjb6F
         ZRpA==
Received: by 10.14.29.2 with SMTP id h2mr2418121eea.5.1335468263879;
        Thu, 26 Apr 2012 12:24:23 -0700 (PDT)
Received: by 10.14.29.2 with SMTP id h2mr2418108eea.5.1335468263756;
        Thu, 26 Apr 2012 12:24:23 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si3697005eef.1.2012.04.26.12.24.23
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 26 Apr 2012 12:24:23 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 8D56D20004E;
	Thu, 26 Apr 2012 12:24:23 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id DDC61E125C; Thu, 26 Apr 2012 12:24:22 -0700 (PDT)
In-Reply-To: <CA+7g9Jxc6eaCUR8aVhqKH--sOrvQVrZn+se7wtFJsOiKNjz9Pg@mail.gmail.com>
	(Nathan Gray's message of "Thu, 26 Apr 2012 11:40:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlE2E+I86vrQYlAA2YbmTw2ID8Uy+vDEloUz23db7Ba9pi5NYwrUTTpxgaOSoC+8LwrHWMPaWQjoUBeHrvQ5wVaklaRy9XHqjWFIbV5SDMKV8m0Zl2Vtblc4dZYwJzP8+TN36mqOKwwySaxVlHYMmWV1oXQRT3vTL8bYtvn3LUdVkmmp4w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196395>

Nathan Gray <n8gray@n8gray.org> writes:

> So why is it that tag refs don't follow this model?

Because the assumed development model for "people work inside their
private world (i.e. "branch"), but integration happens in common
namespace (i.e. somebody eventually pushes to "master branch" of the
repository that every project participant considers authoritative) and
the end product of the project is tagged there for everybody's
consumption.  When something is called "version 1.0", it only invites
confusion if _my_ Git version 1.0 is different from _your_ Git version
1.0, and it makes no sense for tags used in this manner not to be in a
global single namespace.  People need to qualify such "version 1.0" as
"Junio's version 1.0" vs "Nathan's version 1.0" if they want to avoid
confusion anyway, and at that point you would not be talking about
refs/tags/v1.0, but refs/tags/jc/v1.0 vs refs/tags/ng/v1.0 or something.

Other workflows that use private tags are possible and they might
benefit from having separate namespaces; it is just that they are not
the workflow Git was originally designed to support.
