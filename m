From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 08:34:27 +0200
Message-ID: <BFBE8924-5F60-4D1F-9260-29545BEA0790@wincent.com>
References: <85lkdezi08.fsf@lola.goethe.zz> <7v8x9ea1rg.fsf@assigned-by-dhcp.cox.net> <85d4yqz24s.fsf@lola.goethe.zz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 08:35:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB389-0003Kd-F1
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 08:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbXGRGfA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 18 Jul 2007 02:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752936AbXGRGfA
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 02:35:00 -0400
Received: from wincent.com ([72.3.236.74]:57126 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673AbXGRGe7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 02:34:59 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l6I6YrFT023419;
	Wed, 18 Jul 2007 01:34:54 -0500
In-Reply-To: <85d4yqz24s.fsf@lola.goethe.zz>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52833>

El 18/7/2007, a las 7:56, David Kastrup escribi=F3:

> That creating some directory hierarchy (happening to contain empty
> directories) with some external program, adding and committing it,
> then switching to a different branch (or maybe doing a git-reset
> --hard) leaves a skeleton of empty directories around?
>
> I find this almost worse than not being able to put them into the
> repository: you can't get rid of them anymore either!
>
> I'd be tempted to propose that git should remove empty subdirectories
> when cleaning up a removed tree in the working directory, even though
> that violates the principle to not delete anything it isn't tracking.
> But since you can't get it to track the stuff in the first place...
>
> But the real fix would be to track them.

Although I haven't yet been "bitten" by this issue I understand where =20
you're coming from. This could confuse users and appear inconsistent =20
to them (seeing as empty *files* can be tracked). I think it's =20
probably worth tackling for that reason alone, but it will have the =20
additional benefit of enabling other workflows like the one you =20
describe ("installation trees for some application").

> Does some trick work possibly at checkin time, like putting an empty
> file into every empty directory, adding to the index, then removing
> all empty files explicitly from the index and then checking in, or is
> this hopeless to work around with from the user side without affectin=
g
> the repository itself?

I wouldn't recommend any "tricks" here. I think the real solution is =20
to allow the tracking of empty trees; everything else seems like a =20
kludge. And then, as you've noted already that will allow Git to =20
handle the "skeleton of empty directories" left behind problem that =20
you describe.

Cheers,
Wincent
