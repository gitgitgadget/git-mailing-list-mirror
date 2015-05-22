From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH v2] send-email: Add simple email aliases format
Date: Thu, 21 May 2015 23:19:29 -0400
Message-ID: <CAJ80savXAOMAbdDC_F77esD1Fdi=BP6GK4biFOLJTtqqehjEOw@mail.gmail.com>
References: <4b56f6ab3c14aff7752804d11917b1f330f55f40.1432252898.git.allenbh@gmail.com>
	<CAPig+cQ8Gw3Q1QcJ=k4647LW1gBZ3fuJBYpOCE=AxA0ZWtktmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 22 05:19:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvdUm-0003UP-QM
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 05:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246AbbEVDTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 23:19:31 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33318 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854AbbEVDTb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 23:19:31 -0400
Received: by wgez8 with SMTP id z8so5319798wge.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 20:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HBbnai7tnsdXv/kJX2SiJkPtB/0IpdopBX6rTmVW1Vs=;
        b=w6L1yswJUZ7Ru/d/nZpOxzPhGrhuhv90u6AcH8L0WR5DhmQY41DTsO0HogJt8w4HvX
         CGDsTkOeWUi2C/WtRAQvuNcy2UascmzR1N8d6mUL3uK1CXDp2ebmovbhHRBjABYISMbC
         vDNqweMv/mLkIcf/DivNb7txxzps0AGdlIQXVBHw2mK/L9EvrNof90HpA/SOK0lP2f9+
         MQqGFMKvRRUczm1dDT97pzEYqDtwXC2lNka82AoBw7pGlgmFDANu3ZQQpgGmv5/5OhuV
         /TMbL+Be/9RhSVKIp833gxytl+y1XeVWk3yz7ELhTbgBis17oGIqSsUliQDrcriKt4Se
         bjlA==
X-Received: by 10.180.206.229 with SMTP id lr5mr3204949wic.86.1432264769677;
 Thu, 21 May 2015 20:19:29 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Thu, 21 May 2015 20:19:29 -0700 (PDT)
In-Reply-To: <CAPig+cQ8Gw3Q1QcJ=k4647LW1gBZ3fuJBYpOCE=AxA0ZWtktmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269684>

On May 21, 2015 9:05 PM, "Eric Sunshine" <sunshine@sunshineco.com> wrote:
>
> On Thu, May 21, 2015 at 8:16 PM, Allen Hubbe <allenbh@gmail.com> wrote:
> > This format is more simple than the other alias file formats, so it may
> > be preferred by some users.  The format is as follows.
> >
> > <alias>: <address|alias>[, <address|alias>...]
> >
> > Aliases are specified one per line.  There is no line splitting.
> >
> > Example:
> >         alice: Alice W Land <awol@example.com>
> >         bob: Robert Bobbyton <bob@example.com>
> >         chloe: chloe@example.com
> >         abgroup: alice, bob
> >         bcgrp: bob, chloe, Other <o@example.com>
> >
> > Signed-off-by: Allen Hubbe <allenbh@gmail.com>
> > ---
> > diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> > index 804554609def..99583c4f8969 100644
> > --- a/Documentation/git-send-email.txt
> > +++ b/Documentation/git-send-email.txt
> > @@ -383,7 +383,7 @@ sendemail.aliasesFile::
> >
> >  sendemail.aliasFileType::
> >         Format of the file(s) specified in sendemail.aliasesFile. Must be
> > -       one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
> > +       one of 'mutt', 'mailrc', 'pine', 'elm', 'gnus', or 'simple'.
>
> It's perhaps somewhat unfortunate that the formats of the other alias
> file types aren't described here, however, the reader can at least
> look them up. But the new "simple" format is never described anywhere
> in the documentation, so it's effectively unusable. Most users will be
> unable or unwilling to consult the source code or the commit message
> to figure out how to use this format. The description you wrote for
> the commit message might be sufficient as proper documentation (with
> proper Asciidoc formatting, of course).

