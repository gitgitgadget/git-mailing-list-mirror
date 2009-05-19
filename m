From: Jakub Narebski <jnareb@gmail.com>
Subject: gitweb: Comments on perlcritic suggestions with severity 3 (harsh)
Date: Tue, 19 May 2009 10:40:13 +0200
Message-ID: <200905191040.15155.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 10:40:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6KsR-0007MI-PV
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 10:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbZESIkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 04:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbZESIkY
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 04:40:24 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:51923 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbZESIkW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 04:40:22 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1792841rvb.1
        for <git@vger.kernel.org>; Tue, 19 May 2009 01:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=THtu5r/879qOipKTdIv3CPmqq/zTlkIByC8BPoVFyB4=;
        b=K/DV7H2R49/deCt1K7fGu6+ByrCNLOKKASS0tlbTYhs6wyIvRDqQ032oMp4yZrb1Vm
         uy4woadR8d4SklRNaGOkRRRmCm7ewNj0/aMIKvgbcJxQpncQqJuIW8syqbyuHPvZfovC
         2LTUDxv1cw074R/CWCiv8Hgckko4L04KuRy58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=L0rCFTKa+eV4PqBFPavA/4D6cRrgeg8Z+Ht+NKFBM77bDYXQWR3rQ8CLIxfMbscnVQ
         yN0xpouUd/dTpBL9dNaJdFwy+HFlIYwVSRt5vHpo6gAt5XHuzLSG0DiCCE4TNZtzRwjq
         6gv9exMd6KRT8+uDXVRxVB+1u8n1OVHvm7YjE=
Received: by 10.140.144.6 with SMTP id r6mr2814480rvd.185.1242722423723;
        Tue, 19 May 2009 01:40:23 -0700 (PDT)
Received: from ?192.168.1.13? (abwi178.neoplus.adsl.tpnet.pl [83.8.232.178])
        by mx.google.com with ESMTPS id k41sm16041831rvb.37.2009.05.19.01.40.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 May 2009 01:40:22 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119505>

Below there are my comments on perlcritic (Perl::Critic) suggestions
for gitweb. As suggestions with severity 5 and 4 were covered in cover
letter for cleanup series:
  [PATCH 0/5] gitweb: Some code cleanups (up to perlcritic --stern)
  Message-Id: <200905100203.51744.jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/118690
this post is about severity 3 (harsh) suggestions only. I have tried
to exclude issues which were addressed in second cleanup series:
  [PATCH 0/4] gitweb: Some code cleanups, part 2 (low hanging fruit)
  Message-ID: <20090511173025.15152.94215.stgit@localhost.localdomain>
  http://thread.gmane.org/gmane.comp.version-control.git/118812
Both of those series are already in 'next' as merge (or merge of early
parts) from 'jn/gitweb-cleanup' feature branch.

I am sending those comments as I do not know where I would have time
to work on issues mentioned here. But perhaps that would help
somebody...

This post was inspired by similar series of patches for 
git-send-email by Bill Pemberton:
  Subject: [PATCH 0/6] cleanups for git-send-email
  Msg-Id: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu>
  URL: http://thread.gmane.org/gmane.comp.version-control.git/117881

The comments are based on documentation of policy modules for perlcritic
(Perl::Critic).  Most policy modules are in turn based on Damian
Conway's book "Perl Best Practices" (PBP).

I have used online version of perlcritic at http://perlcritic.com, which
is running Perl-Critic version 1.096).

gitweb: Some code cleanups

The following are some code cleanups for gitweb.perl.  They're based on
suggestions by perlcritic (Perl::Critic).  Most policy modules are in turn
based on Damian Conway's book "Perl Best Practices" (PBP).

This series was inspired by similar series of patches for git-send-email by
Bill Pemberton:
  Subject: [PATCH 0/6] cleanups for git-send-email
  Msg-Id: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu>
  URL: http://thread.gmane.org/gmane.comp.version-control.git/117881

Not all suggestions by perlcritic (or, to be more exact, by its online
version at http://perlcritic.com, which is running Perl-Critic version
1.096) were implemented.  Below there is list of perlcritic suggestions,
sorted by severity (gentle, stern, harsh, cruel, brutal): first list of
patches in series which applied perlcritic suggestions, then suggestions
not applied, with short explanation why they were not used.

......................................................................
Severity: harsh (3)

Main code has high complexity score (54) at line 1, column 1.
Consider refactoring.  Severity: 3

NOTE: Yeah, right.  The code is '#!/usr/bin/perl'


