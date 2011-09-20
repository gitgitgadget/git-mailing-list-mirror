From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFCv4 2/4] gitweb: Add manpage for /etc/gitweb.conf (for
 gitweb documentation)
Date: Mon, 19 Sep 2011 23:41:18 -0500
Message-ID: <20110920044118.GI6343@elie>
References: <1316352884-26193-1-git-send-email-jnareb@gmail.com>
 <1316352884-26193-3-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 06:41:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5s9F-000879-QG
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 06:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989Ab1ITEl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 00:41:27 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34839 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab1ITElZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 00:41:25 -0400
Received: by gyg10 with SMTP id 10so88485gyg.19
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 21:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=a90I+QaAxThO1WLSjhwjaiNFq56f8epP0songug7rDs=;
        b=ce3W1/usiPyyynLq4naqRBivxBeHp/yM9P/jl8Z0DVJWu+cn5r/oGThJa8BDlRn7Vt
         z1Cqx6A1akhNM8l58lJfqd+RPWMehxEgCRuruTs0Dxpbqhvzlqjd9Dk1i+2Tq8cDjY41
         9UjyaMZx+kZoUDfdvAk4TSLIWDpnMwz1Y9OAw=
Received: by 10.236.178.102 with SMTP id e66mr1612401yhm.40.1316493685007;
        Mon, 19 Sep 2011 21:41:25 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id p8sm454975yhe.17.2011.09.19.21.41.21
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Sep 2011 21:41:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316352884-26193-3-git-send-email-jnareb@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181732>

Jakub Narebski wrote:

> [jn: Improved, extended, removed duplicate info from README]

Hoorah!  I have very little to add to what's already been done ---
mostly I can just lend my ear as a native English speaker.

[...]
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -3,7 +3,7 @@ MAN1_TXT= \
>  		$(wildcard git-*.txt)) \
>  	gitk.txt git.txt
>  MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
> -	gitrepository-layout.txt
> +	gitrepository-layout.txt gitweb.conf.txt

I take back what I wrote about patch 1.  Maybe its commit message could
be clarified to mention that the new targets build a subset of the pages
built by the ordinary "make doc" et al targets.

[...]
> +++ b/Documentation/gitweb.conf.txt
> @@ -0,0 +1,781 @@
[...]
> +The configuration file is used to override the default settings that
> +were built into gitweb at the time 'gitweb.cgi' script was generated.
> +
> +While one could just alter the configuration settings in the gitweb
> +CGI itself, those changes would be lost upon upgrade.  Configuration
> +settings might also be placed into a file in the same directory as the
> +CGI script with the default name 'gitweb_config.perl' -- allowing
> +one to have multiple gitweb instances with different configurations by
> +the use of symlinks.

This reads nicely now.  Language nit: missing "the" before
"'gitweb.cgi' script".

[...]
> +DISCUSSION
> +----------
> +Gitweb obtains configuration data from the following sources in the
> +following order:
> +
> + * built-in values (some set during build stage),
> +
> + * common system-wide configuration file (defaults to
> +   '/etc/gitweb-common.conf'),
> +
> + * either per-instance configuration file (defaults to 'gitweb_config.perl'
> +   in the same directory as the installed gitweb), or if it does not exists
> +   then system-wide configuration file (defaults to '/etc/gitweb.conf').

Usage nit: in the first sentence, "reads" would be more natural than
"obtains".

In the third item, I'd suggest the phrase "the fallback system-wide
configuration file" to emphasize how it differs from
gitweb-common.conf.

> +
> +Values obtained in later configuration files override values obtained earlier
> +in above sequence.

Language nit: missing "the" before "above sequence".

> +
> +The location of common system-wide configuration file, of fallback system-wide
> +configuration file and of per-instance configuration file is defined at compile
> +time using the build-time Makefile configuration variables, respectively
> +`GITWEB_CONFIG_COMMON`, `GITWEB_CONFIG_SYSTEM` and `GITWEB_CONFIG`.  

Language nits: missing "the" before "common system-wide configuration
file", "fallback system-wide configuration file", and "per-instance
configuration files".  The subject ("The location") and verb should be
plural because we are talking about multiple locations.  Would sound a
bit more natural in English (unlike French) if the preposition "of"
were used once instead of repeated.

Another language nit: it sounds a little better without the "the"
before "build-time Makefile configuration variables", like so:

	... are defined at compile time using build-time Makefile
	variables, namely `GITWEB_CONFIG_COMMON`, `GITWEB_CONFIG_SYSTEM`,
	and `GITWEB_CONFIG`.

> +
> +You can override location of gitweb configuration files during runtime
> +by setting respective environment variables: `GITWEB_CONFIG_COMMON`,
> +`GITWEB_CONFIG_SYSTEM` and `GITWEB_CONFIG` to non-empty value.

Language nit: missing "the" before "location" and "gitweb
configuration files".  "location" should probably be plural.  In place
of "respective", "the following" sounds a little more natural.  Might
be nice to add an "also" after 'can' to emphasize the relationship to
the previous paragraph --- in addition to being able to override the
default locations at compile time, you can override them at run time
by setting environment variables.

> +
> +
> +The syntax of the configuration files is that of Perl, as these files are
> +indeed handled as fragments of Perl code (the language that gitweb itself is
> +written in). Variables may be set using "`our $variable = value`"; text from
> +"#" character until the end of a line is ignored. See the *perlsyn*(1) man
> +page for more information.
> +
> +Actually using `our` qualifier in `our $variable = <value>;` is a safety
> +check: if newer gitweb does no longer use given variable, by using `our` we
> +won't get syntax errors.

Language nit: for "indeed", something like "internally" might be more
natural.

The syntax and the typical idiom were already described in the
DESCRIPTION section, so the emphasis should be somehow different here
to avoid boring the reader.  One way might be to plunge directly into
what the second paragraph above says:

 The syntax of the configuration files is that of Perl, since these files are
 handled by sourcing them as fragments of Perl code (the language that
 gitweb itself is written in). Variables are typically set using the
 `our` qualifier (as in "`our $variable = <value>;`") to avoid syntax
 errors if a new version of gitweb no longer uses a variable and therefore
 stops declaring it.

> +
> +You can include other configuration file using read_config_file()
> +subroutine.  For example, you can read defaults in fallback
> +system-wide GITWEB_CONFIG_SYSTEM from GITWEB_CONFIG by adding
> +
> +  read_config_file($GITWEB_CONFIG_SYSTEM);
> +
> +at very beginning of per-instance GITWEB_CONFIG file.  In this case
> +settings in said per-instance file will override settings from
> +system-wide configuration file.  Note that read_config_file checks
> +itself that the file it reads exists.

