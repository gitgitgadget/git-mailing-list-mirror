From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 0/7] git-p4: add support for large file systems
Date: Wed, 23 Sep 2015 09:41:34 +0200
Message-ID: <84A300C5-3AE7-46E7-A95E-9C19F20431EC@gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com> <xmqq8u7y1580.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, luke@diamand.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 09:41:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeegQ-0003Uf-BY
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 09:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbbIWHli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 03:41:38 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33027 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbbIWHlh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2015 03:41:37 -0400
Received: by wiclk2 with SMTP id lk2so226059736wic.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 00:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=97ei1htA4+/Cu5ZTeAVoSKx9YWeW1BWTjCnZayclfrM=;
        b=vD9STa4My/3e1cjgFpyvFv1vZfeIYNQOqxlAjnqIuFEXE+T7fUSIVRE7pPtULghEho
         eH2NNZxK+uomsYtgGa2U8EVOYqr9QS/YrdcF60bMQ4nv8eKEoH5fNoubqlzKQ+LzygIQ
         HQ6s7Naj2vRPoApbrzZlZGBML8KDlOVfIbcDtSJPOVQNFR+Blc6jBuxLORFVupvyETF5
         CJIdHD8GCecamDac44kiLM4cB/9WE8+B+0hQaQrTGUwFSOAFTn2vaeqJqNXPnGv9u4gF
         qNQbobuiH9bxMhXZcDHYxKcVNlFYVmCwLp+yt+L7Nhu8+w5oyyIyVSzZbRL4a/P4hBQZ
         Bf/w==
X-Received: by 10.180.75.38 with SMTP id z6mr2164582wiv.36.1442994096414;
        Wed, 23 Sep 2015 00:41:36 -0700 (PDT)
Received: from [10.146.248.63] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id bs8sm5766692wjc.47.2015.09.23.00.41.35
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Sep 2015 00:41:35 -0700 (PDT)
In-Reply-To: <xmqq8u7y1580.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278474>


On 23 Sep 2015, at 00:03, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> diff to v6:
>> * fix spaces in .gitattributes for Git-LFS files (old "[:space:]", new "[[:space:]]")
>> * generated patch on top of next (95c4325) to resolve merge conflicts
>> 
>> I am sorry about the "[:space:]" bug this late. I had the fix in my development
>> branch but missed to apply it in this patch series.
>> 
>> @Junio:
>> Your conflict resolution in pu looks good. Nevertheless, I made this patch on
>> top of next to ease the integration. I hope this is ok.
> 
> Please don't rebase without a good reason, especially after you
> checked the conflict resolution is OK and your reroll does not
> affect the way the conflicts are resolved.  If you based your
> v6 patch on v2.6.0-rc0 and then your v7 patch needs to use something
> that did not exist v2.6.0-rc3, you cannot avoid rebasing on top of
> that newer codebase to use that new feature, but otherwise, no.
> 
> This is because I prefer to apply the new series to the same base
> version so that each step can be compared with the corresponding
> step in the previous round.
> 
> I even try hard to keep the commits from the older round if the
> patch text and log message are unchanged.  This time, I had to
> backport [v7 6/7] to apply to the same base before noticing and
> verifying that [v7 7/7] is the only thing that was changed in this
> round.  All the other ones turned out to be identical.
> 
> Hence, the end result for me was
> 
>    $ git checkout ls/p4-lfs
>    $ git reset --hard HEAD^
>    $ git am -s git-p4-lfs-7-of-7.mbox
> 
> but it took me a lot longer than necessary because of the rebase.
> 
Understood. Thanks for taking the time and explaining me your workflow. That helps a lot as my intention was to save your time, not waste it.

Sorry,
Lars
