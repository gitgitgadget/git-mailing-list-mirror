From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/5] progress.c: replace signal() with sigaction()
Date: Wed, 28 May 2014 11:11:05 +0200
Message-ID: <87k396i7yu.fsf@fencepost.gnu.org>
References: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
	<1401257655-6043-2-git-send-email-jmmahler@gmail.com>
	<5385994A.5040507@gmail.com> <87sinuiad2.fsf@fencepost.gnu.org>
	<CABPQNSbRZS6DuNOLpWKtx6150sz20GjQ6RaakiSdi7FEQW5X3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Chris Packham <judge.packham@gmail.com>,
	Jeremiah Mahler <jmmahler@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 11:11:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpZtB-0002wa-Vc
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 11:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbaE1JLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 05:11:09 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:39882 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbaE1JLG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 05:11:06 -0400
Received: from localhost ([127.0.0.1]:38925 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WpZt3-0002sD-Hh; Wed, 28 May 2014 05:11:05 -0400
Received: by lola (Postfix, from userid 1000)
	id 34B67E084B; Wed, 28 May 2014 11:11:05 +0200 (CEST)
In-Reply-To: <CABPQNSbRZS6DuNOLpWKtx6150sz20GjQ6RaakiSdi7FEQW5X3Q@mail.gmail.com>
	(Erik Faye-Lund's message of "Wed, 28 May 2014 10:48:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250276>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Wed, May 28, 2014 at 10:19 AM, David Kastrup <dak@gnu.org> wrote:
>> Chris Packham <judge.packham@gmail.com> writes:
>>
>>> On 28/05/14 18:14, Jeremiah Mahler wrote:
>>>>  static void clear_progress_signal(void)
>>>>  {
>>>>      struct itimerval v = {{0,},};
>>>> +    struct sigaction sa;
>>>> +
>>>> +    memset(&sa, 0, sizeof(sa));
>>>> +    sa.sa_handler = SIG_IGN;
>>>
>>> A C99 initialiser here would save the call to memset. Unfortunately
>>> Documentation/CodingGuidelines is fairly clear on not using C99
>>> initialisers, given the fact we're now at git 2.0 maybe it's time to
>>> revisit this policy?
>>
>> If I look at the initialization of v in the context immediately above
>> the new code, it would appear that somebody already revisited this
>> policy.
>
> Huh, the initialization of v doesn't use C99-features...?

Well, for me anything post-K&R apparently is C99.

Cf
<URL:http://computer-programming-forum.com/47-c-language/859a1b6693a0ddc5.htm>

I have to admit that gcc -c -ansi -std=c89 -pedantic does not complain,
so that makes it quite probable that I was erring somewhat on the side
of the ancient ones and zeros.

-- 
David Kastrup
