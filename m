From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 4/7] remote-bzr: update working tree
Date: Thu, 13 Dec 2012 16:08:54 -0600
Message-ID: <CAMP44s1ZdMK+0_pP3qkZUepOvkfMaXeY2BV0MFu5YOSV=40Dcw@mail.gmail.com>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
	<1352643598-8500-5-git-send-email-felipe.contreras@gmail.com>
	<7vtxs9vda3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 23:09:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjGxw-0002fo-Ju
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 23:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563Ab2LMWI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 17:08:56 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58808 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755925Ab2LMWIy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 17:08:54 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so2625235obb.19
        for <git@vger.kernel.org>; Thu, 13 Dec 2012 14:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mNqULXMfZTMfzGKfVtNl4UocFvRssF2VVbLOt+jC5qs=;
        b=UyWWOE5nwY0KqRz2QpQ6IGoWNnLmoCFMfay3iCsKj3DhaOOiGQ8bQSEH9d/vMLIj95
         K1QmGUfa+2OFbRll92fMyBn4DZVezvF2hSpsdWmHcN8IJadwn9GbxsGo+4kyxHT28YHD
         Fcb54Bx3ERvorbyEmygDyMMwrDWv+v6KxmU4do9thy1EcSVfsTHmjADcnStjJATelzMK
         sIxiWUpvXcS+yKnocchHE+Wh0C7lDSiBQXPCYQdXEhuzh9Q9ShxC+99YwxnuPQPnAh+S
         cUd362quF3j6JXkwDDXmbB311iNW3Gf5UMH7J24h/q/R2P0kjPZHrDm57HRBQvVz8u5v
         KgXA==
Received: by 10.60.7.199 with SMTP id l7mr2802685oea.136.1355436534191; Thu,
 13 Dec 2012 14:08:54 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Thu, 13 Dec 2012 14:08:54 -0800 (PST)
In-Reply-To: <7vtxs9vda3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211474>

On Wed, Nov 28, 2012 at 11:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  contrib/remote-helpers/git-remote-bzr | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
>> index 2c05f35..5b89a05 100755
>> --- a/contrib/remote-helpers/git-remote-bzr
>> +++ b/contrib/remote-helpers/git-remote-bzr
>> @@ -571,6 +571,8 @@ def do_export(parser):
>>              repo.generate_revision_history(revid, marks.get_tip('master'))
>>              revno, revid = repo.last_revision_info()
>>              peer.import_last_revision_info_and_tags(repo, revno, revid)
>> +            wt = peer.bzrdir.open_workingtree()
>> +            wt.update()
>>          print "ok %s" % ref
>>      print
>
> Shouldn't this be squashed as part of one of the earlier patches?
> The split between 1/7 (import first) and 2/7 (then support export)
> makes sense, but this one looks more like "oops, we forgot to touch
> the working tree while updating the history in the previous steps
> and here is a fix" to me.

Perhaps. It's not really clear if we should update the working tree at
all. A 'git push' doesn't update the working directory on the remote,
but a 'bzr push' does. I thought it was better to leave this
distinction clear, in case this becomes an issue later on.

Cheers.

-- 
Felipe Contreras
