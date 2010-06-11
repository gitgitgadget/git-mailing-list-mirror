From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [RFC] ll-merge: Normalize files before merging
Date: Fri, 11 Jun 2010 10:47:44 +0200
Message-ID: <4C11F830.3050404@gmail.com>
References: <1276202894-11805-1-git-send-email-eyvind.bernhardsen@gmail.com> <4C11CE75.7080706@viscovery.net> <4C11E717.4070508@gmail.com> <4C11EB0D.20208@viscovery.net> <20100611083641.GB31109@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Fri Jun 11 10:47:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMzu7-0002bR-0O
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 10:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759480Ab0FKIru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 04:47:50 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41926 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab0FKIrt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 04:47:49 -0400
Received: by wyb40 with SMTP id 40so562727wyb.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 01:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=+zEhzBvSs9/yOU8Q9+Hothuek6Zl7aBQqARDhD0hezk=;
        b=AvbkvPV1WkO26E1lg7kb5WzChLf88ZrkY/Q9i8cAnQFE5oqWZyZYZ2RLV4l4E1qQ/L
         quuV4hbntBmMPlq+AP9MT0I9sGI2etMvdP/cO+LmRdmqLIDTyaCMyie3GeG1Q17ZhUAt
         kmUIDFYKACdbDD4h9sB5gx949tyXa/3NIwz9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=KT+dVIiRLQz2WTgxLqeFWAjoTrqDBwruo0kufweLylGCfn8lyTyNPGj2g4ycbWAeGR
         qmhaE+k88YBrkY8I0OHwMcUA1Fznk5smKOVErN3/ivYSPVSOEzph9haB12X5x2abQ5Bn
         RyNvq1kvG0QLjQG6k+0UeX6t7Bn2qobG6ywqU=
Received: by 10.227.142.78 with SMTP id p14mr1502626wbu.77.1276246065291;
        Fri, 11 Jun 2010 01:47:45 -0700 (PDT)
Received: from [192.168.2.12] ([62.113.137.5])
        by mx.google.com with ESMTPS id n31sm7519775wba.3.2010.06.11.01.47.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 01:47:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.1.9) Gecko/20100515 Icedove/3.0.4
In-Reply-To: <20100611083641.GB31109@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148932>

On 11. juni 2010 10:36, Finn Arne Gangstad wrote:

> It would probably be more correct to do
>
> conert_to_git(convert_to_work_tree(x)) for the parts taken from base
> and theirs, in theory I guess that this can be true:
>
> convert_to_git(x) != convert_to_git(convert_to_work_tree(x))

Interesting idea, might be a bit slow perhaps?  I'll do some 
benchmarketing.  Incidentally, it has to convert_to_work_tree() "ours" 
as well, since the merge code doesn't read anything from the worktree.

I think convert_to_git(convert_to_work_tree(x)) is actually less likely 
to cause trouble than convert_to_git(convert_to_git(x)), which is what 
blind normalization would end up doing for at least one side of the merge.

- Eyvind
