From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 10:48:19 -0500
Message-ID: <CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
	<1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
	<CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
	<CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
	<CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: szeder@ira.uka.de, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 16:48:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZO9i-0005fh-Da
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 16:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab2KPPsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 10:48:20 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:40664 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab2KPPsU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 10:48:20 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so1755051iay.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 07:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4njyrSNiizlLbOuvhSZ+3hf+Z37opYV6q/aiTRR/8S0=;
        b=Pnk+ejGj5+V+Dw1CByaVco7eu29/y4Ipulg92Jpj79seCrj1BZah245AzNt7kZhejj
         3tHbzd6syVPqY7/JYOHUdUVGtf1dEMn+CskMp6UQourzPmtzNp41Kajn7zaBWoEHdVPt
         EPvk3vXwEeCNpOwqGxO2sXRrGplWE2QHR9FVxIg6NKoMeTg93G7DKQVMYvxxmNT2TCVl
         wCdHis5tvX2hoiE+mToM9FMGPDAfVUuKDtOWEO32fieKf0QY9ir6GbK46gKeRtcMFwFc
         Pvxg/3/3wQM0EpU/h6OYzp+Y0AA450nLlovrjHvS6NztMTsI916kDmvV4/w0uHNMDy6F
         fXcw==
Received: by 10.42.68.68 with SMTP id w4mr4130029ici.30.1353080899721; Fri, 16
 Nov 2012 07:48:19 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Fri, 16 Nov 2012 07:48:19 -0800 (PST)
In-Reply-To: <CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209881>

On Fri, Nov 16, 2012 at 10:33 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Nov 16, 2012 at 3:39 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
>> On Thu, Nov 15, 2012 at 8:41 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Thu, Nov 15, 2012 at 12:51 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
>>>> The current tcsh-completion support for Git, as can be found on the
>>>> Internet, takes the approach of defining the possible completions
>>>> explicitly.  This has the obvious draw-back to require constant
>>>> updating as the Git code base evolves.
>>>>
>>>> The approach taken by this commit is to to re-use the advanced bash
>>>> completion script and use its result for tcsh completion.  This is
>>>> achieved by executing (versus sourcing) the bash script and
>>>> outputting the completion result for tcsh consumption.
>>>>
>>>> Three solutions were looked at to implement this approach with (A)
>>>> being retained:
>>>>
>>>>   A) Modifications:
>>>>           git-completion.bash and new git-completion.tcsh
>>>
>>> As I said, I don't think this is needed. It can be done in a single
>>> stand-alone script without modifications to git-completion.bash.
>>>
>>> This works:
>>
>> Thank you for taking the time to try things out.
>>
>> What you suggest below is an improvement on solution (C).
>> I had chosen (A) instead because (C) creates a third script
>> which gets generated each time a new shell is started.
>
> We could generate the script only when it's not already present. The
> disadvantage is that if this script is updated, the helper one would
> not.

I didn't like that too much either.

> One way to solve the problem would be to append the current
> version of git, and figure a way to query it out. Another would be to
> checksum it. But then again, maybe it's more expensive to check the
> version or checksum than just write the file again.

Yeah, I'm also thinking that re-generating the script is not bad enough
to introduce this complexity.

> Is it possible to just check if this is a login shell?

I think it would be nice to allow the user to manually
source git-completion.tcsh, in case they want to make
manual modifications to it.

I think the most user-friendly option is to actually re-generate the
script each time.  It feels wrong, but it works well :)

>>> set called = ($_)
>>
>> I fought with this a lot before posting to the list.
>> It seems that $_ is not set when a double sourcing
>> happens.  Testing the solution as an actual user
>> showed me that when I start a new shell it
>> sources ~/.tcshrc, which then sources ~/.git-completion.tcsh
>> and then $_ is empty for some reason.
>>
>> I couldn't find another way to figure out where the script
>> is located, which is why I had to force the user to use
>> ${HOME} for everything.
>
> Ah :(
>
> --
> Felipe Contreras
