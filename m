From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v9 11/11] Documentation: add documentation for 'git
 interpret-trailers'
Date: Mon, 07 Apr 2014 20:58:00 +0200 (CEST)
Message-ID: <20140407.205800.839733420387302333.chriscool@tuxfamily.org>
References: <xmqqk3b4ogwu.fsf@gitster.dls.corp.google.com>
	<CAP8UFD38TE=5zxvkDvLRsDTpC6zDo6EN5q_HJMQPbUBcfJVsSg@mail.gmail.com>
	<xmqq4n25nkt0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, jrnieder@gmail.com,
	git@vger.kernel.org, josh@joshtriplett.org,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 07 20:58:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXEkG-0005HM-AM
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 20:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755883AbaDGS6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 14:58:05 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:54824 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756105AbaDGS6D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 14:58:03 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id A6FB36C;
	Mon,  7 Apr 2014 20:58:00 +0200 (CEST)
In-Reply-To: <xmqq4n25nkt0.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245890>

From: Junio C Hamano <gitster@pobox.com>
>
> Christian Couder <christian.couder@gmail.com> writes:
> 
>> First accepting both ':' and '=' means one can see the "git
>> interpret-trailers" as acting on trailers only. Not just on trailers
>> from the intput message and option parameters from the command line.
> 
> Sorry, you lost me.  What does "acting on trailers only" really
> mean?

It means that the command can seen as processing only trailers, (from
stdin and from its arguments), sorry if I used the wrong verb.

> Do you mean the command should/can be run without any command
> line options, pick up the existing "Signed-off-by:" and friends in
> its input and emit its output, somehow taking these existing ones as
> its instruction regarding how to transform the input to its output?
>
>> And second there is also a practical advantage, as the user can
>> copy-paste trailers directly from other messages into the command line
>> to pass them as arguments to "git interpret-trailers" without the need
>> to replace the ':' with '='. Even if this command is not often used
>> directly by users, it might simplify scripts using it.
>>
>> Third there is a technical advantage which is that the code that
>> parses arguments from the command line can be the same as the code
>> that parses trailers from the input message.
> 
> I do not see these two as valid arguments to make the command line
> more complex to the end users

I don't think that it makes the command more complex to the end users.

> ---who now need to know that only this
> command treats its command line in a funny way, accepting a colon in
> place of an equal sign.

It accepts both. So if they think that it is like a regular command,
which uses '=' for (key, value) pairs, it will work, and if they think
it works on trailers, which use ':' for (key, value) pairs, it will
also work.

> A different way to sell a colon, e.g.
> 
>     Consider the instruction sed takes on its command line.
>     (e.g. "sed 's/frotz/nitfol/' <xyzzy").  In the most general
>     form, you would always give it as the value of an '-e' option
>     (e.g. "sed -e 's/frotz/nitfol' <xyzzy"), but you are allowed to
>     be loose in limited occassions.  "Key:value" is like that, and
>     in the most general form, it actually needs to be spelled as
>     "-e 'Key:value'".
> 
> is possible, but I do not think it is a particularly good analogy,
> because what you have as the alternative is "Key=value", and not
> "-e 'Key:value'", or "--Key=value" (the last would probably be the 
> most natural way to express this).

The analogy that I would use is rather that Perl lets people use
's:foo:bar:' as well as 's=foo=bar=' instead of 's/foo/bar/' if they
prefer.
