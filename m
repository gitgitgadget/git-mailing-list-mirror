From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 5 Apr 2013 01:22:45 +0530
Message-ID: <CALkWK0mMQJfJ7M=NGJdEs3np3Y32DwKUMVEYJf7xh+X6toWwNg@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
 <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
 <CALkWK0mQt7cE0zUECDF4ZC2-9Q+pEL=XGPdaOksyWzae2_W1CA@mail.gmail.com> <CA+55aFw+2wgUufJn7BcXACBQqywAGBAcZWS6N_UV8UA91G447Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:53:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqEN-0005sK-T0
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764767Ab3DDTx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:53:27 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:57646 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764763Ab3DDTx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:53:26 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so2556815iak.4
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6agmOb6Z3ypRttJib6UMsH2Epc78rgQekuND+Zyg5WM=;
        b=yOCgoctgiA2bYAJYUa3Yy3Us8Ai64ESzoxfGrfqgmuhpJBZkDypVZ/OvxdI6IQVSiM
         aUjMik9E2xmnG5iNwYx222ha/2rb75x+Rg9eg1fab+t15QzYsDcHtG6axNFhifWcvZmQ
         fFfN4+X9wf4eDYF+It8SDbG9ikLa/yoLE2+cQTG8PESyknkaLUC6uw8U7b1JtFVDsfV6
         aV8EMJ2eV/H6vP2wqDjjmLPXtFN5UYosAATpZ/+pf23mnKfQoFa1rGjNlpxuRSsBGVB8
         B2ded+6BLgcO3U9S7HW6Hn3bXCn3NMyANiajfx9dJcHZNFrkSPyKEW3WL+RvwIa3Qwl9
         DISg==
X-Received: by 10.50.108.235 with SMTP id hn11mr4418947igb.107.1365105206101;
 Thu, 04 Apr 2013 12:53:26 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 4 Apr 2013 12:52:45 -0700 (PDT)
In-Reply-To: <CA+55aFw+2wgUufJn7BcXACBQqywAGBAcZWS6N_UV8UA91G447Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220081>

Linus Torvalds wrote:
> On Thu, Apr 4, 2013 at 12:36 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>>
>> Let's compare the two alternatives: .gitmodules versus link object.
>> If I want my fork of .gitmodules, I create a commit on top.
>
> Or you could also just edit and carry a dirty .gitmodules around for
> your personal use-case.

Just take the link's buffer with you everywhere.  All you have to do
is git edit-link <name> and paste the file's contents there, instead
of opening .gitmodules directly in your editor.

> And I don't see what you can do with the link objects that you cannot
> do with .gitmodules. That's what it really boils down to. .gitmodules
> do actually work. Your extensions would work with them too.

If it came to that, you could write a huge Perl script to solve
everything with a .githack.  It breaks the internal symmetry of the
repository, which is why git-submodule is having such a field day.
I'm trying to prove, in my series, that making fundamental changes
lets us get rid of a huge amount of complexity.
