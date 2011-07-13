From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 04/17] revert: Rename no_replay to record_origin
Date: Wed, 13 Jul 2011 13:05:55 +0530
Message-ID: <CALkWK0nm-gX9-3pGxT31VO-06mimd0cg1O8xhk-0QbsbdN7aLg@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-5-git-send-email-artagnon@gmail.com> <20110712170256.GC13578@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 09:36:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgtzd-0008Vm-6w
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 09:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996Ab1GMHgQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 03:36:16 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60676 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758697Ab1GMHgQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 03:36:16 -0400
Received: by wwe5 with SMTP id 5so5698245wwe.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 00:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fdRg1WQUfgP9f3KZz+o43JmStianhfrWaVQLYJcGFKM=;
        b=Bdr+NYwW14TmUZiIR03RzAToakrQaXZolY6DXyPFOPlFkjaTNNBscvvRU5egvxTNe3
         715p0LGIAkDY4jw1/tojHHod+d7Dym2VckZ0o+xvAL+a5Lj7a+vQOLvpbr77PNzVwxP0
         VDF7gAzypXzSL/wWwnw87ZTlVBxW9y0LScEck=
Received: by 10.216.137.92 with SMTP id x70mr3744008wei.62.1310542575131; Wed,
 13 Jul 2011 00:36:15 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 13 Jul 2011 00:35:55 -0700 (PDT)
In-Reply-To: <20110712170256.GC13578@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177009>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Rename the variable corresponding to the "-x" command-line option fr=
om
>> "no_replay" to a more apt "record_origin".
>
> Why is it more apt? =C2=A0What does "-x" do? =C2=A0Why was it called =
"no_replay"
> before? =C2=A0Is there some other motivation to this change (e.g., do=
es this
> pave the way to using the name "replay" for something else)?

Thanks for probing.  Found out the reason after some digging.

revert: Rename no_replay to record_origin

The "-x" command-line option is used to record the name of the
original commits being picked in the commit message.  The variable
corresponding to this option is named "no_replay" for historical
reasons.  This name was introduced in f810379 (Make builtin-revert.c
use parse_options, 2007-10-07) to replace "replay", the opposite of
"no_replay".  The name "replay" was introduced in 9509af6 (Make
git-revert & git-cherry-pick a builtin, 2007-03-01).  Back then, "-x"
was the only command-line option that modified the commit message of
the commit being picked, and was in effect replaying a slightly
different commit; hence the names "replay" and "no_replay".

Today, there are many other options like "-s" which append various
things to the commit message, and the term "replay" doesn't mean what
it used to.  So, give the variable corresponding to the "-x"
command-line option a better name: "record_origin".

-- Ram