Language nits: missing "the" before "fallback systemwide
$GITWEB_CONFIG_SYSTEM file" and "very beginning"; missing "a" before
"per-instance $GITWEB_CONFIG file"; "case" should perhaps be "example"
and followed by a comma.

The reader wonders: After checking that the file exists, what does
read_config_file do (does it silently skip it or error out)?  And why
would I use this trick instead of just writing a gitweb-common.conf
file?  (Was read_config_file introduced before gitweb-common.conf,
making this useful when creating a configuration that should be usable
with older versions of gitweb?)

[...]
> +CONFIGURATION VARIABLES
> +-----------------------
> +Some of configuration variables have their default values (embedded in CGI
> +file) set during building gitweb -- if that is the case, it is put in their
> +description.  See gitweb's 'INSTALL' file for instructions on building and
> +installing gitweb.

Language nit: "Some of configuration variables" should be "Some
configuration variables"; missing "the" before "CGI script"; "it is"
should be "they are" to agree with 'variables'.

> +
> +
> +Location of repositories
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +Configuration variables described below control finding git repositories by
> +gitweb, and control display and access to repositories.

Language nits: missing "The" before "Configuration variables described
below"; "finding git repositories by gitweb" sounds more natural when
paraphrased as "how gitweb finds git repositories" and "display and
access to repositories" paraphrased as "how repositories are displayed
and accessed"; it seems that the sentence scans a little better when
not repeating the verb "control".

[...]
> +For example if `$projectroot` is set to "/srv/git" by putting the following
> +in gitweb config file:
> ++
> +----------------------------------------------------------------------------
> +our $projectroot = "/srv/git";
> +----------------------------------------------------------------------------
> ++
> +then
> ++
> +------------------------------------------------
> +http://git.example.com/gitweb.cgi?p=foo/bar.git
> +------------------------------------------------
> ++
> +or its path_info based equivalent
> ++
> +------------------------------------------------
> +http://git.example.com/gitweb.cgi/foo/bar.git
> +------------------------------------------------
> ++
> +will map to path '/srv/git/foo/bar.git' on filesystem.

Language nits: missing comma after "For example"; "or" should be
"and"; missing "the" before "path '/srv/git/foo/bar.git'" and
"filesystem".

> +
> +$project_maxdepth::
> +	Filesystem traversing depth limit for recursively scanning for git
> +	repositories, used if `$projects_list` (below) is unset.  The default
> +	value of this variable is determined by build-time configuration
> +	variable `GITWEB_PROJECT_MAXDEPTH`, which defaults to 2007.

"Filesystem traversing depth limit" is quite a long stack of nouns :),
and unfortunately I don't know what it means.  Is this the depth of
nested subdirectories below $project_root that gitweb will look at
when discovering repositories?  If I have no subdirectories in the
projectroot except the repositories themselves, should I set this to 1
or 0?  What happens with forks?  Is this just a convenience feature or
can it be used for security or to create performance gaurantees?

By the way, what happens if projectroot contains a symlink to some
directory elsewhere in the filesystem containing repositories --- will
gitweb traverse it?

What if I want this to be infinite (i.e., to disable the feature) ---
would I be crazy?

Language nit: missing "the" before "`GITWEB_PROJECT_MAXDEPTH` Makefile
variable used at build time, which defaults to 2007".

> +
> +$projects_list::
> +	Plain text file listing projects or name of directory
> +	to be scanned for projects.
> ++
> +Project list files should list one project per line, with each line
> +having the following format
> ++
> +-----------------------------------------------------------------------------
> +<URI-encoded filesystem path to repository> SP <URI-encoded repository owner>
> +-----------------------------------------------------------------------------
> ++
> +The default value of this variable is determined by the `GITWEB_LIST`
> +makefile variable at installation time.  If this variable is empty, gitweb
> +will fall back to scanning the `$projectroot` directory for repositories.

Language nit: missing "Path to a" or "Name of a" before "Plain text
file".

When this is a relative path, what is it taken relative to?

> +
> +$export_ok::
> +	Show repository only if this file exists (in repository).  Only
> +	effective if this variable evaluates to true.  Can be set during
> +	building gitweb via `GITWEB_EXPORT_OK`.  [No default / Not set]

This is always a relative path, right?  What is it relative to ---
$GIT_DIR, I guess?

Usage nits: the phrase starting with "during" reads more naturally if
"during" is replaced with "when" and "via" replaced with "by setting".
If there were no default, that would mean that gitweb errors out when
gitweb.conf does not set this variable; instead, the default seems to
be "undef" (or 'false') if I understand correctly.

> +
> +$export_auth_hook::
> +	Show repository only if this subroutine returns true, when given as
> +	the only parameter the full path to the project.  Example:
> ++
> +----------------------------------------------------------------------------
> +our $export_auth_hook = sub { return -e "$_[0]/git-daemon-export-ok"; };
> +----------------------------------------------------------------------------
> ++
> +though the above might be done by using `$export_ok` instead
> ++
> +----------------------------------------------------------------------------
> +our $export_ok = "git-daemon-export-ok";
> +----------------------------------------------------------------------------

Style nit: commands in this kind of documentation should be directed to
the reader, not gitweb, so it would be nicer to explain this in terms of
what the $export_auth_hook is.  That is, something like the following:

 $export_auth_hook::
	Function used to determine which repositories should be shown.
	This subroutine should take one parameter, the full path to
	a project, and if it returns true, that project will be included
	in the projects list and can be accessed through gitweb as long
	as it fulfills the other requirements described by $export_ok,
	$projects_list, and $projects_maxdepth.  Example:

Is "our $export_auth_hook = undef;" a valid configuration?  What is the
default?

> +
> +$strict_export::
> +	Only allow viewing of repositories also shown on the overview page.
> +	This for example makes `$gitweb_export_ok` file decide if repository is
> +	available and not only if it is shown.  If `$gitweb_list` points to
> +	file with list of project, only those repositories listed would be
> +	available for gitweb.  Can be set during building gitweb via
> +	`GITWEB_STRICT_EXPORT`.  [No default / Not set]

Is the default behavior as though this were true or false?

