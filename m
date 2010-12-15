From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/4] --word-regex sanity checking and such
Date: Wed, 15 Dec 2010 20:51:14 +0100
Message-ID: <201012152051.15159.trast@student.ethz.ch>
References: <561247.22837.qm@web110707.mail.gq1.yahoo.com> <cover.1292424926.git.trast@student.ethz.ch> <913156.57703.qm@web110711.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, <git@vger.kernel.org>
To: Scott Johnson <scottj75074@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 20:51:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSxNi-00071r-Mq
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 20:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189Ab0LOTvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 14:51:17 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:38149 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693Ab0LOTvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 14:51:16 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 20:51:07 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 20:51:15 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc5-16-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <913156.57703.qm@web110711.mail.gq1.yahoo.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163789>

Scott Johnson wrote:
> I've attached a pre and post with the complete file that is showing this 
> problem. I hope you'll be able to reproduce the issue with this.

I can't reproduce.  I did this:

  $ ls -l
  total 16
  -rw-r--r-- 1 thomas users 2128 2010-12-15 20:42 post.html
  -rw-r--r-- 1 thomas users 2354 2010-12-15 20:42 pre.html
  $ echo '*.html diff=html'  >.gitattributes
  $ git diff --no-index pre.html post.html
  diff --git 1/pre.html 2/post.html
[...]
  -        <li class="ydn-patterns"><em></em><a href="#">ydn-patterns</a></li>
  -        <li class="ydn-mail"><em></em><a href="#">ydn-mail</a></li>
  -        <li class="yws-maps"><em></em><a href="#">yws-maps</a></li>
  -        <li class="ydn-delicious"><em></em><a href="#">ydn-delicious</a></li>
  -        <li class="yws-flickr"><em></em><a href="#">yws-flickr</a></li>
  -        <li class="yws-events"><em></em><a href="#">yws-events</a></li>
  +        <li><em></em><a href="#">ydn-patterns</a></li>
  +        <li><em></em><a href="#">ydn-mail</a></li>
  +        <li><em></em><a href="#">yws-maps</a></li>
  +        <li><em></em><a href="#">ydn-delicious</a></li>
  +        <li><em></em><a href="#">yws-flickr</a></li>
  +        <li><em></em><a href="#">yws-events</a></li>
         </ul>
       </div><!-- wrap -->
     </div><!-- folder_list -->
  $ git diff --word-diff --no-index pre.html post.html
  diff --git 1/pre.html 2/post.html
[...]
          <li[-class="ydn-patterns"-]><em></em><a href="#">ydn-patterns</a></li>
          <li[-class="ydn-mail"-]><em></em><a href="#">ydn-mail</a></li>
          <li[-class="yws-maps"-]><em></em><a href="#">yws-maps</a></li>
          <li[-class="ydn-delicious"-]><em></em><a href="#">ydn-delicious</a></li>
          <li[-class="yws-flickr"-]><em></em><a href="#">yws-flickr</a></li>
          <li[-class="yws-events"-]><em></em><a href="#">yws-events</a></li>
        </ul>
      </div><!-- wrap -->
    </div><!-- folder_list -->

That's running bleeding-edge git, like I always do, but the userdiff
stuff hasn't changed in ages.

What does

  git config diff.html.wordregex

say on your system?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
