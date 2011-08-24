From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH] submodule: Demonstrate known breakage during recursive
 merge
Date: Wed, 24 Aug 2011 16:02:03 -0400
Message-ID: <4E5558BB.4040307@kitware.com>
References: <680d2679c3275c01152500760311b5f96a93ea62.1314193375.git.brad.king@kitware.com> <20110824191438.GA45292@book.hvoigt.net> <7vty96obo9.fsf@alter.siamese.dyndns.org> <20110824194618.GD45292@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Aug 24 22:02:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwJew-0004HB-L6
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 22:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748Ab1HXUCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 16:02:37 -0400
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:34116 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751617Ab1HXUCe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2011 16:02:34 -0400
Received: from mail-yx0-f179.google.com ([209.85.213.179]) (using TLSv1) by na3sys009aob109.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTlVY2cC27NByZMR7VAe8O9dr9E3gWcH7@postini.com; Wed, 24 Aug 2011 13:02:34 PDT
Received: by mail-yx0-f179.google.com with SMTP id 36so1434734yxk.24
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 13:02:33 -0700 (PDT)
Received: by 10.91.50.39 with SMTP id c39mr5258602agk.7.1314216153272;
        Wed, 24 Aug 2011 13:02:33 -0700 (PDT)
Received: from [192.168.1.220] (66-194-253-20.static.twtelecom.net [66.194.253.20])
        by mx.google.com with ESMTPS id n14sm1168958ani.12.2011.08.24.13.02.31
        (version=SSLv3 cipher=OTHER);
        Wed, 24 Aug 2011 13:02:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <20110824194618.GD45292@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180031>

On 8/24/2011 3:14 PM, Heiko Voigt wrote:
 > thanks for finding this subtle bug!

Thanks for looking at it!

On 8/24/2011 3:46 PM, Heiko Voigt wrote:
> For the merge search we do not take the bases into
> account so the outcome will not change.

The test case creates history like this:

 >     b---bc
 >    / \ /
 >   o   X
 >    \ / \
 >     c---cb

where b, c, bc, and cb all reference different submodule commits.

Isn't the merge search asked to search for a descendant of "b:sub" and "c:sub"
during the recursive part of the merge and then "bc:sub" and "cb:sub" during
the primary merge?  Might those results be different?

As for the UI part, I think the user would be interested only in the search
results for the primary merge between HEAD and MERGE_HEAD.  Results from the
intermediate merges might not make sense.

Thanks,
-Brad
