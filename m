From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Wed, 19 Nov 2014 22:28:35 +0100
Message-ID: <12667112.uUCmIHHWmi@al>
References: <6997784.RuzRO1AFsK@al> <xmqq1toysyak.fsf@gitster.dls.corp.google.com> <xmqqsiherirj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 22:28:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrCny-0004D6-Qs
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 22:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934313AbaKSV2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 16:28:47 -0500
Received: from lekensteyn.nl ([178.21.112.251]:42151 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932735AbaKSV2p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 16:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=1+1NsHQvKqevKA5YmHrc+fJFedJjo1HAcSReI9eRoxA=;
	b=ILKLwq1rtMHpKa6YjjFpYeYAHT8S2WY3Gw56jVTBo4dntHZqp1oE6MEeFTNmOmHww2+yuMmNB9OmhAzQknAGUM82vpdzjPanbOxcdW/NY70wNbXPxNPovmbYOzaN2IXkzrq5h++tMKPxmvbrcHRdQvV6os40zsvwutTbex5JOJDmWQroi8JmfvoVgI4iopWI6uclpJz8w/Vu9DPvWVOXILSsA1bvfFdHunqkFBY+oiAdtfyMXWCXrfk7tuuMIvejpOzRgnx6Ed6hHbZwdwor+OrF+eG/cP31z3CUoINlxtjF9lGFt52IjKKbd/MvNd+9RTeg8AQGmn89bvWwdclhSg==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1XrCnk-00005L-O4; Wed, 19 Nov 2014 22:28:37 +0100
User-Agent: KMail/4.13.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.2; x86_64; ; )
In-Reply-To: <xmqqsiherirj.fsf@gitster.dls.corp.google.com>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 19 November 2014 13:18:56 Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Jeff King <peff@peff.net> writes:
> > If you are fetching from somebody else and then pushing into your
> > own publishing repository (i.e. fork of that upstream), why isn't
> > the sequence of event like this, instead?
> >
> >     $ git clone $upstream
> >     $ browser github.com
> >     ... fork upstream to your own publishing repository ...
> >     $ git remote set-url --push mine <url for your publish repo>
> >
> > Isn't this one of those bad workflows encouraged by GitHub, for
> > which you guys have to be punished ;-)?

For "forks", it usually goes like this:

    git clone $upstream
    ... realizes that is has a bug which I want to fix ...
    ... creates a new repo ...
    git remote rename origin upstream
    git remote add origin git@$personal_repo
    # "--fetch" is what I need
    git remote add --fetch https://$personal_repo

I often start by entering/copying the ssh URL which is what I need for
pushing. Later ssh-agent forget about my key and I realize that push
works fine over https, so would like to set that... only to observe that
is not possible in an straightforward way through 'git remote'.

> Coming back to the topic, how common would this "oops, I cloned via
> a wrong transport" be?  I am not opposed to giving a recovery method
> for gotcha that does not happen very often, but if such an addition
> adds undue confusion factor for people who use "set-url" for more
> common cases, that would be a bad trade-off.

Well, people rarely need to use 'git remote' except when, well, they
need to modify the remotes. Where does the confusion come from? I might
be biased now that I know the internals. Maybe the https/ssh case above
needs to be mentioned in the documentation? What do you think of the
updated documentation by the way?
-- 
Kind regards,
Peter
https://lekensteyn.nl