Ok, I will add the description in the commit, formatted, to the documentation.

>
> >  sendemail.multiEdit::
> >         If true (default), a single editor instance will be spawned to edit
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index e1e9b1460ced..25d72e8db8bf 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -515,7 +515,11 @@ my %parse_alias = (
> >                                $aliases{$alias} = [ split_addrs($addr) ];
> >                           }
> >                       } },
> > -
> > +       simple => sub { my $fh = shift; while (<$fh>) {
> > +               if (/^\s*(\S+)\s*:\s*(.+)$/) {
>
> I imagine that users would appreciate being able to add comments to
> their aliases file, and the implementation complexity to support
> comment lines and blank lines (as described in the Postfix aliases
> documentation you cited earlier[1]) would be so minor that I'm rather
> surprised you chose not to do so.

I will add support for comments. Anything after the first '#' in any
line will be treated as a comment.

>
> [1]: http://www.postfix.org/aliases.5.html
>
> > +                       my ($alias, $addr) = ($1, $2);
> > +                       $aliases{$alias} = [ split_addrs($addr) ];
> > +               }}},
> >         gnus => sub { my $fh = shift; while (<$fh>) {
> >                 if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
> >                         $aliases{$1} = [ $2 ];
> > diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> > index 7be14a4e37f7..bbb73cdf8bec 100755
> > --- a/t/t9001-send-email.sh
> > +++ b/t/t9001-send-email.sh
> > @@ -1548,6 +1548,30 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
> >                 2>errors >out &&
> >         grep "^!someone@example\.org!$" commandline1
> >  '
> > +test_expect_success $PREREQ 'sendemail.aliasfiletype=simple' '
> > +       clean_fake_sendmail && rm -fr outdir &&
> > +       git format-patch -1 -o outdir &&
> > +       {
> > +               echo "alice: Alice W Land <awol@example.com>"
> > +               echo "bob: Robert Bobbyton <bob@example.com>"
> > +               echo "chloe: chloe@example.com"
> > +               echo "abgroup: alice, bob"
> > +               echo "bcgrp: bob, chloe, Other <o@example.com>"
> > +       } >~/.tmp-email-aliases &&
>
> A here-doc would be easier to maintain and read:
>
>     cat >~/.tmp-email-aliases <<-\EOF &&
>         alice: Alice W Land <awol@example.com>
>         bob: Robert Bobbyton <bob@example.com>
>         ...
>     EOF

A here-doc does not flow nicely in an indented block.  Each line in
the here-doc will also contain any indentation which may appear to the
reader to be part of the test case.  Alternatively, the here-doc could
be indented differently than the surrounding test case (all the way to
the left column), but that also has a negative impact for readability.
Finally, the EOF marker can not be indented.

With echo "string", exactly "string" is output to the line.  The
operation is obvious to the reader.  The test case can use sane
indentation, and the resulting output will be exactly what what it
would appear to be in the test case.

Especially for something like a test case where there should be
absolutely no confusion as to exactly what is the input to the test,
clarity matters.  Any operation where the result is not immediately
obvious to the reader, does not belong here.  Therefore, I will keep
the lines in the test case as echo "string".

>
> > +       git config --replace-all sendemail.aliasesfile \
> > +               "$(pwd)/.tmp-email-aliases" &&
> > +       git config sendemail.aliasfiletype simple &&
> > +       git send-email \
> > +               --from="Example <nobody@example.com>" \
> > +               --to=alice --to=bcgrp \
> > +               --smtp-server="$(pwd)/fake.sendmail" \
> > +               outdir/0001-*.patch \
> > +               2>errors >out &&
> > +       grep "^!awol@example\.com!$" commandline1 &&
> > +       grep "^!bob@example\.com!$" commandline1 &&
> > +       grep "^!chloe@example\.com!$" commandline1 &&
> > +       grep "^!o@example\.com!$" commandline1
> > +'
> >
> >  do_xmailer_test () {
> >         expected=$1 params=$2 &&
> > --
> > 2.3.4
