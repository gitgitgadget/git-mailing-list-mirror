From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/8] revert: decouple sequencer actions from builtin commands
Date: Wed, 11 Jan 2012 09:47:51 +0530
Message-ID: <CALkWK0=bEPPv4rtPrMrQnk3MK=JY4-wwAByWPmzg86NBm_56iQ@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com> <1326212039-13806-3-git-send-email-artagnon@gmail.com>
 <20120110183857.GC22184@burratino> <CALkWK0k=44znLr2oYSx61Mk=qdAurona0f0H4i4=YXNSAeQhHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 05:18:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkpe2-0006Yu-Fi
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 05:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511Ab2AKESO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 23:18:14 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47943 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756525Ab2AKESN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 23:18:13 -0500
Received: by wgbds12 with SMTP id ds12so97618wgb.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 20:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mcnurIrX63lcuvCY/atLuGiTh3OGh0/sQuFuUjMzUSs=;
        b=KV+3pqFs4xHdvgDd8FIWQz85DyMpUg2gu14AaeUljgW/e9GAuWEeS/kxvYbqgIzAO5
         f2ZytVMRkrzD283M1QnJd6zNvniGwbJqjwKjUvAeHblAJ4q4cUhTXHCQvOglH0rDXpj7
         h0kvUHXecg06qokBu5THiIjAPIERv+w1gwk7E=
Received: by 10.180.77.200 with SMTP id u8mr16674719wiw.18.1326255492317; Tue,
 10 Jan 2012 20:18:12 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Tue, 10 Jan 2012 20:17:51 -0800 (PST)
In-Reply-To: <CALkWK0k=44znLr2oYSx61Mk=qdAurona0f0H4i4=YXNSAeQhHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188323>

Ramkumar Ramachandra wrote:
> Fine; =C2=A0I'm sold on the string idea. =C2=A0Also, I figured it wou=
ld be
> easier to explain the changes if I change this enum to a string -- I
> should probably use "ease of explaining changes" as a stronger
> criterion in the future when I have two competing implementations in
> mind.

I wrote that too quickly.  I can't stand seeing so many strcmp() calls
all over my codebase -- look at the number of instances of matching
opts->command to REPLAY_CMD_*.  Why should I have to use strcmp() when
the data is semantic?  It makes no sense: by spelling out the string
in so many places, I'm just making the code more error-prone, because
the compiler can't warn me if I make a spelling mistake in one place.
Why do you like the string so much?  A new caller will have to
register new actions in the replay_actions enum and modify the
codebase to define a codepath for its specific case anyway: so I don't
mind it registering a new command in replay_command.

-- Ram
