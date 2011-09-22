From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFCv4 2/4] gitweb: Add manpage for /etc/gitweb.conf (for gitweb documentation)
Date: Thu, 22 Sep 2011 15:41:48 +0200
Message-ID: <201109221541.49474.jnareb@gmail.com>
References: <1316352884-26193-1-git-send-email-jnareb@gmail.com> <1316352884-26193-3-git-send-email-jnareb@gmail.com> <20110920044118.GI6343@elie>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 15:42:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6jXQ-0005tE-Q6
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 15:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610Ab1IVNl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 09:41:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62588 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab1IVNl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 09:41:57 -0400
Received: by fxe4 with SMTP id 4so2748599fxe.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 06:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=GPnHL61TJVpG27Ckbm6kx1fxBCxKDzBjWSfmL5MruXE=;
        b=FC4mAXchIsiBqLRdS/qJ7rXL0cUeGF1xH+0uLd/DzI4KSVC8BFZyDBMdP71DSKzPMt
         cr+kJIk5LdYPXJVT2ERGY6gvz6lDhWgaiicQrkbChSvwfBXgt6eJxhZiTTsKW+H5SzOS
         MaJHe8uA1776O4nUbrfkRZFzPluBU1Ak+JHzc=
Received: by 10.223.95.139 with SMTP id d11mr3109431fan.117.1316698915007;
        Thu, 22 Sep 2011 06:41:55 -0700 (PDT)
Received: from [192.168.1.13] (abvh47.neoplus.adsl.tpnet.pl. [83.8.205.47])
        by mx.google.com with ESMTPS id t19sm7519009faj.23.2011.09.22.06.41.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Sep 2011 06:41:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110920044118.GI6343@elie>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181896>

On Tue, 20 Sep 2011, Jonathan Nieder wrote:
> Jakub Narebski wrote:
> 
> > [jn: Improved, extended, removed duplicate info from README]
> 
> Hoorah!  I have very little to add to what's already been done ---
> mostly I can just lend my ear as a native English speaker.

Thanks, that is a lot of help; English is not my primary language.

> > +The syntax of the configuration files is that of Perl, as these files are
> > +indeed handled as fragments of Perl code (the language that gitweb itself is
> > +written in). Variables may be set using "`our $variable = value`"; text from
> > +"#" character until the end of a line is ignored. See the *perlsyn*(1) man
> > +page for more information.
> > +
> > +Actually using `our` qualifier in `our $variable = <value>;` is a safety
> > +check: if newer gitweb does no longer use given variable, by using `our` we
> > +won't get syntax errors.
> 
> Language nit: for "indeed", something like "internally" might be more
> natural.
> 
> The syntax and the typical idiom were already described in the
> DESCRIPTION section, so the emphasis should be somehow different here
> to avoid boring the reader.  One way might be to plunge directly into
> what the second paragraph above says:
> 
>  The syntax of the configuration files is that of Perl, since these files are
>  handled by sourcing them as fragments of Perl code (the language that
>  gitweb itself is written in). Variables are typically set using the
>  `our` qualifier (as in "`our $variable = <value>;`") to avoid syntax
>  errors if a new version of gitweb no longer uses a variable and therefore
>  stops declaring it.

Thanks, I used your proposal.  It reduces duplication, and reads better.
 
> > +
> > +You can include other configuration file using read_config_file()
> > +subroutine.  For example, you can read defaults in fallback
> > +system-wide GITWEB_CONFIG_SYSTEM from GITWEB_CONFIG by adding
> > +
> > +  read_config_file($GITWEB_CONFIG_SYSTEM);
> > +
> > +at very beginning of per-instance GITWEB_CONFIG file.  In this case
> > +settings in said per-instance file will override settings from
> > +system-wide configuration file.  Note that read_config_file checks
> > +itself that the file it reads exists.
[...]

> The reader wonders: After checking that the file exists, what does
> read_config_file do (does it silently skip it or error out)?  And why
> would I use this trick instead of just writing a gitweb-common.conf
> file?  (Was read_config_file introduced before gitweb-common.conf,
> making this useful when creating a configuration that should be usable
> with older versions of gitweb?)

