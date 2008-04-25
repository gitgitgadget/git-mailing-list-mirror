From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] gitweb wishlist and TODO list
Date: Fri, 25 Apr 2008 15:14:35 +0200
Message-ID: <200804251514.37898.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 15:15:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpNm9-0005E1-BE
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 15:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677AbYDYNOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 09:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754710AbYDYNOs
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 09:14:48 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:29029 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383AbYDYNOq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 09:14:46 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3121581mue.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2008 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=nnJz4pWLQOJ7U9fei21QzFMbWPTDc/94qwcTBh1tT3E=;
        b=BUi5nydenM9Yvvi8BU4LdqrkZ9GmtFSx69AeBGyahkocFbqzvQOluiKHL3XgkPeU+2lSimsOO9TIr9u6M888x18WQgws2rrdPlAM5QGAum9VWFd8MOb33LiWNRn6LLGSVMyRIPwK/OcMwpmmhaq9aNdvBw2HVcrCai796WFYm28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iqmMoIyvfw83fcAUOAIqa4OOhht/MLnmwOq5Xqi+jhfpZP34dWcenpmJbTMmDD2IGyLgOGEPaF/1eRWlqQG4DHtKPCg3rjTPqdwYpfS7x2eMCg8Op/Oty4v8HRsHwjtJP+1gtoVfr27KZD0m1tdqGH2JCQIVNjC9WcnjQd2o7zg=
Received: by 10.78.188.10 with SMTP id l10mr3042011huf.33.1209129283958;
        Fri, 25 Apr 2008 06:14:43 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.255.239])
        by mx.google.com with ESMTPS id 33sm2118667hue.13.2008.04.25.06.14.40
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Apr 2008 06:14:42 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80337>

This is yet another series of planned gitweb features. It expands more
on tasks improving gitweb; new features are mentioned only in general
view.

Which tasks / features are most requested?  Which tasks should be done
first?  All comments appreciated.


1. Cleanup

* HTML: use classes for styling elements.

  There are still some places where we use presentational HTML elements
  like <i>. I'd rather have it replaced by adding class to appropriate
  element, and adding proper rule to CSS. This would make changing the
  style easier, but it would make generated a bit longer page larger.

  Other issue with above is with web browsers which do not implement CSS,
  so it would be good to retain presentational elements, perhaps adding
  styling to those elements.

  On the other hand we use class element when sometimes id attribute would
  be better, and sometimes (in the tables) it would be better served to
  add <col> and <colgroup> elements, and use header attribute and select
  CSS style by this attribute value.

* CSS: remove repetitions, use more elaborate selectors.

  Use descendant selectors more, and use other selectors like parent or
  grandchild, instead of relying on class iself.  The goal is to remove
  some of repetition in CSS file.  For example we could state that all
  "second level" divs, perhaps with some exceptions, should have 8px
  padding.

  This would make adding similar elements easier (for example README for a
  project had for a while no padding), and most probably would make CSS
  style smaller, but at the cost of CSS being more complicated (more
  complicated selectors, knowledge of cascading (priority) sequence).

  Perhaps we should reorder CSS file, and add some comments, to make it's
  maintenance easier, and make it easier to add style for new elements.

* Code: make code more readable.

  Some time passed by since renaming subroutines to better reflect what
  they do, and moving them to group similar subroutines together.  But
  since then gitweb gathered more subroutines, other subroutines were
  modified.  It would be nice if somebody with fresh view examined the
  code and, if it is needed, proposed subroutines renaming, changes in
  subroutines calling conventions, and move code around to have similar
  subroutines together.

* Code refactoring: separate code dealing with similar things.

  Gathering together code dealing with various log-like views, i.e. code
  dealing with 'log', 'shortlog', 'history' and 'rss'/'atom' actions (and
  perhaps also 'search' action for searching commit messages) would allow
  for improvements to "log" code to apply to all those views.  It would
  make also easier to add another log-like views, for example 'raw' or
  'plain' or 'mbox' view, or more delatiled search results (e.g. with
  context) for searching commit message.

  Another bit of code that could be put into separate subroutine is code
  dealing with "item" views, i.e. links for each tag in a list of tags,
  links for each entry in a 'tree' view, links for each commit in a
  'shortlog' or 'log' view, etc.  Yet another, code displaying single
  structured object, like 'tag' and 'commit' view.

  This would also make it easier to change the style used by gitweb
  everywhere simultaneously, without worrying that we forgot some place.

