From: Dave Bradley <dbradley2@bell.net>
Subject: Re: [msysGit] Re: #178 parsing of pretty=format:"%an %ad" causes fatal: bad revision '%ad'
Date: Sun, 4 May 2014 06:14:13 -0400
Message-ID: <BLU0-SMTP387BC836A8719897DD84B79F4D0@phx.gbl>
References: <BLU0-SMTP1116609FAC7E0C76123F929F430@phx.gbl> <20140502172358.GI9218@google.com> <CABPQNSYTWYwSgd=sa0QGmaFDuzprLzLNYmQEx-6MrZ_HEZimww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"; reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GIT Mailing-list" <git@vger.kernel.org>,
	"msysGit" <msysgit@googlegroups.com>
To: <kusmabite@gmail.com>, "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 12:19:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgtW1-00062R-2N
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 12:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbaEDKTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 06:19:21 -0400
Received: from blu0-omc4-s23.blu0.hotmail.com ([65.55.111.162]:22911 "EHLO
	blu0-omc4-s23.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752524AbaEDKTU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2014 06:19:20 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 May 2014 06:19:20 EDT
Received: from BLU0-SMTP38 ([65.55.111.135]) by blu0-omc4-s23.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Sun, 4 May 2014 03:14:14 -0700
X-TMN: [ofvRxojBJmGH3vJ2JHWMvnm/njzYBPjK]
X-Originating-Email: [dbradley2@bell.net]
Received: from prbrad2 ([70.26.38.77]) by BLU0-SMTP38.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Sun, 4 May 2014 03:14:14 -0700
In-Reply-To: <CABPQNSYTWYwSgd=sa0QGmaFDuzprLzLNYmQEx-6MrZ_HEZimww@mail.gmail.com>
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 16.4.3522.110
X-MimeOLE: Produced By Microsoft MimeOLE V16.4.3522.110
X-OriginalArrivalTime: 04 May 2014 10:14:14.0317 (UTC) FILETIME=[99A47DD0:01CF6781]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248089>

Hi,

Interesting discussion. However, the example below of three-spaces between 
"%an"  and "%ad" in the example below resulted in the
formatting of the output with the three spaces,  but no dq's.

> Original #178 content
>G:\ws_test_env\GIT_TESTBED_TMP\fest-swing-1.x>git log --all 
>"--pretty=format:"%an"    "%ad"" -- pom.xml
>xxxx xxxx    Mon Nov 23 03:09:17 2009 +0000
>xxxx xxxx    Mon Nov 23 02:42:24 2009 +0000

This added to my confusion as by right dq within dq should be formatted. 
(Yea right, these days its needs to be escaped. But haven't tried that.)

In summary so far, it would appear that the --pretty......... needs to be 
contained in double-quotes as a whole. This was the solution I applied to my 
problem.

In the discussions I've seen more information requested as to the arguments 
provided to the execution class. I solved this issue as I made it work by 
experiment. I format the argument as a whole and don't have the space. IE. 
"pretty=format:"name:%an%nauthor:%ad%n"".


Regards

-----Original Message----- 
From: Erik Faye-Lund
Sent: Friday, May 02, 2014 2:23 PM
To: Jonathan Nieder
Cc: Dave Bradley ; GIT Mailing-list ; msysGit
Subject: Re: [msysGit] Re: #178 parsing of pretty=format:"%an %ad" causes 
fatal: bad revision '%ad'

On Fri, May 2, 2014 at 7:23 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> (resending with the correct address for the Git for Windows developers.
> Sorry for the noise.)
> Hi Dave,
>
> Dave Bradley wrote:
>
>> G:\ws_test_env\GIT_TESTBED_TMP\fest-swing-1.x>git 
>> log --all --pretty=format:"%an %ad" -- pom.xml
>> xxxx xxxx Mon Nov 23 03:09:17 2009 +0000
>> xxxx xxxx Mon Nov 23 02:42:24 2009 +0000
>>
>> G:\ws_test_env\GIT_TESTBED_TMP\fest-swing-1.x>git log --all 
>> "--pretty=format:"%an %ad"" -- pom.xml
>> fatal: bad revision '%ad'
>
> On Linux, this example gets passed to git as six arguments:
>
>         log
>         --all
>         --pretty=format:%an
>         %ad
>         --
>         pom.xml
>

As does it on Windows. 
