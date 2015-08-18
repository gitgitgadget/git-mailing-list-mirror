From: Renato Botelho <garga@FreeBSD.org>
Subject: Re: [bug] 2.5.0 build with =?utf-8?b?Tk9fUEVSTA==?= is broken
Date: Tue, 18 Aug 2015 11:05:45 +0000 (UTC)
Message-ID: <loom.20150818T130309-687@post.gmane.org>
References: <loom.20150814T171757-901@post.gmane.org> <loom.20150814T184447-932@post.gmane.org> <xmqq7foxiqu6.fsf@gitster.dls.corp.google.com> <CAPig+cR77oFo6D3f8BjAB_yM-xPt+3EUGK4vZr3eYWJGTtksAQ@mail.gmail.com> <xmqqoai9h9co.fsf@gitster.dls.corp.google.com> <CAPig+cR6iT=AC8zq-vHHTkXMzRmDA-o9JLi0h8gbR1tzbqNyKA@mail.gmail.com> <xmqqzj1tfr2g.fsf@gitster.dls.corp.google.com> <CAPig+cQkApWfZ6N159F-XFZk+nnzY-gAgLRfZXNitdd0CHpm2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 13:06:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZReid-0005Ak-3W
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 13:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbbHRLGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 07:06:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:42423 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbbHRLGI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 07:06:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZReiS-00055G-Jt
	for git@vger.kernel.org; Tue, 18 Aug 2015 13:06:05 +0200
Received: from mail2.bluepex.com ([200.247.39.210])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 13:06:04 +0200
Received: from garga by mail2.bluepex.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 13:06:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 200.247.39.210 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:40.0) Gecko/20100101 Firefox/40.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276123>

Eric Sunshine <sunshine <at> sunshineco.com> writes:

> 
> On Fri, Aug 14, 2015 at 6:22 PM, Junio C Hamano <gitster <at> pobox.com>
wrote:
> > Eric Sunshine <sunshine <at> sunshineco.com> writes:
> >
> >> On Fri, Aug 14, 2015 at 5:02 PM, Junio C Hamano <gitster <at>
pobox.com> wrote:
> >>> Eric Sunshine <sunshine <at> sunshineco.com> writes:
> >>>
> >>> I do not think that is anything new.  We always have assumed "some"
> >>> version of Perl available in order to run t/ scripts.
> >>
> >> True, but prior to 527ec39, without Perl available, git itself could
> >> at least be built and used (with some commands unavailable), even if
> >> it couldn't be fully tested. As of 527ec39, however, git won't even
> >> build because common-cmds.h can't be generated.
> >
> > I wouldn't bother digging in the history myself, but I am reasonably
> > sure that the current genereate-common-cmds is not the sole instance
> > that we relied on Perl to build (not test) in the past, and that is
> > another reason why I do not think this is anything new.
> 
> Hmm. In my tests by setting PERL_PATH to a bogus (non-existent)
> command, prior to 527ec39, git builds successfully, whereas, following
> 527ec39, it does not build. But, perhaps I overlooked something...(?)

It builds but there will be at least 3 commands that won't work:

git-submodule
git-request-pull
git-am

I'm considering to add perl dependency as mandatory on FreeBSD ports tree,
and maybe this NO_PERL option doesn't make more sense nowadays...
