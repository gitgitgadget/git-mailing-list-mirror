From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" v2 1/2] xdiff: add
 recs_match helper function
Date: Fri, 15 Apr 2016 15:48:38 -0700
Message-ID: <CA+P7+xpbYa993zr_JqrLbnKcKQ-9iwjMD=eLpbLXLBmkDrJ2eQ@mail.gmail.com>
References: <20160415215622.6040-1-jacob.e.keller@intel.com>
 <20160415215622.6040-2-jacob.e.keller@intel.com> <20160415224615.GA32306@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:49:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arCXw-0007g4-9J
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbcDOWs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:48:59 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36546 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbcDOWs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:48:58 -0400
Received: by mail-io0-f172.google.com with SMTP id u185so148519589iod.3
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 15:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tLmg6w4j/Ly4/3YBjeiiHB+/+YRjHcSAogGIRKHLDN0=;
        b=FBSKR0nSZHuxr8+OFXm2J/4xPq2RJtWJ1SeDEbcPzXeJYoHiENXZdpnp8691p+te6L
         8HO+oRXIZhgJeLJfb9xLcDtKfXF3D+ecC8swpD6wfKmGlnOhCSc4Bh9aEK3bxTs8c7ax
         HU/lBG3FkZzBraronZDBrXvfUre8jiONe6PZ9zCMwacFWfs1rtJgSZvmeIVpLCqs87+j
         Wz79T1kttK1Kwm7vBnzxQ6rvmFGTR9y0BYJt9/rhbMT99cVyfQZehDCJPJGWks8r0Gy1
         tJDGr8gtEUlaSJF9hqgShJFpBbT/WSwwlHRlZpLYKwNNEcpIm6KbweyLo7Cn3646dgk4
         eefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tLmg6w4j/Ly4/3YBjeiiHB+/+YRjHcSAogGIRKHLDN0=;
        b=mPOncZ6FNYlGTUheMia5PIvTquciJI0i2HKO05oW7hAi9pKmMnU5oPia2TXy0/JVao
         fThYsQrotbVA9HX/6tdJJo4p0ODmb2gSgyunyYH+PB1cUXT+4gGoLgQL4zBnQx8V789q
         /vwIE1DEHnDm1qHTvSdvMuKtKhxuvel8SlFnsI8Qvf7YcRGT4fB+L5WesZZBr2QAoV7q
         mtkemlBjPEPBHvWUDAwDn/fVwMN2k6IHGmgzJ/2skVTim1FwD9pX69D0olFl+lD8WX9i
         pVAFSQIurww3IbtYXzDuii1TCk56yMlbJI2JSBwtZUDoyh4iJVzfApoe4PI6fMsCA9Tt
         RkOg==
X-Gm-Message-State: AOPr4FULXvsclqlvD4NFeuOUyBu02SdGrItt5GhKeniKa9qXiCfSNEqwsbo1eMcLnivXd9eZRRBrY5jvGLHF4g==
X-Received: by 10.107.136.69 with SMTP id k66mr28689411iod.0.1460760537896;
 Fri, 15 Apr 2016 15:48:57 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Fri, 15 Apr 2016 15:48:38 -0700 (PDT)
In-Reply-To: <20160415224615.GA32306@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291688>

On Fri, Apr 15, 2016 at 3:46 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 15, 2016 at 02:56:21PM -0700, Jacob Keller wrote:
>
>> @@ -470,8 +477,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>                        * the line next of the current change group, shift forward
>>                        * the group.
>>                        */
>> -                     while (ix < nrec && recs[ixs]->ha == recs[ix]->ha &&
>> -                            xdl_recmatch(recs[ixs]->ptr, recs[ixs]->size, recs[ix]->ptr, recs[ix]->size, flags)) {
>> +                     while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
>> +                             emptylines += is_emptyline(recs[ix]->ptr);
>> +
>
> I have not looked closely at your patches yet, but is this hunk right?
> The is_emptyline stuff doesn't come in until patch 2.
>
> -Peff

Oops, I suspect this is a rebase mistake, will fix it.

Thanks,
Jake
