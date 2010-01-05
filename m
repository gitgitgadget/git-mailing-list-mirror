From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 9/9] rerere forget path: forget recorded resolution
Date: Tue, 05 Jan 2010 22:25:12 +0100
Message-ID: <4B43AE38.9070800@kdbg.org>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com> <1262122958-9378-10-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 22:25:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSGu4-0008HD-1u
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 22:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab0AEVZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 16:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754700Ab0AEVZT
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 16:25:19 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:32020 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751086Ab0AEVZT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 16:25:19 -0500
Received: from [77.116.28.239] (77.116.28.239.wireless.dyn.drei.com [77.116.28.239])
	by bsmtp.bon.at (Postfix) with ESMTP id 7EC2ACDF87;
	Tue,  5 Jan 2010 22:25:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1262122958-9378-10-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136211>

Junio C Hamano schrieb:
> After you find out an earlier resolution you told rerere to use was a
> mismerge, there is no easy way to clear it.  A new subcommand "forget" can
> be used to tell git to forget a recorded resolution, so that you can redo
> the merge from scratch.
> ...
> diff --git a/rerere.c b/rerere.c
> index f013ae7..c1da6f6 100644
> --- a/rerere.c
> +++ b/rerere.c
> ...
> +static int handle_cache(const char *path, unsigned char *sha1)
> +{
> +...
> +	ll_merge(&result, path, &mmfile[0],
> +		 &mmfile[1], "ours",
> +		 &mmfile[2], "theirs", 0);

When you simply call ll_merge(), will it obey any merge drivers that are 
defined in .gitattributes? Do we care about them?

I already had an implementation of "rerere forget" before you presented 
this solution, but it relies on that the user calls "checkout 
--conflict=merge" first. One reason (besides its simplicity) was that it 
does not have to care how the merge is computed.

[I haven't submitted my solution, yet, because I haven't had the time to 
do this large merge where I expect to make use "rerere forget", testing 
its usefulness.]

-- Hannes
