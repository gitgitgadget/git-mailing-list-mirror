From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] macos: lazily initialize iconv
Date: Wed, 01 Aug 2012 21:25:19 +0200
Message-ID: <5019829F.7050606@web.de>
References: <7vk3xjked0.fsf@alter.siamese.dyndns.org> <7v1ujrkc9p.fsf@alter.siamese.dyndns.org> <CA+55aFwE93YeVjZp9VLhRvbxFJNonafmUE6rHzPer5hv-hON5Q@mail.gmail.com> <7vk3xjit4h.fsf@alter.siamese.dyndns.org> <CA+55aFzhgTsHKhL599k7M6NzD5WUm72v3V+NYuCKs4uCPbnFzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>, tboegi@web.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 21:26:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SweYS-0007eT-PD
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 21:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756310Ab2HATZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 15:25:26 -0400
Received: from mout.web.de ([212.227.15.4]:55762 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756275Ab2HATZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 15:25:25 -0400
Received: from [10.0.0.8] ([85.164.185.83]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MLgZ5-1SwvWj364B-000bMC; Wed, 01 Aug 2012 21:25:24
 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <CA+55aFzhgTsHKhL599k7M6NzD5WUm72v3V+NYuCKs4uCPbnFzg@mail.gmail.com>
X-Provags-ID: V02:K0:mbzN13F4VT6qE6DrUwy2zGjOm1Q4K7INNnKiA+oKb6M
 MQhLKYjarn38o14euv3C4cxFL/RVG1uuxJ5ltRYtM/eGSsqWNY
 1JPtAv1BN+sr0Aumu5ToqsA9ktml87wSIm/iyF0Blv6z14zL99
 toh1zO/UrNq5oOnsrOtehMP97tAXzagAi32XLxD2QsRAeZDEHQ
 dRzX1ta8XSAciN50SyyiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202720>

Am 2012-07-31 22:39, schrieb Linus Torvalds:
> On Tue, Jul 31, 2012 at 1:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Eek.
>
> Oh, I agree. Doing a full character set conversion both ways is quite
> a bit more work.
>
>> Not just write_entry() codepath that creates the final paths on the
>> filesystem, you would need to touch lstat() calls that check the
>> existence and freshness of the path, once you go that route.  I am
>> sure such a change can be made to work, but I am not sure how much
>> we would gain from one.
>
> I think it might be interesting. I doubt it matters all that much any
> more in Western Europe (Unicode really does seem to have largely taken
> over), but I think Japan still uses Shift-JIS a lot.
>
> Although maybe that is starting to fade too.
>
> And it really is just a generalization of the OS X filesystem damage.
>
>              Linus
>
Hi,
(I'm on vacation myself, so I migth apologize for answering very late.)

I had done a fully fledges conversion back-and-force of file names.

Having e.g. ISO-8859-1 on disk and UTF-8 in the repo.

The basic idea came from Linus, and it needs conversion for
open() fopen(), unlink(), readdir(), stat(), lstat(), rename()
(and may be one or two more, I even added support in readlink()).

After doing the whole thing ready, I realized that UTF-8 became more and 
more standard.

At the same time people started to enhance msysgit to use UTF-8 as well. 
(Thanks to the contributors)

My feeling was that the "market window" for such a generic file name 
conversion might be closed.

So, is there still a need for such a feature in git?

I wouldn't mind to re-base my pathch to master and post it within a 
couple of days/weeks.

Thanks for git and all enhancements.
/Torsten
