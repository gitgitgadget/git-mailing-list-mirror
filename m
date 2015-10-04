From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/9] ref-filter: add support for %(path) atom
Date: Sun, 04 Oct 2015 11:44:25 -0700
Message-ID: <xmqq1tda1njq.fsf@gitster.mtv.corp.google.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-4-git-send-email-Karthik.188@gmail.com>
	<vpqwpv49so7.fsf@grenoble-inp.fr>
	<CAOLa=ZSdM34_J+gb_=K4-9fgNsMfseAYxUYGm_ncWZstcW+SYw@mail.gmail.com>
	<vpqfv1q5xop.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 04 20:45:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZioHL-0008QJ-5J
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 20:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbbJDSo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 14:44:28 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36171 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbbJDSo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 14:44:27 -0400
Received: by pablk4 with SMTP id lk4so152946768pab.3
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Cme/oGumV+aTllVScp33lpauj0CKFrQ4CGVpO+MOu6U=;
        b=iP3K4i7jmoHGuPIE8zso8fPQovJT/yYYQVMefrOPUv1sSFfCuao36HoIY9p23le2qb
         igy0wzalrdnSiKVcA18o8+S98jIxiggA0pNtXt+1tiqw9S/3eACh/YJBVbEjTeEJ5zHz
         QDdpfb1FGplBK2G5gAqmLddVncX3uxNvBq32FINiDIMd0G22rxqg5k4++xqOkJfV+zqN
         v7D2iseyD77ZgivvgytaqMfcceGnDaf++t190e+MZDs27jdt4i/jeg+K5Ecvjg32tqCQ
         A/LN67MADSsI5XxqOIM+uo3LISfUudGTZxh27uRJh+r1cV/jRmDPHFVOArFw1vwXk2Pt
         JwuA==
X-Received: by 10.68.171.37 with SMTP id ar5mr35523274pbc.39.1443984266921;
        Sun, 04 Oct 2015 11:44:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:cd5:dd7c:35c8:15e])
        by smtp.gmail.com with ESMTPSA id i9sm23145496pbq.84.2015.10.04.11.44.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 04 Oct 2015 11:44:26 -0700 (PDT)
In-Reply-To: <vpqfv1q5xop.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Sun, 04 Oct 2015 19:51:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279020>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>>> This adds %(path) and %(path:short) atoms. The %(path) atom will print
>>>> the path of the given ref, while %(path:short) will only print the
>>>> subdirectory of the given ref.
>>>
>>> What does "path" mean in this context? How is it different from
>>> %(refname)?
>>>
>>> I found the answer below, but I could not guess from the doc and commit
>>> message. Actually, I'm not sure %(path) is the right name. If you want
>>> the "file/directory" analogy, then %(dirname) would be better.
>>>
>>
>> Noted will change.
>
> Note: I don't completely like %(dirname) either. I'm convinced it's
> better than %(path), but there may be a better option.

Is that a derived form of the refname, just like %(refname:short)
that is 'master' for a ref whose %(refname) is 'refs/heads/master'
is a derived form of %(refname), and ":short" is what tells the
formatting machinery what kind of derivation is desired?

If so would %(refname:dir) & %(refname:base) be more in line with
the overall structure?
