From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT 20/28] "guilt graph": Handle patch names containing quotes.
Date: Thu, 8 May 2014 22:18:44 +0200
Message-ID: <CAP=KgsSOz7Yg=J42QU9rUKmX+rxppXVVHs5S4G-_KOcUr+Lwaw@mail.gmail.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
	<1395387126-13681-21-git-send-email-cederp@opera.com>
	<CAPig+cQ8aPSjCzf0AjNQRvtJJ52eaOi=fJNZ8vXdnFoE5vxyAQ@mail.gmail.com>
	<20140506202446.GQ1655@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Thu May 08 22:18:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiUmI-0006Kn-R4
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 22:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786AbaEHUSr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 May 2014 16:18:47 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:39575 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688AbaEHUSp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 May 2014 16:18:45 -0400
Received: by mail-ig0-f174.google.com with SMTP id h3so270364igd.13
        for <git@vger.kernel.org>; Thu, 08 May 2014 13:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Kkmls1X/EUabBMDmN9f8ky+v+HYOh/vWKACIejBUOnk=;
        b=LIOEBzvdFKzlBwbzIgKU1XRFCW+3xBRoX4cokpk5qXO4fmVDpl0SQiJKj4lMci5yEc
         vMnLHyKRwyz5cus812StWLB0i6fKVMYo+RQ3GUBE0uQs/k2cYeHIyGAlnmS7pckO3fbG
         A0cElfoQ65iAxNERfUKV8PHucAfZfVCpT7FwkqWimyPsBMXoJdxumZeC/qltNhtTvprn
         ZHA6UXlTCql8No4FTtOE5JobWY3XPxLiXRDjtWK+N8PpNKYAhMplutRtHOT6oyHX5lGE
         DVCX1Oe0cXTDev5kF2a5PAoJ8gtElA9BJpuGO60Czaa1PkJmwM80msR93vZgC11X9u67
         KqvQ==
X-Gm-Message-State: ALoCoQnVhX7WjXborNYz7SBcOmNITHGZzTn5sDyct3S/oF4Mnnons9A2S3xlyDzgNLbcoRozGquG
X-Received: by 10.50.66.227 with SMTP id i3mr12156473igt.19.1399580324865;
 Thu, 08 May 2014 13:18:44 -0700 (PDT)
Received: by 10.43.89.66 with HTTP; Thu, 8 May 2014 13:18:44 -0700 (PDT)
In-Reply-To: <20140506202446.GQ1655@meili.valhalla.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248440>

On Tue, May 6, 2014 at 10:24 PM, Jeff Sipek <jeffpc@josefsipek.net> wro=
te:
> On Fri, Mar 21, 2014 at 03:57:37AM -0400, Eric Sunshine wrote:
>> On Fri, Mar 21, 2014 at 3:31 AM, Per Cederqvist <cederp@opera.com> w=
rote:
>> > Quote quotes with a backslash in the "guitl graph" output.  Otherw=
ise,
>>
>> s/guitl/guilt/
>
> Yep.

Oups. Will fix.

>> > the "dot" file could contain syntax errors.
>> >
>> > Added a test case.
>> > ---
>> >  guilt-graph          |  2 ++
>> >  regression/t-033.out | 22 ++++++++++++++++++++++
>> >  regression/t-033.sh  |  9 +++++++++
>> >  3 files changed, 33 insertions(+)
>> >
>> > diff --git a/guilt-graph b/guilt-graph
>> > index 575f03b..24ab83b 100755
>> > --- a/guilt-graph
>> > +++ b/guilt-graph
>> > @@ -58,6 +58,8 @@ while [ "$current" !=3D "$base" ]; do
>> >  }"`
>> >         [ -z "$pname" ] && pname=3D"?"
>> >
>> > +       pname=3D"`printf \"%s\" $pname|sed 's/\"/\\\\\"/g'`"
>
> Some of this filtering is getting a bit unwieldy.  I'd add spaces aro=
und the
> |.  Do we want to be paranoid and add quotes around $pname?  If not, =
then it
> looks good.

Indeed. I wish I could think of a better way to do this. :-)

I'll add spaces, and quote $pname just to play safe.

    /ceder

>> > +
>> >         disp "# checking rev $current"
>> >         disp "  \"$current\" [label=3D\"$pname\"]"
>> >
>> > diff --git a/regression/t-033.out b/regression/t-033.out
>> > index e638d7b..1c28ea9 100644
>> > --- a/regression/t-033.out
>> > +++ b/regression/t-033.out
>> > @@ -63,3 +63,25 @@ digraph G {
>> >         "ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label=3D"a.pat=
ch"]
>> >         "891bc14b5603474c9743fd04f3da888644413dc5" -> "ff2775f8d1d=
c753f635830adcc3a067e0b681e2d"; // ?
>> >  }
>> > +% guilt new a-"better&quicker'-patch.patch
>> > +% git add file.txt
>> > +% guilt refresh
>> > +Patch a-"better&quicker'-patch.patch refreshed
>> > +% guilt pop
>> > +Now at c.patch.
>> > +% guilt push
>> > +Applying patch..a-"better&quicker'-patch.patch
>> > +Patch applied.
>> > +% guilt graph
>> > +digraph G {
>> > +# checking rev bc7df666a646739eaf559af23cab72f2bfd01f0e
>> > +       "bc7df666a646739eaf559af23cab72f2bfd01f0e" [label=3D"a-\"b=
etter&quicker'-patch.patch"]
>> > +# checking rev 891bc14b5603474c9743fd04f3da888644413dc5
>> > +       "891bc14b5603474c9743fd04f3da888644413dc5" [label=3D"c.pat=
ch"]
>> > +       "bc7df666a646739eaf559af23cab72f2bfd01f0e" -> "891bc14b560=
3474c9743fd04f3da888644413dc5"; // ?
>> > +# checking rev c7014443c33d2b0237293687ceb9cbd38313df65
>> > +       "c7014443c33d2b0237293687ceb9cbd38313df65" [label=3D"b.pat=
ch"]
>> > +# checking rev ff2775f8d1dc753f635830adcc3a067e0b681e2d
>> > +       "ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label=3D"a.pat=
ch"]
>> > +       "891bc14b5603474c9743fd04f3da888644413dc5" -> "ff2775f8d1d=
c753f635830adcc3a067e0b681e2d"; // ?
>> > +}
>> > diff --git a/regression/t-033.sh b/regression/t-033.sh
>> > index 57dce78..968292c 100755
>> > --- a/regression/t-033.sh
>> > +++ b/regression/t-033.sh
>> > @@ -46,3 +46,12 @@ cmd git add file.txt
>> >  cmd guilt refresh
>> >  fixup_time_info c.patch
>> >  cmd guilt graph
>> > +
>> > +# A patch name that contains funky characters, including unbalanc=
ed
>> > +# quotes.
>> > +cmd guilt new "a-\"better&quicker'-patch.patch"
>> > +cmd echo d >> file.txt
>> > +cmd git add file.txt
>> > +cmd guilt refresh
>> > +fixup_time_info "a-\"better&quicker'-patch.patch"
>> > +cmd guilt graph
>> > --
>> > 1.8.3.1
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe git" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> All parts should go together without forcing.  You must remember that=
 the
> parts you are reassembling were disassembled by you.  Therefore, if y=
ou
> can=E2=80=99t get them together again, there must be a reason.  By al=
l means, do not
> use a hammer.
>                 =E2=80=94 IBM Manual, 1925
