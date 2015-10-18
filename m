From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Mon, 19 Oct 2015 00:37:05 +0530
Message-ID: <CAOLa=ZQ5dCx4XheMvaFo1u-fR=uaR-LU-n7KHR3xNJ7TuF-zww@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <vpqr3l5zgst.fsf@grenoble-inp.fr> <CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
 <vpq8u7dp9qr.fsf@grenoble-inp.fr> <CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
 <xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com> <vpqpp0ojvs6.fsf@grenoble-inp.fr>
 <xmqqfv1jq4jy.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQkjMFXVeJ==myQLjyRs6EcejnYnszYKJLyskFufjeqiA@mail.gmail.com>
 <xmqqbnc4ord4.fsf@gitster.mtv.corp.google.com> <CAOLa=ZT5AUAOgHNhX3AwpY20AZkm39=-JVQjUCgb0_x6LTHXaA@mail.gmail.com>
 <vpq7fms9cjs.fsf@grenoble-inp.fr> <xmqq37xfncak.fsf@gitster.mtv.corp.google.com>
 <vpq612bzz0o.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 18 21:07:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZntJ6-00068O-JD
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 21:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbbJRTHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 15:07:36 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:32793 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbbJRTHf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 15:07:35 -0400
Received: by vkaw128 with SMTP id w128so93392968vka.0
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 12:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TZTG9/HwVzgF4MTI/7NlVVYqUsxLvt/pDQe7Ukd1Yho=;
        b=oJd7wqDpyKQMwuQtf3aS25lVf4ZPgXoJY2DBwrr631kYGS+aSPOuy4vupDDLx3G84t
         YZpWF99lhVY5biHVAB0ZsmkPN9qbpC6o07+xE6jmUs1PLi0juuDs+mVE7ePMsq6qxSSu
         r0t+VPCRIVz2Qabi1cT9lIu3B1/vU0Da1k4f7Kxl5SxdyK3+l8gkgVjn/JN/8qZTcoGK
         i/ZId7FJaFRNvGV8vyKGXdf1LMqPnU5YcCOQL2/reb1E5OyBcDp0tLWZTwkMET4HJToD
         elgG8WWuLE6WARuoJZpAkWiugxhv9DFwWSGc29PpaJUUgOUGPGEhwMoteMR1OFJuY693
         YdZg==
X-Received: by 10.31.49.10 with SMTP id x10mr17769535vkx.46.1445195254918;
 Sun, 18 Oct 2015 12:07:34 -0700 (PDT)
Received: by 10.103.0.7 with HTTP; Sun, 18 Oct 2015 12:07:05 -0700 (PDT)
In-Reply-To: <vpq612bzz0o.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279821>

On Tue, Oct 13, 2015 at 12:37 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> If you design a new infrastructure to help refactoring early
>> (i.e. before adding many copies of code that need to be cleaned up
>> later), it would make the work of reviewing of the design of the
>> helper and refactoring using that helper smaller, not larger.
>
> But most of the code concerned is already reviewed. The first instances
> of the pattern to refactor is already in next. With a real time machine,
> we could go back in past, refactor and then have cleaner series, but
> with Git as our only tool we can't ;-).
>
> The current series will just add one more instance of sub-optimal code,
> it isn't hard to review. Inserting new code before them would make the
> interdiff far bigger.
>

Sorry for the delay, was a bit busy with college work. For the most
part I've been
trying to integrate the %(upstream) and its options 'track',
'trachshort' and 'short'
so we could implement %(upstream:track,nobracket) or
%(upstream:nobracket,track).
While doing so I realized I was moving a lot of code around and this
had me thinking it's
perhaps easier to do the cleaning up first as Junio suggested.

Maybe then it'd be simpler to do implement this rather than move code around now
and then move code around when we implement the parsing methods we
spoke about earlier?

-- 
Regards,
Karthik Nayak
