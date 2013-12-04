From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/5] gitweb: Add a comment explaining the meaning of $/
Date: Wed, 4 Dec 2013 18:34:30 +0100
Message-ID: <CANQwDwfiYAz7dro9mppR62xEFMPTSNjEKYM=7Dhq7auBvyXjSg@mail.gmail.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
 <1386164583-14109-2-git-send-email-krzesimir@endocode.com>
 <CANQwDwdiNHFCChVdkKxkEa+HOKzzhgfzy4d6iZB6ejSfva3Z3A@mail.gmail.com> <1386171977.2173.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 18:35:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoGM1-0000rD-5j
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 18:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab3LDRfN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 12:35:13 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:51949 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755285Ab3LDRfL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 12:35:11 -0500
Received: by mail-wi0-f175.google.com with SMTP id hi5so8643480wib.14
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 09:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=lm7hupWrSfBCQYzEqJMCV++UXm9Z+iGeNkF1FnSstwY=;
        b=mYJNuXR2Kev2NbYkFIq6j2tRQ7q8l5vG/qvojHHc1syNphhQAv7WPJ//XDBVc3KdTA
         B5nPFWv6PcDEl5BiOXlCKbPkvc2WfFG20K3lJMo08hQ+xaU4rYrHWcAoMEXwesemaGwJ
         99wIvGIMMBTc0xsoYcu6LJK2jVc7SS/7y/uhbpDLi70J0dOBH0bm8bKdpkvJiOofYPMn
         L21uXKlVB96NJFRxmboEHMMCSY8FFS+/xmTcoVzNCTocQa4aPL8sPGW2Xnls7p8sZJLl
         SUk5I9VnhRVjX9iU5zrxVQikkAUY1CDGm0/P7zGH/rt1fs/trLO4Is7CW//ij/T+Lngt
         JNrw==
X-Received: by 10.194.175.133 with SMTP id ca5mr64058195wjc.19.1386178510411;
 Wed, 04 Dec 2013 09:35:10 -0800 (PST)
Received: by 10.227.108.131 with HTTP; Wed, 4 Dec 2013 09:34:30 -0800 (PST)
In-Reply-To: <1386171977.2173.23.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238791>

On Wed, Dec 4, 2013 at 4:46 PM, Krzesimir Nowak <krzesimir@endocode.com=
> wrote:
> On Wed, 2013-12-04 at 16:11 +0100, Jakub Nar=C4=99bski wrote:
>> On Wed, Dec 4, 2013 at 2:42 PM, Krzesimir Nowak <krzesimir@endocode.=
com> wrote:
>>
>> > So future reader will know what does it mean without running "perl=
doc
>> > perlvar".
>>
>> Hmmm... shouldn't future reader know it anyway?  It is not that cryp=
tic.
>> I'd say it is idiomatic Perl.
>
> It's plainly obscure. And I think it is not that often used - I keep
> forgetting what that pair of punctuation is actually meaning.

I think it depends on what kind of Perl code one is used to. It is not
as obscure as $; and similar to $|, I think.

> In this case I guess it would be more readable to use the following c=
ode
> instead:
>
>    $fh->input_record_separator ("\0");

That would be a good change to replace

        local $/ =3D "\0";

        open my $fh, "-|", git_cmd(), ..., '-z', ...

with

        open my $fh, "-|", git_cmd(), ..., '-z', ...
        $fh->input_record_separator ("\0");

(not forgetting about "use IO::Handle", which module is core Perl modul=
e);


Anyway, this change (or proposed change) does not, IMHO, belong
in this series.

--=20
Jakub Narebski
