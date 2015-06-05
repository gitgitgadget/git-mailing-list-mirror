From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] make commit --verbose work with --no-status
Date: Fri, 05 Jun 2015 09:03:10 -0700
Message-ID: <xmqqbnguta69.fsf@gitster.dls.corp.google.com>
References: <1433440591-30917-1-git-send-email-rctay89@gmail.com>
	<xmqqd21buxla.fsf@gitster.dls.corp.google.com>
	<CALUzUxqeadRii1o0-yo=QaZCqoAzGk+aVq=y1-11dJvK=em0qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:03:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0u5q-0004Hp-Q6
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 18:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422679AbbFEQDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 12:03:23 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35813 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030183AbbFEQDT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 12:03:19 -0400
Received: by iesa3 with SMTP id a3so61036258ies.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4CN1cOY7yjPTdW/bJK9hazA//IjM1AmXGPr1niM366o=;
        b=jVICqXYECPbmFaOEQlnpSHzcCuAHuMFcXHiV9mOk486OvgXe8YJYIqoxuQTEvxsNGv
         kFm/96L/LxdYtpgMJwbZiozE/ismkBlLXSqjWTkXQOd6ptceiPx0EPhYtMZ3iXCuFcnF
         o4h4lkoczBewUr6oNnsVzh26DN1JsYZ9PI8Bm8FRTmTo8j/qKUB33REuVbfEhjLziqgE
         XUI1XyKS7crcS4vkQbuLG1EZQ8dyGM0jCZOjjmofpWaorNvv5mDU1ePDR3CS6qRMYzVD
         LVsLURIg10jAdVPihGvP53DsXBqYQuY5nUbEpgHWQaRnIzNmMHSLCT1Aq8cD7/vUKsuN
         ekNw==
X-Received: by 10.43.178.195 with SMTP id ox3mr11449342icc.10.1433520198496;
        Fri, 05 Jun 2015 09:03:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8c50:e66f:fc40:1825])
        by mx.google.com with ESMTPSA id g23sm1187784iod.37.2015.06.05.09.03.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 09:03:17 -0700 (PDT)
In-Reply-To: <CALUzUxqeadRii1o0-yo=QaZCqoAzGk+aVq=y1-11dJvK=em0qw@mail.gmail.com>
	(Tay Ray Chuan's message of "Fri, 5 Jun 2015 20:40:01 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270845>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Would it be a good idea to have a --diff-only option to include diff,
> but not status output? Or perhaps a --diff option, while leaving it to
> the user to specify if status output is to be included with
> --no-status, which would open the doors for mixing and matching status
> formatting control, eg. with --short.

The name "--diff-only" does not sound right, as people would wonder
what should happen when you give "--status --diff-only".

Perhaps you would need to do some careful thinking, similar to what
we did when deciding the "diff" and "log" options.

We originally had "--patch" and then "--patch-with-stat" to "diff"
and "log", but soon after that people found that "show only stat
without the patch text" is a useful thing to do.  We retrofitted the
command line parser to take "--patch" and "--stat" as orthogonal but
inter-related options, which was a successful conversion that did
not break backward compatibility (These days people would not even
know that these strangely combined forms "--patch-with-stat" and
"--patch-with-raw" even exist).

All of the above assumes that showing only the patch and not other
hints to help situation awareness while making a commit is a useful
thing in the first place.  I am undecided on that point myself.

Thanks.
