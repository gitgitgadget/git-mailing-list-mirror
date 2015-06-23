From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 1/3] git-rebase -i: add command "drop" to remove a commit
Date: Tue, 23 Jun 2015 13:39:14 -0700
Message-ID: <xmqqa8vqcg7h.fsf@gitster.dls.corp.google.com>
References: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<CAPig+cT+idnGkR0V-UfwbHwvjd_U=zbjHx+so7Jz+4o1XU5eHw@mail.gmail.com>
	<1637608183.731706.1435086079947.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpq1th2p7ka.fsf@anie.imag.fr>
	<392249968.731834.1435087097209.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpq8ubamaz0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 23 22:39:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7UyY-0005mj-2Y
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933316AbbFWUjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:39:17 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35786 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932909AbbFWUjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 16:39:16 -0400
Received: by iebrt9 with SMTP id rt9so20087275ieb.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 13:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NgIkJYQYrONnmIk+FmYhGzlRYACj/VXDzPbkx0zXLLU=;
        b=O4VsgjAaKLnxRmPfrIPlwMLKB4zcBLHNwNVrt+0lhDvCv5AO4RbAeOoDmt541PitKk
         RvkA1QPV/kfKt9vzholj1hqWT7wOKY8nla04IVia0fGXUn4KPf/xwUvMcLT8yeX7cWIe
         q0C7aRkezgFWvgYZ9mtTMM6q8b85w5cR0bk9lwlNHcnr4tmKbyGIUoZeYdiUw73w3TSE
         EhliPqwvss1ZeaicDOAymqhhpC5kULhkybHk+8XsAF70q8djbfuAsG7eK9P/iVEoheS/
         RX0ivwOPzt0MrP++rGDVfjj3i3QkV6i7BzX4QEJawr7Wzu3HQSqVBfipiwrRR+LcxR67
         NKEg==
X-Received: by 10.42.197.5 with SMTP id ei5mr18206267icb.80.1435091956444;
        Tue, 23 Jun 2015 13:39:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3c90:65f7:f86b:dfda])
        by mx.google.com with ESMTPSA id e10sm490606igy.11.2015.06.23.13.39.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 13:39:15 -0700 (PDT)
In-Reply-To: <vpq8ubamaz0.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	23 Jun 2015 22:22:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272509>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:
>
>> I think that the indentation on its own is enough to avoid confusion
>>> test_rebase_end () {
>>> 	test_when_finished "git checkout master &&
>>> 		git branch -D $1 &&
>>> 		test_might_fail git rebase --abort" &&
>>> 	git checkout -b $1 master
>>> }
>> but your idea is fine as well, so I'm ok with either way.
>
> Read too quickly, it looks like a mis-indentation (I could laugh at Eric
> here, but I made the same confusion when reading the code at first). By
> "avoid the confusion" I mean "make it clear it's not a mis-indentation".

Yes, that stray " fooled me as well.  If it were following your
suggestion in the earlier message on this thread, i.e.

	test_when_finished "
		... &&
		...
	" &&
	git checkout

I wouldn't have to waste time commenting on it ;-)