Package variable declared or used at line 27, column 1.
See pages 73,75 of PBP.  Severity: 3
Perl::Critic::Policy::Variables::ProhibitPackageVars
## no critic (ProhibitPackageVars)

 - Eliminate globals declared with our or use vars.

  Conway suggests avoiding package variables completely, because they expose
  your internals to other packages. Never use a package variable when a
  lexical variable will suffice. If your package needs to keep some dynamic
  state, consider using an object or closures to keep the state private.

  This policy assumes that you're using strict vars so that naked variable
  declarations are not package variables by default. Thus, it complains you
  declare a variable with our or use vars, or if you make reference to
  variable with a fully-qualified package name.

* PBP 5.2. Package Variables (Don't use package variables in your own
  development.)

NOTE: This is about 'our $base_url = $my_url;' etc., i.e. using 'our'
instead of 'my' to declare variables.  Unfortunately this is required to be
able to use gitweb from mod_perl, see commit 4a87b43e by Dennis Stosberg:

    gitweb: Declare global variables with "our"
    
    Variables declared with "my" in the file scope cannot be accessed from
    subroutines with mod_perl.


Regular expression without "/x" flag at line XXX, column XX.
See page 236 of PBP.  Severity: 3
Perl::Critic::Policy::RegularExpressions::RequireExtendedFormatting
## no critic (RequireExtendedFormatting) <-- perhaps in some cases...

 - Always use the /x modifier with regular expressions.

  Extended regular expression formatting allows you mix whitespace and
  comments into the pattern, thus making them much more readable.

  You might find that putting a /x on short regular expressions to be
  excessive.  [The minimum_regex_length_to_complain_about defaults to 0]

* PBP 12.1. Extended Formatting (Always use the /x flag.)

NOTE: This is a matter of taste.


"warn" used instead of "carp" at line 381, column 3.
See page 283 of PBP.  Severity: 3
Perl::Critic::Policy::ErrorHandling::RequireCarping

 - Use functions from Carp instead of warn or die.

  The die and warn functions both report the file and line number where the
  exception occurred. But if someone else is using your subroutine, they
  usually don't care where _your_ code blew up. Instead, they want to know
  where _their_ code invoked the subroutine. The Carp module provides
  alternative methods that report the exception from the caller's file and
  line number.

  By default, this policy will not complain about die or warn, if it can
  determine that the message will always result in a terminal newline. Since
  perl suppresses file names and line numbers in this situation, it is
  assumed that no stack traces are desired either and none of the Carp
  functions are necessary.

* PBP 13.6. Reporting Failure (Have exceptions report from the caller's
  location, not from the place where they were thrown.)

NOTE: This is about use of 'warn' in gitweb_get_feature. Probably should
just add end of line character (sic!), which suppresses adding file and
line number info; information which we don't really need in this case
(I have not found where this behavior of "warn" is documented).


Backtick operator used at line 476, column 20.
Use IPC::Open3 instead.  Severity: 3
Perl::Critic::Policy::InputOutput::ProhibitBacktickOperators
## no critic (ProhibitBacktickOperators) <-- TODO anyway

 - Discourage stuff like @files = `ls $directory`.

  Backticks are super-convenient, especially for CGI programs, but I find
  that they make a lot of noise by filling up STDERR with messages when they
  fail. I think its better to use IPC::Open3 to trap all the output and let
  the application decide what to do with it.

NOTE: IPC::Open3 is overkill for setting $git_version.  On the other hand we
should perhaps fail early here if $GIT is not found.


Subroutine "some_sub" with high complexity score (nn) at line XXX, column XX.
Consider refactoring.  Severity: 3
Perl::Critic::Policy::Subroutines::ProhibitExcessComplexity
## no critic (ProhibitExcessComplexity) <-- left for later

 - Minimize complexity by factoring code into smaller subroutines.

  All else being equal, complicated code is more error-prone and more
  expensive to maintain than simpler code. The first step towards managing
  complexity is to establish formal complexity metrics. One such metric is
  the McCabe score, which describes the number of possible paths through a
  subroutine. This Policy approximates the McCabe score by summing the
  number of conditional statements and operators within a
  subroutine. Research has shown that a McCabe score higher than 20 is a
  sign of high-risk, potentially untestable code. See
  http://www.sei.cmu.edu/str/descriptions/cyclomatic_body.html for some
  discussion about the McCabe number and other complexity metrics.

  The usual prescription for reducing complexity is to refactor code into
  smaller subroutines. Mark Dominus book "Higher Order Perl" also describes
  callbacks, recursion, memoization, iterators, and other techniques that
  help create simple and extensible Perl code.

  [...]

  Complexity is subjective, but formal complexity metrics are still
  incredibly valuable. Every problem has an inherent level of complexity, so
  it is not necessarily optimal to minimize the McCabe number. So don't get
  offended if your code triggers this Policy. Just consider if there might
  be a simpler way to get the job done.

