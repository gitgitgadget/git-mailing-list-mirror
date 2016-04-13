From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 0/2] Fix relative path issues in recursive submodules.
Date: Wed, 13 Apr 2016 15:30:22 -0700
Message-ID: <CAGZ79kbh4q-w6yt6eHrvcGvH6mhmCJG1WdRSdO6bgpX=iLwARw@mail.gmail.com>
References: <1459469849-9643-1-git-send-email-sbeller@google.com>
	<56FE8898.20906@ramsayjones.plus.com>
	<CAGZ79kYE3E7stNc3Xbzr-qvncLGt4qRPMbv897k5h0B50-Rogg@mail.gmail.com>
	<570E9C46.6080905@ramsayjones.plus.com>
	<CAGZ79kYj+4_6BsrcRRzsvdp_FcRG9VuiJ1tLjSo3D5_uWe2nfQ@mail.gmail.com>
	<xmqqzisxi1w0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Norio Nomura <norio.nomura@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:30:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqTIo-0001hT-Pu
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 00:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbcDMWaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 18:30:24 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38561 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710AbcDMWaX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 18:30:23 -0400
Received: by mail-ig0-f179.google.com with SMTP id ui10so74062393igc.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=BMii7OLgxa6fsycIv03WMfbCPfGQidVvyX/0D+1MtWY=;
        b=ZhJtSANE5etbiVWMupbNWrPMzPvRet8u6X8TOgla+a7ITUbxpN/XgbBBJULABCsXOK
         f7WBeagsLWmu0e4rdW9NKp46VHMkkdpdFVbodRW//QXIIV+u6sgz5IkOBh0EqqBez9hh
         pl1T+7paHfmRfzyv2DWyfjhdO9ehcDPKffcbbOgH4PBKPkirbu9pAsi08My09ulbchbN
         3Nea4K8jgbCUcQCo47Kj13QGlWCSCf9az69Nvcd8fSkpmHl7WXNerM3dDHM5KuLCOznf
         q89UmbUsUTBtRR5Fq7TXbOkrzmqgeKWW/YHo3yN6UKxwUUUBouf9a16HtuS1KWughC4v
         3iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=BMii7OLgxa6fsycIv03WMfbCPfGQidVvyX/0D+1MtWY=;
        b=V6euXfeY/uuEp0arxrccWQRs4ytlhPx9OoVgw1LiNDbCqLevGogJ8VYaQFFzOj7aO9
         KKnccbfH1t+DWYKAuNtgM4YFs018hudMn+dBP95Y6kUkVhHIMsWvCw2P7WrKSiUjfOqT
         siYP1isxUkuxS9c3vc/i/aOoOgsV/LP86R5JkNL7aXumZIYw++t9Sk4xLcNQzqSZmFBc
         Gs/XAlr24NFFDBOMzgKvshcsDSeU9HtINC/1oYFMTLRhfi7ZuRl2h5wZYGJgrkYj3XiR
         0i5lfO+v1ZToQ4txNZTO1CrdpgQHLZ1ZrmvNqs/2ljzw11+SMPK7wlUCyC4UXokL/wTU
         tMKg==
X-Gm-Message-State: AOPr4FV6LR8cnaFF2CfQfJG481BjC4i/5D2hsjmPbz7oysjHHZHsavKWOg+tEPDY2UfBCvHP/NvOWzhgbPdFO5uL
X-Received: by 10.50.112.10 with SMTP id im10mr13324747igb.93.1460586622531;
 Wed, 13 Apr 2016 15:30:22 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Wed, 13 Apr 2016 15:30:22 -0700 (PDT)
In-Reply-To: <xmqqzisxi1w0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291503>

On Wed, Apr 13, 2016 at 3:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>
>> Ok fixed this instance here, too.
>
> ... So... should I hold sb/submodule-helper-clone-regression-fix?
> It has been marked to be merged to 'next' for some time now.

(Both things Ramsay pointed at are in submodule.c, but
sb/submodule-helper-clone-regression-fix never touches that file,
so Ramsay talks about submodule-init here? I agree
submodule-init is faulty and I am fixing/rewriting it now.)

This series (sb/submodule-helper-clone-regression-fix), has no issues
(on its own as well as playing together with any other submodule
series in flight IIUC), so what is your concern for holding instead of merging?
