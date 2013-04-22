From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 20:27:26 +0530
Message-ID: <CALkWK0kKWebGqQr3aNMCbKzGaWX7AMhyCrs3RiYrbgy0XyEJCw@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 22 16:58:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUIC5-0004Dc-K2
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 16:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab3DVO6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 10:58:08 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:49008 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab3DVO6H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 10:58:07 -0400
Received: by mail-ia0-f173.google.com with SMTP id j5so5477169iaf.4
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=FXgLWAkq1GiXg085yLACYQEH/zUNQPRz6D+JEVI5Qzs=;
        b=CoTZCscgRwDGgWEJqpsGOfu5QibERKDmEhpS1sAafMSYlYo3bHUSXUBciWV2QbaaVH
         NTAFYhGKmWVC5DxbXdi3l3951eCm/JCx9Q7PXtZK/9i1uFm/RuZUma/DThUPIHSXorxl
         KX4z+YtE2v5cnTRg9z5jglrPd/in3Y4+lxraOOoMcxKex0FKkv3ETB6r0CVmI+2fA32D
         p4dzshrvc3M/2NNenF0AKVpb0jbm3IfM3TWYHyQmqDN+XgdvLmpMHK2gQl6ikDQQc0Nx
         2uLthtHBmk7Hpket6z07JIbSsHhCXAr88GP/CSDYOJpTkmnJI/FspXeeuPXQVqOuvqtY
         m8LQ==
X-Received: by 10.50.50.71 with SMTP id a7mr21475700igo.14.1366642686554; Mon,
 22 Apr 2013 07:58:06 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 07:57:26 -0700 (PDT)
In-Reply-To: <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222021>

Ramkumar Ramachandra wrote:
>     $ git log README.md
>
> What do you expect?  The same output you would get if you cloned
> gh:artagnon/clayoven separately and executed 'git log README.md' on
> it.

And the reason I brought up rev-parse in the first place is because
this problem is not unique to log.  Try a 'git shortlog README.md' if
you're not convinced.  The entire revision-walking-pathspec-filtering
mechanism in the log-like-family is broken on trees that are read
into a non-/ prefix.

And no, it doesn't have anything to do with renames or "rename
detection".  If it did, 'git shortlog README.md' should atleast give
me the commit that was responsible for the rename.  And if you're
still wondering about --follow, 'git shortlog --follow' (undocumented)
is completely broken.
