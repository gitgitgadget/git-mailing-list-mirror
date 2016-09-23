Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8417A1F935
	for <e@80x24.org>; Fri, 23 Sep 2016 09:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030237AbcIWJIf (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 05:08:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34306 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030225AbcIWJIc (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Sep 2016 05:08:32 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2C16D203A1;
        Fri, 23 Sep 2016 05:08:31 -0400 (EDT)
Received: from web3 ([10.202.2.213])
  by compute5.internal (MEProxy); Fri, 23 Sep 2016 05:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=iankelling.org; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=iRpNEe2WjHCDkzG9LFjbL/Pb6YY=; b=AM+5dD
        Shp9ARf8+n6wOakre0IVJTkEHT11yHjwyidG7IJ3EZ0GAZ7TB+CPIISz70khYbgp
        J4pvbQJKPx0ho6xTam3te2YDpKlL/8ZXjXlvxS7eISppK+UGeF73zEXT8NvWoFDw
        Nti8oCNdQg29C4u1ShhCKS9OzFbKmaEAzcosU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=iRpNEe2WjHCDkzG
        9LFjbL/Pb6YY=; b=ZZT+kLcwOgEUwxicBle4ZCOO65ubbD8ZJtTQjBnMUiCip8T
        EmOfhb1pFiGDqHdyeIyxB0jzT0lAsKKK6hnhrBohotEB7dtkLdrDc9cl2Dwoa+Lm
        CcJl9wQYkZXHU6cAzKirj11yzF78EUwSh7bd/W0zBDQViSuQz1izR0ZwceZs=
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id E33422E6CC; Fri, 23 Sep 2016 05:08:30 -0400 (EDT)
Message-Id: <1474621710.919704.734654545.799DCFC3@webmail.messagingengine.com>
X-Sasl-Enc: h0HeGwUlPJWVfM+pUE/BsfBgdnFsraroMwsm4ow1jZJf 1474621710
From:   Ian Kelling <ian@iankelling.org>
To:     =?utf-8?Q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-3ce3fca2
In-Reply-To: <2a5aead0-d521-85eb-f304-7091683d8b40@gmail.com>
References: <108ce713-337a-801a-6c3b-089ef25a3883@gmail.com>
 <20160921221856.27830-1-ian@iankelling.org>
 <2a5aead0-d521-85eb-f304-7091683d8b40@gmail.com>
Subject: Re: [PATCH v2] gitweb: use highlight's shebang detection
Date:   Fri, 23 Sep 2016 02:08:30 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016, at 03:50 PM, Jakub Nar=C4=99bski wrote:
> W dniu 22.09.2016 o 00:18, Ian Kelling napisa=C5=82:
>
> > The highlight binary can detect language by shebang when we can't tell
> > the syntax type by the name of the file. In that case, pass the blob
> > to "highlight --force" and the resulting html will have markup for
> > highlighting if the language was detected.
>
> This description feels a bit convoluted. Perhaps something like this:
>
>   The "highlight" binary can, in some cases, determine the language type
>   by the means of file contents, for example the shebang in the first
>   line
>   for some scripting languages.  Make use of this autodetection for files
>   which syntax is not known by gitweb.  In that case, pass the blob
>   contents to "highlight --force"; the parameter is needed to make it
>   always generate HTML output (which includes HTML-escaping).

Nice. Using it in v3.

>
> Also, we might want to have the information about performance of this
> solution either in the commit message, or in commit comments.

I tested it more rigorously and added to v3 commit message.

>
> >
> > Document the feature and improve syntax highlight documentation, add
> > test to ensure gitweb doesn't crash when language detection is used,
>
> All right.
>
> > and remove an unused parameter from gitweb_check_feature().
>
> First, that is guess_file_syntax(), not gitweb_check_feature().
> Second, this change could be made into independent patch, for example
> preparatory one.


Oops. I split it out in v3.

>
> >
> > Signed-off-by: Ian Kelling <ian@iankelling.org>
> > ---
> >  Documentation/gitweb.conf.txt          | 21 ++++++++++++++-------
> >  gitweb/gitweb.perl                     | 14 +++++++-------
> >  t/t9500-gitweb-standalone-no-errors.sh |  8 ++++++++
> >  3 files changed, 29 insertions(+), 14 deletions(-)
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
> >  +
>
> I think the rewrite is a bit more readable.
>
> >  For example if repositories you are hosting use "phtml" extension for
> >  PHP files, and you want to have correct syntax-highlighting for those
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 33d701d..44094f4 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -3913,7 +3913,7 @@ sub blob_contenttype {
> >  # guess file syntax for syntax highlighting; return undef if no highli=
ghting
> >  # the name of syntax can (in the future) depend on syntax highlighter =
used
> >  sub guess_file_syntax {
> > -	my ($highlight, $mimetype, $file_name) =3D @_;
> > +	my ($highlight, $file_name) =3D @_;
>
> Right.
>
> >  	return undef unless ($highlight && defined $file_name);
> >  	my $basename =3D basename($file_name, '.in');
> >  	return $highlight_basename{$basename}
> > @@ -3931,15 +3931,16 @@ sub guess_file_syntax {
> >  # or return original FD if no highlighting
> >  sub run_highlighter {
> >  	my ($fd, $highlight, $syntax) =3D @_;
> > -	return $fd unless ($highlight && defined $syntax);
> > +	return $fd unless ($highlight);
>
> Run highlighter if it is defined, even if gitweb doesn't know syntax,
> right.
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
>
> Use '--force' if syntax is unknown, right.
>
> >  		or die_error(500, "Couldn't open file or run syntax highlighter");
> >  	return $fd;
> >  }
> > @@ -7062,9 +7063,8 @@ sub git_blob {
> >  	$have_blame &&=3D ($mimetype =3D~ m!^text/!);
> >
> >  	my $highlight =3D gitweb_check_feature('highlight');
> > -	my $syntax =3D guess_file_syntax($highlight, $mimetype, $file_name);
> > -	$fd =3D run_highlighter($fd, $highlight, $syntax)
> > -		if $syntax;
> > +	my $syntax =3D guess_file_syntax($highlight, $file_name);
> > +	$fd =3D run_highlighter($fd, $highlight, $syntax);
>
> Remove unused parameter from callsite, *and* run highlighter even if we
> don't know syntax.
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
> This is a bit of code duplication / sync from run_highlighter(), but
> it is not your fault; it was there (and I don't know how to improve it).
>
> >  		}
> >  	}
> >  	close $fd
> > diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-st=
andalone-no-errors.sh
> > index e94b2f1..576db6d 100755
> > --- a/t/t9500-gitweb-standalone-no-errors.sh
> > +++ b/t/t9500-gitweb-standalone-no-errors.sh
>
> Nice.
>
> > @@ -709,6 +709,14 @@ test_expect_success HIGHLIGHT \
> >  	 git commit -m "Add test.sh" &&
> >  	 gitweb_run "p=3D.git;a=3Dblob;f=3Dtest.sh"'
> >
> > +test_expect_success HIGHLIGHT \
> > +	'syntax highlighting (highlighter language autodetection)' \
> > +	'git config gitweb.highlight yes &&
>
> Modern way would be
>
>   +       'test_config gitweb.highlight yes &&
>
> but other tests in this file do not use it.
>
> > +	 echo "#!/usr/bin/ruby" > test &&
>
> Preferred style would be
>
>   +        echo "#!/usr/bin/ruby" >test &&
>
> but other tests in this file do not use it.

Agreed, but leaving it as is for consistency.

>
> Sidenote: why Ruby, and not sh / bash, Perl or Python?

Not sh / bash, just to exercise more functionality of highlight by using
a different language than the other test. ruby just was the first thing
to come to mind since I've worked with it recently, but since you made
me think of it, perl is more likely to exist in the builtin config for
longer, and it seems a bit more fitting with gitweb, so its perl in v3.

>
> > +	 git add test &&
> > +	 git commit -m "Add test" &&
> > +	 gitweb_run "p=3D.git;a=3Dblob;f=3Dtest"'
> > +
> >  # --------------------------------------------------------------------=
--
> >  # forks of projects
> >
> >
>
> Thank you for your work.
> --
> Jakub Nar=C4=99bski
>

The only changes in v3 are the ones I described here.

Thank you for reviewing this.
--
Ian Kelling