I have replaced it now with the following:

  You can include other configuration file using read_config_file()
  subroutine.  For example, one might want to put gitweb configuration
  related to access control for viewing repositories via Gitolite (one
  of git repository management tools) in a separate file, e.g. in
  '/etc/gitweb-gitolite.conf'.  To include it, put
  
  --------------------------------------------------
  read_config_file("/etc/gitweb-gitolite.conf");
  --------------------------------------------------
  
  somewhere in gitweb configuration file used, e.g. in per-installation
  gitweb configuration file.  Note that read_config_file() checks itself
  that the file it reads exists, and does nothing if it is not found.
  It also handles errors in included file.

> > +$project_maxdepth::
> > +	Filesystem traversing depth limit for recursively scanning for git
> > +	repositories, used if `$projects_list` (below) is unset.  The default
> > +	value of this variable is determined by build-time configuration
> > +	variable `GITWEB_PROJECT_MAXDEPTH`, which defaults to 2007.
> 
> "Filesystem traversing depth limit" is quite a long stack of nouns :),
> and unfortunately I don't know what it means.  Is this the depth of
> nested subdirectories below $project_root that gitweb will look at
> when discovering repositories?  If I have no subdirectories in the
> projectroot except the repositories themselves, should I set this to 1
> or 0?  What happens with forks?  Is this just a convenience feature or
> can it be used for security or to create performance gaurantees?
> 
> By the way, what happens if projectroot contains a symlink to some
> directory elsewhere in the filesystem containing repositories --- will
> gitweb traverse it?

I have changed order of describing variables, putting $projects_list
before $project_maxdepth - this way we don't have to refer to following
text.

I have replaced the description of $project_maxdepth with the following

  $project_maxdepth::
  	If `$projects_list` variable is unset, gitweb will recursively
  	scan filesystem for git repositories.  The `$project_maxdepth`
  	is used to limit traversing depth, relative to `$projectroot`
  	(starting point); it means that directories which are further
  	from `$projectroot` than `$project_maxdepth` will be skipped.
  +
  It is purely performance optimization, originally intended for MacOS X,
  where recursive directory traversal is slow.  Gitweb follows symbolic
  links, but it detects cycles, ignoring any duplicate files and directories.
  +
  The default value of this variable is determined by the build-time
  configuration variable `GITWEB_PROJECT_MAXDEPTH`, which defaults to
  2007.
 
I hope that it makes meaning and use of this variable more clear.

> What if I want this to be infinite (i.e., to disable the feature) ---
> would I be crazy?

It is currently not possible to disable this feature.  The value of 2007
should be enough in most cases (read: all sane cases).
 
> > +$projects_list::
> > +	Plain text file listing projects or name of directory
> > +	to be scanned for projects.
[...]

> When this is a relative path, what is it taken relative to?

As with all relative paths to files, it is relative to where CGI script
is.  I probably should write about this somewhere...

> > +
> > +$export_ok::
> > +	Show repository only if this file exists (in repository).  Only
> > +	effective if this variable evaluates to true.  Can be set during
> > +	building gitweb via `GITWEB_EXPORT_OK`.  [No default / Not set]
> 
> This is always a relative path, right?  What is it relative to ---
> $GIT_DIR, I guess?
> 
> Usage nits: the phrase starting with "during" reads more naturally if
> "during" is replaced with "when" and "via" replaced with "by setting".
> If there were no default, that would mean that gitweb errors out when
> gitweb.conf does not set this variable; instead, the default seems to
> be "undef" (or 'false') if I understand correctly.

Description of $export_ok got replaced by the following:

  $export_ok::
  	Show repository only if this file exists (in repository).  Only
  	effective if this variable evaluates to true.  Can be set when
  	building gitweb by setting `GITWEB_EXPORT_OK`.  This path is
  	relative to `GIT_DIR`.  git-daemon[1] uses 'git-daemon-export-ok',
  	unless started with `--export-all`.  [No default / Not set
  	(this feature is turned off)]

