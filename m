From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: git-svn error: ambiguous argument
Date: Wed, 7 Jul 2010 01:11:11 +0200
Message-ID: <AANLkTilv1RywImw4RM3jMZl6YTawGhvodlhnX4RN1RWo@mail.gmail.com>
References: <7A6370FC-843B-43FD-8064-4F44C9C66493@inuus.com>
	<AANLkTik_YK6_KbRIq4MsrU-LDn8apHQfm1_f7XHKKfX1@mail.gmail.com>
	<AANLkTil7WdGZTtmwwK0kYPkK6-y4W5HKKLNdtkoI0riM@mail.gmail.com>
	<AANLkTimE6Wo9HT0p5WMfTggJ059dhDg4fyPeax93VCLy@mail.gmail.com>
	<0D702391-E490-4942-AAB6-C8C887E671C5@inuus.com>
	<AANLkTikKdDI_NMzvsA7e_VoYo7Ie97e2pBkZe_0xPt9P@mail.gmail.com>
	<20100628062409.GA13203@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Lindner <lindner@inuus.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 07 01:12:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWHJ1-0002bk-Na
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 01:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158Ab0GFXLN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 19:11:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37800 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab0GFXLM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 19:11:12 -0400
Received: by iwn7 with SMTP id 7so7172659iwn.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 16:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UYMtXUFlqNdXPmEju33LaYlOIXsf55Vvvc+Skv4D9DM=;
        b=DimDSSNJbH9wE3Ud51RPVcN/OApxjLCZhsBlkyVGfCFyMTN0KDsc6hKAX5AYt7HddG
         G06Fj1T1kMbO9MM6VN4zdLZlY6IVj68EhjKjzF0IlYuTE+/o4R3hHaPPKP8Jtf8qQ+84
         1Km/udfdhP6biKZOLArNO1P9FsIf0mJpfdE/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EyxUEZBTJZO6aK7Be2xeAHHf3xehPwTm9tgoZdL65uG/jyJ8YtnfjboiAACCb3Pc+O
         a8MK2CBCoSxsOK0mPn6QQykjFAEB6oIftp+fmE52V1Nv8k/UxkvOhzw+PLPnS0x6xx1B
         4DSbVdJ857Ubt5uk4QGofPutrIYfVLvS1ehDY=
Received: by 10.231.176.1 with SMTP id bc1mr5310280ibb.46.1278457871804; Tue, 
	06 Jul 2010 16:11:11 -0700 (PDT)
Received: by 10.231.34.198 with HTTP; Tue, 6 Jul 2010 16:11:11 -0700 (PDT)
In-Reply-To: <20100628062409.GA13203@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150416>

On Mon, Jun 28, 2010 at 08:24, Eric Wong <normalperson@yhbt.net> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>> On Tue, May 11, 2010 at 21:44, Paul Lindner <lindner@inuus.com> wrot=
e:
>> > This fixed it for my situation. =C2=A0Thanks!
>> > On May 11, 2010, at 9:20 AM, Bert Wesarg wrote:
>> >> Can you try this patch, it worked on my site:
>
> <snip>
>
>> Eric, have you picked this up, or should I re-send it as a propper p=
atch?
>
> A proper patch + commit message would be easier, thanks Bert!

I have invested some time to verify my patch before sending. And I
think I will break something. The current patch changes the range
argument for git rev-list from "r1^..r2" to "r1^!" & "r2", which
should not be the same, because "r1^..r2" is equivalent to "^r1^" &
"r2". This reads 'all commits reachable from r2 but not reachable from
the parent of r1' where my conversion should read 'all reachable from
r1 (excluding all of its parents) or reachable from r2'. But maybe the
'excluding all of its parents'-part quarantines that the semantic
still holds?

At least test 5 of t9151-svn-mergeinfo.sh does not pass, so my patch
proved to be wrong.

Bert

>
> --
> Eric Wong
>