> +Finding files
> +~~~~~~~~~~~~~
> +Those configuration variables tell gitweb where to find files.  Values of
> +those variables are paths on filesystem.  Of those only `$GIT` is required
> +to be (correctly) set for gitweb to be able to work; all the rest are
> +required only for extra configuration or extra features.

Language nit: "Those" should be "The following" in the first sentence and
"these" in remaining sentences; missing "The" before "Values of those
variables" and "filesystem"; missing comma after "Of these".

When you say the remainder are only required in special cases, does
that mean that they are ignored unless some other enabling variable is
set or that they can be set to "undef" to disable the relevant
feature?

> +
> +$GIT::
> +	Core git executable to use.  By default set to `$GIT_BINDIR/git`, which
> +	in turn is by default set to `$(bindir)/git`.  If you use git from binary
> +	package, set this to "/usr/bin/git".  This can just be "git" if your
> +	webserver has a sensible PATH.  If you have multiple git versions installed
> +	it can be used to choose which one to use.

Language nit: missing "a" or "your operating system distributor's" before
"binary package".

> +
> +$mimetypes_file::
> +	File to use for (filename extension based) guessing of MIME types before
> +	trying '/etc/mime.types'.  Path, if relative, is taken currently as
> +	relative to the current git repository.  [Unset by default]

Language nit: missing "The" before "Path".

The use of "currently" sounds like an apology.  Does that mean that
gitweb ought to be rejecting relative paths for this variable?

> +
> +$highlight_bin::
> +	Path to the highlight executable to use (must be the one from
> +	http://www.andre-simon.de due to assumptions about parameters and output).
> +	Useful if 'highlight' is not installed on your webserver's PATH.
> +        [Default: 'highlight']
> ++
> +*NOTE*: if you want to add support for new syntax (supported by
> +"highlight" but not used by gitweb), you need to modify `%highlight_ext`
> +or `%highlight_basename`, depending on whether you detect type of file
> +based on extension (for example "*.sh") or on its basename (for example
> +"Makefile").  Keys of those hashes are extension or basename,
> +respectively, and value for given key is name of syntax to be passed via
> +`--syntax <syntax>` to highlighter.

Language nits: missing "it" before "must be the one"; "new syntax"
should probably be "a new file type" or something like that; missing
"The" before "Keys of those hashes"; "those" should be "these"; "or"
should be "and".

Is "*.sh" actually an example of an extension?  I.e., do I write the
following?

	our %highlight_ext;
	$highlight_ext{"*.sh"} = "sh";

> +
> +
> +Links and their targets
> +~~~~~~~~~~~~~~~~~~~~~~~
> +Configuration variables described below configure some of gitweb links:
> +their target and their look (text or image), and where to find page
> +prerequisites (stylesheet, favicon, images, scripts).  Usually they are left
> +at their default values, with the possible exception of `@stylesheets`
> +variable.

Language nits: missing "The" before "Configuration variables described
below"; missing "some" before "supporting files".

> +
> +@stylesheets::
> +	List of URIs of stylesheets (relative to base URI of a page). You
> +	might specify more than one stylesheet, for example use gitweb.css
> +	as base, with site specific modifications in separate stylesheet
> +	to make it easier to upgrade gitweb. You can add a `site` stylesheet
> +	for example by putting
> ++
> +----------------------------------------------------------------------------
> +push @stylesheets, "gitweb-site.css";
> +----------------------------------------------------------------------------
> ++
> +in the gitweb config file.  Those values that are relative paths, are
> +relative to base URI of gitweb.

Language nits: missing "the" before "base URI".  What is a base URI ---
is it set by another variable?  Missing "to" before "use gitweb.css as
a base"; there should not be a comma before "with site-specific
modifications" or before "are relative"; missing "a" before "separate
stylesheet"; missing commas surrounding "for example" (or even better,
"For example," could move to the start of the sentence).

> ++
> +This list should contain URI of gitweb's stylesheet.  The URI of gitweb
> +stylesheet is set during build time via `GITWEB_CSS` variable.  It's default
> +value is 'static/gitweb.css' (or 'static/gitweb.min.css' if the `CSSMIN`
> +variable is defined, i.e. if CSS minifier is used during build).
> ++
> +*Note*: there is also legacy `$stylesheet` configuration variable, which was
> +used by older gitweb.

Language nits: missing "the" before "URI of gitweb's standard stylesheet";
missing "default" before "URI of the gitweb stylesheet"; "is set
during" should be "can be set at"; "via `GITWEB_CSS` variable" should be
"using the `GITWEB_CSS` makefile variable"; extra apostrophe in "It's";
missing "a" before "legacy `$stylesheet` configuration variable".

If I am new on the job and find the $stylesheet variable set, what
should I interpret it to mean?  How can it be translated to the newer
@stylesheets style?  What happens if both variables are set --- does
one override the other, or are they combined somehow?

> +
> +$logo::
> +	Points to the location where you put 'git-logo.png' on your web
> +	server, or to be more generic URI of logo, 72x27 size).  This image
> +	is displayed in top right corner of each gitweb page, and used as
> +	logo for Atom feed.  Relative to base URI of gitweb (as a path).
> +	Can be adjusted during building gitweb using `GITWEB_LOGO` variable
> +        [Default: 'static/git-logo.png']

Language nits: missing "the" before "generic URI", "top-right corner",
"Atom feed", and "base URI of gitweb"; missing "a" before "logo";
there should not be a comma before "and used"; "during" sounds more
natural when it is replaced with "when".

> +
> +$favicon::
> +	Points to the location where you put 'git-favicon.png' on your web
> +	server, or to be more generic URI of favicon, assumed to be
> +	"image/png" type; web browsers that support favicons (website icons)
> +	may display them in the browser's URL bar and next to site name in
> +	bookmarks.  Relative to base URI of gitweb.  Can be adjusted during
> +	build time using `GITWEB_FAVICON` variable.
> +        [Default: 'static/git-favicon.png']

Language nits: missing "the" before "generic URI", "site name", and
"base URI"; missing "your chosen" before "favicon"; "assumed to be"
should be "which will be served as" or something like that; would be
easier to read with the semicolon before "web browsers" replaced by a
full stop; "may" should be "will"; "during" sounds more natural when
it is replaced with "at".

> +
> +$javascript::
> +	Points to the location where you put 'gitweb.js' on your web server,
> +	or to be more generic URI of JavaScript code used by gitweb.
> +	Relative to base URI of gitweb.  Set during build time using
> +	`GITWEB_JS` build-time configuration variable.
> ++
> +Default value is either 'static/gitweb.js', or 'static/gitweb.min.js' if
> +`JSMIN` build variable is defined, i.e. if JavaScript minifier is used
> +during build.  *Note* that this single file is build (composed) of
> +individual JavaScript "modules".

