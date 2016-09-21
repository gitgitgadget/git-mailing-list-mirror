Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1B231F935
	for <e@80x24.org>; Wed, 21 Sep 2016 22:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933863AbcIUWPo (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 18:15:44 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40080 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932337AbcIUWPn (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Sep 2016 18:15:43 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 96DA2204AD;
        Wed, 21 Sep 2016 18:15:42 -0400 (EDT)
Received: from web3 ([10.202.2.213])
  by compute5.internal (MEProxy); Wed, 21 Sep 2016 18:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=iankelling.org; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=vkhjBLf8gonS39qOtSstAz8WuaY=; b=lxiskR
        yoOKa9cfNJOucJpgED8SPhgCuT33hRZux4ajgWjqOoQme+VMVvaERDfmGQzo0r4T
        p2nrFyI6mmrkhqLW9Z+txV3I19oSjlQlD56t4ti6NZcAXtD184Ehe3u+iX/Strxm
        c+Spzhs0bMFMjsRRWy0yPZQnquLse2IQatz0k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=vkhjBLf8gonS39q
        OtSstAz8WuaY=; b=ehJstTxTH73YqDr5Zu5R1k+yDfFr3PRpTj2mTPOPTeCeybZ
        kleAWyxZ2hQSe6CHwOYD4BybRn1NzyzogIZ/EhZEcD3pzfCn+qfYrp1wEZxY59lE
        qWEXReJ3QyhefBD1sanDN5I9mgAzbLIgkUzjgSTj7YfzZEnCWLpaZatns7os=
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 6297F2E6CE; Wed, 21 Sep 2016 18:15:42 -0400 (EDT)
Message-Id: <1474496142.400086.733142417.560B3AFF@webmail.messagingengine.com>
X-Sasl-Enc: qeasUWYBTbOTZe9I7R2DAS9hlgW/vLRDAuhx8T5GTCvZ 1474496142
From:   Ian Kelling <ian@iankelling.org>
To:     =?utf-8?Q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-43c89091
Subject: Re: [PATCH] gitweb: use highlight's shebang detection
Date:   Wed, 21 Sep 2016 15:15:42 -0700
In-Reply-To: <108ce713-337a-801a-6c3b-089ef25a3883@gmail.com>
References: <20160906190037.12442-1-ian@iankelling.org>
 <108ce713-337a-801a-6c3b-089ef25a3883@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2016, at 01:22 PM, Jakub Nar=C4=99bski wrote:
> W dniu 06.09.2016 o 21:00, Ian Kelling pisze:
>
> > The highlight binary can detect language by shebang when we can't tell
> > the syntax type by the name of the file.
>
> Was it something always present among highlight[1] binary capabilities,
> or is it something present only in new enough highlight app?  Or only
> in some specific fork / specific binary?  I couldn't find language
> detection in highlight[1] documentation...
>
> [1]: http://www.andre-simon.de/doku/highlight/en/highlight.php

Search for the word shebang, it's mentioned twice.

>
> If this feature is available only for some version, or for some
> highlighters, gitweb would have to provide an option to configure
> it.  It might be an additional configuration variable, it might
> be a special value in the %highlight_basename or %highlight_ext.

Good question. It was added upstream in 2007, and I tested that it's
functioning in the earliest distros I have easy access to: ubuntu 14.04
and debian wheezy.

>
> >                                          To use highlight's shebang
> > detection, add highlight to the pipeline whenever highlight is enabled.
>
> This describes what this patch does, but the sentence feels
> a bit convoluted, as it is stated.
>

Agreed. I've changed it in v2 of the patch, and perhaps this will make
the rest of the patch clearer too. The new paragraph is:

    The highlight binary can detect language by shebang when we can't
    tell
    the syntax type by the name of the file. In that case, pass the blob
    to "highlight --force" and the resulting html will have markup for
    highlighting if the language was detected.



> >
> > Document the shebang detection and add a test which exercises it in
> > t/t9500-gitweb-standalone-no-errors.sh.
>
> Nice!
>
> >
> > Signed-off-by: Ian Kelling <ian@iankelling.org>
> > ---
> >
> > Notes:
> >     I wondered if adding highlight to the pipeline would make viewing a=
 blob
> >     with no highlighting take longer but it did not on my computer. I f=
ound
> >     no noticeable impact on small files and strangely, on a 159k file, =
it
> >     took 7% less time averaged over several requests.
>
> Strange.  I would guess that invoking separate binary and perl would
> always
> add to the time (especially on operation systems where forking / running
> command is expensive... though those are not often used with web servers,
> isn't it).

I dug into this a little more, and I think it's because when we call
highlight, we later call sanitize() instead of esc_html(). sanitize() is
faster and makes up for the extra time highlight takes. I ran a test on
my machine calling sanitize and esc_html on each line of gitweb.perl 100
times: 7.4s for sanitize, 12.4s for esc_html.

>
> >
> >  Documentation/gitweb.conf.txt          | 21 ++++++++++++++-------
> >  gitweb/gitweb.perl                     | 10 +++++-----
> >  t/t9500-gitweb-standalone-no-errors.sh | 18 +++++++++++++-----
> >  3 files changed, 32 insertions(+), 17 deletions(-)
> >
> > diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.=
txt
> > index a79e350..e632089 100644
> > --- a/Documentation/gitweb.conf.txt
> > +++ b/Documentation/gitweb.conf.txt
> > @@ -246,13 +246,20 @@ $highlight_bin::
> >  	Note that 'highlight' feature must be set for gitweb to actually
> >  	use syntax highlighting.
> >  +
> > -*NOTE*: if you want to add support for new file type (supported by
> > -"highlight" but not used by gitweb), you need to modify `%highlight_ex=
t`
> > -or `%highlight_basename`, depending on whether you detect type of file
> > -based on extension (for example "sh") or on its basename (for example
> > -"Makefile").  The keys of these hashes are extension and basename,
> > -respectively, and value for given key is name of syntax to be passed v=
ia
> > -`--syntax <syntax>` to highlighter.
> > +*NOTE*: for a file to be highlighted, its syntax type must be detected
> > +and that syntax must be supported by "highlight".  The default syntax
> > +detection is minimal, and there are many supported syntax types with no
> > +detection by default.  There are three options for adding syntax
> > +detection.  The first and second priority are `%highlight_basename` and
> > +`%highlight_ext`, which detect based on basename (the full filename, f=
or
> > +example "Makefile") and extension (for example "sh").  The keys of the=
se
> > +hashes are the basename and extension, respectively, and the value for=
 a
> > +given key is the name of the syntax to be passed via `--syntax <syntax=
>`
> > +to "highlight".  The last priority is the "highlight" configuration of
> > +`Shebang` regular expressions to detect the language based on the first
> > +line in the file, (for example, matching the line "#!/bin/bash").  See
> > +the highlight documentation and the default config at
> > +/etc/highlight/filetypes.conf for more details.
>
> All right; in addition to expanding the docs, it also improves them.

Noted in v2 commit log.

>
> >  +
> >  For example if repositories you are hosting use "phtml" extension for
> >  PHP files, and you want to have correct syntax-highlighting for those
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 33d701d..a672181 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -3931,15 +3931,16 @@ sub guess_file_syntax {
> >  # or return original FD if no highlighting
> >  sub run_highlighter {
> >  	my ($fd, $highlight, $syntax) =3D @_;
> > -	return $fd unless ($highlight && defined $syntax);
> > +	return $fd unless ($highlight);
>
> Here we would have check if we want / can invoke "highlight".

I think it's right as is. $highlight says the user wants highlighting,
and now we still want to invoke it when we do not know $syntax.

While I was double checking, I noticed there was an unused parameter to
guess_file_syntax(), $mimetype, which could easily make this not
obvious. I removed it in v2.

>
> >
> >  	close $fd;
> > +	my $syntax_arg =3D (defined $syntax) ? "--syntax $syntax" : "--force";
> >  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
> >  	          quote_command($^X, '-CO', '-MEncode=3Ddecode,FB_DEFAULT', '=
-pse',
> >  	            '$_ =3D decode($fe, $_, FB_DEFAULT) if !utf8::decode($_);=
',
> >  	            '--', "-fe=3D$fallback_encoding")." | ".
> >  	          quote_command($highlight_bin).
> > -	          " --replace-tabs=3D8 --fragment --syntax $syntax |"
> > +	          " --replace-tabs=3D8 --fragment $syntax_arg |"
> >  		or die_error(500, "Couldn't open file or run syntax highlighter");
> >  	return $fd;
> >  }
>
> All right (well, except for the question asked at the beginning).
>
> > @@ -7063,8 +7064,7 @@ sub git_blob {
> >
> >  	my $highlight =3D gitweb_check_feature('highlight');
> >  	my $syntax =3D guess_file_syntax($highlight, $mimetype, $file_name);
> > -	$fd =3D run_highlighter($fd, $highlight, $syntax)
> > -		if $syntax;
>
> Hmmm... it looks like the old code checked if there was $syntax defined
> twice: once for truthy value in caller, once for definedness in
> run_highlighter().
>
> > +	$fd =3D run_highlighter($fd, $highlight, $syntax);
>
> All right.
>
> >
> >  	git_header_html(undef, $expires);
> >  	my $formats_nav =3D '';
> > @@ -7117,7 +7117,7 @@ sub git_blob {
> >  			$line =3D untabify($line);
> >  			printf qq!<div class=3D"pre"><a id=3D"l%i" href=3D"%s#l%i" class=3D=
"linenr">%4i</a> %s</div>\n!,
> >  			       $nr, esc_attr(href(-replay =3D> 1)), $nr, $nr,
> > -			       $syntax ? sanitize($line) : esc_html($line, -nbsp=3D>1);
> > +			       $highlight ? sanitize($line) : esc_html($line, -nbsp=3D>1);
>
> Oh, well.  It looks like checking if highlighter could be run in
> run_highlight() is wrong, as the caller (that is, git_blob()) needs
> to know if it is using "highlight" output (which is HTML) or raw blob
> contents (which needs to be HTML-escaped).

Per previous comment, run_highlight() is right, and we use the same
condition here to know if the highlight binary was used. If highlight
was run with --force and did not detect a language in the shebang, it
still outputs html but without adding the highlight markup.

>
> >  		}
> >  	}
> >  	close $fd
> > diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-st=
andalone-no-errors.sh
> > index e94b2f1..9e5fcfe 100755
> > --- a/t/t9500-gitweb-standalone-no-errors.sh
> > +++ b/t/t9500-gitweb-standalone-no-errors.sh
> > @@ -702,12 +702,20 @@ test_expect_success HIGHLIGHT \
> >  	 gitweb_run "p=3D.git;a=3Dblob;f=3Dfile"'
> >
> >  test_expect_success HIGHLIGHT \
> > -	'syntax highlighting (highlighted, shell script)' \
> > +	'syntax highlighting (highlighted, shell script shebang)' \
>
> It would be nice to have in test name that it checks if highlighter
> autodetection works, or at least doesn't crash gitweb.

I've updated it to:
syntax highlighting (highlighter language autodetection)
I'm happy to use any suggestion you have.

>
> >  	'git config gitweb.highlight yes &&
> > -	 echo "#!/usr/bin/sh" > test.sh &&
> > -	 git add test.sh &&
> > -	 git commit -m "Add test.sh" &&
> > -	 gitweb_run "p=3D.git;a=3Dblob;f=3Dtest.sh"'
> > +	 echo "#!/usr/bin/sh" > test &&
> > +	 git add test &&
> > +	 git commit -m "Add test" &&
> > +	 gitweb_run "p=3D.git;a=3Dblob;f=3Dtest"'
> > +
> > +test_expect_success HIGHLIGHT \
> > +	'syntax highlighting (highlighted, header file)' \
>
> Do we check explicit syntax knowledge (based on the extension),
> or autodetect again?

We have explicit syntax knowledge here. My thinking was this would
modify the existing test so that it highlights a different language than
the autodetected one, but the patch is simpler if I just make the
autodetcted one be a different language. I've done that in v2.

>
> > +	'git config gitweb.highlight yes &&
> > +	 echo "#define ANSWER 42" > test.h &&
> > +	 git add test.h &&
> > +	 git commit -m "Add test.h" &&
> > +	 gitweb_run "p=3D.git;a=3Dblob;f=3Dtest.h"'
> >
> >  # --------------------------------------------------------------------=
--
> >  # forks of projects
> >
>
> Thank you for your work on this patch,
> --
> Jakub Nar=C4=99bski

Thank you for reviewing it!
