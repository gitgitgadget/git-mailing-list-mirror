From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 11/14] revert: Introduce a layer of indirection over pick_commits
Date: Wed, 6 Jul 2011 16:54:12 +0530
Message-ID: <CALkWK0=0vBUG_UOLWt+SFMctfW1__OOG-=BAY4WwMGM5OfDj4A@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-12-git-send-email-artagnon@gmail.com> <20110706103734.GL15682@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 13:24:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeQDf-0000s8-6c
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 13:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110Ab1GFLYe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 07:24:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46744 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981Ab1GFLYd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 07:24:33 -0400
Received: by wwe5 with SMTP id 5so6845580wwe.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 04:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OYNr8p0tXskge9SgfO8ylgBq5OskXb5MN1e9np/oJ1E=;
        b=Alb15yaVC32dBuMgaOzugDcmWNYIRqKWvLNmdc5Im0AEeimtfYmz8+bsJfsHpRp2tc
         3XOda/552ZDpTu6CTsz3nYRDjhz/CCMh01Dn6QgGObfO/HhlG8l6BoCXa5iKZAGAqthk
         C7qdiosNd/r56fZ/aaYl+LOZvPRlfk2Q8pJCQ=
Received: by 10.216.60.72 with SMTP id t50mr1887569wec.92.1309951472123; Wed,
 06 Jul 2011 04:24:32 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 04:24:12 -0700 (PDT)
In-Reply-To: <20110706103734.GL15682@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176690>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Write a new function called process_continuation to prepare a
>> todo_list to call pick_commits with; the job of pick_commits is
>> simplified into performing the tasks listed in todo_list.
>
> Why is it called process_continuation? =C2=A0What is its responsibili=
ty?
> When would I call it?

I wanted a general name for the features I'm writing (--reset,
--continue): I want to call these "continuation features".  I
personally like the term, because it reminds me of the "call/cc" in
Scheme.

>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* Decide what to do depending on the arguments=
; a fresh
>> + =C2=A0 =C2=A0 =C2=A0* cherry-pick should be handled differently fr=
om an existing
>> + =C2=A0 =C2=A0 =C2=A0* one that is being continued
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 res =3D process_continuation(&opts);
>
> Is this the new sole entry point to the cherry-pick/revert machinery?

Yes.

> In that case, I'd be mildly tempted to call it something crazy like
> start_or_continue_replay(), and even more tempted to split it into
> separate entry points for new_replay(), continue_replay(),
> abort_replay(), and remove_replay_state() (but please don't trust me
> about the names; this is just to get the idea across).

Why? Is introducing new terminology so bad?  Should I explain what I
mean by "continuation" in the commit message/ a comment?

-- Ram
