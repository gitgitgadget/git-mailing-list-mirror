From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4: add failing tests for case-folding p4d
Date: Wed, 29 Apr 2015 09:19:43 +0100
Message-ID: <5540941F.9090507@diamand.org>
References: <1430212081-16146-1-git-send-email-luke@diamand.org>	<1430212081-16146-2-git-send-email-luke@diamand.org> <CALM2Sna0OqxYWzEj94SY61ZsL8cB+SyuiJ0EsAzq+kbiw87QLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	FusionX86 <fusionx86@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Lex Spoon <lex@lexspoon.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 10:20:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnNEH-0001yY-5y
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 10:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbbD2IUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 04:20:20 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36055 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031314AbbD2IUR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 04:20:17 -0400
Received: by wgen6 with SMTP id n6so19573489wge.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 01:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=QDZGQ2+pDUp08dF8c2U8oaAWK+Qrl/lFyegZQhbkbck=;
        b=YlBJ9omZ6m6ESlvi5W1JfhXk5YWVWrLUIcWHm3tL/gmKDDDaJnYgIdYakkKO4sCOaY
         BwzVmVJmua94xWGXodeY4yLP5GOlnnYIT+59ItOmUb1N01DItaOGeAXhwtV65U2NN/hY
         MziF5H/ZDnnqStb4upPTorBiY2as71VmJQIPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=QDZGQ2+pDUp08dF8c2U8oaAWK+Qrl/lFyegZQhbkbck=;
        b=M1NtijWGOOtpEKwIrQZrg8rqFx2Tyq+X6hpDSJnQ6qhTRwGmvWuYP/IYqE3MiSeZEU
         mJqZWJdf9t1TExgj9Da2GU6GBzdw6S6FfZPV8KD2vQMvMqd5iFeJu5Q5T4j6fxVhx3zA
         DnFOq2XD6B05qT9DIhxY22VdIjJPpL5YLjd3EcD0zafEETjbLyomwWEg1Iq4A4f52YBo
         zHrheoPS+M8HFnDnInLfs1Qo2tj8lyutsZa0Wc3Acqv0jP8sTnP/g8YN+rJHlQagyYhO
         a1EL/vcvKiqrIZHSQEdIe869OSNdEYhNJIU1EONRCMyu62a7bTkNFxlm5VdSBrML/e/V
         mhGA==
X-Gm-Message-State: ALoCoQkpkpa5MAMvCgEvmegStRLt2Gq7LF1V1o8uOaG/XYuoKwuF+0jMUzAXIKezZ9O4KK8AgOdn
X-Received: by 10.194.60.43 with SMTP id e11mr41046057wjr.36.1430295616402;
        Wed, 29 Apr 2015 01:20:16 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id o5sm20110797wia.0.2015.04.29.01.20.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2015 01:20:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CALM2Sna0OqxYWzEj94SY61ZsL8cB+SyuiJ0EsAzq+kbiw87QLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267959>

(Adding Pete, Vitor, and Fusion in case they have any thoughts on 
working with P4 servers that do case-folding, or at least failing 
gracefully).

On 29/04/15 00:01, Lex Spoon wrote:
> The last comment in the test took me a minute to decipher. I would
> suggest "no repo path called LC" instead of "no repo called LC". Also,
> it would have helped me to either have a little comment on the "UC"
> version of the test, or to make the previous comment a little more
> neutral so that it will apply to both test cases.

OK, thanks!

>
> Otherwise, while I am not a regular maintainer of this code, the patch
> does LGTM. Certainly it's good to have more test coverage.
>
> For the underlying problem, I haven't thought about it very much, but
> it looks like a plausible first step might be to simply probe the
> given file name and see if it comes back the same way. If it comes
> back differently, then maybe the command should abort?

I think the problem may be a bit trickier than that.

I think what's happening when cloning is that when files come back from 
the server, git-p4 checks that they are contained within the directory 
it is cloning. This happens in p4StartsWith(), (called from 
extractFilesFromCommit()) which already tries to fix this problem by 
checking 'core.ignorecase'. However, that won't work if the local 
machine is case sensitive but the server isn't (e.g. Linux client, 
Windows server).

git-p4 does this because it's fetching *commits* from Perforce, and a 
commit might have files that are outside the directory being cloned.

I tried teaching p4StartsWith() to ask the server if it is case-folding 
('p4 info') and that then means that the git-p4 clone actually succeeds. 
However, git-p4 submit then fails because it gets terribly confused 
about pathnames - it probably needs to do some lowercasing somewhere. So 
that might be worth pursuing.

Open to other suggestions though!

>
>
> What a tough problem all around...

Indeed!

Luke
