From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: Colors in __git_ps1
Date: Tue, 07 Oct 2014 20:46:31 +0200
Message-ID: <54343507.4010600@xs4all.nl>
References: <CAPWNY8UN+RfDXFgjC0DOtjXhZf7noPp6vtv70bwwPAoh0azgnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 20:46:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbZmT-0001YQ-3Z
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 20:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161AbaJGSqg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Oct 2014 14:46:36 -0400
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:1566 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158AbaJGSqf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 14:46:35 -0400
Received: from localhost.localdomain (simaj.xs4all.nl [80.100.201.97])
	(authenticated bits=0)
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id s97IkVG9066095;
	Tue, 7 Oct 2014 20:46:32 +0200 (CEST)
	(envelope-from s.oosthoek@xs4all.nl)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <CAPWNY8UN+RfDXFgjC0DOtjXhZf7noPp6vtv70bwwPAoh0azgnQ@mail.gmail.com>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257940>

Dear Mantas,

On 07/10/14 18:18, Mantas Mikul=C4=97nas wrote:
> There was a question in #git recently on why __git_ps1 from
> git-prompt.sh does not allow colors in "$PS1 mode".
>
>  From what I see, commit 1bfc51ac8141 talks about the need for \[ and
> \] assignments in $PS1, and commit cf4cac4cfc13 says that PS1 mode
> turns off color support since \[ and \] won't work; as I understand
> it, this is because bash will output literal "\[" if __git_ps1 tries
> to echo it.
>
> Internally, \[ and \] are translated by bash into 0x01 and 0x02 befor=
e
> passing the final string to readline. So there *is* a way to achieve
> the same effect in "PS1 mode" =E2=80=93 __git_ps1 just needs to echo =
\001 and
> \002 before & after the color codes, and readline will interpret them
> correctly when calculating the prompt width. For example, echo
> $'foo\001\e[1m\002bar'.
>
> Might be worth considering, even if $PS1 mode is inferior to
> $PROMPT_COMMAND mode for other reasons.
>

I would actually prefer the PS1=3D'$(__git_ps)' like way, as it is more=
=20
generic and intuitive when you know generic Bourne shell ways.

The reason to go for PROMPT_COMMAND was that it appears to be the only=20
way to set the PS1 prompt and let bash keep track of the length of the=20
prompt properly. This is needed to allow browsing the bash history with=
=20
long(er than width of the terminal) command lines without the terminal=20
getting messed up.
And I'm still not sure PROMPT_COMMAND mode fixes this properly, but it=20
passed the tests where command substitution mode failed.

IMHO the way colours are now implemented could very well be considered =
a=20
workaround for a bug in bash. Only I'm not skilled enough (or have=20
enough time) to get to the bottom of it...

I hope this answers your question.

Cheers

Simon
