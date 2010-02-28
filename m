From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH 4/5] grep: Colorize filename, line number, and separator
Date: Sun, 28 Feb 2010 16:26:30 -0600
Message-ID: <b4087cc51002281426m126a0c07l9f4a38088d0146b1@mail.gmail.com>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com> 
	<1267246670-19118-5-git-send-email-lodatom@gmail.com> <4B890572.5040604@lsrfire.ath.cx> 
	<ca433831002281214q14e6e62bj54cf7227cd32873b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 23:26:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlrbF-0007zv-JQ
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 23:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032171Ab0B1W0x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2010 17:26:53 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:59494 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032168Ab0B1W0w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Feb 2010 17:26:52 -0500
Received: by ewy20 with SMTP id 20so955818ewy.21
        for <git@vger.kernel.org>; Sun, 28 Feb 2010 14:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3JxTao/ArrOnHBHNJAPIrjCbewntFwneSE+8v2JaWk4=;
        b=HN3mszX0YjqHmjKh8ZjPbgNpvW6aF2IP5q4bLaPc/yZ9bpG/fEhvKIUOT2yGTzfAEE
         Dck9YfefvbVXvZc6w3Ya9Y0oGm7oF3S9n5QBUnF+eCCORqcThLNHlNBpsHM3Q7NrtOf1
         JpZgCXd1nwvcd7gZvhSCdoALetSESSJQupgqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iH9vCvN0QdzUDbjprcuzP65cHszRdziaiiKSk9Am8yxyWtjXmW+ymacjk8iXJvO+dj
         cszVIEEVyagtuTMmE6YRtFL3VjQuRv9ijh0qxhMVE5yyaw1v9oo/M41wgAySRgoAGQxl
         yQfIFW6HP/8dwK0raihkvrIQCKamvY8ZtJ/3Q=
Received: by 10.213.68.129 with SMTP id v1mr2250009ebi.15.1267396010119; Sun, 
	28 Feb 2010 14:26:50 -0800 (PST)
In-Reply-To: <ca433831002281214q14e6e62bj54cf7227cd32873b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141291>

On Sun, Feb 28, 2010 at 14:14, Mark Lodato <lodatom@gmail.com> wrote:
> On Sat, Feb 27, 2010 at 6:43 AM, Ren=C3=A9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>> Am 27.02.2010 05:57, schrieb Mark Lodato:
>>> 1. With --name-only, GNU grep colors the filenames, but we do not. =
=C2=A0I do
>>> =C2=A0 =C2=A0not see any point to making everything the same color.
>>
>> I guess they did it for consistency, so when you see "magenta" you t=
hink
>> "filename", and because it can be turned off with a switch. =C2=A0Wi=
th your
>> patch all filenames are coloured the same, too, by the way: using th=
e
>> default foreground colour. :)
>
> Yes, I think I understand the reasoning, but to me it is very
> annoying. =C2=A0However, if there is a consensus that we should follo=
w GNU
> grep in this regard, I will do it.

I'm in favor of colorizing the output even when just one piece of
information is presented. If I turn on colorization, then there should
be colorization; my brain would expect it, especially when I first
grep without --name-only and then turn on --name-only after getting
results that I like.

Of course, I bet you find colorizing the filenames a nuisance because
you don't care to pipe the relevant escape sequences to other
commands. On that note, it would be nice to have something like GNU's
--color=3D(auto|yes|no) with `auto' as the default for a plain --color.

As a compromise (and perhaps as an improvement), perhaps only the
basename of the filename should be colorized when --name-only is used;
that way, colorization is still being used to differentiate different
data, and the rest of the path is usually not that interesting anyway.
However, for consistency, I would still think it wise to colorize the
dirname portion with `color.grep.filename', but color the basename
portion with `color.grep.match' (as though the basename portion is the
text being matched).

Sincerely,
Michael Witten