> > +
> > +$export_auth_hook::
> > +	Show repository only if this subroutine returns true, when given as
> > +	the only parameter the full path to the project.  Example:
> > ++
> > +----------------------------------------------------------------------------
> > +our $export_auth_hook = sub { return -e "$_[0]/git-daemon-export-ok"; };
> > +----------------------------------------------------------------------------
> > ++
> > +though the above might be done by using `$export_ok` instead
> > ++
> > +----------------------------------------------------------------------------
> > +our $export_ok = "git-daemon-export-ok";
> > +----------------------------------------------------------------------------
> 
> Style nit: commands in this kind of documentation should be directed to
> the reader, not gitweb, so it would be nicer to explain this in terms of
> what the $export_auth_hook is.

Thanks.  I should probably rewrite description of $export_ok in the same
way, isn't it?

>                                 That is, something like the following: 
> 
>  $export_auth_hook::
> 	Function used to determine which repositories should be shown.
> 	This subroutine should take one parameter, the full path to
> 	a project, and if it returns true, that project will be included
> 	in the projects list and can be accessed through gitweb as long
> 	as it fulfills the other requirements described by $export_ok,
> 	$projects_list, and $projects_maxdepth.  Example:

Thanks, I have used your description.
 
> Is "our $export_auth_hook = undef;" a valid configuration?  What is the
> default?

I have added the following line at the end of description of this
variable:

  If not set (default), it means that this feature is disabled.

> > +
> > +$strict_export::
> > +	Only allow viewing of repositories also shown on the overview page.
> > +	This for example makes `$gitweb_export_ok` file decide if repository is
> > +	available and not only if it is shown.  If `$gitweb_list` points to
> > +	file with list of project, only those repositories listed would be
> > +	available for gitweb.  Can be set during building gitweb via
> > +	`GITWEB_STRICT_EXPORT`.  [No default / Not set]
> 
> Is the default behavior as though this were true or false?

Last sentence now reads:

  [No default / Not set (you can access	repositories hidden from projects
  list page)]

> > +Finding files
> > +~~~~~~~~~~~~~
> > +Those configuration variables tell gitweb where to find files.  Values of
> > +those variables are paths on filesystem.  Of those only `$GIT` is required
> > +to be (correctly) set for gitweb to be able to work; all the rest are
> > +required only for extra configuration or extra features.
[...]
> When you say the remainder are only required in special cases, does
> that mean that they are ignored unless some other enabling variable is
> set or that they can be set to "undef" to disable the relevant
> feature?

I have removed this sequence, and extended description of each variable
instead.
 
> > +$mimetypes_file::
> > +	File to use for (filename extension based) guessing of MIME types before
> > +	trying '/etc/mime.types'.  Path, if relative, is taken currently as
> > +	relative to the current git repository.  [Unset by default]

> The use of "currently" sounds like an apology.  Does that mean that
> gitweb ought to be rejecting relative paths for this variable?

I think it was originally intended as note that this resolution of relative
path is subject to change in future versions of gitweb.  But I think it
is not true (backward compatibility), and it is more important that this
resolution of relative path is untypical.

I have reformulated this description to read:

  $mimetypes_file::
  	File to use for (filename extension based) guessing of MIME types before
  	trying '/etc/mime.types'.  *NOTE* that this path, if relative, is taken
  	as relative to the current git repository, not to CGI script.  If unset,
  	only '/etc/mime.types' is used (if present on filesystem).  If no mimetypes
  	file is found, mimetype guessing bassed on extension of file is disabled.
  	[Unset by default]
 
