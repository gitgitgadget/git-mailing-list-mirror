From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH] git-prompt.sh: shorter equal upstream branch name
Date: Tue, 07 Oct 2014 15:42:57 -0400
Message-ID: <54344241.60703@bbn.com>
References: <1412091370-11727-1-git-send-email-jcarsique@nuxeo.com>	<542B1623.2070109@bbn.com>	<xmqq7g0krb2p.fsf@gitster.dls.corp.google.com>	<542B7AF8.6080501@bbn.com> <xmqqppebptmj.fsf@gitster.dls.corp.google.com> <54340D63.8030507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org,
	=?windows-1252?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: Julien Carsique <julien.carsique@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 21:43:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbafC-0006CS-7d
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 21:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907AbaJGTnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 15:43:09 -0400
Received: from smtp.bbn.com ([128.33.0.80]:16539 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932308AbaJGTnE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Oct 2014 15:43:04 -0400
Received: from socket.bbn.com ([192.1.120.102]:60591)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Xbaev-0009ge-Nx; Tue, 07 Oct 2014 15:42:57 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 7723640367
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <54340D63.8030507@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257950>

On 2014-10-07 11:57, Julien Carsique wrote:
> Hi,
> 
> Thank you both for your feedback!
> I'm looking at applying your requests:
> - add tests,
> - variable renaming,
> - use of local,
> - fix multiple issues on string parsing
> - avoid useless bash-isms? Did you agree on the ones I should remove?

I'm guessing the structure of your code will change somewhat when you
address the other issues, so I think it may be premature to discuss
specific Bashisms right now.  (There aren't any particular Bashisms that
I think should always be avoided -- I just want people to ponder whether
a particular use of a Bashism is truly preferable to a POSIX-conformant
alternative.)

Write the code in the way you think is best, and if I see a good way to
convert a Bashism to POSIX I'll let you know.  And feel free to ignore
me -- I'm a member of the Church of POSIX Conformance while Junio is
much more grounded in reality.  :)

> 
> I'll send an updated patch asap. Tell me if I forgot something.

Your list looks complete to me.  Thank you for contributing!

-Richard


> 
> Regards,
> Julien
> 
> On 01/10/2014 19:49, Junio C Hamano wrote:
>> Richard Hansen <rhansen@bbn.com> writes:
>>
>>>> and there is no hope to "fix" them to stick to
>>>> the bare-minimum POSIX,
>>> I don't think it'd be hard to convert it to pure POSIX if there was a
>>> desire to do so.
>> Not necessarily; if you make it so slow to be usable as a prompt
>> script, that is not a "conversion".  Bash-isms in the script is
>> allowed for a reason, unfortunately.
>>
>>> It would be unwise to go to great lengths to avoid Bashisms, but I think
>>> it would be smart to use POSIX syntax when it is easy to do so.  
>> In general, I agree with you. People who know only bash tend to
>> overuse bash-isms where they are not necessary, leaving an
>> unreadable mess.
>>
>> For the specific purpose of Julien's "if the tail part of this
>> string matches the other string, replace that with an equal sign",
>> ${parameter/pattern/string} is a wrong bash-ism to use.  But the
>> right solution to count the length of the other string and take a
>> substring of this string from its beginning would require other
>> bash-isms ${#parameter} and ${parameter:offset:length}.
>>
>> And that's fine.
> 
> 
