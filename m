From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 00/27] Use ref transactions for all ref updates
Date: Tue, 29 Apr 2014 15:24:50 -0700
Message-ID: <CAL=YDWkv_XEXCpuAE8inD6Lj5NNHOEf9womimE70AxinO1Ufng@mail.gmail.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
	<xmqq4n1bke4b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:24:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGSN-00078s-Qu
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933747AbaD2WYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:24:52 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:42952 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933054AbaD2WYv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:24:51 -0400
Received: by mail-vc0-f176.google.com with SMTP id lc6so1157155vcb.35
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ma+1TgjghrjRItyEgLu5fhRVD2F6cYqK1fco3TNxrhw=;
        b=eCFRjFsXiTrn71Gvxb+32005SnykMcU2pxuHCLbD4q1rf8rV1mkZ0I19ds2HBCvMNB
         op/w6tqyU5Mx4Q+4zgQggSnlXslm5+J6/fi2HeH1zidCeK9mt+kt88ptjfOVfRgtjvtB
         gyGf4e/IZjeCzXFKYONCaUCpr4WwM6afG4KolLJmVq1N5rC2F/alYV5haV6YUKNxkDxJ
         f5Bi8Y/W22DVl9Y19qoa1NC7HOQ0l1ShKq16iS13mt6/2zAeJrsNH3maz2KDKf87XQmK
         oIgAGrcqDDHjn1w6qboDBDfmVsf2ZeqDoHEuSz1icbxdoAfsv9TrHMepobANW98UUwyP
         22tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Ma+1TgjghrjRItyEgLu5fhRVD2F6cYqK1fco3TNxrhw=;
        b=YmpADtcMElJF72Kjcq1MeYZasn7J1ZKDjIr66eYGkefad9ml+/CKPMByd7VebPUWg/
         wbXP8UzMQ2+HMd5joExpI78xOnqZhpazWHH3wWmHRMpUgHLHAl/AAAN3BdG06XpKFFMt
         QwrdiHr5LptlPgd1QQn/FwICW+PbFRjFtei/eCM9EPGPYuuNQvekkL7TiCxuF8ApYXSf
         aHlHZt8knafvuPCntMEaFY2Mgg4tt5ijXu2aGoObOcS534zC+8MFxE6/T6Y/JI5PUM5W
         lENznz1hVhU3SOmtHKXR0RrSpGoMMpASp2b6e/uJQCXVBJfZHQyGfSkq0z04E39SdOC8
         Hbcw==
X-Gm-Message-State: ALoCoQlIgQXf04r+8ZdG+Tgcr7cUhgMnSZt3nhrrLp+nTz0o1pBocMQMYLGMc0Q6baFJLf4/MDdPX5IazNWigtYiLP+zQ9qA15KsGDglJWPgIEDaZVwny5ATlfD6fCJ4BKsPDY5mWlUIHG2BBC4Pd+mBMB4OScIFzza1BNufEuZRq6+jjNj0YGrtxyaGtRvcFF+4FLu/b7nJ
X-Received: by 10.220.161.8 with SMTP id p8mr378541vcx.4.1398810290495; Tue,
 29 Apr 2014 15:24:50 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Tue, 29 Apr 2014 15:24:50 -0700 (PDT)
In-Reply-To: <xmqq4n1bke4b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247655>

On Tue, Apr 29, 2014 at 2:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> This patch series is based on mhagger/ref-transactions and expands on the
>> transaction API. It converts all external (outside of refs.c) callers to
>> use the transaction API for any writes.
>> This makes most of the ref updates to become atomic when there are failures
>> locking or writing to a ref.
>
> I think I saw some more comments to be addressed on this round, but
> I'll try to push it through into 'pu' by attempting to resolve
> conflicts so that I can ask you to eyeball the result.  This series
> seem to conflict with your own rs/ref-update-check-errors-early
> topic that is already in 'next'.
>
> If I screwed up the conflict resolution (which is very possible), I
> may have to ask you to rebase this series on top of acc62aa (which
> is the merge of rs/ref-update-check-errors-early to 'next'), but I
> am hoping that conflict resolution I'll push out today will be
> correct.  We'll see.
>

Thanks.

I just sent v5 of the patch series where I have addressed the comments from
Eric and Michael so far.

Otherwise,  how hard would it be to drop
rs/ref-update-check-errors-early ?

I can just redo those patches later, and that might be the easiest solution.

Regards
ronnie sahlberg


> Thanks.