Language nits: missing "the" before "URI", "Javascript library", "base
URI", "`GITWEB_JS`" makefile variable", "Default value", and "`JSMIN`
makefile variable"; "Set during" sounds more natural when it is
replaced by "Can be set at"; "is defined" and "is used" should be "was
defined" and "was used" to reflect installation probably already
having occured; "during build" sounds more natural when it is replaced
by "at build time"; "build of" should be "built from" or "generated
from multiple".

> +
> +$home_link::
> +	Target of the home link on top of all pages (the first part of view
> +	"breadcrumbs").  By default set to absolute URI of a page ($my_uri).

Language nit: missing "the" before "top" and "absolute URI".

Which page does "a page" refer to here (doesn't $my_uri change from
request to request)?

> +
> +$home_link_str::
> +	Description of the home link on top of all pages, leading to $home_link
> +	(usually main gitweb page, which means projects list).  Used as first
> +	part of gitweb view "breadcrumb trail": `<home> / <project> / <view>`.
> +	Can be set during build time using `GITWEB_HOME_LINK_STR` variable.
> +	[Default: "projects"]

Language nits: "Description of" means "Label for", I suppose; "home
link" should be "home page link" (?); "on top" is "at the top";
missing "the" before "main gitweb page"; "which means projects list"
is more friendly if paraphrased as "which contains the projects list";
"part of gitweb view" could be paraphrased as "component of gitweb's";
"during" sounds more natural if replaced by "at"; missing "the" before
"`GITWEB_HOME_LINK_STR` makefile variable".

> +
> +$logo_url::
> +$logo_label::
> +	URI and label (title) of GIT logo link (or your site logo, if you choose
> +	to use different logo image). By default they point to git homepage;
> +	in the past they pointed to git documentation at www.kernel.org.

Language nits: "of GIT logo link" should probably be "for the Git logo
link"; "choose" should be "chose" since that's in the past when the
admin is setting this variable; missing comma after "By default" and
"in the past"; the first "they" should be "these both".

> +
> +
> +Changing gitweb look
> +~~~~~~~~~~~~~~~~~~~~
> +You can adjust how pages generated by gitweb look using variables described
> +below.  You can change site name, add common headers and footers for all
> +pages, and add description of gitweb installation on its main page (which is
> +projects list page), etc.

Language nits: missing "'s" in "Changing gitweb's look"; missing "the"
before "variables described below", "site name", and "project list
page"; missing "a" before "description"; missing "this" before "gitweb
installation".

> +
> +$site_name::
> +	Name of your site or organization to appear in page titles.  Set it
> +	to something descriptive for clearer bookmarks etc.  If not set (if
> +	empty) then gitweb uses value of `SERVER_NAME` CGI environment
> +	variable setting prefix of each page title to "$SERVER_NAME Git", or
> +	"Untitled Git" if this variable is not set (e.g. if running gitweb
> +	as standalone script).
> ++
> +Can be set using `GITWEB_SITENAME` during building.  [No default]

Language nits: missing comma after "organization" and before "for use
in page titles"; missing "the" before "the value", "`SERVER_NAME`
environment variable", and "`GITWEB_SITENAME` makefile variable";
"If not set" is missing a subject --- "If this variable is unset or
empty, then gitweb will ..."; "during building" sounds more natural
when replaced by "at build time".

> +
> +$site_header::
> +	Filename of html text to include at top of each page.  Relative to
> +	'gitweb.cgi' script.  Can be set using `GITWEB_SITE_HEADER` during
> +	building.  [No default]

Language nits: "Filename of html text to include" should be "Name of a
file with HTML to be included" (or "Path to ..."); "'gitweb.cgi'
script" should be "the directory containing the 'gitweb.cgi' script";
"during building" sounds more natural when replaced by "at build
time".

> +
> +$site_footer::
> +	Filename of html text to include at bottom of each page.  Relative to
> +	gitweb.cgi script.  Can be set using `GITWEB_SITE_FOOTER` during
> +	building.  [No default]

Likewise.

> +
> +$home_text::
> +	Points to an HTML file which, if it exists, is included on the
> +	gitweb projects overview page ("projects_list" view).  Relative to
> +	gitweb.cgi script.  Default value can be adjusted using during build
> +	via `GITWEB_HOMETEXT` variable.
> +	[Default: 'indextext.html']

Likewise.

> +
> +$projects_list_description_width::
> +	The width (in characters) of the projects list "Description" column.
> +	Longer descriptions will be cut (trying to cut at word boundary);
> +	full description is available as 'title' attribute (usually shown on
> +	mouseover).  By default set to 25, which might be too small if you
> +	use long project descriptions.

Language nit: 'project list "Description" column' sounds more natural when
rearranged to 'the "Description" column of the project list'; "cut" should
be "truncated"; missing "the" before "full description"; "as 'title'
attribute" sounds better as "in the 'title' attribute"; instead of "By
default set to", it is clearer to say "The default is".

> +
> +$default_projects_order::
> +	Default value of ordering of projects on projects list page.  Valid
> +	values are "none" (unsorted), "project" (by project name, i.e. path
> +	to repository relative to `$projectroot`), "descr" (project
> +	description), "owner", and "age" (by date of most current commit).
> ++
> +Default value is "project".  Unknown value means unsorted.

What does "Default" mean here (i.e., what overrides it)?

> +
> +
> +Changing gitweb behavior
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +Those configuration variables control _internal_ gitweb behavior.

Language nits: missing "'s" in "gitweb's behavior"; "Those" should be
"These".  Does internal behavior mean "functionality as opposed to
appearance and input location" or something like that?

> +
> +$default_blob_plain_mimetype::
> +	Default mimetype for blob_plain (raw) view, if mimetype checking
> +	doesn't result in some other type; by default "text/plain".

Language nit: missing "the" before "blob_plain (raw) view".

Where can I look to read more about mimetype autodetection?

> +
> +$default_text_plain_charset::
> +	Default charset for text files. If not set, web server configuration
> +	would be used.

Language nits: to make clear that it is not the web server
configuration that is not set, "If not set" could be paraphrased to
"If this is unset"; "would" should be "will" (yes, conditionals in
English are weird); missing "the" before "web server's usual
configuration".

