From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Tue, 21 Aug 2012 07:38:41 +0530
Message-ID: <CAMK1S_gKWYxSBi5EpBJ3JZhPnqaGD=UoozVzUAKfjBG0CycvQg@mail.gmail.com>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
	<CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
	<7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
	<CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com>
	<7v628dght9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Arthorne <arthorne.eclipse@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 04:08:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3dth-0005ge-Fu
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 04:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764Ab2HUCIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 22:08:45 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:41116 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753067Ab2HUCIn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2012 22:08:43 -0400
Received: by lagy9 with SMTP id y9so3638545lag.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 19:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=A1lp+8LkywDyAUv5ER9kweF+QztHyrOtAhBsy4tPIx8=;
        b=xAyQdDcnfdnZuJW5tGQNjZNe5rOPU43GeIYgOuc3eeUIHFY1wRfNd4TwDdZgC9gjdG
         CYgCL5/UCGIsfk75ciW9wFLzqytBTSZnEAay+qyl9+X16HbOa8FeLDfl1DBVprZaqcRR
         xuyi+YLJjko1I+94H5AZW4TaBMki6JEBhDKFi5mdmRQqfLER4OKp72sXhwhn9cWuZE6w
         9rXRBoH9rhpVABLtXzQ7+jPqP1Mnz3H66QoGdY3wR3MDp4F0DwRYFn5eqT8/PfNUBgib
         11VwiW2Vr0nCNueV6zT6tpOV+x5Nf6GKMi9HYl3NC7t3Qe9AsBMnY8F8vWt5XN+CWlZb
         horA==
Received: by 10.112.25.106 with SMTP id b10mr2480155lbg.28.1345514921858; Mon,
 20 Aug 2012 19:08:41 -0700 (PDT)
Received: by 10.112.32.4 with HTTP; Mon, 20 Aug 2012 19:08:41 -0700 (PDT)
In-Reply-To: <7v628dght9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203918>

On Tue, Aug 21, 2012 at 6:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> On Mon, Aug 20, 2012 at 10:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> John Arthorne <arthorne.eclipse@gmail.com> writes:
>>>
>>>> For all the details see this bugzilla, particularly comment #59 where we
>>>> finally narrowed this down:
>>>>
>>>> https://bugs.eclipse.org/bugs/show_bug.cgi?id=343150
>>>
>>> What does "at the system level" in your "does *not* work at the
>>> system level." exactly mean?
>>
>> "git config --system receive.denynonfastforwards true" is not honored.
>>  At all.  (And I checked there was nothing overriding it).
>>
>> "--global" does work (is honored).
>>
>> Tested on 1.7.11
>
> Thanks, and interesting.

Uggh.  My fault this one.

I had a very tight umask on root, and running 'git config --system'
created an /etc/gitconfig that was not readable by a normal user.

Running strace clued me in...

John: maybe it's as simple as that in your case too.

Junio/Brandon/Jeff: sorry for the false corroboration of John's report!
