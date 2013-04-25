From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/9] remote-hg: remove extra check
Date: Thu, 25 Apr 2013 23:53:04 +0530
Message-ID: <CALkWK0mrMkLBRSKk3GwjYvh+tCtXU=efeuaZC4nKGTZosVyHrQ@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com> <1366888849-19607-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 20:23:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVQph-00057r-EP
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 20:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759118Ab3DYSXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 14:23:45 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:46486 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693Ab3DYSXo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 14:23:44 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so3983149ief.35
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hkoxxpeEtI+4zeH9J0aeLt2vS8eoBMfE0taZX22CUUQ=;
        b=w4JhMv6Wd4UqDVvSBOLWRTp3V7UFcYqe+H3fy4aheQuQIvxOlFQoYEacaZs1aPefJJ
         O7aj7iR15/AnS5dsbGntB6Og4wuMLkEfZb910al+RhVJl/tlrEfKWlOV+1RMWyu2u+4+
         b2FJQx/KmSGuVr9EJduTZalcDRdNnQjQSqjGyl1qllCKoFpNpX0XwGSX24cKUSuBR6JU
         ykD7zc93Eo27rCJ/l2Pwu2jqCn/osVQSPzvOEaxOqHfwDOV+pWioyu9toPs6TYCNcnE6
         QUUt/IblU8tNmHC+NkR4f+ByO2i+ogaDV6M64plmLXqTozdhAp0KsGoXyy4NI4NqJudd
         mc1A==
X-Received: by 10.50.66.197 with SMTP id h5mr9181971igt.63.1366914224262; Thu,
 25 Apr 2013 11:23:44 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 25 Apr 2013 11:23:04 -0700 (PDT)
In-Reply-To: <1366888849-19607-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222406>

Felipe Contreras wrote:
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 5481331..0b7c81f 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -332,10 +332,6 @@ def export_ref(repo, name, kind, head):
>      ename = '%s/%s' % (kind, name)
>      tip = marks.get_tip(ename)
>
> -    # mercurial takes too much time checking this
> -    if tip and tip == head.rev():
> -        # nothing to do
> -        return
>      revs = xrange(tip, head.rev() + 1)

I'm surprised these four lines were even there in a previous revision.
 Again, you changed the meaning: if xrange() returns an empty range,
you must return, by extension.
