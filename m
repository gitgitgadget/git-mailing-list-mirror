From: Andreas Ericsson <exon@op5.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 12:17:21 +0200
Message-ID: <49D33F31.80605@op5.com>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49D339B2.4388.6B1DEF@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49D327C4.7000101@op5.se> <49D35454.12423.D32681@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Russ Dill <russ.dill@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 12:20:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoxYJ-0007zV-Vw
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 12:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323AbZDAKRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 06:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760249AbZDAKR3
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 06:17:29 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:39296 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756832AbZDAKR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 06:17:27 -0400
Received: by fxm2 with SMTP id 2so2858957fxm.37
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 03:17:24 -0700 (PDT)
Received: by 10.86.49.13 with SMTP id w13mr5868056fgw.76.1238581044799;
        Wed, 01 Apr 2009 03:17:24 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.163.94])
        by mx.google.com with ESMTPS id 12sm6585193fgg.7.2009.04.01.03.17.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 03:17:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <49D35454.12423.D32681@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115366>

Ulrich Windl wrote:
> On 1 Apr 2009 at 10:37, Andreas Ericsson wrote:
> 
>>>> Not only that, but modification times are much more useful with make.
>>>> Merging or pulling small changes into a tree shouldn't require a full
>>>> rebuild of the entire tree which in some cases could take hours.
>>> Git is not a build system, and I really dislike "full rebuilds", but for 
>>> stability, before releasing anything, one should test it with a full rebuild.
>> I build all the time. Before and after every commit (merges are one type of
>> commit). I rely on file timestamps to be an accurate indicator of when the
>> file last changed *on my disk*.
>>
> 
> But you are silently assuming that the make files are correct: If a file is not 
> being rebuilt, you might be using an old compile without noticing. There a full 
> recompile will at least 1) either trigger an error (missing object file) or 2) 
> build every file. So I really don't see that relying on file dates is much better 
> than doing a full rebuild. That's specifically true if you pull a new tree: If I 
> understand things right, EVERY file will have a current date, so you'll rebuild 
> everything anyway. So you could also have the "real file dates" and then do "make 
> clean; make all". I see no benefit from either approach.
> 

You'll see the benefit of not rebuilding everything when your projects start
spanning more than 30k lines. Buildtesting a subsystem of the linux kernel
would be a major pain if object files weren't kept around from previous builds,
and integration-testing the hundreds (sometimes) of feature-branches would be
completely impossible if timestamps on files weren't updated when files change
on disk.

Incidentally, we do full rebuilds too, but no developer sits around watching
them. They're handled by our (stupid but efficient) homegrown CI-solution,
which emails the results to the devs. This happens every push though, not
every commit, but in our rather tight environment at $dayjob we push
frequently enough for that not to be a problem.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
