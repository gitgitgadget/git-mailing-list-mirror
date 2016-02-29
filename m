From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v5 1/3] sumodule--helper: fix submodule--helper clone
 usage and check argc count
Date: Mon, 29 Feb 2016 14:05:40 -0800
Message-ID: <CA+P7+xpTHQ3i68cqbuhWqOR_y0gS1icBcBgj4jjaZ=yw-WrPEw@mail.gmail.com>
References: <1456532000-22971-1-git-send-email-jacob.e.keller@intel.com>
 <1456532000-22971-2-git-send-email-jacob.e.keller@intel.com>
 <xmqqr3fvcsoy.fsf@gitster.mtv.corp.google.com> <CA+P7+xryNo=n0fFn9HNrj78z4XtWwoF=j67+Qy8TbO7reBTO-Q@mail.gmail.com>
 <xmqqegbv9u9a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 23:07:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaVyp-0001sD-42
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 23:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbcB2WHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 17:07:20 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:33142 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbcB2WGB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 17:06:01 -0500
Received: by mail-io0-f179.google.com with SMTP id z135so203278321iof.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 14:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mq6Z3fFKo6HcidQvwm5sbhyxyuoiSysY8uZFWkBI+5c=;
        b=Qd13OEW2TtoLHnKNK6p0zy5Q9BIul0uhQhVSoQRb6BbdOgywbKIXrRTk4tAl2lkmVE
         sbhFtN/nwPBaS86T2pUxRmlVDsQMYPLBtJ2Dn3kKKJEVw4njiTHhHK+akIgEajVHX4SH
         gUCK18EmrhPdeUicGVPAWG/rvv8/JXhKGvt/xhVMZWkBhosBnIbAtUSiQJX+k35kauYf
         rlVbsFwO5IycVooMm1J4NmAZFdrdrjaooslL/65Stzgogf7tSUlpjm5CglG/wlWo+/Ov
         hCHnjyMJ5r7r142RnAxH7dlpOqVWg/KpcmJdx79DSBulrrXi+aIeJGf6kpEvmAsY8G8z
         WDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mq6Z3fFKo6HcidQvwm5sbhyxyuoiSysY8uZFWkBI+5c=;
        b=T7VtlDkVZtzlfhzR6nQM+NcyBj/d2I0TC6VtKgZMGnmPwfY2iZwgJr07aQCz0c3ocB
         EDn/U0H+ZanjEDJij1kWyoaIXpKsymZ8sk6Zx908NBC4MgtIAf3GZOcACpGh7y0C06G0
         o6SxlXjLu2im3d8paR3QfRoMCd4f4PteqGkzjLg1gO4Vs9S57KyXou9MFe7ZeQNTvrx5
         s/++Etft2GQkSryDLLuZ5mxRZMZTfbLacR6OKdwoQRLF3YSA8CYJEtg0JjQ3DYsOCfGT
         1AF/LKPJwPYAOCfhp9bQqRkxkzttI2IyDEXacB8q+HfVb6HFhZl9mzs/tm7iD1cXotfn
         42kw==
X-Gm-Message-State: AG10YOQw1I/eJdGXQ2S9C6cOkgqy1uRNtsgyKobssvVZ//pXha/twtsPkwyVuJq897azxsEQv/FPXidhXfdR/A==
X-Received: by 10.107.166.195 with SMTP id p186mr21730062ioe.146.1456783560212;
 Mon, 29 Feb 2016 14:06:00 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Mon, 29 Feb 2016 14:05:40 -0800 (PST)
In-Reply-To: <xmqqegbv9u9a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287919>

On Mon, Feb 29, 2016 at 11:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>> That actually is required because otherwise adding a check for argc
>> would break the things. I could split them and do this first and then
>> check for argc if you really prefer?
>
> It is not "check for argc breaks", it is already broken and by
> checking for argc you are exposing the breakage, no?
>
> So I'd say fix that first and then fix the clone subcommand?
>

Ok, so one patch which fixes the empty string arguments first, then
the second patch which adds the (now valid) check?

Thanks,
Jake
