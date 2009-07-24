From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 2/2] After renaming a section, print any trailing variable definitions
Date: Sat, 25 Jul 2009 07:11:05 +0900
Message-ID: <20090725071105.6117@nanako3.lavabit.com>
References: <1248470504-16326-1-git-send-email-alex@chmrr.net>
	<1248470504-16326-2-git-send-email-alex@chmrr.net>
	<1248470504-16326-3-git-send-email-alex@chmrr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Sat Jul 25 00:12:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUT0X-0005TY-AO
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbZGXWMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754746AbZGXWMn
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:12:43 -0400
Received: from karen.lavabit.com ([72.249.41.33]:58873 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731AbZGXWMm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:12:42 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 1621311B7F2;
	Fri, 24 Jul 2009 17:12:43 -0500 (CDT)
Received: from 5389.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id IQHG6ENHTXAF; Fri, 24 Jul 2009 17:12:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=MYAo/vmUNQnZHrH/gFyIiGN7yEXcqTlglDrHgUEfWevAsil4g1S/4xpKO9r0lGU7SXZrSdrTdID1oE8nXvWb7fEGmq+uIKoVlnyB9NrzNgd2NZPVxrMEKsvmpnym7P5O7c5GBZJMSjPbOfMA10uPp6Ewq2hE7ozisvUubfnKK1g=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1248470504-16326-3-git-send-email-alex@chmrr.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123954>

Quoting Alex Vandiver <alex@chmrr.net>

> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 43ea283..8c43dcd 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -460,6 +460,28 @@ EOF
>  test_expect_success "rename succeeded" "test_cmp expect .git/config"
>  
>  cat >> .git/config << EOF
> +[branch "vier"] z = 1
> +EOF

Isn't this a syntax error?

Documentation/config.txt says this.

    Subsection names are case sensitive and can contain any characters
    except newline (doublequote `"` and backslash have to be escaped as
    `\"` and `\\`, respectively).  Section headers cannot span multiple
    lines.  Variables may belong directly to a section or to a given
    subsection.  You can have `[section]` if you have `[section
    "subsection"]`, but you don't need to.

    There is also a case insensitive alternative `[section.subsection]`
    syntax.  In this syntax, subsection names follow the same restrictions
    as for section names.

    All the other lines are recognized as setting variables, in the form
    'name = value'.  If there is no equal sign on the line, the entire
    line ...

I read "All the other lines" to mean that the section headers and variable definitions are supposed to be on different lines.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
