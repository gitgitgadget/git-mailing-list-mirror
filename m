From: Mike Hommey <mh@glandium.org>
Subject: Re: fetching from an hg remote fails with bare git repositories
Date: Wed, 5 Aug 2015 08:03:59 +0900
Message-ID: <20150804230359.GA27965@glandium.org>
References: <CAKfKJYuuO+eak-L2SUVUEmoOj16bgV6LL0S=g-LzFjTxZUcRzQ@mail.gmail.com>
 <CAGZ79kawh0himmR+DuvcQB0O1rRVBhkg9ycCLvPdbp1m0sHKtQ@mail.gmail.com>
 <CAKfKJYshy58eQMXTusUTf0dc2B7uVU+=rzdSicSG0JAuODSBug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Taylor Braun-Jones <taylor@braun-jones.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 01:04:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMlFv-0003lY-Gb
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 01:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbbHDXER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 19:04:17 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:52989 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669AbbHDXEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 19:04:16 -0400
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <glandium@glandium.org>)
	id 1ZMlFX-0007XB-Cm; Wed, 05 Aug 2015 08:03:59 +0900
Content-Disposition: inline
In-Reply-To: <CAKfKJYshy58eQMXTusUTf0dc2B7uVU+=rzdSicSG0JAuODSBug@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275345>

On Tue, Aug 04, 2015 at 05:27:13PM -0400, Taylor Braun-Jones wrote:
> On Tue, Aug 4, 2015 at 2:56 PM, Stefan Beller <sbeller@google.com> wrote:
> > On Tue, Aug 4, 2015 at 10:45 AM, Taylor Braun-Jones
> > <taylor@braun-jones.org> wrote:
> >> Fetching from an hg remote fails with bare git repositories. Non-bare
> >> repositories work fine.
> >>
> >> Steps to reproduce:
> >>
> >> mkdir /tmp/hgrepo
> >> cd /tmp/hgrepo
> >> hg init
> >> echo foo > foo.txt
> >> hg add foo.txt
> >> hg commit -m "add foo.txt" foo.txt
> >> git clone hg::/tmp/hgrepo/ /tmp/gitrepo
> >> cd /tmp/gitrepo/
> >> git fetch # WORKS
> >> git clone --bare hg::/tmp/hgrepo/ /tmp/gitrepo.git
> >> cd /tmp/gitrepo.git/
> >> git fetch # FAILS
> >>
> >> The error message from the last line is:
> >>
> >> fatal: bad object 0000000000000000000000000000000000000000
> >> error: hg::/tmp/hgrepo/ did not send all necessary objects
> >>
> >> Taylor
> >
> > Which version of git did you test this with? Does it also happen on
> > the latest version?
> 
> Sorry - forgot that detail. This is using git 2.1.4 from Ubuntu 15.04
> x86_64. I haven't tried the latest version of git yet.

Another missing detail is what you're using for mercurial support in
git. I would guess https://github.com/felipec/git-remote-hg. Shameless
plug, you may want to give a try to
https://github.com/glandium/git-cinnabar.

Anyways, your error looks like what I fixed in 33cae54, which git
describe tells me made it to git 2.3.2.

Mike
