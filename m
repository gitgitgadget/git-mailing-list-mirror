From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [RFC] ll-merge: Normalize files before merging
Date: Fri, 11 Jun 2010 09:34:47 +0200
Message-ID: <4C11E717.4070508@gmail.com>
References: <1276202894-11805-1-git-send-email-eyvind.bernhardsen@gmail.com> <4C11CE75.7080706@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 11 09:35:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMylr-0004Oc-Jt
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 09:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757982Ab0FKHfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 03:35:00 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46512 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757279Ab0FKHe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 03:34:58 -0400
Received: by wyb40 with SMTP id 40so523061wyb.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 00:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=az55WG3O1wur3NQdLKnNOgL1WUiI7R/ch+eW3sLM9zo=;
        b=GcOgs+TPFdWoY6NFhTxsGxcwJSmchuZPNuFZfUNkGUvx67yLshIEo7groUabt3apbe
         cFRcB7RH4/WuAVHFKR7Ib3Lq7/6nfmA+9bKxztr/iU6QWmMD3iMgPXiquHVxxdGQf6A0
         FXR4TLK7Wxa0/+sMunDyfk2fM9Uxq9feps2ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=roEh936JdwCJHXEXY1o8gP8oQaXfFp5+6h8zJihGqjqAUC12edM9cH3u1rEQ96HhaZ
         8SH6fomEcJo6M413sdPMfJyxz6EQoymA15jFQkHTkjXYATG57kcm/zCCJntypJz8XkQE
         uXfa3vhJ8HjTJ8kWs3Zmk00Ybv9JpxqrzSRqs=
Received: by 10.227.151.145 with SMTP id c17mr1385421wbw.157.1276241697005;
        Fri, 11 Jun 2010 00:34:57 -0700 (PDT)
Received: from [192.168.2.12] ([62.113.137.5])
        by mx.google.com with ESMTPS id b17sm7028492wbd.13.2010.06.11.00.34.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 00:34:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.1.9) Gecko/20100515 Icedove/3.0.4
In-Reply-To: <4C11CE75.7080706@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148929>

On 11. juni 2010 07:49, Johannes Sixt wrote:
> Am 6/10/2010 22:48, schrieb Eyvind Bernhardsen:
>> Currently, merging across changes in line ending normalization is
>> painful since all lines containing CRLF will conflict uselessly.
>>
>> Fix ll-merge so that the "base", "theirs" and "ours" files are passed
>> through convert_to_git() before a three-way merge.  This prevents
>> differences that can be normalized away from blocking an automatic
>> merge.
>
> I think you are going overboard here. Normalization should only happen
> only for data that moves from the worktree to the database. But during a
> merge, at most one part can come from the worktree, methinks; you are
> normalizing all three of them, though.

Well, that's sort of the point.  All three are normalized to (hopefully) 
minimize the differences between them, increasing the chance of a 
successful merge.

The problem I'm trying to solve is that "base" and "theirs" were not 
normalized when the files were added to the database, and this causes 
unnecessary conflicts with "ours".  Normalizing "ours" allows merging 
the other way to work, too.

It's a brute-force method, and there may be a smarter way, but it works 
for me.

[...]

> Please do not put a dash-dash-blank line before the patch; Thunderbird
> takes it as the beginning of the signature and truncates the message in
> the reply.

Oops, sorry!
-- 
Eyvind
