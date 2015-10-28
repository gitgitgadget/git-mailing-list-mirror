From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv1 2/2] git-p4: work with a detached head
Date: Wed, 28 Oct 2015 19:03:03 +0000
Message-ID: <56311BE7.6090204@diamand.org>
References: <1441461738-25066-1-git-send-email-luke@diamand.org>	<1441461738-25066-3-git-send-email-luke@diamand.org>	<xmqqfv2n5khe.fsf@gitster.mtv.corp.google.com>	<CAE5ih7-_zhxf_daVxNB-hxFfbakMbJp9rk0vP+k46ErrJ6Qxiw@mail.gmail.com> <xmqqfv0ulwgj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 20:03:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrW0W-0000CO-9S
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 20:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209AbbJ1TDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 15:03:30 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34410 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840AbbJ1TDB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 15:03:01 -0400
Received: by wikq8 with SMTP id q8so264674705wik.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=iuwUq0bvtXKiFG4PEJxQWoXYxi7BVVpj8itEzxVHOwA=;
        b=ZkXPIpvfSHE2tJUVGiwSfg7m6mwcE8rdh1ntk+lSzLovs3Jj4NIxNp40wTw7tHYW4K
         cp2XtJ3zBhp83ZL0VYUgKQGgr3FD/hRFbs/sHV9XuJbSPoul1Fzhbh7PncPmXC2ZU8dP
         QmY2gSToJ3dsVp2JboBNZ19IDL7WZpLa4JR2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=iuwUq0bvtXKiFG4PEJxQWoXYxi7BVVpj8itEzxVHOwA=;
        b=YsOUEphHOSDtUoOt0V1Nm8sBw4v9PrvWc6tgh7g+oO9yvib9j6HGETnLapqyklRnHM
         i0HC5w10Q5kysT5jEaJoSPPxDwl32clhijSzej593SZbce0DHHjnfjnr/2jilCqPwMfA
         R8S2Vks7kHAQnIUUANI4xOV1MHj/DxVklF7EChInjLeRwMxYtUyMZLwM6cfPY7pCXKN6
         4b0Mh6RrF27U2V0CTTX8IjHozF0rwyvK5PD3m0/0fasbJn3XP24HmQutW3q7TbHvt2ll
         fbgykpSt2lPyA1Zj/5BGYAqlqS9KrCBNELX3Eslt37ntCmS82wxEK5IPzv48Zbl6GLyg
         Bpug==
X-Gm-Message-State: ALoCoQmJWDQgmcvv81jgmxxK4uTR7GCF1vXqJ3SeVj7zU122fw3tSnQ+PXJn2/v1vh45cNmVOD6P
X-Received: by 10.180.76.240 with SMTP id n16mr4194428wiw.11.1446058980553;
        Wed, 28 Oct 2015 12:03:00 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id ca17sm5989760wib.12.2015.10.28.12.02.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2015 12:02:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqfv0ulwgj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280392>

On 28/10/15 17:44, Junio C Hamano wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> On 9 September 2015 at 22:52, Junio C Hamano <gitster@pobox.com> wrote:
>>> Luke Diamand <luke@diamand.org> writes:
>>> ...
>>>      def currentGitBranch():
>>>          return read_pipe("git name-rev HEAD").split(" ")[1].strip()
>>>
>>> Yuck.  I know it is not entirely the fault of this patch, but
>>> shouldn't it be reading from
>>>
>>>      $ git symbolic-ref HEAD
>>>
>>> and catch the error "fatal: ref HEAD is not a symbolic ref" and use
>>> it as a signal to tell that the HEAD is detached?
>>
>> That sounds much nicer. I'll redo the patch accordingly.
>
> No need to rush, but should I expect a reroll of this sometime, or
> have things around this topic changed to make this topic no longer
> necessary?  I am only asking so that I can decide to either keep or
> drop ld/p4-detached-head topic that is listed in the [Stalled]
> section for quite some time [*1*].

I was waiting for the other git-p4 changes to go through before starting 
this up again.

It definitely needs fixing - it was annoying me a lot today, as I kept 
on having to invent temporary branch names to needlessly keep git-p4 happy.

After getting to "for-p4-9", I'm now onto "xyyyy". I'll see if I can 
sort something out in the next few days.

Luke


>
> Thanks.
>
>
> [Footnote]
>
> *1* Not that my dropping a topic from 'pu' means very much; a
>      dropped topic can still be submitted and requeued after all.
>