FOOTNOTE: The link mentioned above is available only through The Internet
Archive (Wayback Machine) although the information is also available in PDF
file (supposedly for limited time); you can try 'Cyclomatic complexity'
article on Wikipedia (and links therein).

NOTE: The following subroutines were marked as having high complexity score,
 evaluate_path_info (44), href (31), format_diff_line (29),
 git_get_projects_list (21), parse_commit_text (27), git_header_html (33),
 git_difftree_body (54), git_patchset_body (24), git_project_list_body (34),
 git_summary (22), git_blame (23), git_blob (22), git_tree (25),
 git_blobdiff (39), git_commitdiff (56), git_search (51), git_feed (56).

Below they are sorted with greater complexity measure first:
  
  Subroutine                   complexity score 
  name                         (McCabe number)
  ==============================================
  git_commitdiff               56
  git_feed                     56
  git_difftree_body            54
  git_search                   51
  evaluate_path_info           44
  git_blobdiff                 39
  git_project_list_body        34
  git_header_html              33
  href                         31
  format_diff_line             29
  parse_commit_text            27
  git_tree                     25
  git_patchset_body            24
  git_blame                    23
  git_summary                  22
  git_blob                     22
  git_get_projects_list        21


Capture variable used outside conditional at line XXX, column XX.
See page 253 of PBP.  Severity: 3
Perl::Critic::Policy::RegularExpressions::ProhibitCaptureWithoutTest

 - Capture variable used outside conditional.

  If a regexp match fails, then any capture variables ($1, $2, ...) will be
  undefined. Therefore it's important to check the return value of a match
  before using those variables.

  This policy checks that capture variables are inside a conditional and do
  not follow an regexps.

  BUGS: Needs to allow 'next unless /$regexp/' construct.