> +
> +$fallback_encoding::
> +	Gitweb assumes this charset if line contains non-UTF-8 characters.
> +	Fallback decoding is used without error checking, so it can be even
> +	"utf-8". Value must be valid encoding; see *Encoding::Supported*(3pm)
> +	man page for a list.  By default "latin1", aka. "iso-8859-1".

Language nits: "if" should be "when"; missing "a" before "line" and
"valid encoding"; missing "The" before "Fallback encoding", "Value",
and "Encoding::Supported(3pm) manpage"; "By default" sounds a little
better as "The default is" or "Default:".

> +
> +@diff_opts::
> +	Rename detection options for git-diff and git-diff-tree. By default
> +	(\'-M'); set it to (\'-C') or (\'-C', \'-C') to also detect copies,
> +	or set it to () i.e. empty list if you don't want to have renames
> +	detection.

Language nit: "By default" sounds a little better as "The default is".

Probably worth mentioning that GNU patch still has problems with some
rename patches, especially when they involve file copies ['-C'] or
criss-cross renames ['-B'] (see [1] and [2], for example).

[1] http://savannah.gnu.org/bugs/?31058
[2] http://thread.gmane.org/gmane.linux.ports.sh.devel/8697/focus=8773

> +
> +Extra features, administrative
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Most of features are configured via `%feature` hash; however some of extra
> +gitweb features can be turned on and configured using variables described
> +below.  This list beside configuration variables that control how gitweb
> +looks does contain variables configuring administrative side of gitweb
> +(e.g. cross-site scripting prevention; admittedly this as side effect
> +affects how "summary" pages look like, or load limiting).

