From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] 2.5.0 build with NO_PERL is broken
Date: Fri, 14 Aug 2015 12:59:29 -0700
Message-ID: <xmqq7foxiqu6.fsf@gitster.dls.corp.google.com>
References: <loom.20150814T171757-901@post.gmane.org>
	<loom.20150814T184447-932@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Renato Botelho <garga@FreeBSD.org>
X-From: git-owner@vger.kernel.org Fri Aug 14 21:59:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQL8a-0002In-3o
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 21:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbbHNT7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 15:59:32 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32972 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbbHNT7b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 15:59:31 -0400
Received: by pabyb7 with SMTP id yb7so65842808pab.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZYGKWSi8uI6KfDRGLAi81e+5eFscXA8IL8GVGQvGTIg=;
        b=hnsH/w9OJGDWq9CpNmksgYDrM73fFoY6ThobRcfIpqrJj+pn3cmoLQUoKdmOiDZE21
         O+FvAbjjRibSOwwyTwIZ36QPLlxlUElnqmx37jJU3XQ8PlU1OsIB5zMh1Ejf8J9RMw/7
         HbdSUWwFis2rhh31rpPxE9HMFnwm1Vz8VZMK4vUpX3jg5P8M9fp3HDK6Nb035h/cvRQA
         1Il13dOH4Fq//HEfemEzMj0Vr/pcI5Q7M09tdU3hepl9UGAVWf4KaXCNycMoqM5i8XGx
         QiAW1MEq+eHE1rop5D1lCr7xylYT1dzUfZI+pLjh2X4upxy3CGsjMVtycOeMrvRUtdU+
         RCvQ==
X-Received: by 10.66.121.233 with SMTP id ln9mr90171867pab.142.1439582370521;
        Fri, 14 Aug 2015 12:59:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id x11sm6984384pas.46.2015.08.14.12.59.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 12:59:30 -0700 (PDT)
In-Reply-To: <loom.20150814T184447-932@post.gmane.org> (Renato Botelho's
	message of "Fri, 14 Aug 2015 16:46:18 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275933>

Renato Botelho <garga@FreeBSD.org> writes:

> I also found that some commands require perl when NO_PERL is set:
>
> git-submodule
> git-request-pull
> git-am
>
> Definitely NO_PERL is not working as expected.

NO_PERL merely means "I want to build a subset of Git that is meant
to be usable on a system without a working Perl installed".  These
scripts that do require Perl installed are indeed not expected to
work under NO_PERL (if you think about it, that would be natural and
the only sensible expectation---otherwise we would have coded them
without using Perl at all, in which case there will be no need for
NO_PERL in the first place).