* PBP 12.15. Captured Values (Use the numeric capture variables only when
  you're sure that the preceding match succeeded.)

   Pattern matches that fail never assign anything to $1, $2, etc., nor do
   they leave those variables undefined. After an unsuccessful pattern
   match, the numeric capture variables remain exactly as they were before
   the match was attempted. Often, that means that they retain whatever
   values some earlier successful pattern match gave them.

NOTE: Below there are different kind of cases, with different severity:
* line 697 in evaluate_path_info (very cryptic, if it does what I think
  it does, and can be simplified avoiding this warning), 
* lines 1199, 1208, 1210, 1220, 1221 in chop_str (might be an error if it
  doesn't match),
* line 2021 in git_get_hash_by_path, and line 2628 in parse_ls_tree_line,
  and lines 5820, 5821 in git_object (which assumes specified output
  format); git_object shouldn't perhaps do parsing by itself.
* line 2375 in parse_date (which assumes specific format of timezone info in
  time info; we should protect against errors as it was freeform and some
  older git didn't set it up correctly),
* line 2823 in mimetype_guess_file assumes that filename ends in extension
  which is assured by caller, but perhaps that should be also used in this
  subroutine to return early, just in case.


Reused variable name in lexical scope: $var at line XXX, column XX.
Invent unique variable names.  Severity: 3
Perl::Critic::Policy::Variables::ProhibitReusedNames 

 - Do not reuse a variable name in a lexical scope

  It's really hard on future maintenance programmers if you reuse a variable
  name in a lexical scope. The programmer is at risk of confusing which
  variable is which. And, worse, the programmer could accidentally remove
  the inner declaration, thus silently changing the meaning of the inner
  code to use the outer variable.

NOTE: This suggestion occurs in the following places:
* In project_in_list(), which is a very short subroutine; the name $project
  is quite natural here, and we do not use global variable $project.
  Perhaps to be named differently.
* Line 1208 in chop_str, where we (perhaps by accident) redeclare $str
  variable. To be fixed!
* Line 1757 at beginning of format_snapshot_links, where we override $hash
  with value we get as parameter, shadowing $hash with local variable of the
  same name; while we shouldn't overwrite global variable perhaps parameter
  name COULD be (SHOULD be) changed to something else other than $hash.
* Line 1848 at beginning of git_get_head_hash, where we reuse $project for
  name of function argument; perhaps it should be named $path of $repository
  or something, or use '$project ||= shift'.
* Line 1867 at beginning of git_get_type, where name of function argument is
  $hash (same as global variable) and perhaps it should be $object, or
  $object_hash...
* Line 1883 at beginning of hash_set_multi (an utility function), where
  argument should perhaps be named $hashref rather than $hash.
* %config is both name of global variable storing parsed commit, and the
  name of local variable in (utility) subroutine git_parse_project_config,
  which is returned on exit, and which result is set by caller of this
  subroutine to global variable %config.  To be replaced in the future by
  Git::Config.
* git_get_path_by_hash reuses $hash for the name of parameter.
* git_get_project_owner reuses $project.
* git_get_rev_name_tags passes $hash by parameter (and reuses $hash
  for parameter name).
* git_get_heads_list reuses $hash for local variable in line 2703.
* blob_contenttype reuses $file_name for local variable in line 2871.
* git_header_html reuses $action in line 3023 to mean -action parameter form
  $cgi->startform method ("action" attribute in <form> element); better name
  it $action_uri, or $form_action, or $form_uri.
* format_paging_nav passes $action, $hash, $page via arguments instead of
  using global variables; same with git_print_header_div and $action, $hash,
  $hash_base.
* git_get_link_target reuses $hash for parameter name ($object_hash or
  $symlink_object_hash).
* normalize_link_target reuses $hash_base for parameter name (or reuses
  $hash_base for parameter name)... but current lazy (no lookup)
  implementation doesn't use it at all. TODO !!! (TO BE CORRECTED).
* git_print_tree_entry reuses (I think) $hash_base for parameter name;
  I guess it is $basedir_hash or $hash_basedir.
* git_difftree_body passes $hash as parameter instead of using global
  variable
* git_difftree_body uses $hash_parent as local variable in line 3586
  (in a loop over all parents in combined diff).
* git_patchset_body passes $hash as parameter and reuses $hash_parent as a
  local variable (it used to pass $hash_parent as parameter, but now it
  supports also combined diff with multiple parents).
* git_history_body passes $hash_base as parameter.


Ambiguously named variable "nnnn" at line XXX, column XX.
See page 48 of PBP.  Severity: 3
Perl::Critic::Policy::NamingConventions::ProhibitAmbiguousNames
## no critic (ProhibitAmbiguousNames) <-- very subjective

 - Don't use vague variable or subroutine names like 'last' or 'record'.

  Conway lists a collection of English words which are highly ambiguous as
  variable or subroutine names. For example, $last can mean previous or
  final.

  This policy tests against a list of ambiguous words for variable names.

  The default list of forbidden words is:
    abstract bases close contract last left no record right second set

* PBP 3.9. Ambiguous Names (Avoid using inherently ambiguous words in
  names.)


Cascading if-elsif chain at line XXXX, column X.
See pages 117,118 of PBP.  Severity: 3
Perl::Critic::Policy::ControlStructures::ProhibitCascadingIfElse
## no critic (ProhibitCascadingIfElse) <-- can't use 'switch', 
                                           can't simplify otherwise

 - Don't write long "if-elsif-elsif-elsif-elsif...else" chains.

  Long if-elsif chains are hard to digest, especially if they are longer
  than a single page or screen. If testing for equality, use a hash lookup
  instead. See 'Switch' for another approach.

  The default maximum number of elsif alternatives to allow is 2.

* PBP 6.15. Multipart Selections (Avoid cascading an if.)

   Avoid cascades of if-elsif-elsif-else statements wherever possible. They
   tend to produce code with poor readability that is also expensive to
   execute.

NOTE: I'd rather avoid using 'Switch' module / 'switch' command.

Long if-elsif chain is also used for "range" testing in age_string, and for
mode testing using S_SOMETHING subroutines in mode_str, file_type and
file_type_long.

Long if-elsif chain is also used in format_diff_line subroutine, where
perhaps in first case it could be avoided (NOTE strange code using
e.g. tr/+/+/ to count number of occurences, when the fact that there was
occurence is enough), in second case it could be replaced by hash lookup.

Long if-elsif chain is used in parse_tag and parse_commit_text subroutines,
where we match using regexps against known headers (capturing and saving
relevant information).

Long if-elsif chain is used in blob_mimetype; main part is checking using
regexp if filename ends in specified known extension.

Long if-elsif chain is used git_difftree_body to check against possible
single letter status (this part should be simplified, the chain might be
replaced by hash lookup).


Hard tabs used at line 1389, column 11.
See page 20 of PBP.  Severity: 3
Perl::Critic::Policy::CodeLayout::ProhibitHardTabs 

 - Use spaces instead of tabs.

  Putting hard tabs in your source code (or POD) [...] anywhere other than a
  leading position.

* PBP 2.11. Tabs (Indent with spaces, not tabs.)
* PBP 4.3. Single-Character Strings (Don't write one-character strings in
  visually ambiguous ways.) <-- this includes literal tabs in strings.

NOTE: It is about: 
* using tabs in replacement part of 's{...}{...}eg;' regexp in
  format_log_line_html subroutine.

-- 
Jakub Narebski
Poland
