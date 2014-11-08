From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Sat, 8 Nov 2014 00:03:41 -0800
Message-ID: <CANiSa6hPHfh_Vz_X8cqKeEbOfAAj1YmxLr5LyG0ncm5U=r4SVQ@mail.gmail.com>
References: <20141107081324.GA19845@peff.net>
	<xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
	<20141107191745.GB5695@peff.net>
	<CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
	<CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
	<CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 09:03:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn0zr-0000Io-BR
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 09:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbaKHIDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 03:03:43 -0500
Received: from mail-vc0-f172.google.com ([209.85.220.172]:57901 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172AbaKHIDm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 03:03:42 -0500
Received: by mail-vc0-f172.google.com with SMTP id le20so2580932vcb.31
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 00:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZzJNWF3BSZIlO/dR5wEAt+agSuaNWPLVeUk3CgtEQcE=;
        b=c7SzvnOGHXisF4P0GVYKA3RiR2ErHDxnnFx8w/jaM5kwQxCQvRN5oZquRXWw7c3cLY
         /iBUcL6L+EWaO+/ltSsOuNfNivYTQKdluJFFTKOEowloGHYZllnjm7qgtdbqU0iIbiJC
         2AuSgVr1LZgUWzcSQBKE6ceNX9QmVtBT6hS1l4pf4VwR/F7WhWqSdq0Cj369pkuZKLSm
         IPaNDBYs+g0Ir3iz6mnqnRCqZYYFssZQyTRvF/cUGQqfOeqfUnrttizoYZYcFS6zzCm2
         57HaPJIRrHMtY9c9tIIi7P223k9uEfqes7U3v4U2aamxQzdD8RXOJNInNEUjTSwJ344f
         iOfQ==
X-Received: by 10.220.71.72 with SMTP id g8mr11048067vcj.33.1415433821545;
 Sat, 08 Nov 2014 00:03:41 -0800 (PST)
Received: by 10.221.37.74 with HTTP; Sat, 8 Nov 2014 00:03:41 -0800 (PST)
In-Reply-To: <CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not sure I had seen that particular thread, but it seems like
we're all in agreement on that topic. I'm keeping my fingers crossed
that Jeff will have time to tackle that this time :-)

On Fri, Nov 7, 2014 at 11:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I think that has direct linkage; what you have in mind I think is
> http://thread.gmane.org/gmane.comp.version-control.git/234903/focus=234935
>
> What is on thread here is an implementation glitch, not semantic one.
> Checking out a "directory" as opposed to "set of paths that match the
> pathspec" was a deliberate design choice, not an implementation glitch.
>
> Pardon HTML, misspellings and grammos, typed on a tablet.
>
> On Nov 7, 2014 11:10 PM, "Martin von Zweigbergk" <martinvonz@gmail.com>
> wrote:
>>
>> Trying again from plain old gmail which I think does not send a
>> multipart content.
>>
>> On Fri, Nov 7, 2014 at 11:06 PM, Martin von Zweigbergk
>> <martinvonz@gmail.com> wrote:
>> > Is this also related to "git checkout $rev ." not removing removed
>> > files?
>> > What you say about the difference in implementation between checkout and
>> > reset sounds vaguely familiar from when I looked at it some years ago.
>> > Curiously, I just talked to Jonathan about this over lunch yesterday. I
>> > think we would both be happy to get that oddity of checkout fixed. If
>> > what
>> > you mention here is indeed related to fixing that, it does complicate
>> > things
>> > with regards to backwards compatibility.
>> >
>> >
>> > On Fri Nov 07 2014 at 11:24:09 AM Jeff King <peff@peff.net> wrote:
>> >>
>> >> On Fri, Nov 07, 2014 at 09:14:42AM -0800, Junio C Hamano wrote:
>> >>
>> >> > Jeff King <peff@peff.net> writes:
>> >> >
>> >> > > Is there a reason that we don't use this diff technique for
>> >> > > checkout?
>> >> >
>> >> > I suspect that the reasons are probably mixture of these:
>> >> >
>> >> >  (1) the code path may descend from checkout-index and predates the
>> >> >      in-core diff machinery;
>> >> >
>> >> >  (2) in the context of checkout-index, it was more desirable to be
>> >> >      able to say "I want the contents on the filesystem, even if you
>> >> >      think I already have it there, as you as a new software are
>> >> >      likely to be wrong and I know better"; or
>> >> >
>> >> >  (3) it was easier to code that way ;-)
>> >> >
>> >> > I do not see there is any reason not to do what you suggest.
>> >>
>> >> OK. It's not very much code (and can mostly be lifted from git-reset),
>> >> so I may take a stab at it.
>> >>
>> >> -Peff
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe git" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
