From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: Wrong error message when access to .git directory denied
Date: Fri, 29 May 2015 08:29:54 -0700
Message-ID: <xmqq1thzfll9.fsf@gitster.dls.corp.google.com>
References: <20150529104743.6220a11f@outerspace.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jonas Berlin <xkr47@outerspace.dyndns.org>
X-From: git-owner@vger.kernel.org Fri May 29 17:30:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyMEZ-0000WA-E5
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 17:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763AbbE2P37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 11:29:59 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33677 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756490AbbE2P34 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 11:29:56 -0400
Received: by igbpi8 with SMTP id pi8so17468392igb.0
        for <git@vger.kernel.org>; Fri, 29 May 2015 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0tZswr/ZWF13nXWP4OG9+FIaUcdYoNauj+06jbW2wzs=;
        b=Ct5/3XfUngf39zqohSkW6x+yvskdA/zDu4nJDcboU1+2PkMzq2vz+XKy015OKKJ0TK
         qtQ32JJ1LVckMnBm4s1nhbFCqWI+5A73461c4J/RpXeKS4Winb++mYEC+Bb7OmeIsilc
         WqCGkFHUF3VtjVCE90h7laC3wfNWL77H86QfgN1bMa6iKMin3Tw/CPbgHPq6U/OzDzRW
         etW2CjhZ2pP6go52d7V1GZ4YBBbNQ04HxB+mirNf//1xqgRRV/+VfBNLU2ZQZJlJu7hj
         Lbd1rKgHXY+K/QZjuxsrYOAL94Koklm6Mc7tQrTBghXrTv4yAlBc/Bjhn3C8giuKFHNi
         HIrw==
X-Received: by 10.43.169.137 with SMTP id nm9mr15267520icc.82.1432913396054;
        Fri, 29 May 2015 08:29:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id r34sm4387386ioi.34.2015.05.29.08.29.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 08:29:55 -0700 (PDT)
In-Reply-To: <20150529104743.6220a11f@outerspace.dyndns.org> (Jonas Berlin's
	message of "Fri, 29 May 2015 10:47:43 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270243>

Jonas Berlin <xkr47@outerspace.dyndns.org> writes:

> Severity: Low
> Impact: Confusion

;-)

> Git version: 1.9.1
>
> If I don't have permissions to access the .git folder of a non-bare
> git repository, I get the following output:
>
>   fatal: Not a git repository (or any of the parent directories): .git
>
> Expected output:
>
>   fatal: Permission denied while accessing .git directory

But the thing is, .git being unreadable simply means we do not know
if it is a .git directory, or a random directory that does not have
anything to do with Git that happens to have that name.

So "Not a git repository" is the best Git can say.
