From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 5/5] Speed up log -L... -M
Date: Sun, 24 Mar 2013 03:38:54 -0400
Message-ID: <CAPig+cSnndjHWJ3U-DE3qG9Q3VvuDgyFnnfwZ8m3K335nwFCwQ@mail.gmail.com>
References: <cover.1363865444.git.trast@student.ethz.ch>
	<72a500432c0e6fde830f505204a1d02180710656.1363865444.git.trast@student.ethz.ch>
	<CAPig+cSG1gYohpZQZxnCpKgkUPs=Dwfokx+3OhiqdGKX8fajBw@mail.gmail.com>
	<87k3oyzmg7.fsf@pctrast.inf.ethz.ch>
	<20130323090459.GB25600@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Thomas Rast <trast@student.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?ISO-8859-2?Q?Zbigniew_J=EAdrzejewski=2DSzmek?= 
	<zbyszek@in.waw.pl>, Will Palmer <wmpalmer@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 24 08:39:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJfWY-0005zD-5z
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 08:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755743Ab3CXHi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 03:38:57 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:39252 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755559Ab3CXHiz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 03:38:55 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so6368922ieb.34
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=V+dpFb+7CDWU+MbMHQHB/ACXuCcWceSgEdyZR+42D70=;
        b=xyg3ErRFrV+oIXWzlc5EB9cw/gQkkg2wqG1W9WOO5CT2xIzjMEKXK8JzOpuMQxiZoW
         ZlNBTPwZ0jN0+TwcsNAaUEFE8mftahfg9nhOpLNfj5JZtYDr7YQ4v9LwbcGwVFBRYBcM
         yM3hXR6GBrOfTjypF8Ww3AqQsL6vnYReUjjaRSEPxyYW76/xs3qZFZCBr882cFCZnNN+
         JzWyusS8fj3PqaBZHAt4Ju9rMNdqZifLjXBSjrF+ooJHSOTCkbHfrPyrNXTJeY7ngEVE
         8jK/x1j0iHJX4bAFySedFp7g66BuxFmLv0kiSOnC2XzaZAcPnyPaJplWCMTD96ejx7Lf
         b7fg==
X-Received: by 10.50.191.133 with SMTP id gy5mr8819639igc.50.1364110734690;
 Sun, 24 Mar 2013 00:38:54 -0700 (PDT)
Received: by 10.64.23.239 with HTTP; Sun, 24 Mar 2013 00:38:54 -0700 (PDT)
In-Reply-To: <20130323090459.GB25600@sigill.intra.peff.net>
X-Google-Sender-Auth: ArijG5QxBtPPjE-0ZA69Ywsv6gU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218944>

On Sat, Mar 23, 2013 at 5:04 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 23, 2013 at 06:58:48AM +0100, Thomas Rast wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > On Thu, Mar 21, 2013 at 8:52 AM, Thomas Rast <trast@student.ethz.ch> wrote:
>> >> This is a bit hacky and should really be replaced by equivalent
>> >> support in --follow, and just using that.  However, in the meantime it
>> >
>> > s/using/use/
>>
>> I'm not a native speaker, but I really think 'using' is more correct
>> here.
>
> Cannot...resist...grammar discussion.
>
> I think you are both potentially right.
>
> You might consider the two items "equivalent support" and "using that"
> to be two noun phrases that are objects of the preposition "by", and
> that the writer simply omits the second "by" after the "and". In which
> case you are making a noun phrase from a verb phrase, and would want to
> use the gerund form "using".  And the sentence, simplifying out some
> modifiers and adding the missing "by" (which is fine to omit, but the
> parts of speech become much clearer with it there), looks like:
>
>   ...should be replaced by equivalent support, and by using that.
>
> However, you could also argue that the final clause is a second verb
> phrase for "this should" which just omits the extra "should" (which is
> also OK in a list. In which case "use" acts as a verb, and parses as:
>
>   ...should be replaced by equivalent support, and this should just use
>   that.
>
> So I think it is correct either way, and though it parses slightly
> differently, the overall meaning is the same.
>
> Phew. Totally not worth that much discussion, but for some reason I find
> these sorts of ambiguous language cases interesting.

Wishing to avoid bike-shedding the commit message, I suggested
s/using/use/ as a minor change to help clarify the grammar a bit.
However, perhaps it could be rephrased as:

  This is a bit hacky and should really be replaced by equivalent
  support in --follow, which can then be employed instead.

-- ES
