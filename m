From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-p4: fix faulty paths for case insensitive systems
Date: Sun, 23 Aug 2015 23:33:33 -0700
Message-ID: <xmqqtwrp5h6q.fsf@gitster.dls.corp.google.com>
References: <1440177578-5317-1-git-send-email-larsxschneider@gmail.com>
	<xmqqmvxk5xm9.fsf@gitster.dls.corp.google.com>
	<D3B14EF1-C005-43CE-A3FF-2ABEF879CA01@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, pw@padd.com,
	torarvid@gmail.com, ksaitoh560@gmail.com, tboegi@web.de,
	sunshine@sunshineco.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 08:33:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTlKG-0003uW-OZ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 08:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbbHXGdg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2015 02:33:36 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34106 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbbHXGdf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 02:33:35 -0400
Received: by pdbfa8 with SMTP id fa8so49797500pdb.1
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 23:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=LUJxA/6aDaR0PhDPxoSrkonjzIAbAOldmI8kUP/t9Ys=;
        b=cbB8ME97lI+jTGBMUYKECi6NRG3GT4GsXh5rp6fidAURXp73JRr1Mu7riT5q4N7ORB
         WHpn8Ht6uTa8w4LSfFR7aC0ENgVzj691PZrlJLUYmMluVZk83KDO/KU0nKH2TWona4d7
         edL7Vb9DxtnGmgSt29xpUB8hEdosO1XYmH5lXbh9o4NkJNMu3W+Wz7cT6FHb6CUpkIQ0
         k71Un1uyaysYJmrvGn9KzZUoKn4gDHkNwcy/6ARouDh2767yYb4Lgs2LT4+CkSV/ukfF
         V6BEe/Dq5wbcxOe1F1lQ+6+ne244uNGxtE8kQ3gnAQ7JGwZ64zTybIqggxqkPZ+qmH17
         s/KQ==
X-Received: by 10.70.38.165 with SMTP id h5mr42928885pdk.164.1440398014710;
        Sun, 23 Aug 2015 23:33:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e53a:1155:f7f9:400e])
        by smtp.gmail.com with ESMTPSA id fn15sm16025948pdb.50.2015.08.23.23.33.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 23 Aug 2015 23:33:33 -0700 (PDT)
In-Reply-To: <D3B14EF1-C005-43CE-A3FF-2ABEF879CA01@gmail.com> (Lars
	Schneider's message of "Sun, 23 Aug 2015 19:10:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276435>

Lars Schneider <larsxschneider@gmail.com> writes:

>> - Have you checked "git log" on our history and notice how nobody
>>   says "PROBLEM:" and "SOLUTION:" in capital letters?  Don't try to
>>   be original in the form; your contributions are already original
>>   and valuable in the substance ;-)
> haha ok. I will make them lower case :-)

I cannot tell if you are joking or not, but just in case you are
serious, please check "git log" for recent history again.  We do not
mark our paragraphs with noisy labels like "PROBLEM" and "SOLUTION",
regardless of case.  Typically, our description outlines the current
status (which prepares the reader's mind to understand what you are
going to talk about), highlight what is problematic in that current
status, and then explains what change the patch does and justifies
why it is the right change, in this order.  So those who read your
description can tell PROBLEM and SOLUTION apart without being told
with labels.

>> - I think I saw v3 yesterday.  It would be nice to see a brief
>>   description of what has been updated in this version.
> I discovered an optimization. In v3 I fixed the paths of *all* files
> that are underneath of a given P4 clone path. In v4 I fix only the
> paths that are visible on the client via client-spec (P4 can perform
> partial checkouts via =E2=80=9Cclient-views=E2=80=9D). I was wonderin=
g how to convey
> this change. Would have been a cover letter for v4 the correct way or
> should I have made another commit on top of my v3 change?

Often people do this with either

 (1) a cover letter for v4, that shows the "git diff" output to go
     from the result of applying v3 to the result of applying v4 to
     the same initial state; or

 (2) a textual description after three-dash line of v4 that explains
     what has changed relative to v3.

The latter is often done when the change between v3 and v4 is small
enough.

> Yes, that is PEP-8 style and I will change it
> accordingly. Unfortunately git-p4.py does not follow a style guide.
> e.g. line 2369: def commit(self, details, files, branch, parent =3D "=
"):

OK, just as I suspected.  Then do not worry too much about it for
now, as fixes to existing style violations should be done outside of
this change, perhaps after the dust settles (or if you prefer, you
can do so as a preliminary clean-up patch, that does not change
anything but style, and then build your fix on top of it).

> More annoyingly (to me at least) is that git-p4 mixes CamelCase with
> snake_case even within classes/functions. I think I read somewhere
> that these kind of refactorings are discouraged. I assume that applie=
s
> here, too?

If you are doing something other than style fixes (call that
"meaningful work"), it is strongly discouraged to fix existing style
violations in the same commit.  If you are going to do meaningful
work on an otherwise dormant part of the system (you can judge it by
checking the recent history of the files you are going to touch,
e.g. "git log --no-merges pu -- git-p4.py"), you are encouraged to
first do the style fixes in separate patches as preliminary clean-ups
without changing anything else and then build your meaningful work
on top of it.

What is discouraged is a change that tries to only do style fixes
etc. to parts of the system that are actively being modified by
other people for their meaningful work.

>> You are verifying what the set of "canonical" paths should be by
>> checking ls-files output.  I think that is what you intended to do
>> (i.e. I am saying "I think the code is more correct than the earlier
>> round that used find"), but I just am double checking.
> I agree that =E2=80=9Cls-files=E2=80=9D is better because it reflects=
 what ends up
> in the Git repository and how it ends up there.

Thanks. I wanted to double-check that the problem you saw was not
about what is left in the filesystem but more about what is recorded
in the Git history.  "ls-files" check is absolutely the right approach
in that case.
