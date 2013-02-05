From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Tue, 5 Feb 2013 10:11:53 -0500
Message-ID: <CABURp0rMk-W8VMRhXoR9YYQSwjWTfPbXz5mhPX3-HKsBSu5_mw@mail.gmail.com>
References: <1359901085.24730.11.camel@t520> <510E8F82.9050306@gmail.com>
 <1359915086.24730.19.camel@t520> <510F03FC.6080501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Robert Clausecker <fuzxxl@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 16:12:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2kCL-00064P-Qj
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 16:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593Ab3BEPMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 10:12:15 -0500
Received: from mail-vb0-f47.google.com ([209.85.212.47]:37922 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885Ab3BEPMO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 10:12:14 -0500
Received: by mail-vb0-f47.google.com with SMTP id e21so147427vbm.20
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 07:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=z/LzE9J3jkEwJWyxFwbAMJTQxg0ZGl3ImRUAchFQyyU=;
        b=XGDQVcQlML8PISJ7uRUu26tBrY9Y1tjO5UqYbQKAXWaEG90L7Ry+2P39iZVYcx0gGv
         qE0ulipSIJB8lRtlBlDI+Ccf7Y+aN10NZbyuYa0m0IodiEgaOS+Op9VJNT1zCIRlEa0L
         VblB8urCuuiu5mHkcenYzIgK84ElnxPpnP8gGF1bWEnR9BOTchTXrQ8jl0ZFkA/kGBr7
         YbadvMWGFleiV5Xy2bI/AqlYjazzMbFOzCpkiBqTG9ZdRiEY4sx4b59PtPq+Fh1/m5ha
         QLpWVMtFUXqLgynaBJ0aazs1zujFPInB0MV8q8DKPjQHhuLQm7ySxSkKMcYbssFqaA05
         OCVg==
X-Received: by 10.220.39.69 with SMTP id f5mr28027436vce.45.1360077133310;
 Tue, 05 Feb 2013 07:12:13 -0800 (PST)
Received: by 10.58.201.103 with HTTP; Tue, 5 Feb 2013 07:11:53 -0800 (PST)
In-Reply-To: <510F03FC.6080501@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215503>

On Sun, Feb 3, 2013 at 7:42 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On 02/03/2013 11:41 PM, Robert Clausecker wrote:
>>
>> Am Sonntag, den 03.02.2013, 21:55 +0530 schrieb Sitaram Chamarty:
>>> Could you help me understand why piping it to tar (actually 'tar -C
>>> /dest/dir -x') is not sufficient to achieve what you want?
>>
>> Piping the output of git archive into tar is of course a possible
>> solution; I just don't like the fact that you need to pipe the output
>> into a separate program to do something that should be possible with a
>> simple switch and not an extra command. It feels unintuitive and like a
>> workaround to make an archive just to unpack it on-the-fly. Also, adding
>> such a command (or at least documenting the way to do this using a pipe
>> to tar somewhere in the man pages) is a small and simple change that
>> improves usability.
>
> I realise it appears to be the fashion these days to get away from the
> Unix philosophy of having different tools do different things and
> combining them as needed.
>
> Ignoring the option-heavy GNU, and looking at the more traditional BSD
> tar manpage [1], I notice the following flags that could still be
> potentially needed by someone running 'git archive': '-t' (instead of
> '-x'), '-C dir', '--exclude/include', '-k', '-m', '--numeric-owner', -o,
> -P, -p, -q, -s, -T, -U, -v, -w, and -X.

OP did not ask about tar so I do not see why any of these tar options
are relevant.  It seems like what he really wants is 'git archive
--format=native' , maybe.   You can almost create this option by
saying

   git config tar.native.command "tar -x"

except that you do not get the opportunity to specify a target directory.

But maybe he really wants a form of 'git checkout' instead.


> And I'm ignoring the esoteric ones like "--chroot" and "-S" (sparse mode).
>
> How many of these options would you like included in git?  And if you
> say "I don't need any of those; I just need '-x'", that's not relevant.
>  Someone else may need any or all of those flags, and if you accept "-x"
> you have to accept some of the others too.

This is only true if you cannot stop yourself from thinking about
'tar'.  What about zip, for example?

I think none of these options is relevant.


> Also, I often want to deploy to a different host, and I might do that
> like so:
>
>     git archive ... | ssh host tar -C /deploy/dir -x
>
> Why not put that ssh functionality into git also?

This slippery-slope argument is growing tiresome.

Phil

p.s. Conceded: OP set off this avalanche by disparaging the vaunted
PIPE operation.
