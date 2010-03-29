From: Eli Barzilay <eli@barzilay.org>
Subject: Re: `git check-attr' problems & questions
Date: Mon, 29 Mar 2010 12:09:15 -0400
Message-ID: <19376.53419.640007.930897@winooski.ccs.neu.edu>
References: <m3iq8jn3ar.fsf@winooski.ccs.neu.edu>
	<20100328014208.GA23015@progeny.tock>
	<19376.50971.397375.810974@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 18:09:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwHWk-0003nL-Lf
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 18:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034Ab0C2QJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 12:09:17 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:36207 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784Ab0C2QJR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 12:09:17 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1NwHWd-0002QB-Kz; Mon, 29 Mar 2010 12:09:15 -0400
In-Reply-To: <19376.50971.397375.810974@winooski.ccs.neu.edu>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143490>

On Mar 29, Eli Barzilay wrote:
> On Mar 27, Jonathan Nieder wrote:
> >  : "Usage: $0 commit check-attr-args" &&
> > 
> >  GIT_INDEX=tmp-index git read-tree --reset -i "$1" &&
> >  shift &&
> >  GIT_INDEX=tmp-index git check-attr "$@" &&
> >  rm tmp-index
> 
> I tried that, but it doesn't work.  (I used GIT_INDEX_FILE.)

In case I'm doing something wrong, here's a script that shows the
problem that I have:

  #!/bin/sh
  rm -rf /tmp/test
  mkdir /tmp/test
  cd /tmp/test
  mkdir t
  cd t
  git init > /dev/null
  echo "Blah" > foo
  echo "foo x=y" > .gitattributes
  git add foo .gitattributes
  git commit -m "stuff" > /dev/null
  echo -n "check-attr in a working directory: "
  git check-attr x foo
  cd ..
  git clone --bare t > /dev/null
  cd t.git
  git read-tree --reset -i master
  echo -n "check-attr in a bare repository:   "
  git check-attr x foo

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
