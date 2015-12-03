From: Mike Crowe <mac@mcrowe.com>
Subject: Re: [PATCH] push: Improve --recurse-submodules support
Date: Thu, 3 Dec 2015 13:10:06 +0000
Message-ID: <20151203131006.GA5119@mcrowe.com>
References: <20151202095451.GA22568@mcrowe.com>
 <1449050172-1119-1-git-send-email-mac@mcrowe.com>
 <xmqqsi3k4ety.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 14:10:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4TeR-0007eg-2h
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 14:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759742AbbLCNKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 08:10:16 -0500
Received: from avasout05.plus.net ([84.93.230.250]:41240 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbbLCNKP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 08:10:15 -0500
Received: from deneb ([80.229.24.9])
	by avasout05 with smtp
	id p1A61r0030BmcFC011A7h5; Thu, 03 Dec 2015 13:10:10 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=MryvkDue c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17 a=0Bzu9jTXAAAA:8
 a=-An2I_7KAAAA:8 a=kj9zAlcOel0A:10 a=wUQvQvOEmiQA:10 a=YOu_mwoRy9jSUDrgkhUA:9
 a=CjuIK1q_8ugA:10
Received: from mac by deneb with local (Exim 4.84)
	(envelope-from <mac@mcrowe.com>)
	id 1a4TeA-0001bT-2o; Thu, 03 Dec 2015 13:10:06 +0000
Content-Disposition: inline
In-Reply-To: <xmqqsi3k4ety.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281951>

On Wednesday 02 December 2015 at 15:21:13 -0800, Junio C Hamano wrote:
> Mike Crowe <mac@mcrowe.com> writes:
> 
> > b33a15b08131514b593015cb3e719faf9db20208 added support for the
> > push.recurseSubmodules config option. After it was merged Junio C Hamano
> > suggested some improvements:
> >
> >  - Declare recurse_submodules on a separate line.
> >
> >  - Accept multiple --recurse-submodules options on command line with the
> >    last one winning. (This simplified the implementation too.)
> >
> > Also slightly improve one of the tests added in
> > b33a15b08131514b593015cb3e719faf9db20208.
> 
> The above is overly verbose about how the commit materialized,
> compared to the description of the merit of this update.
> 
>     push: fix --recurse-submodules breakage
>
>     When b33a15b0 (push: add recurseSubmodules config option,
>     2015-11-17) added push.recurseSubmodules configuration option,
>     it also changed the command line parsing to allow
>     --no-recurse-submodules to override configured default.
>
>     However, the parsing of configuration variables and command line
>     options did not follow the usual "last one wins" convention.
>     Fix this.

That's not quite true.

The check for conflicting options was added back in 2012 by eb21c732 when
--recurse-submodules=on-demand support was originally implemented. b33a15b0
treated that as correct and maintained the behaviour.

> 
>     Also fix the declaration of the new file-scope global variable
>     to put it on a separate line on its own.
> 
> or something?

Thanks for the better wording. Hopefully I've included enough of the right
bits in the updated patches that follow.

> Also describe what "slightly improve" really means.  What did the
> old one not test that should have been tested?

In attempting to describe this change I've found that both of the tests had
failings so I have improved them too.

Thanks.

Mike.
