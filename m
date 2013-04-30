From: John Szakmeister <john@szakmeister.net>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Tue, 30 Apr 2013 06:09:17 -0400
Message-ID: <CAEBDL5VspccUmkkYBf17soGTyT3sinjnnNzRB_kytnOr3OBVQw@mail.gmail.com>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
	<20130420140051.GB29454@ruderich.org>
	<7vd2towdiq.fsf@alter.siamese.dyndns.org>
	<CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
	<20130421102150.GJ10429@elie.Belkin>
	<CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
	<20130421160939.GA29341@elie.Belkin>
	<7vli8bu3ne.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Tapsell <johnflux@gmail.com>,
	Simon Ruderich <simon@ruderich.org>,
	Git List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 12:09:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX7Ux-0002ML-UC
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 12:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760036Ab3D3KJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 06:09:19 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:52262 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759863Ab3D3KJS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 06:09:18 -0400
Received: by mail-we0-f182.google.com with SMTP id s43so278243wey.13
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=yaVlgxGR3fYqNkM1sKGqda8j9S1cvIja4YfleiUxfco=;
        b=FHgbi+z2GA4Ruc0367pYsjb1zDMbIVLVqa6qCe9dzZybYnvfX1mdmLzeW0RHnuPUmK
         48b5Q3KduobWjG5nD8a2lusIbQasBFJWwD2cy97wDWotrdvHtT9wWTA7cy7Icj2Zmdcd
         yTltlgi8v76rA3r6CoCAcU0jkiwxPg8F/6zt8EuJZooalGf3RZ7RFJP68U6AWYOj+xxL
         EaCo7g9tNHH+5sg46BeyC+F7yDPElq7t2VB62gvi7jVsionNPYpYkxBNkPL7ev9y7xGQ
         xTVAPmFMWKsBuPao0/8+KOu+IBsW4llSszXbqpNzOXx0M8WkcWe2sXuSxGNwtffdh2iO
         +oxA==
X-Received: by 10.194.90.108 with SMTP id bv12mr84546333wjb.4.1367316557177;
 Tue, 30 Apr 2013 03:09:17 -0700 (PDT)
Received: by 10.180.108.240 with HTTP; Tue, 30 Apr 2013 03:09:17 -0700 (PDT)
In-Reply-To: <7vli8bu3ne.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: dNQzdRjRitKHtIEOZHqsYVdCYgM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222921>

On Sun, Apr 21, 2013 at 2:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> The thing is, I'm not convinced this is a bad default.  "Shows no diff
>> at all for merges" is easy for a person to understand.  It is much
>> easier to understand its limitations than -c and --cc.
>
> Making "log -p -m" a default before -c/--cc was introduced would
> have been the stupidest thing to do, as it would make the command
> mostly useless.  Nobody would want to see repetitious output from a
> merge that he would eventually get when the traversal drills down to
> individual commits on the merged side branch.
>
> When I added -c/--cc, I contemplated making -p imply --cc, but
> decided against it primarily because it is a change in traditional
> behaviour, and it is easy for users to say --cc instead of -p from
> the command line.

FWIW, security aside, I would've like to have seen that.  I find it
confusing that merge commits that introduce code don't have a diff
shown when using -p.  And I find it hard to remember --cc.  BTW,
what's the mnemonic for it?  -p => patch, --cc => ?

> On the other hand, "show" was a newer command and it was easy to
> turn its default to --cc without having to worry too much about
> existing users.
>
>> For that
>> reason, it is a much *better* default for security than --cc or -c
>> (even though I believe one of the latter would be a better default for
>> convenience).
>
> Yes.  I do not fundamentally oppose to the idea of "log -p" to imply
> "log --cc" when "-m" is not given ("log -p -m" is specifically
> declining the combined diff simplification).  It may be a usability
> improvement.

Would you consider such a patch?

-John