> > +
> > +$highlight_bin::
> > +	Path to the highlight executable to use (must be the one from
> > +	http://www.andre-simon.de due to assumptions about parameters and output).
> > +	Useful if 'highlight' is not installed on your webserver's PATH.
> > +        [Default: 'highlight']
> > ++
> > +*NOTE*: if you want to add support for new syntax (supported by
> > +"highlight" but not used by gitweb), you need to modify `%highlight_ext`
> > +or `%highlight_basename`, depending on whether you detect type of file
> > +based on extension (for example "*.sh") or on its basename (for example
> > +"Makefile").  Keys of those hashes are extension or basename,
> > +respectively, and value for given key is name of syntax to be passed via
> > +`--syntax <syntax>` to highlighter.
[...]

> Is "*.sh" actually an example of an extension?  I.e., do I write the
> following?
> 
> 	our %highlight_ext;
> 	$highlight_ext{"*.sh"} = "sh";

You are right, it should be "sh", not "*.sh".  Fixed, and added example
(about "phtml", which usually means PHP, but might mean embedded Perl
(ePerl)).

> > +Links and their targets
> > +~~~~~~~~~~~~~~~~~~~~~~~
> > +Configuration variables described below configure some of gitweb links:
> > +their target and their look (text or image), and where to find page
> > +prerequisites (stylesheet, favicon, images, scripts).  Usually they are left
> > +at their default values, with the possible exception of `@stylesheets`
> > +variable.
> 
> Language nits: missing "The" before "Configuration variables described
> below"; missing "some" before "supporting files".
                                ^^^^^^^^^^^^^^^^^^---???  
 
> > +
> > +@stylesheets::
> > +	List of URIs of stylesheets (relative to base URI of a page). You
> > +	might specify more than one stylesheet, for example use gitweb.css
> > +	as base, with site specific modifications in separate stylesheet
> > +	to make it easier to upgrade gitweb. You can add a `site` stylesheet
> > +	for example by putting
> > ++
> > +----------------------------------------------------------------------------
> > +push @stylesheets, "gitweb-site.css";
> > +----------------------------------------------------------------------------
> > ++
> > +in the gitweb config file.  Those values that are relative paths, are
> > +relative to base URI of gitweb.
> 
> [...]  What is a base URI --- is it set by another variable?

Base URI is a concept defined in HTML / XHTML specification (or in URI
definition), so I'd rather not explain it here.


> > +This list should contain URI of gitweb's stylesheet.  The URI of gitweb
> > +stylesheet is set during build time via `GITWEB_CSS` variable.  It's default
> > +value is 'static/gitweb.css' (or 'static/gitweb.min.css' if the `CSSMIN`
> > +variable is defined, i.e. if CSS minifier is used during build).
> > ++
> > +*Note*: there is also legacy `$stylesheet` configuration variable, which was
> > +used by older gitweb.
[...]
> If I am new on the job and find the $stylesheet variable set, what
> should I interpret it to mean?  How can it be translated to the newer
> @stylesheets style?  What happens if both variables are set --- does
> one override the other, or are they combined somehow?

Added

  If `$stylesheet` variable is defined, only CSS stylesheet
  given by this variable is used by gitweb.

I hope that old config files that define this variable are rare.

> > +$home_link::
> > +	Target of the home link on top of all pages (the first part of view
> > +	"breadcrumbs").  By default set to absolute URI of a page ($my_uri).

> Which page does "a page" refer to here (doesn't $my_uri change from
> request to request)?

I have extended last sequence of this description to read:

  By default it is set to the absolute URI of a current page
  (to the value of `$my_uri` variable, or to "/" if `$my_uri` is undefined
  or is an empty string).
 
$my_uri changes from request to request, and $home_link too.

By default config is re-read on each request; if not, one should
use $per_request_config subroutine to set this variable if it changes
from request to request.

> > +$default_projects_order::
> > +	Default value of ordering of projects on projects list page.  Valid
> > +	values are "none" (unsorted), "project" (by project name, i.e. path
> > +	to repository relative to `$projectroot`), "descr" (project
> > +	description), "owner", and "age" (by date of most current commit).
> > ++
> > +Default value is "project".  Unknown value means unsorted.
> 
> What does "Default" mean here (i.e., what overrides it)?

Added

  [...], which means the ordering used if you don't explicitly sort
  projects list (if there is no "o" CGI query parameter in the URL).
 
> > +
> > +
> > +Changing gitweb behavior
> > +~~~~~~~~~~~~~~~~~~~~~~~~
> > +Those configuration variables control _internal_ gitweb behavior.
> 
> [...] Does internal behavior mean "functionality as opposed to
> appearance and input location" or something like that?

Yes, it does.

> > +
> > +$default_blob_plain_mimetype::
> > +	Default mimetype for blob_plain (raw) view, if mimetype checking
> > +	doesn't result in some other type; by default "text/plain".
[...]

> Where can I look to read more about mimetype autodetection?

Added the following sentence:

  	Gitweb guesses mimetype of a file to display based on extension
  	of its filename, using `$mimetypes_file` (if set and file exists)
  	and '/etc/mime.types' files (see *mime.types*(5) manpage; only
  	filename extension rules are supported by gitweb).
 
> > +@diff_opts::
> > +	Rename detection options for git-diff and git-diff-tree. By default
> > +	(\'-M'); set it to (\'-C') or (\'-C', \'-C') to also detect copies,
> > +	or set it to () i.e. empty list if you don't want to have renames
> > +	detection.
[...]

> Probably worth mentioning that GNU patch still has problems with some
> rename patches, especially when they involve file copies ['-C'] or
> criss-cross renames ['-B'] (see [1] and [2], for example).
> 
> [1] http://savannah.gnu.org/bugs/?31058
> [2] http://thread.gmane.org/gmane.linux.ports.sh.devel/8697/focus=8773

I have added the following paragraph:

  +
  *Note* that rename and especially copy detection can be quite
  CPU-intensive.  Note also that non git tools can have problems with
  patches generated with options mentioned above, especially when they
  involve file copies (\'-C') or criss-cross renames (\'-B').


> > +@git_base_url_list::
> > +	List of git base URLs used for URL to where fetch project from, shown
> > +	in project summary page.  Full URL is "`$git_base_url/$project`".  You
> > +	can setup multiple base URLs (for example one for `git://` protocol
> > +	access, and one for `http://` "dumb" protocol access).  Note that per
> > +	repository configuration can be set in '$GIT_DIR/cloneurl' file, or as
> > +	values of multi-value `gitweb.url` configuration variable in project
> > +	config.
> > ++
> > +You can setup one single value (single entry/item in this list) during
> > +building by using `GITWEB_BASE_URL` built-time configuration variable.
> > +[No default]
> 
> Language nits: "git base URLs used for URL to where fetch project from"
> means something like "Git URLs relative to which projects can be
> fetched"; [...]

[...]
> Is the per repository cloneurl added to this list, or does it override
> it?

I have rewritten it to hopefully more clear version, and added information
about precedence of cloneurl and the like:

  @git_base_url_list::
  	List of git base URLs.  These URLs are used to generate URLs
  	describing from where to fetch a project, which are shown on
  	project summary page.  The full fetch URL is "`$git_base_url/$project`",
  	for each element of this list. You can set up multiple base URLs
  	(for example one for `git://` protocol, and one for `http://`
  	protocol).
  +
  Note that per repository configuration can be set in '$GIT_DIR/cloneurl'
  file, or as values of multi-value `gitweb.url` configuration variable in
  project config.  Per-repository configuration takes precedence over value
  composed from `@git_base_url_list` elements and project name.
  +
  You can setup one single value (single entry/item in this list) at build
  time by setting the `GITWEB_BASE_URL` built-time configuration variable.
  [Default: (), i.e. empty list]

> > +$maxload::
> > +	Used to set the maximum load that we will still respond to gitweb queries.
> > +	If server load exceed this value then return "503 Service Unavailable"
> > +	error. Server load is taken to be 0 if gitweb cannot determine its value.
> > +	Set it to undefined value to turn it off. [Default: 300]
> 
> Probably worth spelling out that this is a "load average" (as shown by uptime(1)).

I have added the following sentence to describe it:

  Currently it works only on Linux,
  where it uses '/proc/loadavg'; the load there is the number of active
  tasks on the system -- processes that are actually running -- averaged
  over the last minute.
 

> > +$per_request_config::
> > +	If set to code reference, it would be run once per each request.  You can
> > +	set parts of configuration that change per session, e.g. by adding
> > +	the following code to gitweb configuration file
> > ++
> > +--------------------------------------------------------------------------------
> > +our $per_request_config = sub {
> > +	$ENV{GL_USER} = $cgi->remote_user || "gitweb";
> > +};
> > +--------------------------------------------------------------------------------
> 
> Language nits: missing "this is" before "set to a code reference";
> "would" should be "will" (those crazy English conditionals again); the
> appropriate preposition before "each request" is "for", not "per";
> missing "this way" after "change per session"; would be clearer with a
> full stop before the example, and with the example made into a full
> sentence ("For example, one might use the following code in a gitweb
> configuration file:").
> 
> > ++
> > +Otherwise it is treated as boolean value: if true gitweb would process
> > +config file once per request, if false it would process config file only
> > +once.  [Default: true]
> > ++
> > +*NOTE*: `$my_url`, `$my_uri`, and `$base_url` are overwritten with their default
> > +values before every request, so if you want to change them, be sure to set
> > +this variable to true or a code reference effecting the desired changes.
> 
> At this point, I've forgotten what the "Otherwise" is contrasting with;
> probably best to repeat it ("If $per_request_config is not a code
> reference, it is interpreted as a boolean value."); "would" should be
> "will" again (2x); missing "the" or "each" before "config file" (2x);
> missing "and" before "if it is false"; "it" could be "gitweb" to
> avoid confusion in this pronoun-heavy sentence; missing "each time it
> is executed" after "process the config file only once".
> 
> Probably worth mentioning that this variable starts to shine when one
> gitweb instance is used to serve multiple requests, with CGI
> replacements like mod_perl, fastcgi, plackup, and so on.

I have rewritten and extended it as following:

  If `$per_request_config` is not a code reference, it is interpreted as boolean
  value.  If it is true gitweb will process config files once per request,
  and if it is false gitweb will process config files only once, each time it
  is executed.  [Default: true]
  +
  *NOTE*: `$my_url`, `$my_uri`, and `$base_url` are overwritten with their default
  values before every request, so if you want to change them, be sure to set
  this variable to true or a code reference effecting the desired changes.
  +
  This variable matters only when using persistent web environments that
  serve multiple requests using single gitweb instance, like mod_perl,
  FastCGI or Plackup.

> > +$version::
> > +	Gitweb version, set automatically when creating gitweb.cgi from
> > +	gitweb.perl. You might want to modify it if you are running modified
> > +	gitweb, for example 
> > ++
> > +---------------------------------------------------
> > +our $version .= " with caching";
> > +---------------------------------------------------
> 
> Might be worth mentioning this is only used in HTML comments and the
> "generator" metadata field, nothing more special than that.

Added:

  This variable is purely informational, used e.g. in the "generator"
  meta header in HTML header.
 
> > +
> > +$my_url::
> > +$my_uri::
> > +	Full URL and absolute URL of gitweb script;
> > +	in earlier versions of gitweb you might have need to set those
> > +	variables, now there should be no need to do it.  See
> > +	`$per_request_config` if you need to set them still.
[...]

> What is the difference between a full URL and an absolute URL?

Full URL is e.g. 'http://git.example.com/gitweb.cgi', while absolute URL
is e.g. '/gitweb.cgi'.

> > +sub::
> > +	Subroutine that will be called with default options as parameters to
> > +	examine per-repository configuration, but only if feature is
> > +	overridable (\'override' is set to true).  If not present then
> > +	per-repository override for given feature is not supported.
> > ++
> > +You wouldn't need to ever change it in gitweb config file.
> 
> Language nits: "default options as parameters" means "the array
> referred to by the 'default' field as parameter list", I guess.
> Missing "the" before "feature is overridable" and "gitweb
> configuration files".  "given feature" -> "this feature".  "not
> supported" -> "not enabled", maybe.
> 
> Actually, I'm not sure I understand this one.  Are users supposed to
> set this field?  Where can they look to find out what features have it
> set by default?  Who calls this function, and what does that person or
> code path do with the return value?  If it is not part of the gitweb
> configuration that an administrator might modify (the subject of this
> manpage), why not just say that ("subroutine used internally; present
> if and only if this feature can be made overridable with the
> "override" field; you should not change it") and leave it at that?

Changed this to:

  sub::
  	Internal detail of implementation.  What is important is that
  	if this field is not present then per-repository override for
  	given feature is not supported.
  +
  You wouldn't need to ever change it in gitweb config file.
 
> > +
> > +
> > +Features in `%feature`
> > +~~~~~~~~~~~~~~~~~~~~~~
> > +Below there are described gitweb features that are configurable via
> > +`%feature` hash.  For a complete list please consult gitweb sources.
> 
> Language nit: "Below there are described gitweb features ..." -> "The
> gitweb features ... are listed below".  The second sentence could
> probably be more apologetic, something like "Currently the only
> authoritative and complete list is in the comments in the gitweb.cgi
> source code."

Reformulated it to read:

  The gitweb features that are configurable via `%feature` hash are listed
  below.  This should be a complete list, but ultimately the authoritative
  and complete list is in gitweb.cgi source code, with features described
  in the comments.

> > +pickaxe::
> > +	Enable the so called pickaxe search, which will list the commits
> > +	that modified a given string in a file.  This can be practical and
> > +	quite faster alternative to "blame" action, but still potentially
> > +	CPU-intensive.  Enabled by default.
> > ++
> > +The pickaxe search is described in linkgit:git-log[1] (the
> > +description of `-S<string>` option, which refers to pickaxe entry in
> > +linkgit:gitdiffcore[7] for more details).
> > ++
> > +This feature can be configured on a per-repository basis via
> > +repository's `gitweb.pickaxe` configuration variable (boolean).
> 
> I think "modified" means "introduced or removed" (as an approximation to
> "changes the number of occurences of").

It is even more correct with respect to mechanism behind '-S' option.

> (By the way, is there any way for the the very paranoid to limit the
> length of regexes used or CPU time used per request, to get some
> reasonable cap on this sort of thing?  I guess that's more in the
> realm of web server configuration than something gitweb should be
> responsible for --- but if there's some common practice or well known
> reference on the topic, it could be worth mentioning at the top of
> this GITWEB FEATURES section some day.)

I don't know if it is possible to limit CPU time used per request.
I think most of time is spent in git commands; gitweb currently doesn't
offer any way to renice or limit time of running git commands.  The
only load-related mechanism is $maxload.

> > +show-sizes::
> > +	Enable showing size of blobs (ordinary files) in a "tree" view, in a
> > +	separate column, similar to what `ls -l` does; see description of
> > +	`-l` option in linkgit:git-ls-tree[1] manpage.  This cost a bit of
> > +	I/O.  Enabled by default.
> > ++
> > +This feature can be configured on a per-repository basis via
> > +repository's `gitweb.showsizes` configuration variable (boolean).
> 
> Nit: "cost" -> "costs".  Interesting (I guess packv4 will help with
> the CPU [decompression] cost of this when it comes).

Nb. the fast that directory entries ('tree' objects) do not have their
size displayed was result of request from people working on packv4, where
'tree' objects would be stored decomposed, and calculating object size
for a 'tree' object will be quite costly.

Add to that the fact that 'tree' object size is not very interesting...
 
> > +avatar::
> > +	Avatar support.  When this feature is enabled, views such as
> > +	"shortlog" or "commit" will display an avatar associated with
> > +	the email of the committer(s) and/or author(s).
> > ++
> > +Currently available providers are *"gravatar"* and *"picon"*.
> > +If an unknown provider is specified, the feature is disabled.
> > +*Note* that some provides might require extra Perl packages to be
> > +installed; see 'gitweb/INSTALL' for more details.
[...]

> If I set 'default' to ["gravator", "picon", "unknown"], will that
> really disable the feature?

Only one provider at a time can be selected; I have added this
information to description.
 

> > +forks::
> > +	Make gitweb consider projects in subdirectories of project root
> > +	(basename) to be forks of existing projects.  Given project
> > +	`$projname.git`, projects matching `$projname/*.git` will not be
> > +	shown in the main projects list, instead a \'+' mark will be added
> > +	to `$projname` there and a "forks" view will be enabled for the
> > +	project, listing all the forks.  If project list is taken from a
> > +	file, forks have to be listed after the main project.
> > ++
> > +Project specific override is not supported.
[...]

> If I understand correctly, "Given project `$projname.git`, projects
> matching `$projname/*.git`" can be written as "If the project
> `$projname.git` exists, projects in the `$projname/` directory".  Is
> it just projects in that directory, or are subdirectories included, as
> in the following example?
> 
> 	project.git
> 	project/foo/bar/baz/qux.git

Yes, they are.

The new improved and extended version is now:

  forks::
  	If this feature is enabled, gitweb considers projects in
  	subdirectories of project root (basename) to be forks of existing
  	projects.  For each project `$projname.git`, projects in the
  	`$projname/` directory and its subdirectories will not be
  	shown in the main projects list.  Instead, a \'+' mark is shown
  	next to `$projname`, which links to a "forks" view that lists all
  	the forks (all projects in `$projname/` subdirectory).  Additionally
  	a "forks" view for a project is linked from project summary page.
  +
  If the project list is taken from a file (`$projects_list` points to a
  file), forks are only recognized if they are listed after the main project
  in that file.
  +
  Project specific override is not supported.

> > +
> > +actions::
> > +	Insert custom links to the action bar of all project pages.  This
> > +	enables you to link to third-party scripts integrating into gitweb.
> > ++
> > +The "default" value consists of a list of triplets in the form
> > +`("<label>", "<link>", "<position>")` where "position" is the label
> > +after which to insert the link, "link" is a format string where `%n`
> > +expands to the project name, `%f` to the project path within the
> > +filesystem, `%h` to the current hash (\'h' gitweb parameter) and
> > +`%b` to the current hash base (\'hb' gitweb parameter); `%%` expands
> > +to \'%'.
> 
> Interesting.  "enables" should be "allows" here.

Right.
 
> Is %f an absolute path (i.e., starting with '/')?
 
It is "$projectroot/$project" (which I have added to this description).

> > +In most case you would want to change only default timezone:
> > ++
> > +---------------------------------------------------------------------------
> > +$feature{'javascript-timezone'}{'default'}[0] = "utc";
> > +---------------------------------------------------------------------------
[...]
> > +Timezone value can be "local" (for local timezone that browser uses), "utc"
> > +(what gitweb uses when JavaScript or this feature is disabled), or numerical
> > +timezone in the form of "+/-HHMM" for example "+0200".  This way is
> > +guaranteed to be backward compatibile.
> > ++
> > +Project specific override is not supported.
> 
> Language nits: when we are talking about supported values in general,
> it sounds better for some reason with "value" -> values"; "numerical
> timezone" -> "numerical timezones"; "for example" -> "such as".
> 
> What is "This way", and what other way should people be avoiding to
> prevent forward compatibility gotchas?
 
"This way" refers to the example configuration.  I have reformulated
this description by removing last sentence, and adding

  +
  The example configuration presented here is guaranteed to be backwards
  and forward compatible.

just after example.


> [...]
> > +GITWEB_CONFIG::
> > +	Sets location of per-instance configuration file.
> [...]
> > +FILES
> > +-----
> > +gitweb_config.perl::
> > +	This is default value for per-instance configuration file.  The
> > +	format of this file is described above.
> > +/etc/gitweb.conf::
> > +	This is default value for fallback system-wide configuration
> > +	file.  This file is used only if per-instance configuration
> > +	variable is not found.
> > +/etc/gitweb-common.conf::
> > +	This is default value for common system-wide configuration
> > +	file.
> 
> "default value" sounds strange here --- I guess I would have expected
> something more like
> 
>  ENVIRONMENT
>  -----------
>  ...
>  GITWEB_CONFIG::
> 	Path to use to find the per-instance configuration file,
> 	instead of gitweb_config.perl.  If relative, this is relative
> 	to $GITWEBDIR.
> 
>  FILES
>  -----
>  /etc/gitweb-common.conf::
> 	Options to be shared by all gitweb instances.  The format is
> 	described above.
>  $GITWEBDIR/gitweb_config.perl::
> 	Additional settings for a particular gitweb instance (in
> 	the same format).
>  /etc/gitweb.conf::
> 	Fallback configuration file with settings for gitweb instances
> 	that do not contain a gitweb_config.perl file.

I'll think about this proposal.

For now I have just changed "default value for ..." to
"default name of ...".
  

Thank you very much for your feedback.

-- 
Jakub Narebski
Poland