Language nit: the title sounds like these are going to be extra
administrative features --- might be best to spell it out ("Some
optional features and policies" or something like that).

> +
> +@git_base_url_list::
> +	List of git base URLs used for URL to where fetch project from, shown
> +	in project summary page.  Full URL is "`$git_base_url/$project`".  You
> +	can setup multiple base URLs (for example one for `git://` protocol
> +	access, and one for `http://` "dumb" protocol access).  Note that per
> +	repository configuration can be set in '$GIT_DIR/cloneurl' file, or as
> +	values of multi-value `gitweb.url` configuration variable in project
> +	config.
> ++
> +You can setup one single value (single entry/item in this list) during
> +building by using `GITWEB_BASE_URL` built-time configuration variable.
> +[No default]

Language nits: "git base URLs used for URL to where fetch project from"
means something like "Git URLs relative to which projects can be
fetched"; missing "The" before and 'for the `"$projectroot/$project"`
repository' after "Full URL"; "setup" as a verb is spelled "set up" or
"set" (2x); "http://" access is not necessarily passive; "during
building" sounds better as "at build time"; "using" should be "setting
the"; "built-time configuration variable" is spelled as "build-time
configu..." or even better as "makefile variable"; "No default" does
not seem quite right --- I think the default is "Default: ()" (i.e.,
it defaults to the empty list).

Is the per repository cloneurl added to this list, or does it override
it?

> +
> +$projects_list_group_categories::
> +	Enables the grouping of projects by category on the project list page.
> +	The category of a project is determined by the `$GIT_DIR/category` file
> +	or the `gitweb.category` variable in its repository configuration.
> +	[Disabled by default].

Language nits: "its repository configuration" probably means "each
repository's configuration"; "Enables" can be rephrased more clearly
as "Whether to enable" (assuming this is boolean).

> +
> +$project_list_default_category::
> +	Default category for projects for which none is specified.  If set to
> +	the empty string, such projects will remain uncategorized and listed at
> +	the top, above categorized projects.  Used only if project cateories are
> +	enabled, which means if `$projects_list_group_categories` is true.
> +	[Default: "" (empty string)]

Language nit: "If set to the empty string" is clearer as "If this is
set to the empty string" since it is not the projects but this
variable that is being set to the empty string.

> +
> +$prevent_xss::
> +	If true, some gitweb features are disabled to prevent content in
> +	repositories from launching cross-site scripting (XSS) attacks.  Set this
> +	to true if you don't trust the content of your repositories.
> +	[Default: false].

Nice.

> +
> +$maxload::
> +	Used to set the maximum load that we will still respond to gitweb queries.
> +	If server load exceed this value then return "503 Service Unavailable"
> +	error. Server load is taken to be 0 if gitweb cannot determine its value.
> +	Set it to undefined value to turn it off. [Default: 300]

Probably worth spelling out that this is a "load average" (as shown by uptime(1)).

Language nits: missing "the" before "server load" (2x); instead of
"exceed", use "exceeds" (singular); missing subject "gitweb" before
"will return the"; clearer to say it is "this feature" rather than
"it" that can be turned off by setting this var to undef.

> +
> +$per_request_config::
> +	If set to code reference, it would be run once per each request.  You can
> +	set parts of configuration that change per session, e.g. by adding
> +	the following code to gitweb configuration file
> ++
> +--------------------------------------------------------------------------------
> +our $per_request_config = sub {
> +	$ENV{GL_USER} = $cgi->remote_user || "gitweb";
> +};
> +--------------------------------------------------------------------------------

Language nits: missing "this is" before "set to a code reference";
"would" should be "will" (those crazy English conditionals again); the
appropriate preposition before "each request" is "for", not "per";
missing "this way" after "change per session"; would be clearer with a
full stop before the example, and with the example made into a full
sentence ("For example, one might use the following code in a gitweb
configuration file:").

> ++
> +Otherwise it is treated as boolean value: if true gitweb would process
> +config file once per request, if false it would process config file only
> +once.  [Default: true]
> ++
> +*NOTE*: `$my_url`, `$my_uri`, and `$base_url` are overwritten with their default
> +values before every request, so if you want to change them, be sure to set
> +this variable to true or a code reference effecting the desired changes.

At this point, I've forgotten what the "Otherwise" is contrasting with;
probably best to repeat it ("If $per_request_config is not a code
reference, it is interpreted as a boolean value."); "would" should be
"will" again (2x); missing "the" or "each" before "config file" (2x);
missing "and" before "if it is false"; "it" could be "gitweb" to
avoid confusion in this pronoun-heavy sentence; missing "each time it
is executed" after "process the config file only once".

Probably worth mentioning that this variable starts to shine when one
gitweb instance is used to serve multiple requests, with CGI
replacements like mod_perl, fastcgi, plackup, and so on.

> +
> +
> +Other variables
> +~~~~~~~~~~~~~~~
> +Usually you should not need to change (adjust) any of configuration
> +variables described below; they should be automatically set by gitweb to
> +correct value.
> +
> +
> +$version::
> +	Gitweb version, set automatically when creating gitweb.cgi from
> +	gitweb.perl. You might want to modify it if you are running modified
> +	gitweb, for example 
> ++
> +---------------------------------------------------
> +our $version .= " with caching";
> +---------------------------------------------------

Might be worth mentioning this is only used in HTML comments and the
"generator" metadata field, nothing more special than that.

> +
> +$my_url::
> +$my_uri::
> +	Full URL and absolute URL of gitweb script;
> +	in earlier versions of gitweb you might have need to set those
> +	variables, now there should be no need to do it.  See
> +	`$per_request_config` if you need to set them still.

Language nits: missing "the" before "gitweb script" and "but" before
"now".

What is the difference between a full URL and an absolute URL?

> +
> +$base_url::
> +	Base URL for relative URLs in pages generated by gitweb,
> +	(e.g. `$logo`, `$favicon`, `@stylesheets` if they are relative URLs),
> +	needed and used only for URLs with nonempty PATH_INFO via
> +	'<base href="$base_url">'.  Usually gitweb sets its value correctly,
> +	and there is no need to set this variable, e.g. to $my_uri or "/".
> +	See `$per_request_config` if you need to set it anyway.

Language nits: clearer with "via '<base ...>'" moved before "only for
URLs with nonempty PATH_INFO"; "no need to set" could be "no need to
override".

> +
> +
> +CONFIGURING GITWEB FEATURES
> +---------------------------
> +Many gitweb features can be enabled (or disabled) and configured using the
> +`%feature` hash.  Names of gitweb features are keys of this hash.
> +
> +Each `%feature` hash element is a hash reference and has the following
> +structure:
> +----------------------------------------------------------------------
> +"<feature_name>" => {
> +	"sub" => <feature-sub (subroutine)>,
> +	"override" => <allow-override (boolean)>,
> +	"default" => [ <options>... ]
> +},
> +----------------------------------------------------------------------

Nice.

> +Some of features does not support project specific override.  For those
> +features the structure of appropriate `%feature` hash element has a simpler
> +form:
> +----------------------------------------------------------------------
> +"<feature_name>" => {
> +	"override" => 0,
> +	"default" => [ <options>... ]
> +},
> +----------------------------------------------------------------------
> +As one can see it lacks \'sub' element.

Language nits: the "of" in "Some of features" is extraneous; "does" should
be "do" (plural) because we are talking about multiple features,
or, better, be replaced by "cannot be overriden per project" (so:
"Some features cannot be overridden per project"); missing "the"
before "'sub' field".

> +
> +The meaning of respective parts of feature configuration are described
> +below:

Language nit: "respective parts" should be "each part", "each field",
or something like that; "are" needs to be "is" to agree with the
subject ('meaning').

> +
> +default::
> +	List (array reference) of feature parameters (if there are any),
> +	used also to toggle (enable or disable) given feature.
> ++
> +Note that it is currently *always* an array reference, even if
> +feature doesn't accept any configuration parameters, and \'default'
> +is used only to turn it on or off.  In such case you turn feature on
> +by setting this element to `[1]`, and torn it off by setting it to
> +`[0]`.  See also part about "blame" feature in the "Examples"
> +section.
> ++
> +To disable feature that accepts parameters (is configurable), you
> +need to set this element to empty list i.e. `[]`.

Nits: "part" means "passage" here; missing "the" before "passage" and
'"blame" feature'; "feature" should be "features", "accepts" should
be "accept", and "is configurable" should be "are configurable".

> +
> +override::
> +	If it has a true value then given feature is overridable, which
> +	means that it can be configured (or enabled/disabled) on
> +	per-repository basis.
> ++
> +Usually given "<feature>" is configurable via `gitweb.<feature>`
> +config variable in per-repository git configuration file.
> ++
> +*Note* that no feature is overridable by default.

Nits: better to spell out what "it" is ("this field", I guess);
missing "the" before "given feature", "`gitweb.<feature>`
configuration variable", and "per-repository Git configuration file".

> +
> +sub::
> +	Subroutine that will be called with default options as parameters to
> +	examine per-repository configuration, but only if feature is
> +	overridable (\'override' is set to true).  If not present then
> +	per-repository override for given feature is not supported.
> ++
> +You wouldn't need to ever change it in gitweb config file.

Language nits: "default options as parameters" means "the array
referred to by the 'default' field as parameter list", I guess.
Missing "the" before "feature is overridable" and "gitweb
configuration files".  "given feature" -> "this feature".  "not
supported" -> "not enabled", maybe.

Actually, I'm not sure I understand this one.  Are users supposed to
set this field?  Where can they look to find out what features have it
set by default?  Who calls this function, and what does that person or
code path do with the return value?  If it is not part of the gitweb
configuration that an administrator might modify (the subject of this
manpage), why not just say that ("subroutine used internally; present
if and only if this feature can be made overridable with the
"override" field; you should not change it") and leave it at that?

> +
> +
> +Features in `%feature`
> +~~~~~~~~~~~~~~~~~~~~~~
> +Below there are described gitweb features that are configurable via
> +`%feature` hash.  For a complete list please consult gitweb sources.

Language nit: "Below there are described gitweb features ..." -> "The
gitweb features ... are listed below".  The second sentence could
probably be more apologetic, something like "Currently the only
authoritative and complete list is in the comments in the gitweb.cgi
source code."

> +
> +blame::
> +	Enable the "blame" and "blame_incremental" blob views, showing for
> +	each line the last commit that modified it; see linkgit:git-blame[1].
> +	This can be very CPU-intensive and is therefore disabled by default.
> ++
> +This feature can be configured on a per-repository basis via
> +repository's `gitweb.blame` configuration variable (boolean).

Nice.

> +
> +snapshot::
> +	Enable and configure "snapshot" action, providing a compressed
> +	archive of any tree or commit; see also linkgit:git-archive[1].
> +	This can potentally generate high traffic if you have large project.
> ++
> +The value (of \'default') is a list of names of snapshot formats
> +defined in `%known_snapshot_formats` hash, that you wish to offer.
> +Among supported formats are "tgz", "tbz2", "txz" (gzip/bzip2/xz
> +compressed tar archive) and "zip"; please consult gitweb sources for
> +a definitive list.  By default only "tgz" is offered.
> ++
> +This feature can be configured on a per-repository basis via
> +repository's `gitweb.blame` configuration variable, which contains
> +a comma separated list of formats, or "none" to disable snapshots.
> +Unknown values will be ignored.

Language nits: missing "the" before "snapshot action"; "providing"
would be clearer if replaced by "which allows users to download" or
"which serves" or something like that; instead of "see also" it might
be nice to say "as produced by" because more precise; would be clearer
without parentheses around "of 'default'"; missing comma before
"defined in the %known_snapshot_formats hash"; "Among supported
formats are" is clearer as "Supported formats include"; comma before
"or 'none' to disable snapshots" is extraneous; "will be ignored"
should be "are ignored".

> +
> +grep::
> +	Enable grep search, which will list the files in currently selected
> +	tree (directory) containing the given string; see linkgit:git-grep[1].
> +	This can be potentially CPU-intensive, of course.  Enabled by default.
> ++
> +This feature can be configured on a per-repository basis via
> +repository's `gitweb.grep` configuration variable (boolean).

Language nit: "will list" should be "lists".  Nice.

> +
> +pickaxe::
> +	Enable the so called pickaxe search, which will list the commits
> +	that modified a given string in a file.  This can be practical and
> +	quite faster alternative to "blame" action, but still potentially
> +	CPU-intensive.  Enabled by default.
> ++
> +The pickaxe search is described in linkgit:git-log[1] (the
> +description of `-S<string>` option, which refers to pickaxe entry in
> +linkgit:gitdiffcore[7] for more details).
> ++
> +This feature can be configured on a per-repository basis via
> +repository's `gitweb.pickaxe` configuration variable (boolean).

I think "modified" means "introduced or removed" (as an approximation to
"changes the number of occurences of").  Missing "it is" before "still
potentially CPU-intensive".  "via" seems to mean "using the".

(By the way, is there any way for the the very paranoid to limit the
length of regexes used or CPU time used per request, to get some
reasonable cap on this sort of thing?  I guess that's more in the
realm of web server configuration than something gitweb should be
responsible for --- but if there's some common practice or well known
reference on the topic, it could be worth mentioning at the top of
this GITWEB FEATURES section some day.)

> +
> +show-sizes::
> +	Enable showing size of blobs (ordinary files) in a "tree" view, in a
> +	separate column, similar to what `ls -l` does; see description of
> +	`-l` option in linkgit:git-ls-tree[1] manpage.  This cost a bit of
> +	I/O.  Enabled by default.
> ++
> +This feature can be configured on a per-repository basis via
> +repository's `gitweb.showsizes` configuration variable (boolean).

Nit: "cost" -> "costs".  Interesting (I guess packv4 will help with
the CPU [decompression] cost of this when it comes).

> +
> +patches::
> +	Configure "patches" view, which displays list of commits in email
> +	(plain text) output format; see also linkgit:git-format-patch[1].
> +	The value is the maximum number of patches in a patchset generated
> +	in "patches" view.  Set this to 0 or undef to disable patch view, or
> +	to a negative number to remove any limit.  Default value is 16.
> ++
> +This feature can be configured on a per-repository basis via
> +repository's `gitweb.patches` configuration variable (integer).

"Configure" -> "Enable and configure" and "Set this to ..." -> "Set
the 'default' field to a list containing the single item ...", I
guess.  

> +
> +avatar::
> +	Avatar support.  When this feature is enabled, views such as
> +	"shortlog" or "commit" will display an avatar associated with
> +	the email of the committer(s) and/or author(s).
> ++
> +Currently available providers are *"gravatar"* and *"picon"*.
> +If an unknown provider is specified, the feature is disabled.
> +*Note* that some provides might require extra Perl packages to be
> +installed; see 'gitweb/INSTALL' for more details.

"commiter(s) and/or author(s)" -> "each committer and author".

If I set 'default' to ["gravator", "picon", "unknown"], will that
really disable the feature?

> ++
> +This feature can be configured on a per-repository basis via
> +repository's `gitweb.avatar` configuration variable.
> ++
> +See also `%avatar_size` with pixel sizes for icons and avatars
> +("default" is used for one-line like "log" and "shortlog", "double"
> +is used for two-line like "commit", "commitdiff" or "tag").  If the
> +default font sizes or lineheights are changed (e.g. via adding extra
> +CSS stylesheet in `@stylesheets`), it may be appropriate to change
> +these values.

What is the syntax of the "[gitweb] avatar" value --- space delimited?
comma delimited?

> +
> +highlight::
> +	Server-side syntax hightlight support in "blob" view.  It requires
> +	`$highlight_bin` program available (see description of this variable
> +	in "Configuration variables" section above), and therefore is
> +	disabled by default.
> ++
> +This feature can be configured on a per-repository basis via
> +repository's `gitweb.highlight` configuration variable (boolean).

Language nit: missing "to be" before "available", "the" before
"description" and '"Configuration variables" section'; the comma
before "and" is extraneous.

> +
> +remote_heads::
> +	Enable displaying remote heads (remote-tracking branches) in the "heads"
> +	list.  In most cases it is unnecessary internal private detail, and it
> +	is therefore disabled by default.  linkgit:git-instaweb[1], which is
> +	usually used to browse local repositories, enables and uses this
> +	feature.
> ++
> +This feature can be configured on a per-repository basis via
> +repository's `gitweb.remote_heads` configuration variable (boolean).

Could clarify that "it" means "the list of remote-tracking branches"
first and then "this feature".  Missing "an" before "irrelevant,
private detail".

> +
> +
> +The list below presents features that do not allow project specific
> +overrides.

If we consider it one list: "The remaining features cannot be
overridden on a per project basis".

> +
> +search::
> +	Enable text search, which will list the commits which match author,
> +	committer or commit text to a given string; see description of
> +	`--author`, `--committer` and `--grep` options in linkgit:git-log[1]
> +	manpage.  Enabled by default.
> ++
> +Project specific override is not supported.

Nice.  I prefer "Enables" over "Enable" so commands can be directed at
the reader only, but the current text is clear enough.  Missing "the"
before "descriptions".

> +
> +forks::
> +	Make gitweb consider projects in subdirectories of project root
> +	(basename) to be forks of existing projects.  Given project
> +	`$projname.git`, projects matching `$projname/*.git` will not be
> +	shown in the main projects list, instead a \'+' mark will be added
> +	to `$projname` there and a "forks" view will be enabled for the
> +	project, listing all the forks.  If project list is taken from a
> +	file, forks have to be listed after the main project.
> ++
> +Project specific override is not supported.

To avoid questions of who made it happen: "If this feature is enabled,
gitweb considers projects in subdirectories ...".

If I understand correctly, "Given project `$projname.git`, projects
matching `$projname/*.git`" can be written as "If the project
`$projname.git` exists, projects in the `$projname/` directory".  Is
it just projects in that directory, or are subdirectories included, as
in the following example?

	project.git
	project/foo/bar/baz/qux.git

Replacing the comma before "instead" with a full stop, adding a
comma after "instead", and putting the sentence in the present tense
("Instead, a '+' mark is shown next to `$projname` and links to a
"forks" view that lists projects in the $projname/ subdirectory)
seems to make it clearer.

Missing "the" before "project list"; missing "in that file" after
"after the main project"; "have to be" probably means "are only
recognized if".

> +
> +actions::
> +	Insert custom links to the action bar of all project pages.  This
> +	enables you to link to third-party scripts integrating into gitweb.
> ++
> +The "default" value consists of a list of triplets in the form
> +`("<label>", "<link>", "<position>")` where "position" is the label
> +after which to insert the link, "link" is a format string where `%n`
> +expands to the project name, `%f` to the project path within the
> +filesystem, `%h` to the current hash (\'h' gitweb parameter) and
> +`%b` to the current hash base (\'hb' gitweb parameter); `%%` expands
> +to \'%'.

Interesting.  "enables" should be "allows" here.

Is %f an absolute path (i.e., starting with '/')?

> ++
> +For example http://repo.or.cz git hosting site sets it to the
> +following to enable graphical log (via third party tool
> +*git-browser*):
> ++
> +----------------------------------------------------------------------
> +$feature{'actions'}{'default'} =
> +	[ ('graphiclog', '/git-browser/by-commit.html?r=%n', 'summary')];
> +----------------------------------------------------------------------
> ++
> +This adds link titled "graphiclog" after "summary" link, leading to
> +`git-browser` script, passing `r=<project>` as a query parameter.

Missing ", at the time this page was written, the" after "For
example" (with "sets" replaced by "set" to match); "via" sounds
more natural when replaced by "using the"; missing "a" before "link";
missing "the" before "summary link on the project listing and project
pages".

> ++
> +Project specific override is not supported.
> +
> +timed::
> +	Enable displaying how much time and how many git commands it took to
> +	generate and display page in the page footer (at the bottom of
> +	page).  For example it might be: "This page took 6.53325 seconds and
> +	13 git commands to generate."  Disabled by default.
> ++
> +Project specific override is not supported.

Missing "each" between "display" and "page".  "it might be" -> "the
footer might contain".

> +
> +javascript-timezone::
> +	Enable and configure ability to change common timezone for dates in
> +	gitweb output via JavaScript.  Dates in gitweb output include
> +	authordate and comitterdate in "commit", "commitdiff" and "log"
> +	views, and taggerdate in "tag" view.  Enabled by default.
> ++
> +Value is list of three values: default timezone (if client didn't
> +select other timezone and saved it in a cookie), name of cookie
> +where to store selected timezone, and CSS class used to mark up
> +dates for manipulation.  If you want to turn it off, set "default"
> +to empty list: `[]`.
> ++

Language nits: missing "the" before "ability", "client", and "Value";
missing "a" before "common timezone", "list of three values", "default
timezone", "cookie name", and "HTML class name" (why is this last one
configurable?); "change" should probably be "choose"; missing "for
users" before "to choose"; "didn't select other timezone" -> "hasn't
selected some other timezone"; missing "for" before "if the client
hasn't selected"; "turn it off" would be clearer as "turn this feature
off".

> +In most case you would want to change only default timezone:
> ++
> +---------------------------------------------------------------------------
> +$feature{'javascript-timezone'}{'default'}[0] = "utc";
> +---------------------------------------------------------------------------

Nice.  "In most case you would want to change only" -> "Typical gitweb
config files will only change" can take the desires of an admin that
is implementing someone else's will out of the equation.

> ++
> +Timezone value can be "local" (for local timezone that browser uses), "utc"
> +(what gitweb uses when JavaScript or this feature is disabled), or numerical
> +timezone in the form of "+/-HHMM" for example "+0200".  This way is
> +guaranteed to be backward compatibile.
> ++
> +Project specific override is not supported.

Language nits: when we are talking about supported values in general,
it sounds better for some reason with "value" -> values"; "numerical
timezone" -> "numerical timezones"; "for example" -> "such as".

What is "This way", and what other way should people be avoiding to
prevent forward compatibility gotchas?

> +
> +
> +EXAMPLES
> +--------

Hoorah!

[...]
> +ENVIRONMENT
> +-----------
> +The location of per-instance and system-wide configuration files can be set
> +using the following environment variables:

Clearer to say "overridden" to emphasize that these replace rather
than supplementing the locations described under FILES.

[...]
> +GITWEB_CONFIG::
> +	Sets location of per-instance configuration file.
[...]
> +FILES
> +-----
> +gitweb_config.perl::
> +	This is default value for per-instance configuration file.  The
> +	format of this file is described above.
> +/etc/gitweb.conf::
> +	This is default value for fallback system-wide configuration
> +	file.  This file is used only if per-instance configuration
> +	variable is not found.
> +/etc/gitweb-common.conf::
> +	This is default value for common system-wide configuration
> +	file.

"default value" sounds strange here --- I guess I would have expected
something more like

 ENVIRONMENT
 -----------
 ...
 GITWEB_CONFIG::
	Path to use to find the per-instance configuration file,
	instead of gitweb_config.perl.  If relative, this is relative
	to $GITWEBDIR.

 FILES
 -----
 /etc/gitweb-common.conf::
	Options to be shared by all gitweb instances.  The format is
	described above.
 $GITWEBDIR/gitweb_config.perl::
	Additional settings for a particular gitweb instance (in
	the same format).
 /etc/gitweb.conf::
	Fallback configuration file with settings for gitweb instances
	that do not contain a gitweb_config.perl file.
 
[...]
> gitweb/README                 |  133 +-------
[...]
> +++ b/gitweb/README
> @@ -41,139 +41,8 @@ Ultimate description on how to reconfigure the default features setting
>  in your `GITWEB_CONFIG` or per-project in `project.git/config` can be found
>  as comments inside 'gitweb.cgi'.
>  
> -See also the "Gitweb config file" (with an example of config file), and
[...]
> +See also gitweb.conf(5) manpage.
> +

Thanks very much for this.