* Code: list form of open pipeline (?)

  Gitweb uses list form of open to run git commands, avoiding (negligible)
  cost of forking shell, and (non negligigle) trouble with shell-quoting
  command arguments.  But when output must be passed to other command,
  gitweb falls back to "shell" form of open.  Currently this happens only
  for snapshot formats using external compresor, now that pickaxe search
  got rewritten to use git-log, instead of git-rev-list fed to
  git-diff-tree.

  But if gitweb is to get syntax highlighting using some external tool, it
  would be better to have some kind of "list form of open" to open
  pipelines.

* Code: deal with utf8 when reading data (?)

  Currently gitweb converts from utf8 to Perl internal form using
  (misnamed) to_utf8() subroutine when writing out (printing out) via
  esc_html(), or by calling to_utf8() explicitely.  It would be less
  error-prone to force conversion to Perl internal form when reading data
  from external sources, and always store data in variables in Perl
  internal form.

* Code: input reading and validation refactoring.

  Currently gitweb reads values of CGI parameters into global variables,
  performing in the meantime basic validation of parameters.  It is done
  independently if current action access all the [possible] parameters.

  Perhaps this should be separated into subroutine.  This should help
  to have better FastCGI and probably also "native" mod_perl support.
  It would also show which actions use (and require) which parameters.


2. Performance etc.

* Better for FastCGI (via CGI::Fast or FCGI).

  Unfortunately I don't use FastCGI.  This has to be done in a very
  un-intruisive way, and without performance penalties for "ordinary" CGI
  and mod_perl.

  Suggested: input reading and validation refactoring.

* Optional information about load stats

  Add an option to display information about how much time it took to
  generate page, how many git commands were called, and possibly other
  metric; if page was cached, write when it was generated, and how much
  time till timeout.  This probably would require additional perl modules,
  and it should be conditional on those modules.

* Gitweb caching

  Add caching to gitweb, either caching of output, or caching of
  intermediate Perl structures.  Support proper replies to HTTP cache
  (in)validation requests.

  This is one of GSoC 2008 projects.

  Bundled together is using "infinite" (or at least large: currently we
  use +1d) Expires: and/or Cache-Control: max-age (if HTTP/1.1) for
  unchanging pages. Although those pages are usually rarely accessed...

* Reduce size of project list page

  Now that gitweb is used for installations spanning thousands of
  repositories, showing all projects (repositories) in the front page is
  hard on server (this can be migitated by caching), but also hard on
  browser which has to render huge table / huge page.

  One solution would be to divide projects list page into pages; this
  would have the advantage that for sorting by project name (default),
  or by project owner gitweb would have to get data (owner, last change)
  only for the projects shown.  Alternate solution, if categories support
  would got implemented, would be to show only list of categories.  Yet
  another would be to put projects search form as homepage (front page).

* AJAX sorting of tables

  Implement sorting tables (projects list, fork list, heads, tags) in
  browser using JavaScript, like tables in Wikipedia (if possible).  This
  would reduce server load, too.


3. New features

* Committags support

  Support expansion of "tags" in commit messages, like gitweb now does for
  (shortened) SHA-1, converting them to 'object' view link.  It should be
  done in a way to make it easy configurable, preferebly having to
  configure only variable part, and not having to write whole replacement
  rule.

  Possible committags include: _BUG(n)_, bug _#n_, _FEATURE(n),
  Message-Id, plain text URL e.g. _http://repo.or.cz_, spam protecting of
  email addresses, "rich text formatting" like *bold* and _underline_,
  syntax highlighting of signoff lines.

* Project categories support

* Syntax highlighting for "blob" view
  (in general: blob output filter)

* New log views (formats)

  New log-like views could include: 'log' view with path limiter,
  'whatchanged' like view with list of changed files, 'mbox' format (aka
  'plain' format) to be used by git-am, etc.

  This would I think require changes to log showing infrastructure.

* Enable showing blob size in 'tree' view (optional)

* Graphical log (like gitk, qgit, tig, or git-browser)
  perhaps also graphical view of forks like in GitHub

* Enable transparent compression for HTTP output
  (for performance reasons it makes sense to do it only for cached output)

-- 
Jakub Narebski
Poland
