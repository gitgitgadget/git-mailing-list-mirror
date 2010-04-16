From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] patch-id: Add support for mbox format
Date: Fri, 16 Apr 2010 22:55:35 +0200
Message-ID: <4BC8CEC7.40003@gnu.org>
References: <1271434948-14134-1-git-send-email-bonzini@gnu.org> <7vk4s7cks4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 22:55:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2sZt-0001lV-Hh
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 22:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451Ab0DPUzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 16:55:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:31725 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932266Ab0DPUzp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 16:55:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so503628fgg.1
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 13:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=+jfrNn4ZnmI7oMXLs64F+DvOJlE1j8v4O0R9h0lKJXY=;
        b=PcR94/ScrI3mniR/Me18YV3Rtj0KHyMJNMY15jt/B8LLE/OKbzUCLjSg2BCLUWNPNh
         Zcf0MIi/Agh1BwXKBl1O6Gcj+MOQLHcz6u18ZE0nKcG5Tdercf7xBXkPEQoRKFgwMBW7
         UA+TcxwPwRRbxMsI+1u688IHaX/UVO0QkHMSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Amo09He+XvoNdQeV1QgGCo/NIbSx5LDCvhmHa0Jj/+NYR7DsDjJy70iFfq0MiwDgYp
         w1DdPkA7q9BPeBAvlsFl5om0fYES+wrbAdVoByXRIirG2FZg06k2f8XvJHS/4ObP+us4
         nBDZzLWCFj/3WBDXn3DKtIFJ9o2rffUBylRIE=
Received: by 10.223.76.132 with SMTP id c4mr937228fak.106.1271451344145;
        Fri, 16 Apr 2010 13:55:44 -0700 (PDT)
Received: from yakj.usersys.redhat.com (s209p8.home.99maxprogres.cz [85.93.118.17])
        by mx.google.com with ESMTPS id 21sm4782610fkx.10.2010.04.16.13.55.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Apr 2010 13:55:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.3
In-Reply-To: <7vk4s7cks4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145095>

On 04/16/2010 08:30 PM, Junio C Hamano wrote:
>> >  I have an alias that takes two arguments and compares their patch IDs.
>> >  I would like to use to make sure I've tested exactly what I submit
>> >  (patch by patch), like
>> >
>> >      git patch-cmp origin/master.. file-being-sent
>> >
>> >  However, I cannot do that because git patch-id is fooled by the
>> >  "-- " trailer that git format-patch puts.
>> >
>> >  This patch adds a bit of lookahead to git patch-id in order to detect
>> >  the trailer and split the patch when it comes.  In addition, commit
>> >  ids in the "From " lines are considered and printed in the output.
>
> How well does this interact with mime encoded output?

It doesn't work.  I have a version of the patch that works with it now 
(by parsing hunk headers and looking for a "--" line outside the hunk, 
but I doubt that would satisfy your feeling.

> I somehow have a feeling that this is solving a wrong problem.

In what sense?

In the end the patch id is what matters for the usecase above.  I could 
obtain it in other ways for the "origin/master.." part, but the mbox 
file from "git format-patch --stdout" must be given unmodified to 
git-patch-cmp, otherwise it wouldn't be what I send on the next step.

Paolo
