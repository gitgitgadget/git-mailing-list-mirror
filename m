From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSOC Application [gitweb]
Date: Mon, 19 Mar 2012 16:06:49 -0700 (PDT)
Message-ID: <m3bons42d2.fsf@localhost.localdomain>
References: <4F67AEAD.4070401@informatik.uni-luebeck.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Philipp Abraham <abrahamp@informatik.uni-luebeck.de>
X-From: git-owner@vger.kernel.org Tue Mar 20 00:06:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9lfF-0007rg-5N
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 00:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758575Ab2CSXGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 19:06:52 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36216 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617Ab2CSXGv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 19:06:51 -0400
Received: by wibhq7 with SMTP id hq7so4467369wib.1
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 16:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=xgMwhcpUzBf2Fu+CxszyimryYGXnvjj2NRzgcaaHn/0=;
        b=mgVkV4ejTmpgUfDD/aVLOHCKTnyuoqi4eRcx3UdYF/v7Lnkz1euLZKmwXW63bp6wtW
         HKVE6sA/ukCofI40cPDdhmZzHiv+P2BSxw8pWzh9P8YB3FpnhO5OgPB8k+8tTiUcqfKi
         mpKJQqJrvixMBKeB4vZYTVBBc7PTeJQsLxoU4INaJstiMA87v4ax9q7OIDjZ3GbV+whm
         jYEySbYrgaM0oMTP37mPkLD/OlrGx/Frw3HhUSmZlronthKc7ndTC1xQib7ppvsbbrKf
         F9tXhE+DPJ0ewqLgc3aTBsqW3kOf/sYKK0XxeC3fo3U0cN4OMzntg4pMJ+oXqdB6lMel
         G6bw==
Received: by 10.180.76.74 with SMTP id i10mr23802529wiw.2.1332198410329;
        Mon, 19 Mar 2012 16:06:50 -0700 (PDT)
Received: from localhost.localdomain (abvw11.neoplus.adsl.tpnet.pl. [83.8.220.11])
        by mx.google.com with ESMTPS id n15sm29241721wiw.6.2012.03.19.16.06.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Mar 2012 16:06:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2JN6oim010528;
	Tue, 20 Mar 2012 00:06:50 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2JN6nQE010525;
	Tue, 20 Mar 2012 00:06:49 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4F67AEAD.4070401@informatik.uni-luebeck.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193473>

Philipp Abraham <abrahamp@informatik.uni-luebeck.de> writes:

> For my application, I would like to focus on gitweb.
> Looking at this year's proposals [1] the point "Use JavaScript library
> / framework in gitweb" caught my interest.
> I scanned through the current javascript code used by gitweb and
> noticed that there's not too much going on currently.
> 
> There are only 2 components where JS is used: Adjusting the time zone
> and incrementally looking up the data for blame.

Well, there is 2 and a 1/2: there is also "JavaScript detection".

> Since including a JS library (like prototype.js or jQuery) and
> refactoring the (small) existing code base to use the lib's methods
> doesn't look enough for GSoC, I wanted to ask what would be the best
> idea for a project proposal.

All three components could be improved:

* "JavaScript detection" now rewrites all internal links after
  loading document.  Perhaps a better solution would be to install
  "live" onclick event handler that would capture clicking on
  internal links and only then add 'js=1'

* The UI for adjusting timezone could be improved using UI part of
  JavaScript library; also capturing of onclick could be improved.

* Incremental blame could be written in two parts: one as possibly
  emulated (via timer) onprogress for XHR, one as queuing visual
  updates based on received data

> Are there any additional features that you would like to see in gitweb?

* Client-side sorting of tables (e.g. list of projects), though at
  least for some JavaScript libraries that would hardly need any work
  beside intergrating visually with the rest of gitweb and disabling
  server-side sorting

* Client-side syntax highlighting of blob view.  The problem here is
  how gitweb splits putput into lines, and provides line numbers,
  instead of just dumping file contents inside some kind of
  <pre>...</pre> element.

* Some way of allowing to create a diff between two arbitrary
  revisions; this might need some changes in server-side, and
  knowledge of Perl.

  A subset of this could be something like history view in MediaWiki.

* Perhaps further refinement of highlighting changes in diff, or even
  implementing transforming ordinary unified diff into side-by-side
  diff entirely on client side.
 
* Some way of automatic extending of clickable area for places where
  we have single link in a cell or cell-like structure

> I thought about creating a graphical representation of the tree (as
> proposed on last years idea list [2]) additionally or in exchange for
> the first idea.
> Though I couldn't think of the perfect solution (from a technology
> point) yet.
> Possible technologies would be using SVG, html5 canvas element or
> dynamically manipulated DOM elements (best browser support but harder
> to realize). Using special characters like 'git log --graph' does,
> seems to look a bit too retro in a web application.

Or just use Raphael JavaScript library (http://raphaeljs.com)...

> What would you advice to maximize the chances of getting accepted to
> work on gitweb?

-- 
Jakub Narebski
