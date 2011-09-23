From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Fri, 23 Sep 2011 12:38:11 +0200
Message-ID: <4E7C6193.2020201@alum.mit.edu>
References: <4E7A3BDE.3040301@alum.mit.edu>	<7vy5xh1whq.fsf@alter.siamese.dyndns.org>	<4E7AF1AE.5030005@alum.mit.edu> <m3vcskqjcv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 12:38:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R739F-0001go-1h
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 12:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab1IWKiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 06:38:20 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58784 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101Ab1IWKiU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 06:38:20 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8NAcBMe027932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 23 Sep 2011 12:38:12 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <m3vcskqjcv.fsf@localhost.localdomain>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181958>

On 09/23/2011 12:54 AM, Jakub Narebski wrote:
> There is a slight problem from the UI point of view of git-check-attr,
> namely that there are _three_ pieces of information: a place to read
> .gitattributes from (working tree, index, commit), list of attributes
> to check (or --all) and list of files (list of paths).  You can use
> "--" to separate _two_ pieces of information.

An alternative would be to accept <rev>:<path>, :<n>:<path>, and :<path>
in addition to simple <path>.

I also just remembered that currently the paths passed to
git-check-attr, git_check_attr(), and git_all_attrs() do not have to
correspond to existing objects; the paths are compared as strings.
Presumably we should retain this aspect of the behavior even if a
revision or tree is specified explicitly.

There are other problems in the UI of git-check-attr:

1. Its "-z" option affects how standard input is interpreted; there is
no way to cause the output to be generated with NUL separators.

2. Its output does not distinguish between the special statuses
unspecified/unset/set and possible string values
"unspecified"/"unset"/"set".

Maybe a --porcelain option could be used to overcome these shortcomings.

If necessary we could deprecate "git check-attr" and implement an
improved command ("git get-attr"?) that starts from a clean UI slate.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
