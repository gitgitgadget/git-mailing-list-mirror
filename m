From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git-prompt.sh vs leading white space in __git_ps1()::printf_format
Date: Wed, 28 Nov 2012 19:04:40 +0100
Message-ID: <CAA01CsouyXABkmbFy_u3Qt8R8W+1caxn34d5pscZSZJk9mynQg@mail.gmail.com>
References: <CAA01Cso1E4EC4W667FEU_af2=uGOfPuaWEB3y+zPCpB+bPzoaA@mail.gmail.com>
	<20121128132033.GA10082@xs4all.nl>
	<CAA01CspHAHN7se2oJ2WgcmpuRfoa+9Sx9sUvaPEmQ-Y+kDwHhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:04:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdm0G-0002gR-95
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 19:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab2K1SEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 13:04:41 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:56533 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443Ab2K1SEl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 13:04:41 -0500
Received: by mail-qa0-f53.google.com with SMTP id k31so5102013qat.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 10:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YyrUMQQ3M4ykQ1X2B8g2eCL15oOAuUE8OcQe7WnIa0A=;
        b=bNd0atWK69TM0cUaio1vCfR7qU9A1q8fSkBis9twukBD1NKmwsmX85FsegpJoLIOFm
         D956wphW85FEN0KkJ3rKgC8ParfpVRWnRW5W3XkbgIY0AFBYHknwLoK1iRTrranwhLlx
         m/evbH4iwnk47BTv83FiWd3NX0uJp8H2fUq97Ulgxnp+U8o3oTH77+CQ9H4ViaBsHvjv
         H8AGaadzdbUUetGvOTIgOaCDasD3Q6a7Zp2DI0XtpY/I7u/aQJnKwgRLEYjabb+jSHHj
         Hec9/ggu+oNJb8D5N6lwclu4A1eZS+AWlq5dcqBoXvwCYeg1cL6VmsSfc+YHipaDYfHi
         M8eg==
Received: by 10.229.173.162 with SMTP id p34mr2656251qcz.138.1354125880294;
 Wed, 28 Nov 2012 10:04:40 -0800 (PST)
Received: by 10.49.26.132 with HTTP; Wed, 28 Nov 2012 10:04:40 -0800 (PST)
In-Reply-To: <CAA01CspHAHN7se2oJ2WgcmpuRfoa+9Sx9sUvaPEmQ-Y+kDwHhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210747>

Re-sending mail.

On Wed, Nov 28, 2012 at 7:02 PM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
>
> On Wed, Nov 28, 2012 at 2:20 PM, Simon Oosthoek <s.oosthoek@xs4all.nl> wrote:
>>
>> * Piotr Krukowiecki <piotr.krukowiecki@gmail.com> [2012-11-28 11:03:29 +0100]:
>>
>> > Hi,
>> >
>> > when I set PROMPT_COMMAND to __git_ps1 I get a space at the beginning:
>> >
>>
>> Is your setting?:
>> PROMPT_COMMAND=__git_ps1
>
>
> That's right
>
>
>> I believe you need to give 2 parameters in order to use it in PROMPT_COMMAND mode.
>
>
> Are you sure? git-prompt.sh says:
>
> #    3a) In ~/.bashrc set PROMPT_COMMAND=__git_ps1
> #        To customize the prompt, provide start/end arguments
> #        PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
>
> I interpret this as: if you don't want to customize the prompt, the simple "PROMPT_COMMAND=__git_ps1" is enough.
>
>>
>> >  (master)pkruk@foobar ~/dir$
>> > ^ space
>> >
>> > Is there a reason for this? It looks like a waste of space. If I'm not in
>> > git repository I don't have the space:
>> >
>> > pkruk@foobar ~/other$
>> >
>> > I noticed the space is explicitly specified in printf_format in
>> > git-prompt.sh. Is it needed? If I remove it, everything seems to work fine
>> > (no leading space)...
>> >
>> > --- /usr/local/src/git/git/contrib/completion/git-prompt.sh 2012-11-28
>> > 10:27:05.728939201 +0100
>> > +++ /home/pkruk/.git-prompt.sh 2012-11-28 10:52:56.852629745 +0100
>> > @@ -218,7 +218,7 @@ __git_ps1 ()
>> >   local detached=no
>> >   local ps1pc_start='\u@\h:\w '
>> >   local ps1pc_end='\$ '
>> > - local printf_format=' (%s)'
>> > + local printf_format='(%s)'
>> >
>> >   case "$#" in
>> >   2) pcmode=yes
>>
>>
>> These last 2 lines say: if 2 arguments are given, use pcmode. Otherwise you get command-subtitution mode, which gives weird effects when being called from PROMPT_COMMAND.
>>
>
> Still, it seems to work with above "patch"..
>




--
Piotr Krukowiecki
