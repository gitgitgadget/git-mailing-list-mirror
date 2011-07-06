From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 11/14] revert: Introduce a layer of indirection over pick_commits
Date: Wed, 6 Jul 2011 17:14:59 +0530
Message-ID: <CALkWK0mXQszjM57E==YCisUng8buyMmP6EGkcrncJOkNJhK35Q@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-12-git-send-email-artagnon@gmail.com> <20110706103734.GL15682@elie>
 <CALkWK0=0vBUG_UOLWt+SFMctfW1__OOG-=BAY4WwMGM5OfDj4A@mail.gmail.com> <20110706113928.GO15682@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 13:45:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeQXm-0000rT-R9
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 13:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014Ab1GFLpV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 07:45:21 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62301 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab1GFLpU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 07:45:20 -0400
Received: by wwe5 with SMTP id 5so6861915wwe.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 04:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hqHBWsVPQ46JTq0VXPBjzFn3Q9PbLG3N7ZlMnxHGLHM=;
        b=VrOFBEOFwQHvxZS0j5dPXcut54m0QZ1AMrcHAtRdr617PiJdwmPFIqc4ATYA5/CmGn
         uuyTvm1igChCWpc0zfqvJPDD8NZ4i3V0gjTkvEralV/d16s8ps6p3EliQSqwITLQH1vI
         JdpYz7wQ5rgHYTa4kcxDaqSmymtsxZVQ1iqnU=
Received: by 10.216.233.211 with SMTP id p61mr6909568weq.107.1309952719074;
 Wed, 06 Jul 2011 04:45:19 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 04:44:59 -0700 (PDT)
In-Reply-To: <20110706113928.GO15682@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176695>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Jonathan Nieder writes:
>>> In that case, I'd be mildly tempted to call it something crazy like
>>> start_or_continue_replay()
> [...]
>> Why? Is introducing new terminology so bad? =C2=A0Should I explain w=
hat I
>> mean by "continuation" in the commit message/ a comment?
>
> If "process_continuation" means "parse .git/sequencer state, which we
> are pretending is a serialized continuation object, and either (a)
> call it, (b) throw it away, or (c) modify it and then call it", then
> yes, how do you expect anyone to know what you are talking about?
>
> Less importantly, starting a cherry-pick (which is what pick_commits(=
)
> already does) doesn't seem to fit in that picture.
>
> A simpler jargon-filled description of this model is checkpoint/
> restart. =C2=A0But it is an incomplete analogy and still not a great =
name.
> With a goal of making future writers' lives happier and more
> productive in mind, I do not think it is often worth confusing them b=
y
> choosing a clever presentation of ideas instead of a clear one.

Thanks for the elaborate explanation; I can see what's wrong with it
now.  However, I "start_or_continue_or_stop_or_[insert more options
here]_replay" isn't a good name.  I want something future-proof,
because I intend to extend this with more nifty helpers like "skip
one".  Your earlier "pick_revisions" suggestion doesn't sound like a
bad alternative now -- let me know if you have any other suggestions.

Thanks.

-- Ram
