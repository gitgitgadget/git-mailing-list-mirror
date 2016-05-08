From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v5 0/2] bisect--helper: rewrite of check-term-format()
Date: Sun, 8 May 2016 19:04:54 +0530
Message-ID: <CAFZEwPPZJqGHsHk0RLzo-pA8rUN0VP9-ricycNOnGbhO=2JZgg@mail.gmail.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<xmqqtwia25qc.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOA9c8eQAacnuB1n=juOhN1zsMdzcupS3ijqwYFPRrW4A@mail.gmail.com>
	<xmqq60up1e24.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPML8MCAL2quAN3ExMFXrhjS07g3KEC-WuSfYAXc2WQKuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 15:35:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azOrf-00087z-Ew
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 15:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbcEHNe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 09:34:56 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33888 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbcEHNez (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 09:34:55 -0400
Received: by mail-yw0-f196.google.com with SMTP id i22so21254350ywc.1
        for <git@vger.kernel.org>; Sun, 08 May 2016 06:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=4AxYLr3XGfnQK8opj5S5a9unpIfsve1qYIeIt7QR19o=;
        b=b3jjsP/JFbSxnvnQ6qme/p5Ii4pTMeJpVbaWbi2+BFRJSJ+btLQ9SRnAte8Fw5uzlb
         3VLtF50aQG1eyxzar2L6qI13vDuSCVr8a7ks31umAiW/0G3CTi2+wHlvBzgL0/XaIhqN
         bRSWJ9m1sZXsTeF9kIc8C/qbWEla8W/3HLq3i5tqBVCcQpA2e+GKe6JoCQwlb4T2/wRd
         JZi92RabmZo7s5rty2cgPaig6MOdApd0SERB9RwYf1txCC1lnEY5OSzawS29mipdbweZ
         4LMuyRU8ZgeGYkTf3GRt2QmBfDCL0PCPt/vsZdSiiZhOnUDHRP0/ClmoJF2VTBrqpFtI
         YJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4AxYLr3XGfnQK8opj5S5a9unpIfsve1qYIeIt7QR19o=;
        b=aGQm6DpCzVKnOvt4N5G2sf9ffrZ4vQ79iQXkWKZBBBvkc0jktp2bzJO9Wk0Q4f76aE
         XId4uDOhww70stmZa1jHmM7KNr3GjzCFq+CNd3EoVN+qF5lx/d/ZoFiuGmPRlJVPLuFJ
         LTdflMwphNYAax344tN+nxrDKR0+0c94yreCjgqRN+uAnq8uVE2CTzq8AQ7+G5oEu9TE
         nxU1rg5fpTRFJo7TJb3gNy5zwJE9kazgMuYbb6bfqPWvAVE9xZyjyXG9P15Tn8AaqONO
         8Jvr7DhcRv+dNEbCXOtihL1eF1Ej4EnDWnTdh0RYF4LqwCvEOh5TwTjNjNKKoAYmaWpS
         cZJw==
X-Gm-Message-State: AOPr4FXPwpRUkU/b2gCabefkM+tQk0+BuBD9bnh/YvJEcXmFEw5Vh0+k8LQz/myQvZ3wvi6z7PjK4nEFbXCDkg==
X-Received: by 10.37.118.69 with SMTP id r66mr2617222ybc.80.1462714494137;
 Sun, 08 May 2016 06:34:54 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Sun, 8 May 2016 06:34:54 -0700 (PDT)
In-Reply-To: <CAFZEwPML8MCAL2quAN3ExMFXrhjS07g3KEC-WuSfYAXc2WQKuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293967>

On Sun, May 8, 2016 at 11:53 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Sun, May 8, 2016 at 7:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>
>>> I completely missed your point and you want me to go the Eric Sunshine's way?
>>
>> I am neutral.
>>
>> When I read your response to Eric's "top down" suggestion, I didn't
>> quite get much more than "I started going this way, and I do not
>> want to change to the other direction.", which was what I had the
>> most trouble with.  If your justification for the approach to start
>> from building a tiny bottom layer that will need to be dismantled
>> soon and repeat that (which sounds somewhat wasteful) were more
>> convincing, I may have felt differently.
>
> Sorry if it seemed that "I have done quite some work and I don't want
> to scrape it off and redo everything". This isn't a case for me. I
> think of this as just a small part in the process of learning and my
> efforts would be completely wasted as I can still reuse the methods I

efforts would **not** be completely wasted

> wrote. This is still open for a "philosophical" discussion. I am
> assuming 1e1ea69fa4e is how Eric is suggesting.
>
> Why I think its better to go the subcommand way:
>  * I can test **C implementation** of the function to verify whether
> it was done in a proper way. By using a "top down" approach, I can
> make the test suite passing by running the code from git-bisect.sh not
> the re-written C code.
>  * I have made a very few minor mistakes in conversion of
> check_term_format() which just messed up my head (I actually spent 3
> days before Christian pointed out that '!' was missing). Imagine
> debugging the complete git-bisect.sh to find a very small error after
> a complete implementation.
>  * Using subcommands, I can easily verify whether I have done it the
> right way or not.
>  * It makes the review process very simple. The reviewers/testers can
> verify that my method is working correctly and well computers can
> detect errors better than humans.
>  * I can convert small functions which can be reviewed easily rather
> than dumping a big series.
>
> What I think is that the bottom up approach will make life easier for
> the me and for reviewer. Yes, it does make the code "unclean" for the
> time being and if it is between releases then all the more painful.
> Well, the latter part can be avoided by keeping it in next.
>
> Please point out if I am mistaken about anything.

There is also a third way in which I can go which is kind of merge of
both the ways:

 * Make two branches, one will contain the top down approach and
another will contain the subcommand approach.

 * I will write convert a function as a subcommand and test it locally
as well as on Travis-Cl by a PR on my git.git repo. The
reviewers/testers can consult the Travis-CI for output of the tests.
This will also reduce the need of locally compiling/testing.

 * I will then just write the function as it is in my "top down"
branch and thus send the patch to the mailing list. These can be kept
in next until it finishes.

 * Then will remove linking of git-bisect.sh and thus finalize.

This will be a bit more intensive not in a coding way but in
maintaining the repo. So I will have more experience of maintaining a
git repo. :)

Regards,
Pranit Bauva
