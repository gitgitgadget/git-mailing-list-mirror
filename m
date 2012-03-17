From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 7/9] difftool: teach difftool to handle directory diffs
Date: Sat, 17 Mar 2012 10:18:58 -0400
Message-ID: <CAFouetgFwaksCpggMER28i9UhEfpWhRcx5To8ck0Bsv+mbirTg@mail.gmail.com>
References: <1331949574-15192-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr4mc7OwUzE9d51KkgMaMauVJx_T=rdmXnhEc_a0hc0LGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 15:19:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8uTN-0008Ic-60
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 15:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab2CQOTA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 10:19:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39474 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab2CQOS7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 10:18:59 -0400
Received: by iagz16 with SMTP id z16so6903936iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YcVFII3aZZ3WUF+m6Gt04tsUHRH25dad9HdmwcHEDY8=;
        b=C5iV54NmrX+A+tbwnrjaoFqlJyFOmpSDjzBDTgpY2g0lLHbHmCqHtbF/CjQ2KJDU9Q
         3fC2KzaKqZVsRFxJg+rYrZxytVggFDTSxWucyD9PZh2vePzNynO5/xUe0jsSYaw69S34
         iLuFQmDtI8x/uZwGjQtcWB+VsNVmtopICxy5WyUNXNIBUh8ZBtn6y0mCsgRXJ4JcgvsY
         HFAaiQJT7syGbWBvhIqPkwf5a7Hf5EHtJSrzudYxs23zvx6dVL+DzkUfTGnpSob+j5D5
         40ZhvimjhtppTZJT36eciBHKBFSZIlA8bWT8HcsL3GPDGkYL4eEB0Gz5ovFsvcs7IRhu
         wF1w==
Received: by 10.50.188.138 with SMTP id ga10mr1962361igc.51.1331993938902;
 Sat, 17 Mar 2012 07:18:58 -0700 (PDT)
Received: by 10.42.218.65 with HTTP; Sat, 17 Mar 2012 07:18:58 -0700 (PDT)
In-Reply-To: <CAJDDKr4mc7OwUzE9d51KkgMaMauVJx_T=rdmXnhEc_a0hc0LGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193327>

On Fri, Mar 16, 2012 at 11:08 PM, David Aguilar <davvid@gmail.com> wrot=
e:
> On Fri, Mar 16, 2012 at 6:59 PM, Tim Henigan <tim.henigan@gmail.com> =
wrote:

>> + =C2=A0 =C2=A0 =C2=A0 # Setup temp directories
>> + =C2=A0 =C2=A0 =C2=A0 my $tmpdir =3D tempdir('/tmp/git-diffall.XXXX=
X', CLEANUP =3D> 1);
>
> Is it okay to hardcode /tmp here, or should we instead do something l=
ike this?:
>
> =C2=A0 =C2=A0my $tmp =3D $ENV{TMPDIR} || '/tmp';

This could be done better.  Based on the documentation [1], it appears
that the proper way to do this is:

    my $tmpdir =3D tempdir('git-diffall.XXXXX', CLEANUP =3D> 1, TMPDIR =
=3D> 1);

Adding 'TMPDIR =3D> 1' is the equivalent of commanding the tmp dir to b=
e
created in 'File::Spec->tmpdir' [2].

I will try this out and send a v2 patch.

[1]: http://perldoc.perl.org/File/Temp.html
[2]: http://perldoc.perl.org/File/Spec.html
