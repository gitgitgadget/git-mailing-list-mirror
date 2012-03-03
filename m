From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] Use startup_info->prefix rather than prefix.
Date: Sat, 3 Mar 2012 16:50:33 +0700
Message-ID: <CACsJy8DtZLCLfeHNP_eq9kVZxjV3xh3gs6pgQCi=FDZ_Je7_Gw@mail.gmail.com>
References: <cover.1330740964.git.jaredhance@gmail.com> <b564d95b1efcd91874beb6d410253f86617f8fa6.1330740964.git.jaredhance@gmail.com>
 <7v8vji87kg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jared Hance <jaredhance@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 10:51:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3lcT-0008Ee-21
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 10:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673Ab2CCJvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 04:51:07 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61079 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab2CCJvG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 04:51:06 -0500
Received: by wgbdr13 with SMTP id dr13so2212214wgb.1
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 01:51:04 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.24.7 as permitted sender) client-ip=10.180.24.7;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.24.7 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.24.7])
        by 10.180.24.7 with SMTP id q7mr3015607wif.14.1330768264845 (num_hops = 1);
        Sat, 03 Mar 2012 01:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FKwr08jFwstqGOuJ9TTN3M0IyWORacvzwGyPe+Wxdfw=;
        b=K9jivQri3hH3fnO8uzI6iQZunVJ+3v/efZf+2D3BPU8T0uLm5bc2SDaYtNJUP1S7Ch
         6BEA8yo+Vi0DexdgRQLI2XLyyigXLisMsL1OD/qZCs94FVw7EN1Tsghgj6wcdaDoh2br
         IMwDx/2/xdXbczfAD9oZPLjrh4vBTqCWmpalZFv9AjySGMCP/mYKD5vjkOAPG5mDCZL/
         c9LlcjjbgPzKyMXltEXMALXplCBeKqh+7ku9owoxViSOVxccjshwV/NT3XM1lDrsGRaR
         RCv3bibBv9F2vewwEW2gmqFV2y9dtCPlGGGA6RBZr4jtCA6tZy/nt314tVR8pLbKkLWP
         HN9g==
Received: by 10.180.24.7 with SMTP id q7mr2385247wif.14.1330768263194; Sat, 03
 Mar 2012 01:51:03 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Sat, 3 Mar 2012 01:50:33 -0800 (PST)
In-Reply-To: <7v8vji87kg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192101>

2012/3/3 Junio C Hamano <gitster@pobox.com>:
> Jared Hance <jaredhance@gmail.com> writes:
>
>> In trace_repo_setup, prefix is passed in as startup_info->prefix. But, as
>> indicated but a FIXME comment, trace_repo_setup has access to
>> startup_info. The prefix parameter has therefor been eliminated.
>>
>> Signed-off-by: Jared Hance <jaredhance@gmail.com>
>> ---
>
> This comes from a9ca8a8 (builtins: print setup info if repo is found,
> 2010-11-26) and hasn't ever changed over time, even across f07d6a1 (setup:
> save prefix (original cwd relative to toplevel) in startup_info,
> 2010-12-01) that did add the necessary "prefix" field to the startup_info
> and was done reasonably close to the patch that wanted to have the field
> in the first place.
>
> The fix looks too easy to be correct X-<; in other words, I find it hard
> to believe that such a triviality was left without a good reason, but I do
> not think of any.
>
> Well, but perhaps something too good to be true is indeed true sometimes.

This patch makes this function only usable when startup_info pointer
is initialized. As "git" binary is the only caller, the change is ok.
If non-builtin commands want to use this function, they need to
initialize startup_info first.
-- 
Duy
