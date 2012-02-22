From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] contrib: added git-diffall
Date: Wed, 22 Feb 2012 11:05:55 +0100
Message-ID: <4F44BE03.2000906@gmail.com>
References: <1329785969-828-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 11:06:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S095N-0006Ym-12
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 11:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134Ab2BVKGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 05:06:03 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57716 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab2BVKGB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 05:06:01 -0500
Received: by bkcjm19 with SMTP id jm19so6074100bkc.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 02:06:00 -0800 (PST)
Received-SPF: pass (google.com: domain of stefano.lattarini@gmail.com designates 10.205.124.15 as permitted sender) client-ip=10.205.124.15;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of stefano.lattarini@gmail.com designates 10.205.124.15 as permitted sender) smtp.mail=stefano.lattarini@gmail.com; dkim=pass header.i=stefano.lattarini@gmail.com
Received: from mr.google.com ([10.205.124.15])
        by 10.205.124.15 with SMTP id gm15mr15837931bkc.63.1329905160152 (num_hops = 1);
        Wed, 22 Feb 2012 02:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=GED979RbFYrB1PPvyYForjpumsBN05jRwnRCVQ9EkOM=;
        b=Vy2KyZOaIjWz9/h50jVhdR9243XIHSnrE/wj/1j/+7MX02SX0nXJPMfjzPYhu9Gav8
         bPHQp4wFc9g2UaURhF3bRPk0Ks1+As3FVrh4GfkHH4KiCZaBIWLa+iRB8lAvxzvMEr6w
         8PocObNbidR66yzp/stVJqyvk7sDARjcGEWB8=
Received: by 10.205.124.15 with SMTP id gm15mr12766843bkc.63.1329905160081;
        Wed, 22 Feb 2012 02:06:00 -0800 (PST)
Received: from [87.4.94.32] (host32-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.32])
        by mx.google.com with ESMTPS id w15sm50651576bku.0.2012.02.22.02.05.57
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 02:05:58 -0800 (PST)
In-Reply-To: <1329785969-828-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191243>

On 02/21/2012 01:59 AM, Tim Henigan wrote:
> test -z $(which mktemp 2>/dev/null)
>
This is wrong: if mktemp is not avilable, the expression above will
become, after command substitution and word splitting have taken pace,
equivalent to:

  test -z

which, per POSIX, must return 0 (and does with at least bash 4.1.5 and
dash 0.5.5.1).  You should just use this instead:

  which mktemp 2>/dev/null

OK, technically you could also fix your idiom above a little and use:

  test -z "$(which mktemp 2>/dev/null)"

but seems like a useless use of indirections to me.

And all of this is naturally render moot by Junio's advice of not using
which(1) in the first place ;-)

Regards,
  Stefano
